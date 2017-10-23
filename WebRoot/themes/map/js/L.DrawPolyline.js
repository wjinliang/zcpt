L.DrawPolyline = L.Handler.extend({
	statics: {
		TYPE: 'polyline'
	},

	Poly: L.Polyline,

	options: {
		allowIntersection: true,
		repeatMode: false,
		drawError: {
			color: '#b00b00',
			timeout: 2500
		},
		icon: new L.DivIcon({
			iconSize: new L.Point(8, 8),
			className: 'leaflet-div-icon'
		}),
		closeButton:"<img src='leaflet/images/delete.png'/>",
		tooltip:{
           start:"单击选择起点",
           moving:"单击继续，双击结束"
		},
		guidelineDistance: 20,
		maxGuideLineLength: 4000,
		shapeOptions: {
			stroke: true,
			color: 'red',
			weight: 4,
			opacity: 0.8,
			fill: false,
			clickable: true
		},
		metric: true, // Whether to use the metric meaurement system or imperial
		showLength: true, // Whether to display distance in the tooltip
		zIndexOffset: 2000 // This should be > than the highest z-index any map layers
	},

	initialize: function (map, options) {

		this._map = map;
		this._container = map._container;
		this._overlayPane = map._panes.overlayPane;
		this._popupPane = map._panes.popupPane;
		this._polys = [];
            	// Merge default shapeOptions options with custom shapeOptions
		if (options && options.shapeOptions) {
			options.shapeOptions = L.Util.extend({}, this.options.shapeOptions, options.shapeOptions);
		}
		L.setOptions(this, options);
		// Need to set this here to ensure the correct message is used.
		this.options.drawError.message = "不能交叉！";

		// Merge default drawError options with custom options
				// Save the type so super can fire, need to do this as cannot do this.TYPE :(
		this.type = L.DrawPolyline.TYPE;
	},

addHooks: function () {
	  if (this._map) {
			this._mapDraggable = this._map.dragging.enabled();
			if (this._mapDraggable) {
				this._map.dragging.disable();
			}
            this._markers = [];
            this._poly = new L.Polyline([], this.options.shapeOptions);
			this._markerGroup = new L.LayerGroup();
			this._map.addLayer(this._markerGroup);
			this._poly.showDiv = [];
			this._map.addLayer(this._poly);
		}
		this._container.style.cursor = 'pointer';
			if (!this._mouseMarker) {
				this._mouseMarker = L.marker(this._map.getCenter(), {
					icon: L.divIcon({
						//className: 'leaflet-mouse-marker',
						iconAnchor: [20, 20],
						iconSize: [40, 40]
					}),
					opacity: 0,
					zIndexOffset: this.options.zIndexOffset
				});
			}
            this._tooltip = new L.Tooltip(this._map);
			this._mouseMarker
				.on('mousedown', this._onMouseDown, this)
				.addTo(this._map);
           //L.DomEvent.on(this._container, 'keyup', this._cancelDrawing, this);
           	this._map
           		.on('mousemove', this._onMouseMove, this)
				.on('mouseup', this._onMouseUp, this)
				.on('zoomstart',this._onZoomStart,this)
				.on('zoomend', this._onZoomEnd, this);
			},

	removeHooks: function () {
		if (this._map) {
			if (this._mapDraggable) {
				this._map.dragging.enable();
			}

			//TODO refactor: move cursor to styles
			this._container.style.cursor = '';

			this._map
				.off('mousedown', this._onMouseDown, this)
				.off('mousemove', this._onMouseMove, this);

					// remove markers from map
		this._mouseMarker
			.off('mousedown', this._onMouseDown, this)
			.off('mouseup', this._onMouseUp, this);
		this._map.removeLayer(this._mouseMarker);
		delete this._mouseMarker;
		//删除及节点marker
		/*this._map.removeLayer(this._markerGroup);
		delete this._markerGroup;
		delete this._markers;*/
		// clean up DOM
		this._map
			.off('mousemove', this._onMouseMove, this)
			.off('zoomend', this._onZoomEnd, this);
		}
		if (this._poly) {
				this._map.removeLayer(this._poly);
				delete this._poly;
				this._tooltip.dispose();
			}
	},

	addVertex: function (latlng) {
		var markersLength = this._markers.length;

		this._markers.push(this._createMarker(latlng));
        this._poly.addLatLng(latlng);
        this._vertexChanged(latlng, true);
	},
    _onZoomEnd: function () {    
        if(this._poly.showDiv.length>0)
		{
			for(var i in this._poly.showDiv)
			{ 
				var pos = this._map.latLngToLayerPoint(this._poly.showDiv[i].latlng);
				L.DomUtil.setPosition(this._poly.showDiv[i], pos)
				//this._poly.showDiv[i].latlng = this._map.layerPointToLatLng(pos);
			} 
		}
	},
	_finishShape: function () {
		//var intersects = this._poly.newLatLngIntersects(this._poly.getLatLngs()[0], true);

		/*if ((!this.options.allowIntersection && intersects) || !this._shapeIsValid()) {
			this._showErrorTooltip();
			return;
		}*/
      
		
		
		this._fireCreatedEvent();
		this._tooltip.dispose();

		this._markers[this._markers.length - 1].off('click', this._finishShape, this);
		this.disable();
		if (this.options.repeatMode) {
			this.enable();
		}
	},

	//Called to verify the shape is valid when the user tries to finish it
	//Return false if the shape is not valid
	_shapeIsValid: function () {
		return true;
	},

	_onZoomStart: function () {
		if(this._poly.showDiv.length>0)
		{
			for(var i in this._poly.showDiv)
			{ 
				var pos = L.DomUtil.getPosition(this._poly.showDiv[i]);
				this._poly.showDiv[i].latlng = this._map.layerPointToLatLng(pos);
			} 
		}
	},

	_onMouseMove: function (e) {
		var newPos = e.layerPoint,
			latlng = e.latlng;
        this._mouseMarker.setLatLng(latlng);
        this._currentLatLng = latlng;
        this._updateTooltip(latlng);
        var len = this._markers.length;
       if(len>0)
       {
            this._poly.spliceLatLngs(len,1,latlng);
       }  
		// Save latlng
		// should this be moved to _updateGuide() ?
		

		//this._updateTooltip(latlng);

		// Update the guide line
		//this._updateGuide(newPos);

		// Update the mouse marker position
		

		L.DomEvent.preventDefault(e.originalEvent);
	},

	_vertexChanged: function (latlng, added) {
		this._updateFinishHandler();

		this._updateRunningMeasure(latlng, added);

		//this._clearGuides();

		this._updateTooltip(latlng);
		
		 if(this._markers.length>1)
        {
          var pos = this._map.latLngToLayerPoint(latlng);
          var d = L.DomUtil.create('div', 'leaflet-draw-tooltip', this._popupPane);
			d.innerHTML=this._getTooltipText().subtext;
			d.style.visibility = 'inherit';
			this._poly.showDiv.push(d);
			L.DomUtil.setPosition(d, pos);
		}
	},

	_onMouseDown: function (e) {
		var originalEvent = e.originalEvent;
		this._mouseDownOrigin = L.point(originalEvent.clientX, originalEvent.clientY);

	},

	_onMouseUp: function (e) {
		
		if (this._mouseDownOrigin) {
			// We detect clicks within a certain tolerance, otherwise let it
			// be interpreted as a drag by the map
			var distance = L.point(e.originalEvent.clientX, e.originalEvent.clientY)
				.distanceTo(this._mouseDownOrigin);
			if (Math.abs(distance) < 9 * (window.devicePixelRatio || 1)) {
				this.addVertex(e.latlng);
			}
		}
		this._mouseDownOrigin = null;
	},

	_updateFinishHandler: function () {
		var markerCount = this._markers.length;
		// The last marker should have a click handler to close the polyline
		if (markerCount > 1) {
			this._markers[markerCount - 1].on('click', this._finishShape, this);
		}

		// Remove the old marker click handler (as only the last point should close the polyline)
		if (markerCount > 2) {

			this._markers[markerCount - 2].off('click', this._finishShape, this);
		}
	},

	_createMarker: function (latlng) {
		var marker = new L.Marker(latlng, {
			icon: this.options.icon,
			zIndexOffset: this.options.zIndexOffset * 2
		});

		this._markerGroup.addLayer(marker);

		return marker;
	},

	_updateGuide: function (newPos) {
		var markerCount = this._markers.length;

		if (markerCount > 0) {
			newPos = newPos || this._map.latLngToLayerPoint(this._currentLatLng);

			// draw the guide line
			this._clearGuides();
			this._drawGuide(
				this._map.latLngToLayerPoint(this._markers[markerCount - 1].getLatLng()),
				newPos
			);
		}
	},

	_updateTooltip: function (latLng) {
		var text = this._getTooltipText();
		if (latLng) {

			this._tooltip.updatePosition(latLng);
		}

		if (!this._errorShown) {
			this._tooltip.updateContent(text);
		}
	},

	_drawGuide: function (pointA, pointB) {
		var length = Math.floor(Math.sqrt(Math.pow((pointB.x - pointA.x), 2) + Math.pow((pointB.y - pointA.y), 2))),
			guidelineDistance = this.options.guidelineDistance,
			maxGuideLineLength = this.options.maxGuideLineLength,
			// Only draw a guideline with a max length
			i = length > maxGuideLineLength ? length - maxGuideLineLength : guidelineDistance,
			fraction,
			dashPoint,
			dash;

		//create the guides container if we haven't yet
		if (!this._guidesContainer) {
			this._guidesContainer = L.DomUtil.create('div', 'leaflet-draw-guides', this._overlayPane);
		}

		//draw a dash every GuildeLineDistance
		for (; i < length; i += this.options.guidelineDistance) {
			//work out fraction along line we are
			fraction = i / length;

			//calculate new x,y point
			dashPoint = {
				x: Math.floor((pointA.x * (1 - fraction)) + (fraction * pointB.x)),
				y: Math.floor((pointA.y * (1 - fraction)) + (fraction * pointB.y))
			};

			//add guide dash to guide container
			dash = L.DomUtil.create('div', 'leaflet-draw-guide-dash', this._guidesContainer);
			dash.style.backgroundColor =
				!this._errorShown ? this.options.shapeOptions.color : this.options.drawError.color;

			L.DomUtil.setPosition(dash, dashPoint);
		}
	},

	_updateGuideColor: function (color) {
		if (this._guidesContainer) {
			for (var i = 0, l = this._guidesContainer.childNodes.length; i < l; i++) {
				this._guidesContainer.childNodes[i].style.backgroundColor = color;
			}
		}
	},

	// removes all child elements (guide dashes) from the guides container
	_clearGuides: function () {
		if (this._guidesContainer) {
			while (this._guidesContainer.firstChild) {
				this._guidesContainer.removeChild(this._guidesContainer.firstChild);
			}
		}
	},

	_getTooltipText: function () {
		var showLength = this.options.showLength,
			labelText, distanceStr;

		if (this._markers.length === 0) {
			labelText = {
				text: this.options.tooltip.start
			};
		} else {
			distanceStr = showLength ? this._getMeasurementString() : '';
			labelText = {
					text: this.options.tooltip.moving,
					subtext: distanceStr
				};
		}
		return labelText;
	},

	_updateRunningMeasure: function (latlng, added) {
		var markersLength = this._markers.length,
			previousMarkerIndex, distance;

		if (this._markers.length === 1) {
			this._measurementRunningTotal = 0;
		} else {
			previousMarkerIndex = markersLength - (added ? 2 : 1);
			distance = latlng.distanceTo(this._markers[previousMarkerIndex].getLatLng());
			this._measurementRunningTotal += distance * (added ? 1 : -1);
		}
	},

	_getMeasurementString: function () {
		var currentLatLng = this._currentLatLng,
			previousLatLng = this._markers[this._markers.length - 1].getLatLng(),
			distance;
        // calculate the distance from the last fixed point to the mouse position
		distance = this._measurementRunningTotal + currentLatLng.distanceTo(previousLatLng);
       var distanceStr;
       if (distance > 1000) {
				distanceStr = (distance  / 1000).toFixed(2) + ' km';
			} else {
				distanceStr = Math.ceil(distance) + ' m';
			}
       return distanceStr;
		//return L.GeometryUtil.readableDistance(distance, this.options.metric);
	},

	_showErrorTooltip: function () {
		this._errorShown = true;

		// Update tooltip
		this._tooltip
			.showAsError()
			.updateContent({ text: this.options.drawError.message });

		// Update shape
		this._updateGuideColor(this.options.drawError.color);
		this._poly.setStyle({ color: this.options.drawError.color });

		// Hide the error after 2 seconds
		this._clearHideErrorTimeout();
		this._hideErrorTimeout = setTimeout(L.Util.bind(this._hideErrorTooltip, this), this.options.drawError.timeout);
	},

	_hideErrorTooltip: function () {
		this._errorShown = false;

		this._clearHideErrorTimeout();

		// Revert tooltip
		this._tooltip
			.removeError()
			.updateContent(this._getTooltipText());

		// Revert shape
		this._updateGuideColor(this.options.shapeOptions.color);
		this._poly.setStyle({ color: this.options.shapeOptions.color });
	},

	_clearHideErrorTimeout: function () {
		if (this._hideErrorTimeout) {
			clearTimeout(this._hideErrorTimeout);
			this._hideErrorTimeout = null;
		}
	},

	_cleanUpShape: function () {
		if (this._markers.length > 1) {
			this._markers[this._markers.length - 1].off('click', this._finishShape, this);
		}
	},

	_fireCreatedEvent: function () {
		var poly = new this.Poly(this._poly.getLatLngs(), this.options.shapeOptions);
		poly.showDiv = this._poly.showDiv;
		this._polys.push(poly);
		this._map.removeLayer(this._poly);
		this._map.addLayer(poly);
		delete this._poly;
		this._map.fire('draw:created', { layer: poly, layerType: this.type });
		var lastIndex = poly.showDiv.length-1;
		var close = L.DomUtil.create('span', 'closeLine', poly.showDiv[lastIndex]);
		close.style.cursor="pointer";
		close.innerHTML=this.options.closeButton;
		var m = this._map;
		var group = this._markerGroup;
		L.DomEvent.on(close,"click",function(){
           m.removeLayer(poly);
           m.removeLayer(group);
           var i=0;
           for(;i<poly.showDiv.length;i++)
           {
           	var p = poly.showDiv[i].parentNode;
               p.removeChild(poly.showDiv[i]);
           }
          })
			this._map
           		.off('zoomstart',this._onZoomStart,this)
				.off('zoomend', this._onZoomEnd, this);
			this._map
           		.on('zoomstart',this._mZoomStart,this)
				.on('zoomend', this._mZoomEnd,this);
					
		//var m = this;
		//L.DomEvent.on(close, 'click',);
	},
	_mZoomStart: function(e){
      for(var i in this._polys)
      {
      	var poly = this._polys[i];
       if(poly.showDiv.length>0)
		{
			for(var i in poly.showDiv)
			{ 
				var pos = L.DomUtil.getPosition(poly.showDiv[i]);
				poly.showDiv[i].latlng = this._map.layerPointToLatLng(pos);
			} 
		}
	}
  },
	_mZoomEnd:function(poly){
		 for(var i in this._polys)
      {
      	var poly = this._polys[i];
       if(poly.showDiv.length>0)
 		{
			for(var i in poly.showDiv)
			{ 
				var pos = this._map.latLngToLayerPoint(poly.showDiv[i].latlng);
				L.DomUtil.setPosition(poly.showDiv[i], pos)
				//this._poly.showDiv[i].latlng = this._map.layerPointToLatLng(pos);
			} 
		}
	 }
	},
	_cancelDrawing: function (e) {
		if (e.keyCode === 27) {
			this.disable();
		}
	},
	enable: function () {
			if (this._enabled) { return; }
		L.Handler.prototype.enable.call(this);
      },
	disable: function () {
			if (!this._enabled) { return; }
            L.Handler.prototype.disable.call(this);
			this._map.fire('draw:drawstop', { layerType: this.type });
			L.DomEvent.off(this._container, 'keyup', this._cancelDrawing, this);
			}
	});
