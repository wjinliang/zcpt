function changeall(){
		var check = document.getElementById("cball").checked;
		var cbs = document.getElementsByName("ids");	
		for(var i = 0 ; i < cbs.length; i++){
			cbs[i].checked = check;
		}
	}
function checkchange(){
		var flag = false;
		var cbs = document.getElementsByName("ids");
		for(var i = 0 ; i < cbs.length; i++){
			if(cbs[i].checked == false){
				flag = true;
			}
		}
		if(flag){
			document.getElementById("cball").checked = false;
		}else{
			document.getElementById("cball").checked = true;
		}
}

function getcheckedids(){
	var ids=[];
	var cbs = document.getElementsByName("ids");
	for(var i = 0 ; i < cbs.length; i++){
		if(cbs[i].checked == true){
			ids.push(cbs[i].value);
		}
	}
	return ids;
}

