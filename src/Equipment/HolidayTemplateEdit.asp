<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL,strOper, strRecordID, strTemplateName,iNewID,iNewHolidayCode,iControllerID,strActions
strOper = Request.Form("oper")
strRecordID = Replace(Request.Form("id"),"'","''")
strTemplateName = Replace(Request.Form("TemplateName"),"'","''")

if strOper<>"add" and strOper<>"edit" and strOper<>"del" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if 

if GetOperRole("HolidayTemplate",strOper) <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

Call fConnectADODB()

'判断模板名称是否存在
strSQL=""
Select Case strOper
	Case "add": 'Add Record
	strSQL = "Select 1 from ControllerTemplates where TemplateName='"&strTemplateName&"'"
	Case "edit": 'Edit Record
	strSQL = "Select 1 from ControllerTemplates where TemplateName='"&strTemplateName&"' and TemplateId <> "&strRecordID
End Select
if	strSQL<>"" then 
	if IsExistsValue(strSQL) = true then 
		Call fCloseADO()
		Call ReturnMsg("false",GetEquLbl("TempNameUsed"),0)	'"名称已使用"
		response.End()
	end if
end if

Select Case strOper
	Case "add": 'Add Record
		strSQL = "INSERT INTO ControllerTemplates (TemplateType,TemplateName) values('1'"&",'"&strTemplateName&"') "
	Case "edit": 'Edit Record
		strSQL = "Update ControllerTemplates Set TemplateName ='"&strTemplateName&"' Where TemplateId = "&strRecordID
		strSQL = strSQL & "; Update ControllerHoliday Set TemplateName ='"&strTemplateName&"' Where TemplateId = "&strRecordID
	Case "del": 'Delete Record
		strSQL = "update ControllerHoliday set TemplateId=0,TemplateName='',status=0 where TemplateId in ("&strRecordID&")"
		strSQL = strSQL & "; Delete From ControllerTemplateHoliday where TemplateId in ("&strRecordID&") "
		strSQL = strSQL & "; Delete From ControllerTemplates where TemplateId in ("&strRecordID&") "
End Select

if	strSQL<>"" then 
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",Err.Description,0)
		On Error GoTo 0
		response.End()
	end if
	
	Select Case strOper
		Case "add": 'Add Record
			strActions = GetCerbLbl("strLogAdd")
			'Call AddLogEvent("设备管理-假期表-模板方式",cstr(strActions),cstr(strActions)&"假期表,假期表名称["&strTemplateName&"]")
			Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("Holiday")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("Holiday")&","&GetEquLbl("HolidayName2")&"["&strTemplateName&"]")
		Case "edit": 'Edit Record
			strActions = GetCerbLbl("strLogEdit")
			'Call AddLogEvent("设备管理-假期表-模板方式",cstr(strActions),cstr(strActions)&"假期表,ID["&strRecordID&"],修改后假期表名称["&strTemplateName&"]")
			Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("Holiday")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("Holiday")&",ID["&strRecordID&"],"&GetEquLbl("EditHolidayName2")&"["&strTemplateName&"]")
		Case "del": 'Delete Record
			strActions = GetCerbLbl("strLogDel")
			'Call AddLogEvent("设备管理-假期表-模板方式",cstr(strActions),cstr(strActions)&"假期表,ID["&strRecordID&"]")
			Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("Holiday")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("Holiday")&",ID["&strRecordID&"]")
	End Select
	
	Call fCloseADO()
	Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)	'"执行成功"
else
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)	'"执行成功"
end if

%>