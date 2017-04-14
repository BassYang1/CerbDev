<%
	dim EmId,ScreenFile
	EmId = Request.QueryString("id")
	ScreenFile = Request.QueryString("ScreenFile")
	if EmId= "" then EmId = 0
	if ScreenFile= "" then ScreenFile = 1
%>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/lang/lang.js"></script>
<script>
	document.write("<scr"+"ipt type='text/javascript' src='../js/lang/"+getLan()+"'><\/script>");
</script>
<script type="text/javascript" src="../js/plugins/jquery.form.js"></script>
<script type="text/javascript" src="../js/custom/system.js"></script>
<head></head>
<body topmargin="0" style="width:100%">
<table align="left" cellspacing="0" cellpadding=0 border=0 width="160"><tr align="left"><td>
<img name="Imgsrc" id="img"  width="160" height="120" border="1">
</td></tr></table>
</body>
<script language="javascript">
<% if clng(EmId) > 0 then %>
var strUrl = 'DisplayImg.asp?nd='+getRandom()+'&ScreenFile='+<%response.Write(ScreenFile)%>+'&id='+<%response.Write(EmId)%>;
var htmlObj = $.ajax({url:strUrl,async:false});
strData = htmlObj.responseText;
<% end if %>

if(strData){
	var pic = document.getElementById("img");
	pic.src='DisplayImg.asp?nd='+getRandom()+'&ScreenFile='+<%response.Write(ScreenFile)%>+'&id='+<%response.Write(EmId)%>;
}
else{
	var pic = document.getElementById("img");
	//pic.src="../images/picture.gif";
	pic.src="../"+getlbl("login.picture");
}
</script>
</html>



