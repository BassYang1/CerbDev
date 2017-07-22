<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Common\Controller.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL,strOper, strRecordID,strEmployeeDesc,strEmployeeCode,strDepartmentCode,strOtherCode,strAllDay,strStartTime,strEndTime,strLeaveNum,strNote, strEmpId, strDescription
Dim strSumTotal, strTimeTemp, strAskDay, strStatus
Dim strFields, strValues
Dim strDepartmentName, strEmployeeName
Dim isEditEmpCode,arr
Dim strConditionSql
Dim oldstrValidateMode,isDelOldEmployee
strOper = Request.Form("oper")
strRecordID = Replace(Request.Form("id"),"'","''")
strEmployeeCode = Replace(Request.Form("EmployeeCode"),"'","''")
strDepartmentCode = Replace(Request.Form("DepartmentCode"),"'","''")
strOtherCode = Replace(Request.Form("OtherCode"),"'","''")

'strAllDay = Replace(Request.Form("AllDay"),"'","''")
strAllDay = 0 '非整天'
strStartTime = Replace(Request.Form("StartTime"),"'","''")
strEndTime = Replace(Request.Form("EndTime"),"'","''")
strNote = Replace(Request.Form("Note"),"'","''")
strEmpId = Replace(Request.Form("EmpId"),"'","''")

dim strUserId, strTransactorName, strTransactorId
strUserId = session("UserId")
strTransactorId = session("WorkflowApproverEmpId")
if strTransactorId = "" then strTransactorId = "0"
strTransactorName = session("WorkflowApproverEmpName")

if strOper<>"add" and strOper<>"edit" and strOper<>"del" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if 
if GetOperRole("AskForLeave",strOper) <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

if oper = "del" then
	If strStartTime = "" Then 
		Call ReturnErrMsg(GetEmpLbl("Leave_Start_Date_Not_Null"))	'"开始时间不能为空"
	end if

	If strEndTime = ""  Then 
		Call ReturnErrMsg(GetEmpLbl("Leave_End_Date_Not_Null"))	'"结束时间不能为空！"
	end if

	On Error Resume Next
	'取合计时间 ---- strSumTotal
	If strAllDay = "0" Then  '非整天	
		If DateDiff("n",CDate(strStartTime),CDate(strEndTime)) > 1440 Then 
			Call ReturnErrMsg(GetEmpLbl("Time_Over_24_Hour"))	'"加班时间不能超过24小时"
		End If

		strTimeTemp = CStr( DateDiff( "n", CDate(strStartTime), CDate(strEndTime) ) )
		strAskDay = DateDiff( "n", CDate(strStartTime), CDate(strEndTime) )/1440   '天算
		If CStr(strTimeTemp \ 1440) = "0" then
			strSumTotal = CStr( FormatNumber((strTimeTemp mod 1440)/60, 1, -1) )+ "h"
		Else
			strSumTotal = CStr(strTimeTemp \ 1440) + "d "
			If CStr(strTimeTemp mod 1440) <> "0" then
				strSumTotal = strSumTotal + CStr(FormatNumber((strTimeTemp mod 1440)/60, 1, -1))+ "h"
			End if
		End if
	'Else                       '整天
		'strStartTime = Left(strStartTime, 10) + " 00:00:00"
		'strEndTime   = Left(strEndTime, 10) + " 23:59:59"
		'strAskDay = DateDiff( "d", CDate(strTimeStart), CDate(strEndTime) ) + 1
		'strSumTotal = CStr( DateDiff( "d", CDate(strTimeStart), CDate(strEndTime) ) + 1 ) + "d"
	End If

	If Err.number <> 0 Then
		Call ReturnErrMsg(GetEmpLbl("Leave_Time_Invalid"))	'"非法时间"
	End If

	If DateDiff( "s", CDate(strTimeStart), CDate(strEndTime) ) <= 300 then
		Call ReturnErrMsg(GetEmpLbl("Leave_Time_Interval_5_Minute"))	'"开始时间不能大于等于截止时间,且间隔需大于等于5分钟"
	End If

	If strNote = "" Then 
		Call ReturnErrMsg(GetEmpLbl("OT_Reason_Not_Null"))	'"加班原因不能为空"
	end if

	If Len(strNote) > 50 Then 
		Call ReturnErrMsg(GetEmpLbl("OT_Reason_More_50_Char"))	'"加班原因只允许50个字符！"
	End if
end if

Call fConnectADODB()

'判断模板名称是否存在
strSQL=""
Select Case strOper
	Case "add": 'Add Record
		strSQL = "select 1 from AttendanceAskForLeave where EmployeeId="+CStr(strEmpId)+" and ( (StartTime<='"+CStr(strStartTime)+"' and EndTime>='"+CStr(strStartTime)+"') or (StartTime<='"+CStr(strEndTime)+"' and EndTime>='"+CStr(strEndTime)+"') or (  StartTime>='"+CStr(strStartTime)+"' and EndTime<='"+CStr(strEndTime)+"') )"
	Case "edit": 'Edit Record
		strSQL = "select 1 from AttendanceAskForLeave where AskForLeaveId<>"+CStr(strRecordID)+" and EmployeeId="+CStr(strEmpId)+"  and ( (StartTime<='"+CStr(strStartTime)+"' and EndTime>='"+CStr(strStartTime)+"') or (StartTime<='"+CStr(strEndTime)+"' and EndTime>='"+CStr(strEndTime)+"') or (  StartTime>='"+CStr(strStartTime)+"' and EndTime<='"+CStr(strEndTime)+"') )"
End Select

if	strSQL<>"" then 
	if IsExistsValue(strSQL) = true then 
		Call fCloseADO()
		Call ReturnErrMsg(GetEmpLbl("Re_Ask_For_Leave_On_Date"))	'"时间段内已被申请过请假,不能再申请！"
	end if
end if

Dim ctrlObj
set ctrlObj = new Controller
ctrlObj.DBConnection = Conn
ctrlObj.UserId = strUserId

Select Case strOper
	Case "add": 'Add Record
		if session("NeedApprovWorkflow") = 1 then
			if session("WorkflowApproverEmpId") = "" then
				Call ReturnErrMsg(GetEmpLbl("FlowOper_Not_Exist_Approver"))	'"审批人不存在"
			end if

			strStatus = getEmpLbl("FlowStatus_Applied_0")
		else 
			strStatus = getEmpLbl("FlowStatus_Approved_2")	
		end if

		strFields = " EmployeeId, StartTime, EndTime, AllDay, SumTotal, Note, Status, WorkFlowId, WorkFlowName, NowStep, NextStep, TransactorDesc, TransactorId, TransactorName "
		strValues = cstr(strEmpId)+", '"+cstr(strStartTime)+"','"+CStr(strEndTime)
		strValues = strValues + "',"+CStr(strAllDay)+",'"+cstr(strSumTotal)+"', '"+CStr(strNote)+"', '" + strStatus + " ', 0"
		strValues = strValues + ", '', 0, '0','', "+CStr(strTransactorId)+", '"+cstr(strTransactorName)+"' "
		strSQL = "Insert into AttendanceOT(" + cstr(strFields) + ")values(" + cstr(strValues) + ")"
		strSQL = strSQL + " ; insert into FlowStepDetail(FlowType, FlowDataId, StepId, Transactorid,Transactor, Operation, OperateTime) select '" + getEmpLbl("FlowType_Overtime_2") + "', OTId, 0, "+CStr(strEmpId)+", (select Name from Employees where EmployeeId="+CStr(strEmpId)+") AS TransactorName, '" + strStatus + "', getdate() from AttendanceOT where OTId=(select Max(OTId) from AttendanceOT)"
	Case "edit": 'Edit Record		
		strDescription = Replace(Request.Form("Description"),"'","''")
		If Len(strDescription) > 50 Then 
			Call fCloseADO()
			Call ReturnErrMsg(GetEmpLbl("FlowApprove_Desc_Length_50"))	'"批注/说明最多长度为50个字符！"
		End if
		strSQL = "update AttendanceOT set Status='" + getEmpLbl("FlowStatus_Approved_2") + "' where OTId=" + CStr(strRecordID)
		strSQL = strSQL + " ; insert into FlowStepDetail(FlowType, FlowDataId, StepId, Transactorid,Transactor, Operation, OperateTime, Postil) select '" + getEmpLbl("FlowType_Overtime_2") + "', OTId, 0, "+CStr(strTransactorId)+", '" + cstr(strTransactorName) + "' as TransactorName, '" + strStatus+  "', getdate(), '" + cstr(strDescription) + "' from AttendanceOT where OTId=" + strRecordID
	Case "del": 'Delete Record
		strStatus = getEmpLbl("FlowStatus_Ceased_C")	
		strSQL = "update AttendanceOT set Status='" + strStatus + "' where OTId=" + CStr(strRecordID)
		strSQL = strSQL + " ; insert into FlowStepDetail(FlowType, FlowDataId, StepId, Transactorid,Transactor, Operation, OperateTime, Postil) select '" + getEmpLbl("FlowType_Overtime_2") + "', OTId, 0, L.EmployeeId, (select Name from Employees where EmployeeId= L.EmployeeId) AS TransactorName, '" + strStatus+  "', getdate(), '" + cstr(strDescription) + "' from AttendanceOT L where OTId=" + strRecordID
End Select

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

	Select Case strOper
		Case "add": 'Add Record

			strActions = GetCerbLbl("strLogApply")
			'Call AddLogEvent("设备管理-注册卡号表-模板方式",cstr(strActions),cstr(strActions)&"注册卡号模板,模板名称["&strTemplateName&"]")
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("Attend")&"-"&GetEmpLbl("Attend_Overtime"),cstr(strActions),cstr(strActions)&GetEmpLbl("Attend_Overtime")&","&strEmpId)
		Case "edit": 'Edit Record
			strActions = GetCerbLbl("strLogApproval")
			'Call AddLogEvent("设备管理-注册卡号表-模板方式",cstr(strActions),cstr(strActions)&"注册卡号模板,ID["&strRecordID&"],修改后模板名称["&strTemplateName&"]")			
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("Attend")&"-"&GetEmpLbl("Attend_Overtime"),cstr(strActions),cstr(strActions)&GetEmpLbl("Attend_Overtime")&","&strRecordID)
		Case "del": 'Delete Record
			strActions = GetCerbLbl("strLogCease")
			'Call AddLogEvent("设备管理-注册卡号表-模板方式",cstr(strActions),cstr(strActions)&"注册卡号模板,ID["&strRecordID&"]")		
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("Attend")&"-"&GetEmpLbl("Attend_Overtime"),cstr(strActions),cstr(strActions)&GetEmpLbl("Attend_Overtime")&","&strRecordID)
	End Select
	
	Call fCloseADO()
	Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)	'"执行成功"
else
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
end if
%>