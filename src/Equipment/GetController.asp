<!--#include file="..\Conn\conn.asp" -->
<%
fConnectADODB()
dim strSQL,strJS,strType,strControllerId
dim i
dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

strSQL = "select ControllerId,ControllerNumber,Location from Controllers "
'取有访问权限的设备
if strUserId<>"1" then '1 为admin用户
	strSQL = strSQL & " where ControllerId in (select ControllerID from RoleController where UserId in ("&strUserId&") and Permission=1 ) "
end if 
strSQL = strSQL & " order by ControllerId  "

i =0
'strJS = "<script language='javascript'>var Arr = new Array(new Array(),new Array());"
strJS = "var ConArray = new Array(new Array(),new Array());"
Rs.open strSQL, Conn, 1, 1
if Rs.eof=false and Rs.Bof=false then
	while not Rs.eof 
		strJS = strJS + "ConArray[0][" + cstr(i) + "] = " + trim(Rs.fields("ControllerId").value) + ";"
		strJS = strJS + "ConArray[1][" + cstr(i) + "] = '" + trim(Rs.fields("ControllerNumber").value) + "-"+trim(Rs.fields("Location").value)+"';"
		i = i + 1	
		Rs.MoveNext
	Wend
end if
Rs.close

response.write strJS

fCloseADO()
%>