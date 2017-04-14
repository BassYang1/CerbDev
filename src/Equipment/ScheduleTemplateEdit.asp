<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL,strOper, strRecordID, strTemplateName,iNewID,iNewScheduleCode,iControllerID,iNewRecordID,i
strOper = Request.Form("oper")
strRecordID = Replace(Request.Form("id"),"'","''")
strTemplateName = Replace(Request.Form("TemplateName"),"'","''")

if strOper<>"add" and strOper<>"edit" and strOper<>"del" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if 
if GetOperRole("ScheduleTemplate",strOper) <> true then 
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
		strSQL = "INSERT INTO ControllerTemplates (TemplateType,TemplateName) values('2'"&",'"&strTemplateName&"') "
		On Error Resume Next
		Conn.Execute strSQL
		if err.number <> 0 then
			Call fCloseADO()
			Call ReturnMsg("false",GetEquLbl("AddScheduleTempError"),0)	'"增加时间模板出错"
			On Error GoTo 0
			response.End()
		end if
		iNewId = GetMaxID("TemplateId","ControllerTemplates where TemplateType='2'")
		
		strSQL = ""
		strSQL = strSQL +"INSERT ControllerTemplateSchedule (TemplateId,[WeekDay],HolidayTemplateId,[StartTime1],[EndTime1])  "
		strSQL = strSQL +"           select "+CStr(iNewId)+",'holiday',0,NULL,NULL"
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'1',NULL,'00:00','00:01'"
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'2',NULL,'00:00','00:01'"
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'3',NULL,'00:00','00:01'"
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'4',NULL,'00:00','00:01'"
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'5',NULL,'00:00','00:01'"
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'6',NULL,'00:00','00:01'"
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'7',NULL,'00:00','00:01'"
		On Error Resume Next
		Conn.Execute strSQL
		if err.number <> 0 then
			Call fCloseADO()
			Call ReturnMsg("false",GetEquLbl("AddScheduleTempDetailError"),0)	'"增加时间模板明细出错"
			On Error GoTo 0
			response.End()
		end if
	
	Case "edit": 'Edit Record
		strSQL = "Update ControllerSchedule Set TemplateName ='"&strTemplateName&"' Where TemplateId = "&strRecordID
		strSQL = strSQL & "; Update ControllerTemplates Set TemplateName ='"&strTemplateName&"' Where TemplateId = "&strRecordID
		On Error Resume Next
		Conn.Execute strSQL
		if err.number <> 0 then
			Call fCloseADO()
			Call ReturnMsg("false",GetEquLbl("EditScheduleTempError"),0)	'"修改时间模板出错"
			On Error GoTo 0
			response.End()
		end if
	Case "del": 'Delete Record
		strSQL = "Update ControllerSchedule Set TemplateName=NULL,TemplateId=0,Status=0 Where TemplateId in ("&strRecordID&")"
		strSQL = strSQL & "; Update ControllerInout Set ScheduleName=NULL,ScheduleId=0,Status=0 Where ScheduleId in ("&strRecordID&")"
		strSQL = strSQL & "; Update ControllerTemplateInout Set ScheduleName=NULL,ScheduleId=0 Where ScheduleId in ("&strRecordID&")"
		strSQL = strSQL & "; Delete From ControllerTemplateSchedule where TemplateId in ("&strRecordID&")"
		strSQL = strSQL & "; Delete From ControllerTemplates where TemplateId in ("&strRecordID&")"
		On Error Resume Next
		Conn.Execute strSQL
		if err.number <> 0 then
			Call fCloseADO()
			Call ReturnMsg("false",GetEquLbl("DelScheduleTempError"),0)	'"删除时间模板出错"
			On Error GoTo 0
			response.End()
		end if
End Select

if	strSQL<>"" then 
	'On Error Resume Next
	'Conn.Execute strSQL
	'if err.number <> 0 then
	'	Call fCloseADO()
	'	Call ReturnMsg("false",Err.Description,0)
	'	On Error GoTo 0
	'	response.End()
	'end if


	Select Case strOper
		Case "add": 'Add Record
			strActions = GetCerbLbl("strLogAdd")
			'Call AddLogEvent("设备管理-时间表-模板方式",cstr(strActions),cstr(strActions)&"时间表,时间表名称["&strTemplateName&"]")
			Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("Schedule")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("Schedule")&","&GetEquLbl("ScheduleName")&"["&strTemplateName&"]")
		Case "edit": 'Edit Record
			strActions = GetCerbLbl("strLogEdit")
			'Call AddLogEvent("设备管理-时间表-模板方式",cstr(strActions),cstr(strActions)&"时间表,ID["&strRecordID&"],修改后时间表名称["&strTemplateName&"]")
			Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("Schedule")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("Schedule")&",ID["&strRecordID&"],"&GetEquLbl("EditScheduleName")&"["&strTemplateName&"]")
		Case "del": 'Delete Record
			strActions = GetCerbLbl("strLogDel")
			'Call AddLogEvent("设备管理-时间表-模板方式",cstr(strActions),cstr(strActions)&"时间表,ID["&strRecordID&"]")
			Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("Schedule")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("Schedule")&",ID["&strRecordID&"]")
	End Select

	Call fCloseADO()
	Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)	'"执行成功"
else
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
end if

%>