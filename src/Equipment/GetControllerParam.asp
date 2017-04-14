<!--#include file="..\Conn\conn.asp" -->
<%
fConnectADODB()
dim strSQL,strControllerId,strParam

strControllerId = Trim(Request.QueryString("id"))
strParam = Trim(Request.QueryString("param"))

If strControllerId = "" Then
	response.write "0"
	response.end
End If

if strParam = "worktype" then 
	strSQL = "Select ControllerId From Controllers Where ('1' = left(worktype, 1) or '2' = left(worktype, 1)) and ControllerId in (" + strControllerId + ")"
elseif strParam = "boardtype" then 
	strSQL = "select controllerid from Controllers where substring(isNull(BoardType,'0'),1,1)='1' and ControllerId in ("+CStr(strControllerId)+")"
end if 

On Error Resume next
Rs.open strSQL, Conn, 0, 1

If Not Rs.eof Then
	Response.write "1"
Else
	Response.write "0"
End If
Rs.Close

fCloseADO()
%>