<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
CheckLoginStatus("parent.location.href='../login.html'")
CheckOperPermissions()

dim strSQL,strActions
dim strEmvalues,strConvalues,strselSchedule,strselDoor,strtxtFloor,strselMode,arrConValue,strOper
dim strRecordID '删除注册卡号时使用，为ControllerEmployee表的Recordid

response.Charset="utf-8"
strOper = request.Form("oper")
strEmvalues = Replace(request.Form("Emvalues"),"'","''")
strConvalues = Replace(request.Form("Convalues"),"'","''")
strselSchedule = Replace(request.Form("selSchedule"),"'","''")
strselMode = Replace(request.Form("selMode"),"'","''")
strselDoor = Replace(request.Form("selDoor"),"'","''")
strtxtFloor = Replace(request.Form("txtFloor"),"'","''")

arrConValue = Split(strConvalues, ",")

if strOper<>"add" and strOper<>"edit" and strOper<>"del" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if 

if GetOperRole("RegCard",strOper) <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

fConnectADODB()

if strOper = "add" then 
	'先注册时间表
	For i=0 To UBound(arrConValue)
		'判断当前时间表ID是否已经注册到设备上
		strSQL = " select 1 from ControllerSchedule where ControllerId="&CStr(arrConValue(i))&" and TemplateId="&strselSchedule
		if IsExistsValue(strSQL) = false then 
			'没注册的，则找一个未使用最小的ScheduleCode来注册该时间表
			strSQL = " update ControllerSchedule set TemplateId="&strselSchedule&",TemplateName=(select top 1 TemplateName from ControllerTemplates where TemplateId="&strselSchedule&" ),Status=0 where  ControllerId="&CStr(arrConValue(i))&" and ScheduleCode=(select Min(ScheduleCode) from ControllerSchedule where ControllerId="&CStr(arrConValue(i))&" and  ISNULL(TemplateId,0)=0 ) ;  "
		strSQL = strSQL + " update ControllerDataSync set SyncStatus=0,SyncTime=GETDATE() where ControllerId="&CStr(arrConValue(i))&" and SyncType='schedule' "
			On Error Resume Next
			Conn.Execute strSQL
			if err.number <> 0 then
				Call fCloseADO()
				'Call ReturnMsg("false","注册时间表到设备:[ControllerId="+CStr(arrConValue(i))+"]时出错！"+Err.Description,0)
				Call ReturnMsg("false",GetEquLbl("RegScheduleErr1")+"[ControllerId="+CStr(arrConValue(i))+"]"+GetEquLbl("RegScheduleErr2")+Err.Description,0)
				On Error GoTo 0
				response.End()
			end if
		end if
	Next
	
	'注册卡号
	For i=0 To UBound(arrConValue)
		strSQL = "delete from ControllerEmployee where ControllerId in("+CStr(arrConValue(i))+") and Employeeid in("+CStr(strEmvalues)+"); "
		strSQL = strSQL + "insert into ControllerEmployee(ControllerId,E.Employeeid,UserPassword,ScheduleCode,EmployeeDoor,DeleteFlag, Status, ValidateMode,Floor) select "+cstr(arrConValue(i))+", E.Employeeid, U.UserPassword,'"+cstr(strselSchedule)+"','"+CStr(strselDoor)+"','0', '0', '"+strselMode+"','"+ strtxtFloor +"' from Employees E left Join Users U on E.Employeeid=U.Employeeid where E.EmployeeId in("+CStr(strEmvalues)+") and  Left(IncumbencyStatus,1)<>'1' and Card>0 ;"
	
		On Error Resume Next
		Conn.Execute strSQL
		if err.number <> 0 then
			Call fCloseADO()
			'Call ReturnMsg("false","注册卡号到设备:[ControllerId="+CStr(arrConValue(i))+"]时出错！"+Err.Description,0)
			Call ReturnMsg("false",GetEquLbl("RegCardErr1")+"[ControllerId="+CStr(arrConValue(i))+"]"+GetEquLbl("RegCardErr2")+Err.Description,0)
			On Error GoTo 0
			response.End()
		end if
	Next
	
	strSQL = "update ControllerDataSync set SyncStatus=0,SyncTime=GETDATE() where ControllerId in ("&strConvalues&") and SyncType='register' "
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		'Call ReturnMsg("false","同步到设备:[ControllerId="+CStr(strConvalues)+"]时出错！"+Err.Description,0)
		Call ReturnMsg("false",GetEquLbl("RegSyncToConErr1")+"[ControllerId="+CStr(strConvalues)+"]"+GetEquLbl("RegSyncToConErr2")+Err.Description,0)
		On Error GoTo 0
		response.End()
	end if
		
elseif strOper = "del" then 
	strRecordID = request.Form("RecordID")
	if strRecordID <> "" then 
		strSQL = "update ControllerEmployee set DeleteFlag=1,Status=0 where  RecordId in("+CStr(strRecordID)+"); "
		strSQL = strSQL + " update ControllerDataSync set SyncStatus=0,SyncTime=GETDATE() where ControllerId in ("&strConvalues&") and SyncType='register' "
		On Error Resume Next
		Conn.Execute strSQL
		if err.number <> 0 then
			Call fCloseADO()
			'Call ReturnMsg("false","删除注册卡号:[RecordID="+CStr(strRecordID)+"]时出错！"+Err.Description,0)
			Call ReturnMsg("false",GetEquLbl("DelRegErr1")+"[RecordID="+CStr(strRecordID)+"]"+GetEquLbl("DelRegErr2")+Err.Description,0)
			On Error GoTo 0
			response.End()
		end if
	end if
	
end if

'[objects]字段最长度为2000
if len(strEmvalues) > 1800 then 
	strEmvalues = LEFT(strEmvalues,1800)&"......"
end if

Select Case strOper
	Case "add": 'Add Record
		strActions = GetCerbLbl("strLogAdd")
		'Call AddLogEvent("设备管理-注册卡号表-设备方式",cstr(strActions),cstr(strActions)&"注册卡号,设备ID["&strConvalues&"],员工ID["&strEmvalues&"],验证方式["&strselMode&"]")
		Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("RegCard")&"-"&GetEquLbl("DeviceMode"),cstr(strActions),cstr(strActions)&GetEquLbl("RegCard2")&","&GetEquLbl("ConID")&"["&strConvalues&"],"&GetEmpLbl("EmpID")&"["&strEmvalues&"],"&GetEquLbl("ValidateMode")&"["&strselMode&"]")
	Case "del": 'Delete Record
		strActions = GetCerbLbl("strLogDel")
		'Call AddLogEvent("设备管理-注册卡号表-设备方式",cstr(strActions),cstr(strActions)&"注册卡号,设备ID["&strConvalues&"],员工ID["&strEmvalues&"]")
		Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("RegCard")&"-"&GetEquLbl("DeviceMode"),cstr(strActions),cstr(strActions)&GetEquLbl("RegCard2")&","&GetEquLbl("ConID")&"["&strConvalues&"],"&GetEmpLbl("EmpID")&"["&strEmvalues&"]")
End Select

Call fCloseADO()
Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)	'"执行成功"
	
%>