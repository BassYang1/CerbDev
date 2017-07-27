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

'可休年假职员'
Dim strAnnalDeptEmps
AnnalDeptEmps = Trim(Replace(Request.Form("AnnalDeptEmps"),"'","''"))

'年假规则	'
Dim strBaseAnnualDay, strMaxAnnualDay, bContinueNext
Dim strIncreaseType1, strIncreaseYear1, strIncreaseDay1
Dim strIncreaseType2, strIncreaseYear2, strIncreaseDay2, strIncreaseYear3, strIncreaseDay3
strBaseAnnualDay = Trim(Replace(Request.Form("BaseAnnualDay"),"'","''"))
strIncreaseType1 = Trim(Replace(Request.Form("IncreaseType1"),"'","''"))
strIncreaseYear1 = Trim(Replace(Request.Form("IncreaseYear1"),"'","''"))
strIncreaseDay1 = Trim(Replace(Request.Form("IncreaseDay1"),"'","''"))
strIncreaseType2 = Trim(Replace(Request.Form("IncreaseType2"),"'","''"))
strIncreaseYear2 = Trim(Replace(Request.Form("IncreaseYear2"),"'","''"))
strIncreaseDay2 = Trim(Replace(Request.Form("IncreaseDay2"),"'","''"))
strIncreaseYear3 = Trim(Replace(Request.Form("IncreaseYear3"),"'","''"))
strIncreaseDay3 = Trim(Replace(Request.Form("IncreaseDay3"),"'","''"))
strMaxAnnualDay = Trim(Replace(Request.Form("MaxAnnualDay"),"'","''"))
bContinueNext = Trim(Replace(Request.Form("ContinueNext"),"'","''"))

if strBaseAnnualDay <> "" and not ISNUMERIC(strBaseAnnualDay) then
	Call ReturnErrMsg(GetToolLbl("Annual_Day_Not_Numeric"))	'"可休年假天数需填写数值"
end if

if strMaxAnnualDay <> "" and not ISNUMERIC(strMaxAnnualDay) then
	Call ReturnErrMsg(GetToolLbl("Annual_Day_Not_Numeric"))	'"最大年假天数需填写数值"
end if

if strIncreaseType1 = "1" then 
	strIncreaseType2 = ""

	if not ISNUMERIC(strIncreaseYear1) then
		Call ReturnErrMsg(GetToolLbl("Annual_Year_Not_Numeric"))	'"增加年限需填写数值"
	end if

	if not ISNUMERIC(strIncreaseDay1) then
		Call ReturnErrMsg(GetToolLbl("Annual_Day_Not_Numeric"))	'"增加年假天数需填写数值"
	end if

	strIncreaseType1 = strIncreaseType1 + "," + strIncreaseYear1 + "," + strIncreaseDay1
end if

if strIncreaseType2 = "1" then 
	strIncreaseType1 = ""

	if not ISNUMERIC(strIncreaseYear2) or not ISNUMERIC(strIncreaseYear3)then
		Call ReturnErrMsg(GetToolLbl("Annual_Year_Not_Numeric"))	'"增加年限需填写数值"
	end if

	if not ISNUMERIC(strIncreaseDay2) or not ISNUMERIC(strIncreaseDay3) then
		Call ReturnErrMsg(GetToolLbl("Annual_Day_Not_Numeric"))	'"增加年假天数需填写数值"
	end if

	strIncreaseType2 = strIncreaseType2 + "," + strIncreaseYear2 + "," + strIncreaseDay2 + "," + strIncreaseYear3 + "," + strIncreaseDay3
end if

'请假期间的[休息日、法定假]仍计为[休息日、法定假]'
Dim strSkipHoliday
strSkipHoliday = "PersonalLeave"+Trim(Replace(Request.Form("IsPrivate"),"'","''")) + "," 
strSkipHoliday = strSkipHoliday + "SickLeave"+Trim(Replace(Request.Form("IsSick"),"'","''")) + ","
strSkipHoliday = strSkipHoliday + "CompensatoryLeave"+Trim(Replace(Request.Form("IsCompensatory"),"'","''")) + ","
strSkipHoliday = strSkipHoliday + "MaternityLeave"+Trim(Replace(Request.Form("IsMaternity"),"'","''")) + ","
strSkipHoliday = strSkipHoliday + "WeddingLeave"+Trim(Replace(Request.Form("IsMatrimony"),"'","''")) + ","
strSkipHoliday = strSkipHoliday + "LactationLeave"+Trim(Replace(Request.Form("IsLactation"),"'","''")) + ","
strSkipHoliday = strSkipHoliday + "OtherLeave"+Trim(Replace(Request.Form("IsOther"),"'","''")) + ","
strSkipHoliday = strSkipHoliday + "OnTrip"+Trim(Replace(Request.Form("IsTrip"),"'","''")) + ","
strSkipHoliday = strSkipHoliday + "AnnualVacation"+Trim(Replace(Request.Form("IsAnnual"),"'","''")) + ","
strSkipHoliday = strSkipHoliday + "PublicHoliday"+Trim(Replace(Request.Form("IsHolidy"),"'","''")) + ","
strSkipHoliday = strSkipHoliday + "InjuryLeave"+Trim(Replace(Request.Form("IsInjury"),"'","''")) + ","
strSkipHoliday = strSkipHoliday + "FuneralLeave"+Trim(Replace(Request.Form("IsFuneral"),"'","''")) + ","
strSkipHoliday = strSkipHoliday + "VisitLeave"+Trim(Replace(Request.Form("IsVisit"),"'","''"))

'休息日所计工时'
Dim strWorkTime
strWorkTime = Trim(Replace(Request.Form("WorkTime"),"'","''"))

if strWorkTime <> "" and not ISNUMERIC(strWorkTime) then
	Call ReturnErrMsg(GetToolLbl("Holiday_Work_Time_Not_Numeric"))	'"休息日所计工时需填写数值"
end if

Call fConnectADODB()

On Error Resume NEXT

'可休年假职员'
strSQL = "update options set VariableValue='"+cstr(strAnnalDeptEmps)+"' where VariableName='strAnnalDeptEmps' ; "

'基本年假天数'
strSQL = strSQL + "update options set VariableValue='"+cstr(strBaseAnnualDay)+"' where VariableName='intBasicDay';"

'年假递增方式1'
strSQL = strSQL + "update options set VariableValue='"+cstr(strIncreaseType1)+"' where VariableName='strIncreaseType1';"

'年假递增方式2'
strSQL = strSQL + "update options set VariableValue='"+cstr(strIncreaseType2)+"' where VariableName='strIncreaseType2';"

'最大年假天数'
strSQL = strSQL + "update options set VariableValue='"+cstr(strMaxAnnualDay)+"' where VariableName='intMaxVacation';"

'可延续到下一年'
strSQL = strSQL + "update options set VariableValue='"+cstr(bContinueNext)+"' where VariableName='blnContinueNext';"

'休假时跨过法定假'
strSQL = strSQL + "update options set VariableValue='"+cstr(strSkipHoliday)+"' where VariableName='strSkipHoliday';"

'休息日所计工时'
strSQL = strSQL + "update options set VariableValue='"+cstr(strWorkTime)+"' where VariableName='intWorkTime';"

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