<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL,strOper, strRecordID, strControllerId, strControllerNumber, strControllerName,strLocation,strIP,strMASK,strGateWay,strDNS,strDNS2,strEnableDHCP,strWorkType,strServerIP,strStorageMode,strIsFingerprint,strAntiPassBackType,strCardReader1,strCardReader2,strSystemPassword,strDataUpdateTime,strWaitTime,strCloseLightTime,strDownPhoto,strDownFingerprint,strSound,strBoardType
Dim iNewId,strActions

strOper = request.Form("oper")
strRecordID = Replace(request.Form("id"),"'","''")
strControllerId = Replace(request.Form("ControllerId"),"'","''")
strControllerNumber = Replace(request.Form("ControllerNumber"),"'","''")
strControllerName = Replace(request.Form("ControllerName"),"'","''")
strLocation = Replace(request.Form("Location"),"'","''")
strIP = Replace(request.Form("IP"),"'","''")
strMASK = Replace(request.Form("MASK"),"'","''")
strGateWay = Replace(request.Form("GateWay"),"'","''")
strDNS = Replace(request.Form("DNS"),"'","''")
strDNS2 = Replace(request.Form("DNS2"),"'","''")
strEnableDHCP = Replace(request.Form("EnableDHCP"),"'","''")
strWorkType = Replace(request.Form("WorkType"),"'","''")
strServerIP = Replace(request.Form("ServerIP"),"'","''")
strStorageMode = Replace(request.Form("StorageMode"),"'","''")
strIsFingerprint = Replace(request.Form("IsFingerprint"),"'","''")
strAntiPassBackType = Replace(request.Form("AntiPassBackType"),"'","''")
strCardReader1 = Replace(request.Form("CardReader1"),"'","''")
strCardReader2 = Replace(request.Form("CardReader2"),"'","''")
strSystemPassword = trim(Replace(request.Form("SystemPassword"),"'","''"))
strDataUpdateTime = trim(Replace(request.Form("DataUpdateTime"),"'","''"))
strWaitTime = trim(Replace(request.Form("WaitTime"),"'","''"))
strCloseLightTime = trim(Replace(request.Form("CloseLightTime"),"'","''"))
strDownPhoto = trim(Replace(request.Form("DownPhoto"),"'","''"))
strDownFingerprint = trim(Replace(request.Form("DownFingerprint"),"'","''"))
strSound = trim(Replace(request.Form("Sound"),"'","''"))
strBoardType = trim(Replace(request.Form("BoardType"),"'","''"))

if strOper<>"add" and strOper<>"edit" and strOper<>"del" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if 

if GetOperRole("BasicData",strOper) <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

if strEnableDHCP = "" then strEnableDHCP =0 end if
if strIsFingerprint= "" then strIsFingerprint =0 end if
if strAntiPassBackType = "" then strAntiPassBackType = 0 end if
if strDataUpdateTime = "" then	strDataUpdateTime=60 end if
if strWaitTime = "" then  strWaitTime = 1 end if
if strCloseLightTime = "" then  strCloseLightTime= 1 end if
if strDownPhoto = "" then strDownPhoto =0 end if
if strDownFingerprint= "" then strDownFingerprint =0 end if
if strSound = "" then strSound = 8 end if
if strBoardType= "" then strBoardType =GetEquLbl("BoardTypeAcs") end if	'0-门禁控制
if strEnableDHCP=1 then 
	strIP = ""
	strMASK= ""
	strGateWay = ""
	strDNS = ""
	strDNS2 = ""
end if

Call fConnectADODB()

'判断设备编号是否存在 
strSQL=""
Select Case strOper
	Case "add": 'Add Record
	strSQL = "Select 1 from Controllers where ControllerNumber='"&strControllerNumber&"'"
	Case "edit": 'Edit Record
	strSQL = "Select 1 from Controllers where ControllerNumber='"&strControllerNumber&"' and ControllerId <> "&strRecordID
End Select
if	strSQL<>"" then 
	if IsExistsValue(strSQL) = true then 
		Call fCloseADO()
		Call ReturnMsg("false",GetEquLbl("ConNumUsed"),0)	'设备编号已使用
		response.End()
	end if
end if

'判断设备名称是否存在 
strSQL=""
Select Case strOper
	Case "add": 'Add Record
	strSQL = "Select 1 from Controllers where ControllerName='"&strControllerName&"'"
	Case "edit": 'Edit Record
	strSQL = "Select 1 from Controllers where ControllerName='"&strControllerName&"' and ControllerId <> "&strRecordID
End Select
if	strSQL<>"" then 
	if IsExistsValue(strSQL) = true then 
		Call fCloseADO()
		Call ReturnMsg("false",GetEquLbl("ConNameUsed"),0)	'设备名称已使用
		response.End()
	end if
end if

'判断IP是否存在 
if strEnableDHCP <> "1" then 
	strSQL=""
	Select Case strOper
		Case "add": 'Add Record
		strSQL = "Select 1 from Controllers where IP='"&strIP&"'"
		Case "edit": 'Edit Record
		strSQL = "Select 1 from Controllers where IP='"&strIP&"' and ControllerId <> "&strRecordID
	End Select
	if	strSQL<>"" then 
		if IsExistsValue(strSQL) = true then 
			Call fCloseADO()
			Call ReturnMsg("false",GetEquLbl("ConIPUsed"),0)	'IP已使用
			response.End()
		end if
	end if
end if

strSQL=""
Select Case strOper
	Case "add": 'Add Record
	strSQL = "insert into Controllers(ControllerNumber,ControllerName,Location,IP,MASK,GateWay,DNS,DNS2,EnableDHCP,WorkType,ServerIP,StorageMode,IsFingerprint,AntiPassBackType,DoorType,CardReader1,CardReader2,SystemPassword,DataUpdateTime,WaitTime,CloseLightTime,DownPhoto,DownFingerprint,Sound,BoardType) Values("&"'"&strControllerNumber&"','"&strControllerName&"','"&strLocation&"','"&strIP&"','"&strMASK&"','"&strGateWay&"','"&strDNS&"','"&strDNS2&"',"&strEnableDHCP&",'"&strWorkType&"','"&strServerIP&"','"&strStorageMode&"',"&strIsFingerprint&","&strAntiPassBackType&",'2','"&strCardReader1&"','"&strCardReader2&"','"&strSystemPassword&"',"&strDataUpdateTime&","&strWaitTime&","&strCloseLightTime&","&strDownPhoto&","&strDownFingerprint&","&strSound&",'"&strBoardType&"') "
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",GetEquLbl("AddConError"),0)	'增加设备出错
		On Error GoTo 0
		response.End()
	end if
	iNewId = GetMaxID("ControllerId","Controllers")
	
	strSQL = ""
	strSQL = strSQL +"INSERT [ControllerHoliday] ([ControllerId],[HolidayCode],TemplateId,[TemplateName],Status)  "
	strSQL = strSQL +"           select "+CStr(iNewId)+",1,0,'',0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",2,0,'',0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",3,0,'',0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",4,0,'',0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",5,0,'',0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",6,0,'',0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",7,0,'',0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",8,0,'',0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",9,0,'',0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",10,0,'',0"
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",GetEquLbl("AddHolidayError"),0)	'增加假期表出错
		On Error GoTo 0
		response.End()
	end if
	
	strSQL = ""
	strSQL = strSQL +"INSERT [ControllerSchedule] ([ControllerId],[ScheduleCode],TemplateId,[TemplateName],[Status]) "
	strSQL = strSQL +"           select "+CStr(iNewId)+",1,1,'"+GetEquLbl("Schedule024")+"',0"	'0 - 24H进出
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",2,0,NULL,0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",3,0,NULL,0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",4,0,NULL,0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",5,0,NULL,0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",6,0,NULL,0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",7,0,NULL,0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",8,0,NULL,0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",9,0,NULL,0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",10,0,NULL,0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",11,0,NULL,0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",12,0,NULL,0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",13,0,NULL,0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",14,0,NULL,0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",15,0,NULL,0"
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",GetEquLbl("AddScheduleError"),0)	'增加时间表出错
		On Error GoTo 0
		response.End()
	end if
	
	strSQL = ""
	strSQL = strSQL +"Insert Into ControllerInOut(ControllerId,InoutPoint,InoutDesc,ScheduleID,ScheduleName,Out1,Out2,Out3,Out4,Out5,Status) "
	strSQL = strSQL +"           select "+CStr(iNewId)+",1,'',1,'"+GetEquLbl("Schedule024")+"',3000,0,0,0,0,0"			'0 - 24H进出			
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",2,'',null,null,0,0,0,0,0,0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",3,'',null,null,0,0,0,0,0,0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",4,'',null,null,0,0,0,0,0,0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",5,'',null,null,0,0,0,0,0,0"
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",6,'"+GetEquLbl("RD1Valid")+"',null,null,3000,0,0,0,0,0"		'读卡器1-有效卡
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",7,'"+GetEquLbl("RD1Illegal")+"',null,null,0,0,0,0,0,0"		'读卡器1-非法卡
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",8,'"+GetEquLbl("RD1IllegalTime")+"',null,null,0,0,0,0,0,0"		'读卡器1-非法时段
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",9,'"+GetEquLbl("RD1AntiPassBack")+"',null,null,0,0,0,0,0,0"		'读卡器1-防遣返
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",10,'"+GetEquLbl("RD2Valid")+"',null,null,0,3000,0,0,0,0"	'读卡器2-有效卡
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",11,'"+GetEquLbl("RD2Illegal")+"',null,null,0,0,0,0,0,0"		'读卡器2-非法卡
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",12,'"+GetEquLbl("RD2IllegalTime")+"',null,null,0,0,0,0,0,0"		'读卡器2-非法时段
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",13,'"+GetEquLbl("RD2AntiPassBack")+"',null,null,0,0,0,0,0,0"		'读卡器2-防遣返
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",14,'"+GetEquLbl("DoorNO")+"',null,null,0,0,0,0,0,0"				'门-常开
	strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",15,'"+GetEquLbl("DoorNC")+"',null,null,0,0,0,0,0,0"				'门-常闭
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",GetEquLbl("AddInOutError"),0)		'"增加设备输入输出表出错"
		On Error GoTo 0
		response.End()
	end if
	
	strSQL = ""			
	strSQL = strSQL + "Insert into ControllerDataSync(ControllerId,SyncType,SyncStatus,SyncTime) values ("+CStr(iNewId)+", 'register', '0', GetDate()) ;"
	strSQL = strSQL + "Insert into ControllerDataSync(ControllerId,SyncType,SyncStatus,SyncTime) values ("+CStr(iNewId)+", 'schedule', '0', GetDate()) ;"
	strSQL = strSQL + "Insert into ControllerDataSync(ControllerId,SyncType,SyncStatus,SyncTime) values ("+CStr(iNewId)+", 'holiday', '0', GetDate()) ;"
	strSQL = strSQL + "Insert into ControllerDataSync(ControllerId,SyncType,SyncStatus,SyncTime) values ("+CStr(iNewId)+", 'inout', '0', GetDate()) ;"
	strSQL = strSQL + "Insert into ControllerDataSync(ControllerId,SyncType,SyncStatus,SyncTime) values ("+CStr(iNewId)+", 'controller', '0', GetDate()) ;"
	strSQL = strSQL + "Insert into ControllerDataSync(ControllerId,SyncType) values ("+CStr(iNewId)+", 'online') ;"
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",GetEquLbl("AddDataSyncError"),0)	'增加设备同步表数据出错
		On Error GoTo 0
		response.End()
	end if
		
	Case "edit": 'Edit Record
	strSQL = "Update Controllers Set ControllerNumber ='"&strControllerNumber&"',ControllerName = '"&strControllerName&"', Location = '"&strLocation&"', IP = '"&strIP&"', MASK = '"&strMASK&"', GateWay = '"&strGateWay&"', DNS = '"&strDNS&"', DNS2 = '"&strDNS2&"', EnableDHCP = '"&strEnableDHCP&"', WorkType = '"&strWorkType&"', ServerIP = '"&strServerIP&"', StorageMode = '"&strStorageMode&"', IsFingerprint = '"&strIsFingerprint&"', AntiPassBackType = '"&strAntiPassBackType&"', DoorType = '2', CardReader1 = '"&strCardReader1&"', CardReader2 = '"&strCardReader2&"', SystemPassword = '"&strSystemPassword&"', DataUpdateTime = '"&strDataUpdateTime&"', WaitTime = '"&strWaitTime&"', CloseLightTime = '"&strCloseLightTime&"', DownPhoto = '"&strDownPhoto&"', DownFingerprint = '"&strDownFingerprint&"', Sound = '"&strSound&"', BoardType = '"&strBoardType&"' Where ControllerId = "&strRecordID
	strSQL = strSQL+"; Update ControllerDataSync set SyncStatus=0,Synctime=Getdate(),TrueTimeInfo='Web' where ControllerID="&strRecordID&" and SyncType='controller' "
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",GetEquLbl("EditConError"),0)	'修改设备出错
		On Error GoTo 0
		response.End()
	end if
	
	Case "del": 'Delete Record
	strSQL = ""
	strSQL = strSQL + "Delete From RoleController Where ControllerId in ("&strRecordID&"); "
	strSQL = strSQL + "Delete From ControllerHoliday Where ControllerId in ("&strRecordID&"); "
	strSQL = strSQL + "Delete From ControllerSchedule Where ControllerId in ("&strRecordID&"); "
	strSQL = strSQL + "Delete From ControllerInOut Where ControllerId in ("&strRecordID&"); "
	strSQL = strSQL + "Delete From ControllerEmployee Where ControllerId in ("&strRecordID&"); "
	strSQL = strSQL + "Delete From ControllerDataSync Where ControllerId in ("&strRecordID&"); "
	strSQL = strSQL + "Delete From Controllers Where ControllerId in ("&strRecordID&")"
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",GetEquLbl("DelConError"),0)	'"删除设备出错"
		On Error GoTo 0
		response.End()
	end if
End Select
'response.Write strSQL
'response.Write("{"&chr(34)&"success"&chr(34)&":true,"&chr(34)&"message"&chr(34)&":"&chr(34)&"保存失败"&chr(34)&"}")

if strOper<>"add" and strOper<>"edit" and strOper<>"del" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	Call fCloseADO()
	response.End()
end if

Select Case strOper
	Case "add": 'Add Record
		strActions = GetCerbLbl("strLogAdd")
		strRecordID=iNewId
		'Call AddLogEvent("设备管理-基本资料",cstr(strActions),cstr(strActions)&"基本资料,设备ID["&strRecordID&"]")
		Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("BasicData"),cstr(strActions),cstr(strActions)&GetEquLbl("BasicData")&","&GetEquLbl("ConID")&"["&strRecordID&"]")
	Case "edit": 'Edit Record
		strActions = GetCerbLbl("strLogEdit")
		'Call AddLogEvent("设备管理-基本资料",cstr(strActions),cstr(strActions)&"基本资料,设备ID["&strRecordID&"]")
		Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("BasicData"),cstr(strActions),cstr(strActions)&GetEquLbl("BasicData")&","&GetEquLbl("ConID")&"["&strRecordID&"]")
	Case "del": 'Delete Record
		strActions = GetCerbLbl("strLogDel")
		Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("BasicData"),cstr(strActions),cstr(strActions)&GetEquLbl("BasicData")&","&GetEquLbl("ConID")&"["&strRecordID&"]")
End Select
Call fCloseADO()
Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),strRecordID)	'"执行成功"

%>