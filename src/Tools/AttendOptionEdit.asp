<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Common\Controller.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL, strOper

dim strUserId
strUserId = session("UserId")
strOper = "edit"

if GetOperRole("Options",strOper) <> true then 
	Call ReturnMsg("false", GetEmpLbl("NoRight"), 0)'您无权操作！
	response.End()
end if

'迟到规则'
Dim strLate, strLateTime, strHasLateTime
strLateTime = Trim(Replace(Request.Form("LateTime"),"'","''"))
strHasLateTime = Replace(Request.Form("HasLateTime"),"'","''")
strLate = Cstr(strLateTime) + "," + Cstr(strHasLateTime)

if strLateTime <> "" and not ISNUMERIC(strLateTime) then
	Call ReturnErrMsg(GetToolLbl("Late_Min_Not_Numeric"))	'"迟到规则时间需填写数值"
end if

'早退规则'
Dim strEarly, strEarlyTime, strHasEarlyTime
strEarlyTime = Trim(Replace(Request.Form("EarlyTime"),"'","''"))
strHasEarlyTime = Replace(Request.Form("HasEarlyTime"),"'","''")
strEarly = Cstr(strEarlyTime) + "," + Cstr(strHasEarlyTime)

if strEarlyTime <> "" and not ISNUMERIC(strEarlyTime) then
	Call ReturnErrMsg(GetToolLbl("Early_Min_Not_Numeric"))	'"早退规则时间需填写数值"
end if

'异常处理'
Dim strAbnormity
strAbnormity = Trim(Replace(Request.Form("IsAbnormity"),"'","''"))

'申请加班'
Dim strOt, strOtOn, strOtOff
strOtOn = Trim(Replace(Request.Form("IsOtOn"),"'","''"))
strOtOff = Trim(Replace(Request.Form("IsOtOff"),"'","''"))
strOt = Cstr(strOtOn) + "," + Cstr(strOtOff)

'超时加班'
Dim strOtOver, strEarlyOt, strLateOt, strOtAll, strOtBase, strOtBaseNum
strEarlyOt = Trim(Replace(Request.Form("IsEarlyOt"),"'","''"))
strLateOt = Trim(Replace(Request.Form("IsLateOt"),"'","''"))
strOtAll = Trim(Replace(Request.Form("IsOtAll"),"'","''"))
strOtBase = Trim(Replace(Request.Form("IsOtBase"),"'","''"))
strOtBaseMin = Trim(Replace(Request.Form("OtBase"),"'","''"))
strOtOver = Cstr(strEarlyOt) + "," + Cstr(strLateOt) + "," + Cstr(strOtAll) + "," + Cstr(strOtBase) + "," + Cstr(strOtBaseMin)

if strOtBaseMin <> "" and not ISNUMERIC(strOtBaseMin) then
	Call ReturnErrMsg(GetToolLbl("Ot_Over_Min_Not_Numeric"))	'"加班超时时间需填写数值"
end if

'结算周期'
Dim strTotalCycle, strStartMonth, strStartDay, strEndMonth, strEndDay
strStartMonth = Trim(Replace(Request.Form("StartMonth"),"'","''"))
strStartDay = Trim(Replace(Request.Form("StartDay"),"'","''"))
strEndMonth = Trim(Replace(Request.Form("EndMonth"),"'","''"))
strEndDay = Trim(Replace(Request.Form("EndDay"),"'","''"))
strTotalCycle = Cstr(strStartMonth) + "," + Cstr(strStartDay) + "," + Cstr(strEndMonth) + "," + Cstr(strEndDay)

'分析下班刷卡'
Dim strAnalyseOffDuty, strFirstOff, strLastOff
strFirstOff = Trim(Replace(Request.Form("IsFirstOff"),"'","''"))
strLastOff = Trim(Replace(Request.Form("IsLastOff"),"'","''"))
strAnalyseOffDuty = Cstr(strFirstOff) + "," + Cstr(strLastOff)

'出勤天数'
Dim strAnalyseWorkDay, strWorkDay, strWorkHour
strWorkDay = Trim(Replace(Request.Form("IsWorkDay"),"'","''"))
strWorkHour = Trim(Replace(Request.Form("IsWorkHour"),"'","''"))
strAnalyseWorkDay = Cstr(strWorkDay) + "," + Cstr(strWorkHour)

'流程审批'
Dim strWorkflowApproval, strApproval, strEmp, strEmpCode, strAdmin
strApproval = Trim(Replace(Request.Form("IsApproval"),"'","''"))
strEmp = Trim(Replace(Request.Form("IsEmp"),"'","''"))
strEmpCode = Trim(Replace(Request.Form("EmpCode"),"'","''"))
strAdmin = Trim(Replace(Request.Form("IsAdmin"),"'","''"))
strWorkflowApproval = Cstr(strApproval) + "," + Cstr(strEmp) + "," + Cstr(strEmpCode) + "," + Cstr(strAdmin)

if strEmp = "1" and strEmpCode = "" then
	Call ReturnErrMsg(GetToolLbl("Workflow_Approver_Empty"))	'"未填写流程审批人工号"
end if

'自动统计'
Dim strAutoTotal, isAutoTotal, strTotalHour, strTotalMinute
isAutoTotal = Trim(Replace(Request.Form("IsAutoTotal"),"'","''"))
strTotalHour = Trim(Replace(Request.Form("TotalHour"),"'","''"))
strTotalMinute = Trim(Replace(Request.Form("TotalMinute"),"'","''"))
strAutoTotal = Cstr(strTotalHour) + ":" + Cstr(strTotalMinute)

if (strTotalHour <> "" and strTotalMinute = "") or (strTotalHour = "" and strTotalMinute<> "") then
	Call ReturnErrMsg(GetToolLbl("Auto_Total_Time_Not_Valid"))	'"自动统计时间无效"
end if

if strTotalHour <> "" and strTotalMinute <> "" then
	if not ISNUMERIC(strTotalHour) or not ISNUMERIC(strTotalMinute) then
		Call ReturnErrMsg(GetToolLbl("Auto_Total_Time_Not_Valid"))	'"自动统计时间无效"
	end if

	if Cint(strTotalHour) < 0 or Cint(strTotalHour) > 23 or Cint(strTotalMinute) < 0 or Cint(strTotalMinute) > 59 then
		Call ReturnErrMsg(GetToolLbl("Auto_Total_Time_Not_Valid"))	'"自动统计时间无效"
	end if
end if

Call fConnectADODB()

'判断模板名称是否存在
strSQL=""

if strEmp = "1" and strEmpCode <> "" then
	strSQL = "select 1 from Employees where Number = '" + CStr(strEmpCode) + "' and Left(IncumbencyStatus,1)<>'1'"
end if

if	strSQL<>"" then 
	if IsExistsValue(strSQL) = true then 
		Call fCloseADO()
		Call ReturnErrMsg(GetEmpLbl("Workflow_Approver_Invalid"))	'"流程审批人无效"
	end if
end if

On Error Resume NEXT

'迟到规则'
strSQL = "update options set VariableValue='"+cstr(strLate)+"' where VariableName='strLate' ; "

'早退规则'
strSQL = strSQL + "update options set VariableValue='"+cstr(strEarly)+"' where VariableName='strLeaveEarly';"

'异常处理'
strSQL = strSQL + "update options set VariableValue='"+cstr(strAbnormity)+"' where VariableName='strAbnormity';"

'申请加班'
strSQL = strSQL + "update options set VariableValue='"+cstr(strOt)+"' where VariableName='strOnduty';"

'超时加班'
strSQL = strSQL + "update options set VariableValue='"+cstr(strOtOver)+"' where VariableName='strOTType';"

'结算周期'
strSQL = strSQL + "update options set VariableValue='"+cstr(strTotalCycle)+"' where VariableName='strTotalCycle';"

'分析下班刷卡'
strSQL = strSQL + "update options set VariableValue='"+cstr(strAnalyseOffDuty)+"' where VariableName='strAnalyseOffDuty';"

'出勤天数'
strSQL = strSQL + "update options set VariableValue='"+cstr(strAnalyseWorkDay)+"' where VariableName='blnAnalyseWorkDay';"

'流程审批'
strSQL = strSQL + "update options set VariableValue='"+cstr(strWorkflowApproval)+"' where VariableName='strWorkflowApproval';"

'自动统计'
strSQL = strSQL + "update options set VariableValue='"+cstr(isAutoTotal)+"' where VariableName='blnautoTotal';"
strSQL = strSQL + "update options set VariableValue='"+cstr(strAutoTotal)+"' where VariableName='datAutotime';"

'response.write strSQL
'response.end

if	strSQL<>"" then 
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",Err.Description,0)
		On Error GoTo 0
		response.End()
	end if

	strActions = GetCerbLbl("strLogEdit")		
	Call AddLogEvent(GetToolLbl("Tool")&"-"&GetToolLbl("Options"),cstr(strActions),cstr(strActions)&GetToolLbl("Options")&","&GetToolLbl("UserID")&":"&strUserId)
	
	Call fCloseADO()
	Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)	'"执行成功"
else
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
end if
%>