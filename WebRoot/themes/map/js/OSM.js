L.TileLayer.OSM = L.TileLayer.extend({

    initialize: function(options) { // (type, Object)
        var url = 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
        L.TileLayer.prototype.initialize.call(this,url,options);
    }
});
L.tileLayer.OSM= function(options) {
    return new L.TileLayer.OSM(options);
};