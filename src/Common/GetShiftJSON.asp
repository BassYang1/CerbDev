<!--#include file="Page.asp" -->
<!--#include file="..\Conn\conn.asp" -->
<%
dim strUserId
dim strSQL,strJS

strUserId = Cstr(Trim(Request.QueryString("userId")))
if strUserId = "" then strUserId = "0" end if


fConnectADODB()

strSQL = "select(select '{"&chr(34)&"id"&chr(34)&":"&chr(34)&"'+ CAST(ShiftId AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"name"&chr(34)&":"&chr(34)&"' + ShiftName + '"&chr(34)&"},' from AttendanceShifts order by ShiftId DESC for xml path('')) JsonData"


Rs.open strSQL, Conn, 2, 1
strJS = "["

If Not Rs.eof Then
	strJS = strJS & Trim(Rs.fields(0).value)
End If

Rs.close
if len(strJS) >= 2 then 
	strJS=left(strJS,InStrRev(strJS,",")-1)
end if
strJS=strJS & "]"
response.write strJS
	
fCloseADO()
%>