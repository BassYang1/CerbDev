<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Common\Controller.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")

Dim strSQL,strOper, strRecordID, strLeaveType,strEmployeeDesc,strEmployeeCode,strDepartmentCode,strOtherCode,strBrushTime,strRemark, strEmpId
Dim strStatus, blnRefuse
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

blnRefuse = Replace(Request.Form("Refuse"),"'","''")

if strOper = "edit" and blnRefuse = "" then
	Call ReturnErrMsg(GetEmpLbl("IllegalOperate")) '非法操作！"
end if

strBrushTime = Replace(Request.Form("BrushTime"),"'","''")
strRemark = Replace(Request.Form("Remark"),"'","''")
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

if CheckWorkflowPermission(strOper) <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

if strOper <> "del" then
	If strBrushTime = "" Then 
		Call ReturnErrMsg(GetEmpLbl("Brush_Date_Not_Null"))	'"补卡时间不能为空"
	end if

	If strRemark = "" Then 
		Call ReturnErrMsg(GetEmpLbl("SignCard_Reason_Not_Null"))	'"补卡原因不能为空"
	end if

	If Len(strRemark) > 50 Then 
		Call ReturnErrMsg(GetEmpLbl("Reason_More_50_Char"))	'"补卡原因只允许50个字符！"
	End if
end if

Call fConnectADODB()

'判断模板名称是否存在
strSQL=""
Select Case strOper
	Case "add": 'Add Record
		strSQL = "select 1 from AttendanceSignIn where EmployeeId="+CStr(strEmpId)+" and BrushTime='"+CStr(strBrushTime)+"' "
	Case "edit": 'Edit Record
End Select

if	strSQL<>"" then 
	if IsExistsValue(strSQL) = true then 
		Call fCloseADO()
		Call ReturnErrMsg(GetEmpLbl("Not_ReSign_On_Same_Time"))	'"一天中同一人不可有重复补卡"
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

		strFields = " EmployeeId, BrushTime, Remark, Status, WorkFlowId, WorkFlowName, NowStep, NextStep, TransactorDesc, TransactorId, TransactorName "
		strValues = cstr(strEmpId)+", '"+cstr(strBrushTime)+"', '"+CStr(strRemark)+"', '" + strStatus + " ', 0"
		strValues = strValues + ", '', 0, '0','', "+CStr(strTransactorId)+", '"+cstr(strTransactorName)+"' "
		strSQL = "Insert into AttendanceSignIn(" + cstr(strFields) + ")values(" + cstr(strValues) + ")"
		strSQL = strSQL + " ; insert into FlowStepDetail(FlowType, FlowDataId, StepId, Transactorid,Transactor, Operation, OperateTime) select '" + getEmpLbl("FlowType_Signcard_3") + "', SignId, 0, "+CStr(strEmpId)+", (select Name from Employees where EmployeeId="+CStr(strEmpId)+") AS TransactorName, '" + strStatus + "', getdate() from AttendanceSignIn where SignId=(select Max(SignId) from AttendanceSignIn)"
	Case "edit": 'Edit Record
		if strRecordID = "" or not isnumeric(strRecordID) then
			Call ReturnErrMsg(GetEmpLbl("IllegalOperate")) '非法操作！"
		end if

		if blnRefuse = "0" then
			strStatus = getEmpLbl("FlowStatus_Approved_2")	
		else
			strStatus = getEmpLbl("FlowStatus_Refused_3")	
		end if

		strDescription = Replace(Request.Form("Description"),"'","''")
		strSQL = "update AttendanceSignIn set Status='" + strStatus + "', TransactorId=" + CStr(strTransactorId) + ", TransactorName='" + cstr(strTransactorName) + "' where SignId=" + CStr(strRecordID)
		strSQL = strSQL + " ; insert into FlowStepDetail(FlowType, FlowDataId, StepId, Transactorid,Transactor, Operation, OperateTime, Postil) select '" + getEmpLbl("FlowType_Signcard_3") + "', SignId, 0, "+CStr(strTransactorId)+", '" + cstr(strTransactorName) + "' as TransactorName, '" + strStatus+  "', getdate(), '" + cstr(strDescription) + "' from AttendanceSignIn where SignId=" + strRecordID
	Case "del": 'Delete Record
		if strRecordID = "" then
			Call ReturnErrMsg(GetEmpLbl("IllegalOperate")) '非法操作！"
		end if

		strStatus = getEmpLbl("FlowStatus_Ceased_C")	
		strSQL = "update AttendanceSignIn set Status='" + strStatus + "' where SignId in (" + CStr(strRecordID) + ");"
		strSQL = strSQL + " ; insert into FlowStepDetail(FlowType, FlowDataId, StepId, Transactorid,Transactor, Operation, OperateTime, Postil) select '" + getEmpLbl("FlowType_Signcard_3") + "', SignId, 0, L.EmployeeId, (select Name from Employees where EmployeeId= L.EmployeeId) AS TransactorName, '" + strStatus+  "', getdate(), '" + cstr(strDescription) + "' from AttendanceSignIn L where SignId in (" + CStr(strRecordID) + ");"
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
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("Attend")&"-"&GetEmpLbl("Attend_SignCard"),cstr(strActions),cstr(strActions)&GetEmpLbl("Attend_SignCard")&","&strEmpId)
		Case "edit": 'Edit Record
			if blnRefuse = "0" then
				strActions = GetCerbLbl("strLogApproval")
			else
				strActions = GetCerbLbl("strLogRefuse")
			end if
			
			'Call AddLogEvent("设备管理-注册卡号表-模板方式",cstr(strActions),cstr(strActions)&"注册卡号模板,ID["&strRecordID&"],修改后模板名称["&strTemplateName&"]")			
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("Attend")&"-"&GetEmpLbl("Attend_SignCard"),cstr(strActions),cstr(strActions)&GetEmpLbl("Attend_SignCard")&","&strRecordID)
		Case "del": 'Delete Record
			strActions = GetCerbLbl("strLogCease")
			'Call AddLogEvent("设备管理-注册卡号表-模板方式",cstr(strActions),cstr(strActions)&"注册卡号模板,ID["&strRecordID&"]")		
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("Attend")&"-"&GetEmpLbl("Attend_SignCard"),cstr(strActions),cstr(strActions)&GetEmpLbl("Attend_SignCard")&","&strRecordID)
	End Select
	
	Call fCloseADO()
	Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)	'"执行成功"
else
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
end if
%>