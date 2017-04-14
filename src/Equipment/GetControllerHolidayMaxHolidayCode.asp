<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<%
Dim strSQL,strControllerId,strJS
strControllerId = Cstr(Trim(Request.QueryString("ControllerId")))
if strControllerId = "" then 
	strControllerId = "0"
end if 

Call fConnectADODB()

strSQL="select (ISNULL(MAX(HolidayCode),0)+1) as HolidayCode  from  ControllerHoliday where ControllerId='"&strControllerId&"'"
On Error Resume Next
Rs.open strSQL,Conn,1,1
IF NOT Rs.EOF then
	if NOT ISNULL(Rs.Fields("HolidayCode").value) then
		strJS = trim(Rs.fields("HolidayCode").value)
	else
		strJS = 0
	end if
End IF
Rs.close
response.write strJS
	
Call fCloseADO()
%>