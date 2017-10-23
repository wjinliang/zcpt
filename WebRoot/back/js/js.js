// JavaScript Document
function showCarddiv(cardid,infoid,clsName)
	{
	
	 var cardList = cardid.parentNode.getElementsByTagName("span");
	  for(i=0;i<cardList.length;i++){
	   if(cardid == cardList[i]) {
			cardList[i].className = clsName + "On";
			eval("document.getElementById('"+infoid + i + "').style.display=\"inline\";"); 
	   }
	   if(cardid != cardList[i]){
			cardList[i].className = clsName + "Off";
			eval("document.getElementById('"+infoid + i + "').style.display=\"none\";"); 
		}
		}
	}





function showdlFrame(){
		window.document.getElementById("zcBox").style.display = "none";	
		window.document.getElementById("dlBox").style.display = "inline";
	}
	
	function closedlBox(){
		window.document.getElementById("dlBox").style.display = "none";	
	}
	
function showZcFrame(){
		window.document.getElementById("dlBox").style.display = "none";	
		window.document.getElementById("zcBox").style.display = "inline";
	}
	
	function closezcBox(){
		window.document.getElementById("zcBox").style.display = "none";	
	}	
	

function showTan(){
		window.document.getElementById("tcBox").style.display = "inline";
	}
	
	function closeTcBox(){
		window.document.getElementById("tcBox").style.display = "none";	
	}
	
function showTan2(){
		window.document.getElementById("tcBox2").style.display = "inline";
	}
	
	function closeTcBox2(){
		window.document.getElementById("tcBox2").style.display = "none";	
	}
function showTan3(){
		window.document.getElementById("tcBox3").style.display = "inline";
	}
	
	function closeTcBox3(){
		window.document.getElementById("tcBox3").style.display = "none";	
	}
function showTan4(){
		window.document.getElementById("tcBox4").style.display = "inline";
	}
	
	function closeTcBox4(){
		window.document.getElementById("tcBox4").style.display = "none";	
	}
function showTan5(){
		window.document.getElementById("tcBox5").style.display = "inline";
	}
	
	function closeTcBox5(){
		window.document.getElementById("tcBox5").style.display = "none";	
	}
function showTan6(){
		window.document.getElementById("tcBox6").style.display = "inline";
	}
	
	function closeTcBox6(){
		window.document.getElementById("tcBox6").style.display = "none";	
	}
	
	
	
function showTab(num){
	for (i=0;i<7 ;i++ )
	{
		var card=document.getElementById("card"+i);
		var list=document.getElementById("list"+i);
		if (i==num)
		{
			card.className="card"+i+"On";
			list.style.display="inline";
		} else{
			card.className="card"+i+"Off";
			list.style.display="none";
		}
	}
}



function showMenu(num){
	for (i=0;i<9 ;i++ )
	{
		var cardLeft=document.getElementById("cardLeft"+i);
		var Box=document.getElementById("Box"+i);
		if (i==num)
		{
			cardLeft.className="cardLeft"+i+"On";
			Box.style.display="inline";
		} else{
			cardLeft.className="cardLeft"+i+"Off";
			Box.style.display="none";
		}
	}
}


function showMenu(num){
	for (i=0;i<9 ;i++ )
	{
		var cardLeft=document.getElementById("cardLeft"+i);
		var Box=document.getElementById("Box"+i);
		if (i==num)
		{
			cardLeft.className="cardLeft"+i+"On";
			Box.style.display="inline";
		} else{
			cardLeft.className="cardLeft"+i+"Off";
			Box.style.display="none";
		}
	}
}



function showKuang(num){
	for (i=0;i<9 ;i++ )
	{
		var chek=document.getElementById("chek"+i);
		var kuang=document.getElementById("kuang"+i);
		if (i==num)
		{
			chek.className="chek"+i+"On";
			kuang.style.display="inline";
		} else{
			chek.className="chek"+i+"Off";
			kuang.style.display="none";
		}
	}
}




function showBan(){
		window.document.getElementById("nav_botm").style.display = "inline";
		
	}
	
	
	function closenav_botm(){
		window.document.getElementById("nav_botm").style.display = "none";	
	}
	
function showBan2(){
		window.document.getElementById("nav_botm2").style.display = "inline";
	}
	
	function closenav_botm2(){
		window.document.getElementById("nav_botm2").style.display = "none";	
		
	}
function showBan3(){
		window.document.getElementById("nav_botm3").style.display = "inline";
	}
	
	function closenav_botm3(){
		window.document.getElementById("nav_botm3").style.display = "none";	
	}
function showBan4(){
		window.document.getElementById("nav_botm4").style.display = "inline";
	}
	
	function closenav_botm4(){
		window.document.getElementById("nav_botm4").style.display = "none";	
	}	
function showBan5(){
		window.document.getElementById("nav_botm5").style.display = "inline";
	}
	
	function closenav_botm5(){
		window.document.getElementById("nav_botm5").style.display = "none";	
	}
function showBan6(){
		window.document.getElementById("nav_botm6").style.display = "inline";
	}
	
	function closenav_botm6(){
		window.document.getElementById("nav_botm6").style.display = "none";	
	}	
function showBan7(){
		window.document.getElementById("nav_botm7").style.display = "inline";
	}
	
	function closenav_botm7(){
		window.document.getElementById("nav_botm7").style.display = "none";	
	}
	
	
	
	
	
function show(x){
	    if(x==1){document.getElementById("koko").style.display="block"}
		if(x==2){document.getElementById("koko").style.display="none"}
	}	
	
	
	
function showTabdiv(cardid,infoid,clsName)
	{
	
	 var cardList = cardid.parentNode.getElementsByTagName("span");
	  for(i=0;i<cardList.length;i++){
	   if(cardid == cardList[i]) {
			cardList[i].className = clsName + "On";
			eval("document.getElementById('"+infoid + i + "').style.display=\"inline\";"); 
	   }
	   if(cardid != cardList[i]){
			cardList[i].className = clsName + "Off";
			eval("document.getElementById('"+infoid + i + "').style.display=\"none\";"); 
		}
		}
	}	