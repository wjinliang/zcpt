function SubPicture(ulID, leftID, rightID) {
	var left = $("#" + leftID);
	var right = $("#" + rightID);
	var obj = $("#" + ulID);
	var w = obj.find("li").innerWidth();
	
	left.click(function(){
		obj.find("li:last").prependTo(obj);
		obj.css("margin-left",-w);
		obj.animate({"margin-left": 0});
	});
	
	right.click(function(){
		obj.animate({"margin-left": -w},function(){
			obj.find("li:first").appendTo(obj);
			obj.css("margin-left","0");
		});
	});
}