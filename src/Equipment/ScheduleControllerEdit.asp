﻿<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL,strControllerID, strEditData,strAddData, strHolidayCode,strTempName,strActions,strUsedTemplateId
strControllerID = Request.Form("ControllerID")
strEditData = Request.Form("strEdit")
strAddData = Request.Form("strAdd")
strUsedTemplateId = ""

'response.Write(strID&"<br>"&strAddData&"<br>"&strEditData&"<br>"&strDelRowID)
if	strControllerID="" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if
if GetOperRole("ScheduleController","edit") <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if
Call fConnectADODB()

'
Dim EditArray,AddArray
if	strEditData<>"" then 
	EditArray = split(strEditData,"||")
	If	IsArray(EditArray) then 
		For i = 0 To UBound(EditArray)
			Row = split(EditArray(i),",,")
			'判断是否重复选择了时间表模板，如果是，则第一个选择的有效，后面重复的将清空
			if Instr(strUsedTemplateId, Row(1)) > 0 then 
				Row(1) = "0"
				Row(2) = ""
			else 
				strUsedTemplateId = strUsedTemplateId&Row(1)&","
			end if

			'提交的字段顺序 ScheduleCode,TemplateId,TemplateName 
			strSQL = "UPDATE ControllerSchedule set TemplateId='"&Row(1)&"',TemplateName = '"&Row(2)&"',status=0 where ControllerId="&strControllerID&" and ScheduleCode="&Row(0)
			On Error Resume Next
			Conn.Execute strSQL
			if err.number <> 0 then
				Call fCloseADO()
				Call ReturnMsg("false",GetEquLbl("EditScheduleError"),0)	'"修改时间表出错"
				On Error GoTo 0
				response.End()
			end if
		Next 
	End if
end if
if	strAddData<>"" then 
	AddArray = split(strAddData,"||")
	If	IsArray(AddArray) then 
		For i = 0 To UBound(AddArray)
			Row = split(AddArray(i),",,")
			'判断是否重复选择了时间表模板，如果是，则第一个选择的有效，后面重复的将清空
			if Instr(strUsedTemplateId, Row(1)) > 0 then 
				Row(1) = "0"
				Row(2) = ""
			else 
				strUsedTemplateId = strUsedTemplateId&Row(1)&","
			end if

			'提交的字段顺序 ScheduleCode,TemplateId,TemplateName 
			strSQL = "INSERT INTO ControllerSchedule(ControllerId,ScheduleCode,TemplateId,TemplateName,Status) Values("&strControllerID&","&Row(0)&",'"&Row(1)&"','"&Row(2)&"',0)"
			On Error Resume Next
			Conn.Execute strSQL
			if err.number <> 0 then
				Call fCloseADO()
				Call ReturnMsg("false",GetEquLbl("EditScheduleError"),0)	'"修改时间表出错"
				On Error GoTo 0
				response.End()
			end if
		Next 
	End if
end if

if	strEditData<>"" or strAddData<>"" then 
	strSQL = "update ControllerDataSync set SyncStatus=0,SyncTime=GETDATE() where ControllerId="&strControllerID&" and SyncType='schedule' "
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",GetEquLbl("SyncScheduleError"),0)	'"同步时间表出错"
		On Error GoTo 0
		response.End()
	end if
end if


strActions = GetCerbLbl("strLogEdit")
'Call AddLogEvent("设备管理-时间表-设备方式",cstr(strActions),cstr(strActions)&"设备时间表,设备ID["&strControllerID&"]")
Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("Schedule")&"-"&GetEquLbl("DeviceMode"),cstr(strActions),cstr(strActions)&GetEquLbl("ConSchedule")&","&GetEquLbl("ConID")&"["&strControllerID&"]")
	
Call fCloseADO()
Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)	'"执行成功"

%>