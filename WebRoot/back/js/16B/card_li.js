//通用选卡代码（不切换内容区）
function changeCard(cardName,clsName)
{
 var cardList = cardName.parentNode.getElementsByTagName("li");
  for(i=0;i<cardList.length;i++){
   if(cardName == cardList[i]) {
		cardList[i].className = clsName + "On";
   }
   else{
		cardList[i].className = clsName + "Off";
    }
	}
}

//通用选卡切层切换代码 
//infoid 为选卡内容区域DIV的ID。cardid传this。调用是注意‘’的使用。
function showCard(cardid,infoid,clsName)
{
 var cardList = cardid.parentNode.getElementsByTagName("li");
  for(i=0;i<cardList.length;i++){
   if(cardid == cardList[i]) {
		cardList[i].className = clsName + "On";
		eval(infoid + i + ".style.display=\"block\";"); 
   }
   else{
		cardList[i].className = clsName + "Off";
		eval(infoid + i + ".style.display=\"none\";"); 
    }
	}
}
