<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<%
Dim strSQL,strTemplateId,strJS
strTemplateId = Cstr(Trim(Request.QueryString("TemplateId")))
if strTemplateId = "" then 
	strTemplateId = "0"
end if 

Call fConnectADODB()

strSQL="select (ISNULL(MAX(HolidayNumber),0)+1) as HolidayNumber  from  ControllerTemplateHoliday where TemplateId='"&strTemplateId&"'"
On Error Resume Next
Rs.open strSQL,Conn,1,1
IF NOT Rs.EOF then
	if NOT ISNULL(Rs.Fields("HolidayNumber").value) then
		strJS = trim(Rs.fields("HolidayNumber").value)
	else
		strJS = 0
	end if
End IF
Rs.close
response.write strJS
	
Call fCloseADO()
%>