<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<%
Dim strSQL,strControllerID,strSelectID,strJs,strIsShowNULLSchedule,strIsShow24HSchedule
strControllerID = Request.QueryString("ControllerID")
strSelectID = Request.QueryString("SelectID")
strIsShowNULLSchedule = Request.QueryString("IsShowNULLSchedule")
strIsShow24HSchedule = Request.QueryString("IsShow24HSchedule")

if strIsShowNULLSchedule = "1" then 
	strJs = "<select id='"+strSelectID+"' class='FormElement ui-widget-content ui-corner-all' ><option value =''></option>"
else
	strJs = "<select id='"+strSelectID+"' class='FormElement ui-widget-content ui-corner-all' >"
end if
Call fConnectADODB()
'ControllerID为空，表示非设备的时间表，则从模板表中取所有模板
if strControllerID = "" then 
	if strIsShow24HSchedule = "1" then 
		strSQL="select TemplateId,TemplateName from ControllerTemplates where TemplateType='2' order by TemplateId "
	else 
		strSQL="select TemplateId,TemplateName from ControllerTemplates where TemplateType='2' and TemplateId<>1 order by TemplateId "
	end if
else 
	strSQL="select distinct TemplateId,TemplateName from ControllerSchedule where Controllerid in ("&strControllerID&") and TemplateName <> '' order by TemplateId "
end if
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