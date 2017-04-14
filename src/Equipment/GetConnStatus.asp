<!--#include file="..\Conn\conn.asp" -->
<%
fConnectADODB()
dim strSQL,strJS,strType,strControllerId
dim i

strType = trim(Request.QueryString("Type"))
strControllerId = trim(Request.Form("ControllerId"))

strSQL = "select ControllerId, CASE WHEN datediff(second,SyncTime,GETDATE()) < 180 then '1' else '0' end as Status from ControllerDataSync where SyncType='online' "
if strControllerId <> "" then 
	strSQL = strSQL+" and ControllerId in ("&strControllerId&") "
end if

i =0
'strJS = "<script language='javascript'>var Arr = new Array(new Array(),new Array());"
strJS = "var Arr = new Array(new Array(),new Array());"
Rs.open strSQL, Conn, 1, 1
if Rs.eof=false and Rs.Bof=false then
	while not Rs.eof 
		strJS = strJS + "Arr[0][" + cstr(i) + "] = " + trim(Rs.fields("ControllerId").value) + ";"
		strJS = strJS + "Arr[1][" + cstr(i) + "] = " + trim(Rs.fields("Status").value) + ";"
		'if Rs.fields("SyncStatus").value=0 or Rs.fields("SyncStatus").value=false then 
		'	strJS = strJS + "Arr[1][" + cstr(i) + "] = 0 ;"
		'else
		'	strJS = strJS + "Arr[1][" + cstr(i) + "] = 1 ;"
		'end if
		i = i + 1	
		Rs.MoveNext
	Wend
end if
Rs.close

response.write strJS

fCloseADO()
%>