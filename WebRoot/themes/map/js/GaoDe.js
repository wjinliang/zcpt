L.TileLayer.GaoDe = L.TileLayer.extend({

    initialize: function(options) { // (type, Object)
        var url = 'http://webrd0{s}.is.autonavi.com/appmaptile?lang=zh_cn&size=1&scale=1&style=8&x={x}&y={y}&z={z}';
        options.subdomains =  ["1","2","3","4"];
        console.log(options);
        L.TileLayer.prototype.initialize.call(this,url,options);
    }
});
L.tileLayer.GaoDe= function(options) {
    return new L.TileLayer.GaoDe(options);
};
