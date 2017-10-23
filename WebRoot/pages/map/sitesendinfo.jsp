<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  
  <body>
   <form>
<input type="hidden" name="agreementId" id="agreementId" />
   语句总数：&nbsp;&nbsp;&nbsp;<select name="staTotal">
        <option selected="selected" value=1>1</option>
        <option value=2>2</option>
        <option value=3>3</option>
        <option value=4>4</option>
        <option value=5>5</option>
        <option value=6>6</option>
        <option value=7>7</option>
        <option value=8>8</option>
        <option value=9>9</option>
      </select><br /><br />
   语句编号：&nbsp;&nbsp;&nbsp;<select name="staNum">
        <option selected="selected" value=1>1</option>
        <option value=2>2</option>
        <option value=3>3</option>
        <option value=4>4</option>
        <option value=5>5</option>
        <option value=6>6</option>
        <option value=7>7</option>
        <option value=8>8</option>
        <option value=9>9</option>
      </select><br /><br />
      信息识别符：<select name="mesIdentity">
        <option selected="selected" value=1>1</option>
        <option value=2>2</option>
        <option value=3>3</option>
      </select><br /><br />
  MMSI码：&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="mmsi" style="width: 120px;"/><br /><br />
  AIS信道：&nbsp;&nbsp;&nbsp;&nbsp;<select name="aisRoad">
        <option selected="selected" value=1>信道A</option>
        <option value=2>信道B</option>
        <option value=3>信道A和B</option>
      </select><br /><br />
      报文ID：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="mess">
        <option selected="selected" value=1>6号报文</option>
        <option value=2>8号报文</option>
        <option value=2>12号报文</option>
        <option value=2>14号报文</option>
      </select><br /><br />
      &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="发送" id="msgSendButton"/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" id="reset" value="重置"/>
</form>
  </body>
</html>
