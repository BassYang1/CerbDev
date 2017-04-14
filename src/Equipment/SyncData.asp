<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL, strControllerId,strType,strTemplateId,strRegisterSyncOpt,strRecordID
Dim iNewId,strActions,strLogMsg

strControllerId = request.Form("ControllerId")
strType = request.QueryString("type")
strTemplateId = request.Form("TemplateId")
strRegisterSyncOpt = request.QueryString("syncOpt")

Call fConnectADODB()

if strType="all" then 
	strSQL = ""

	strSQL = strSQL&"Update ControllerSchedule set Status=0 where ControllerID in ("&strControllerId&"); "
	strSQL = strSQL&"Update ControllerHoliday set Status=0 where ControllerID in ("&strControllerId&"); "
	strSQL = strSQL&"Update ControllerInout set Status=0 where ControllerID in ("&strControllerId&"); "
	strSQL = strSQL&"Update ControllerEmployee set Status=0 where ControllerID in ("&strControllerId&"); "
	strSQL = strSQL&"Delete ControllerDataSync where ControllerID in ("&strControllerId&") and SyncType in ('register','schedule','holiday','inout','controller'); "
	strSQL = strSQL&"Insert into ControllerDataSync(ControllerId,SyncType,SyncStatus,SyncTime) Select ControllerId, 'register', '0', GetDate() from Controllers where ControllerId in ("&strControllerId&"); "
	strSQL = strSQL&"Insert into ControllerDataSync(ControllerId,SyncType,SyncStatus,SyncTime) Select ControllerId, 'schedule', '0', GetDate() from Controllers where ControllerId in ("&strControllerId&"); "
	strSQL = strSQL&"Insert into ControllerDataSync(ControllerId,SyncType,SyncStatus,SyncTime) Select ControllerId, 'holiday', '0', GetDate() from Controllers where ControllerId in ("&strControllerId&"); "
	strSQL = strSQL&"Insert into ControllerDataSync(ControllerId,SyncType,SyncStatus,SyncTime) Select ControllerId, 'inout', '0', GetDate() from Controllers where ControllerId in ("&strControllerId&"); "
	strSQL = strSQL&"Insert into ControllerDataSync(ControllerId,SyncType,SyncStatus,SyncTime) Select ControllerId, 'controller', '0', GetDate() from Controllers where ControllerId in ("&strControllerId&"); "
	
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",GetEquLbl("SyncBasicError"),0)	'"同步基本资料出错"
		On Error GoTo 0
		response.End()
	end if
	strActions = GetCerbLbl("strLogSync")
	'Call AddLogEvent("设备管理-基本资料",cstr(strActions),cstr(strActions)&"基本资料,设备ID["&strControllerId&"]")
	Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("BasicData"),cstr(strActions),cstr(strActions)&GetEquLbl("BasicData")&","&GetEquLbl("ConID")&"["&strControllerId&"]")
	
elseif strType="holiday" then 
	'Holiday	
	if strTemplateId <> "" then 
		strSQL = "update ControllerHoliday set Status=0 where TemplateId IN ("&strTemplateId&"); "
		strSQL = strSQL&"update ControllerDataSync set SyncStatus=0,SyncTime=GETDATE() where controllerid IN (select Distinct ControllerId from ControllerHoliday where TemplateId IN ("&strTemplateId&") ) and SyncType='holiday' "
	else
		strSQL = "update ControllerHoliday set Status=0 where controllerid IN ("&strControllerId&"); "
		strSQL = strSQL&"update ControllerDataSync set SyncStatus=0,SyncTime=GETDATE() where controllerid IN ("&strControllerId&") and SyncType='holiday' "
	end if
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",GetEquLbl("SyncHolidayError"),0)		'同步假期表出错
		On Error GoTo 0
		response.End()
	end if
	strActions = GetCerbLbl("strLogSync")
	if strTemplateId <> "" then 
		'Call AddLogEvent("设备管理-假期表-模板方式",cstr(strActions),cstr(strActions)&"假期表,假期模板ID["&strTemplateId&"]")
		Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("Holiday")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("Holiday")&","&GetEquLbl("Template")&" ID["&strTemplateId&"]")
	else
		'Call AddLogEvent("设备管理-假期表-设备方式",cstr(strActions),cstr(strActions)&"假期表,设备ID["&strControllerId&"]")
		Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("Holiday")&"-"&GetEquLbl("DeviceMode"),cstr(strActions),cstr(strActions)&GetEquLbl("Holiday")&","&GetEquLbl("ConID")&"["&strControllerId&"]")
	end if
	
elseif strType="schedule" then 
	'Schedule
	if strTemplateId <> "" then 
		strSQL = "update ControllerSchedule set Status=0 where TemplateId IN ("&strTemplateId&"); "
		strSQL = strSQL&"update ControllerDataSync set SyncStatus=0,SyncTime=GETDATE() where controllerid IN (select Distinct ControllerId from ControllerSchedule where TemplateId IN ("&strTemplateId&") ) and SyncType='schedule' "
	else
		strSQL = "update ControllerSchedule set Status=0 where controllerid IN ("&strControllerId&"); "
		strSQL = strSQL&"update ControllerDataSync set SyncStatus=0,SyncTime=GETDATE() where controllerid IN ("&strControllerId&") and SyncType='schedule' "
	end if
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",GetEquLbl("SyncScheduleError"),0)	'"同步时间表出错"
		On Error GoTo 0
		response.End()
	end if
	strActions = GetCerbLbl("strLogSync")
	if strTemplateId <> "" then 
		'Call AddLogEvent("设备管理-时间表-模板方式",cstr(strActions),cstr(strActions)&"时间表,时间模板ID["&strTemplateId&"]")
		Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("Schedule")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("Schedule")&","&GetEquLbl("Template")&" ID["&strTemplateId&"]")
	else
		'Call AddLogEvent("设备管理-时间表-设备方式",cstr(strActions),cstr(strActions)&"时间表,设备ID["&strControllerId&"]")
		Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("Schedule")&"-"&GetEquLbl("DeviceMode"),cstr(strActions),cstr(strActions)&GetEquLbl("Schedule")&","&GetEquLbl("ConID")&"["&strControllerId&"]")
	end if

elseif strType="inout" then 
	'Schedule
	strSQL = "update ControllerInout set Status=0 where controllerid IN ("&strControllerId&"); "
	strSQL = strSQL&"update ControllerDataSync set SyncStatus=0,SyncTime=GETDATE() where controllerid IN ("&strControllerId&") and SyncType='inout' "
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",GetEquLbl("SyncInOutError"),0)		'"同步输入输出表出错"
		On Error GoTo 0
		response.End()
	end if
	strActions = GetCerbLbl("strLogSync")
	'Call AddLogEvent("设备管理-输入输出表-设备方式",cstr(strActions),cstr(strActions)&"输入输出表,设备ID["&strControllerId&"]")
	Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("Inout")&"-"&GetEquLbl("DeviceMode"),cstr(strActions),cstr(strActions)&GetEquLbl("Inout")&","&GetEquLbl("ConID")&"["&strControllerId&"]")
	
elseif strType="register" then 
	'Schedule
	strSQL = ""
	if strRegisterSyncOpt = "all" then 
		strSQL = "update ControllerEmployee set Status=0 where controllerid IN ("&strControllerId&") ; "
	elseif strRegisterSyncOpt = "part" then 
		strRecordID = Request.Form("RecordID")
		strSQL = "update ControllerEmployee set Status=0 where RecordID IN ("&strRecordID&") ; "
	end if
	strSQL = strSQL&"update ControllerDataSync set SyncStatus=0,SyncTime=GETDATE() where controllerid IN ("&strControllerId&") and SyncType='register' "
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",GetEquLbl("SyncRegcardError"),0)	'"同步注册卡号表出错"
		On Error GoTo 0
		response.End()
	end if
	strActions = GetCerbLbl("strLogSync")
	
	'strLogMsg = cstr(strActions)&"注册卡号表,设备ID["&strControllerId&"]"
	strLogMsg = cstr(strActions)&GetEquLbl("RegCard")&","&GetEquLbl("ConID")&"["&strControllerId&"]"
	if strRegisterSyncOpt = "all" then 
		strLogMsg = strLogMsg & ","&GetEquLbl("SyncAll")	'同步所有数据
	elseif strRegisterSyncOpt = "part" then 
		strLogMsg = strLogMsg & ","&GetEquLbl("SyncPart")&",RecordID["&strRecordID&"]"	'同步部分数据
	else 
		strLogMsg = strLogMsg & ","&GetEquLbl("SyncChange")	'同步变更数据
	end if
	'Call AddLogEvent("设备管理-注册卡号表-设备方式",cstr(strActions),strLogMsg)
	Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("RegCard")&"-"&GetEquLbl("DeviceMode"),cstr(strActions),strLogMsg)
end if


Call fCloseADO()
Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)	'"执行成功"

%>