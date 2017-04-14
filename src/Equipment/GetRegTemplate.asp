<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<%
Dim strSQL,strSelectID
strSelectID = Cstr(Trim(Request.QueryString("selectId")))

strJs = "<select id='"+strSelectID+"' class='FormElement ui-widget-content ui-corner-all' >"
Call fConnectADODB()

strSQL="select TemplateId,TemplateName from ControllerTemplates where TemplateType='4' order by TemplateId "
On Error Resume Next
Rs.open strSQL,Conn,1,1
while NOT Rs.EOF
	if instr(trim(Rs.fields("TemplateName").value), "'") > 0 then
		strJS = strJS + "<option value ='"+trim(Rs.fields("TemplateId").value)+"'>" + GetSafeJs(trim(Rs.fields("TemplateName").value)) + "</option>"
	else
		strJS = strJS + "<option value ='"+trim(Rs.fields("TemplateId").value)+"'>" + trim(Rs.fields("TemplateName").value) + "</option>"
	end if
	Rs.movenext
wend
Rs.close
strJS = strJS + "</select>"
response.write strJS
	
Call fCloseADO()
%>