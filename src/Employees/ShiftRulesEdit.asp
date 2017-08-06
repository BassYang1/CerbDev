<%Session.CodePage=65001%>
<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<!--#include file="..\Equipment\SearchExec.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

'//*********************  Declare Values  **********************//
dim strSQL, strOper
dim strDepartmentCode, strEmployeeCode, strDepartmentName, strEmployeeName, strEmployeeDesc, strEmployeeExpress
dim strRelationship, strOtherCode, strOtherCond, arrOtherCode, strField, strSearchOper, strFieldData
dim strOnDutyMode, strRuleDetail, strLoopCount, strNoBrushCard, strFirstWeekDate,strChangeDate
dim strMonday1, strTuesday1, strWednesday1, strThursday1, strFriday1, strSaturday1, strSunday1,strMonday2, strTuesday2, strWednesday2, strThursday2, strFriday2, strSaturday2, strSunday2
dim strDay15,strDay16,strDay17,strDay18,strDay19,strDay20,strDay21,strDay22,strDay23,strDay24,strDay25,strDay26,strDay27,strDay28,strDay29,strDay30,strDay31
dim arrRules(31), arrRulesTemp
dim strRecordID
dim strFields, strValues
'//************************************************************//'"EmployeeWork"

strRecordID = FormatStringSafe(Request.Form("id")) '规则Id
strOper = FormatStringSafe(Request.Form("oper"))  '操作

if strOper<>"add" and strOper<>"edit" and strOper<>"del" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if

if GetOperRole("ShiftRules",strOper) <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

if strOper <> "del" then 
	'员工条件
	strDepartmentCode = FormatStringSafe(Request.Form("DepartmentCode"))
	strDepartmentName = FormatStringSafe(Request.Form("DepartmentName"))
	strEmployeeExpress = FormatStringSafe(Request.Form("EmployeeExpress"))
	strEmployeeName = FormatStringSafe(Request.Form("EmployeeName"))
	strAdjustDate = FormatStringSafe(Request.Form("AdjustDate"))
	strLoopCount = FormatStringSafe(Request.Form("LoopCount"))
	strRuleDetail = FormatStringSafe(Request.Form("RuleDetail"))

	strRelationship = Replace(Request.Form("Relationship"),"'","''")
	strOtherCode = Replace(Request.Form("OtherCode"),"'","''")
	strOtherCond = Replace(Request.Form("OtherCond"),"'","''")
	arrOtherCode = split(strOtherCode, "|,")
	if ubound(arrOtherCode) >= 0 then strField = arrOtherCode(0)
	if ubound(arrOtherCode) >= 1 then strSearchOper = arrOtherCode(1)
	if ubound(arrOtherCode) >= 2 then strFieldData = arrOtherCode(2)

	if strOtherCode <> "" then strOtherCond = strOtherCond + "|," + strOtherCode
	strOtherCode = ""

	if strField <> "" then
		strOtherCode = Replace(GetSearchSQLWhere(strField, strSearchOper, strFieldData),"'","''")
	end if

	if strRuleDetail = "" then	
		Call ReturnErrMsg(GetEmpLbl("ShiftRule_Invalid"))'未设置上班规则
	end if

	if strDepartmentName <> "" then
		strEmployeeDesc = strEmployeeDesc & "," & strDepartmentName
	end if

	if strEmployeeName <> "" then
		strEmployeeDesc = strEmployeeDesc & "," & strEmployeeName
	end if

	if strOtherCond <> "" then
		strEmployeeDesc = strEmployeeDesc & "," & split(strOtherCond, "|,")(0)
	end if

	if strEmployeeExpress <> "" then
		strEmployeeCode = "(E.EmployeeId in (" + strEmployeeExpress + "))"
	end if

	if strDepartmentCode <> "" and left(strDepartmentCode, 1) <> "0" then
		if strEmployeeCode <> "" then
			strEmployeeCode = "(" + strEmployeeCode + " or (E.DepartmentId in (" + strDepartmentCode + ")))"
		else
			strEmployeeCode = "(E.DepartmentId in (" + strDepartmentCode + "))"
		end if
	end if

	if strOtherCode <> "" then
		if strEmployeeCode <> "" then
			strEmployeeCode = "((" + strEmployeeCode + ") " + strRelationship + " (" + strOtherCode + "))"
		else
			strEmployeeCode = " (" + strOtherCode + ")"
		end if
	end if

	if strEmployeeCode <> "" then
		strEmployeeCode = " EmployeeId in (select E.EmployeeId from Employees E where " + strEmployeeCode + ") "
	end if

	if strEmployeeExpress = "" and strDepartmentCode = "" and strEmployeeDesc = "" then	
		Call ReturnErrMsg(GetEmpLbl("ShiftRulesCondition"))'未设置上班规则员工条件
	end if

	if strEmployeeDesc <> "" then
		strEmployeeDesc = right(strEmployeeDesc, len(strEmployeeDesc) - 1)  '注册员工描述
	end if

	'免打卡,上班方式,第一周开始日期
	strNoBrushCard   = FormatStringSafe(Request.form("NoBrushCard"))
	if strNoBrushCard = "" then strNoBrushCard = "0"
	strOnDutyMode = FormatStringSafe(Request.Form("OnDutyMode"))
	strFirstWeekDate = FormatStringSafe(Request.Form("FirstWeekDate"))
	if strOnDutyMode = "" then strOnDutyMode = GetEmpLbl("Wm_Sng_Week_1")

	if LEFT(strOnDutyMode,1) = "2" then '2-双周循环
		if strFirstWeekDate = "" then
			Call ReturnErrMsg(GetEmpLbl("Wm_Dbl_St_Dt_Null")) '"双周时第一周开始日不能为空！"
		end if
		if CheckDate(strFirstWeekDate, 0, "")<>1 then
			Call ReturnErrMsg(GetEmpLbl("Wm_Dbl_St_Dt_Invalid")) '"第一周开始日格式无效"
		end if
	end if

	if strLoopCount = "" OR NOT isNumeric(strLoopCount) then
		if LEFT(strOnDutyMode,1) = "1" then '1-单周循环
			strLoopCount = "7"
		elseif LEFT(strOnDutyMode,1) = "2" then '2-双周循环
			strLoopCount = "14"
		else '3-自定义循环
			strLoopCount = "31"
		end if
	end if

	'规则详细	
	arrRulesTemp = split(strRuleDetail, ",")

	FOR i = 0 to 30
		IF i <= UBOUND(arrRulesTemp) THEN
			arrRules(i) = arrRulesTemp(i)
		END IF
	NEXT

	strMonday1    = arrRules(0)
	strTuesday1   = arrRules(1)
	strWednesday1 = arrRules(2)
	strThursday1  = arrRules(3)
	strFriday1    = arrRules(4)
	strSaturday1  = arrRules(5)
	strSunday1    = arrRules(6)

	strMonday2    = arrRules(7)
	strTuesday2   = arrRules(8)
	strWednesday2 = arrRules(9)
	strThursday2  = arrRules(10)
	strFriday2    = arrRules(11)
	strSaturday2  = arrRules(12)
	strSunday2    = arrRules(13)


	strDay15 = arrRules(14)
	strDay16 = arrRules(15)
	strDay17 = arrRules(16)
	strDay18 = arrRules(17)
	strDay19 = arrRules(18)
	strDay20 = arrRules(19)
	strDay21 = arrRules(20)
	strDay22 = arrRules(21)
	strDay23 = arrRules(22)
	strDay24 = arrRules(23)
	strDay25 = arrRules(24)
	strDay26 = arrRules(25)
	strDay27 = arrRules(26)
	strDay28 = arrRules(27)
	strDay29 = arrRules(28)
	strDay30 = arrRules(29)
	strDay31 = arrRules(30)

	'生效日期
	strChangeDate = FormatStringSafe(Request.form("ChangeDate"))
	if strChangeDate = "" then 
		Call ReturnErrMsg(GetEmpLbl("Wm_Effec_Dt_Null")) '"生效日期不能为空"
	end if
	if CheckDate(strChangeDate, 0, "") <> 1 then  
		Call ReturnErrMsg(GetEmpLbl("Wm_Effec_Dt_Invalid")) '"生效日期格式无效"
	end if
end if

Call fConnectADODB()

'判断模板名称是否存在
strSQL=""

Select Case strOper
	Case "add": 'Add Record
		strFields = "EmployeeDesc,EmployeeExpress,DepartmentCode,Relationship,OtherCode,EmployeeCode,OnDutyMode,NoBrushCard,FirstWeekDate,LoopCount,"
		strFields = strFields & "Monday1,Tuesday1,Wednesday1,Thursday1,Friday1,Saturday1,Sunday1,"
		strFields = strFields & "Monday2,Tuesday2,Wednesday2,Thursday2,Friday2,Saturday2,Sunday2,"
		strFields = strFields & "day15,day16,day17,day18,day19,day20,day21,day22,day23,day24,day25,day26,day27,day28,day29,day30,day31"

		strValues = "'" & strEmployeeDesc & "','" & strEmployeeExpress & "','" & strDepartmentCode & "','" & strRelationship & "','" & strOtherCond & "','" & strEmployeeCode & "',NULL,'" & strOnDutyMode & "','" & strNoBrushCardNo & "','" & strChangeDate & "'," & strLoopCount & ",'" & strMonday1 & "','" & strTuesday1 & "','" & strWednesday1 & "','" & strThursday1 & "','" & strFriday1 & "','" & strSaturday1 & "','" & strSunday1 & "','" & strMonday2 & "','" & strTuesday2 & "','" & strWednesday2 & "','" & strThursday2 & "','" & strFriday2 & "','" & strSaturday2 & "','" & strSunday2 & "','" & strDay15 & "','" & strDay16 & "','" & strDay17 & "','" & strDay18 & "','" & strDay19 & "','" & strDay20 & "','" & strDay21 & "','" & strDay22 & "','" & strDay23 & "','" & strDay24 & "','" & strDay25 & "','" & strDay26 & "','" & strDay27 & "','" & strDay28 & "','" & strDay29 & "','" & strDay30 & "','" & strDay31 & "'"

		strSQL = "BEGIN TRY "	
		strSQL = strSQL & "BEGIN TRANSACTION "			
		strSQL = strSQL & "INSERT INTO AttendanceOndutyRule(" & strFields & ") VALUES (" & strValues & ") "
		strSQL = strSQL & "DECLARE @ruleId INT "
		strSQL = strSQL & "SELECT @ruleId = @@identity "
		strSQL = strSQL & "INSERT INTO AttendanceOnDutyRuleChange(RuleId,ChangeDate," & strFields & ") VALUES (@ruleId,'" & strChangeDate & "'," & strValues & ") "
		strSQL = strSQL & "COMMIT TRANSACTION "
		strSQL = strSQL & "END TRY "
		strSQL = strSQL & "BEGIN CATCH "
		strSQL = strSQL & "ROLLBACK TRANSACTION "
		strSQL = strSQL & "THROW "
		strSQL = strSQL & "END CATCH "
	Case "edit": 'Edit Record             '修改
		if strRecordID = "" or not isnumeric(strRecordID) then
			Call ReturnErrMsg(GetEmpLbl("IllegalOperate")) '非法操作！"
		end if

		strFields = "RuleId,ChangeDate,EmployeeDesc,EmployeeExpress,DepartmentCode,Relationship,OtherCode,EmployeeCode,OnDutyMode,NoBrushCard,FirstWeekDate,LoopCount,"
		strFields = strFields & "Monday1,Tuesday1,Wednesday1,Thursday1,Friday1,Saturday1,Sunday1,"
		strFields = strFields & "Monday2,Tuesday2,Wednesday2,Thursday2,Friday2,Saturday2,Sunday2,"
		strFields = strFields & "day15,day16,day17,day18,day19,day20,day21,day22,day23,day24,day25,day26,day27,day28,day29,day30,day31"

		strValues = strRecordID & ",'" & strChangeDate & "','" & strEmployeeDesc & "','" & strEmployeeExpress & "','" & strDepartmentCode & "','" & strRelationship & "','" & strOtherCond & "','" & strEmployeeCode & "','" & strOnDutyMode & "','" & strNoBrushCardNo & "','" & strChangeDate & "'," & strLoopCount & ",'" & strMonday1 & "','" & strTuesday1 & "','" & strWednesday1 & "','" & strThursday1 & "','" & strFriday1 & "','" & strSaturday1 & "','" & strSunday1 & "','" & strMonday2 & "','" & strTuesday2 & "','" & strWednesday2 & "','" & strThursday2 & "','" & strFriday2 & "','" & strSaturday2 & "','" & strSunday2 & "','" & strDay15 & "','" & strDay16 & "','" & strDay17 & "','" & strDay18 & "','" & strDay19 & "','" & strDay20 & "','" & strDay21 & "','" & strDay22 & "','" & strDay23 & "','" & strDay24 & "','" & strDay25 & "','" & strDay26 & "','" & strDay27 & "','" & strDay28 & "','" & strDay29 & "','" & strDay30 & "','" & strDay31 & "'"

		strSQL = "BEGIN TRY "	
		strSQL = strSQL & "BEGIN TRANSACTION "			
		strSQL = strSQL & "UPDATE AttendanceOndutyRule SET EmployeeDesc='" & strEmployeeDesc & "',EmployeeExpress='" & strEmployeeExpress & "',DepartmentCode='" & strDepartmentCode & "',OtherCode='" & strOtherCond & "',Relationship='" & strRelationship & "',EmployeeCode='" & strEmployeeCode & "',OnDutyMode='" & strOnDutyMode & "',NoBrushCard='" & strBrushCard & "',FirstWeekDate='" & strFirstWeekDate & "',LoopCount=" & strLoopCount & ",Monday1='" & strMonday1 & "',Tuesday1='" & strTuesday1 & "',Wednesday1='" & strWednesday1 & "',Thursday1='" & strThursday1 & "',Friday1='" & strFriday1 & "',Saturday1='" & strSaturday1 & "',Sunday1='" & strSunday1 & "',Monday2='" & strMonday2 & "',Tuesday2='" & strTuesday2 & "',Wednesday2='" & strWednesday2 & "',Thursday2='" & strThursday2 & "',Friday2='" & strFriday2 & "',Saturday2='" & strSaturday2 & "',Sunday2='" & strSunday2 & "',day15='" & strDay15 & "',day16='" & strDay16 & "',day17='" & strDay17 & "',day18='" & strDay18 & "',day19='" & strDay19 & "',day20='" & strDay20 & "',day21='" & strDay21 & "',day22='" & strDay22 & "',day23='" & strDay23 & "',day24='" & strDay24 & "',day25='" & strDay25 & "',day26='" & strDay26 & "',day27='" & strDay27 & "',day28='" & strDay28 & "',day29='" & strDay29 & "',day30='" & strDay30 & "',day31='" & strDay31 & "' WHERE RuleId=" & strRecordID
		strSQL = strSQL + "DELETE FROM AttendanceOnDutyRuleChange WHERE RuleId=" + cstr(strRecordID) + " AND ChangeDate>'"+CStr(strChangeDate)+"' "
		strSQL = strSQL & "INSERT INTO AttendanceOnDutyRuleChange(" & strFields & ") VALUES (" & strValues & ") "
		strSQL = strSQL & "COMMIT TRANSACTION "
		strSQL = strSQL & "END TRY "
		strSQL = strSQL & "BEGIN CATCH "
		strSQL = strSQL & "ROLLBACK TRANSACTION "
		strSQL = strSQL & "THROW "
		strSQL = strSQL & "END CATCH "
	Case "del": 'Delete Record
		if strRecordID = "" then
			Call ReturnErrMsg(GetEmpLbl("IllegalOperate")) '非法操作！"
		end if

		strSQL = "SELECT(SELECT EmployeeDesc + '|' FROM AttendanceOnDutyRule WHERE RuleId in ("+strRecordID+") for xml path('')) AS EmployeeDesc"

		Rs.open strSQL, Conn, 2, 1

		If Not Rs.eof Then
			strEmployeeDesc = Trim(Rs.fields(0).value)
		End If

		Rs.close
		if len(strEmployeeDesc) >= 2 then 
			strEmployeeDesc=left(strEmployeeDesc,InStrRev(strEmployeeDesc,"|")-1)
		end if

		strSQL = "BEGIN TRY "	
		strSQL = strSQL & "BEGIN TRANSACTION "			
		strSQL = strSQL & "DELETE AttendanceOnDutyRuleChange WHERE ChangeId in ("+strRecordID+")"
		strSQL = strSQL & "DELETE AttendanceOnDutyRule WHERE RuleId in ("+strRecordID+")"
		strSQL = strSQL & "COMMIT TRANSACTION "
		strSQL = strSQL & "END TRY "
		strSQL = strSQL & "BEGIN CATCH "
		strSQL = strSQL & "ROLLBACK TRANSACTION "
		strSQL = strSQL & "THROW "
		strSQL = strSQL & "END CATCH "
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
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("Attend")&"-"&GetEmpLbl("ShiftRules"),cstr(GetCerbLbl("strLogAdd")),cstr(GetCerbLbl("strLogAdd"))&GetEmpLbl("ShiftRules")&","&GetEmpLbl("EmpDescription")&"["&cstr(strEmployeeDesc)&"]")
		Case "edit": 'Edit Record
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("Attend")&"-"&GetEmpLbl("ShiftRules"),cstr(GetCerbLbl("strLogEdit")),cstr(GetCerbLbl("strLogEdit"))&GetEmpLbl("ShiftRules")&","&GetEmpLbl("EmpDescription")&"["&cstr(strEmployeeDesc)&"]")
		Case "del": 'Delete Record
			strActions = GetCerbLbl("strLogDel")
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("Attend")&"-"&GetEmpLbl("ShiftRules"),cstr(GetCerbLbl("strLogDel")),cstr(GetCerbLbl("strLogDel"))&GetEmpLbl("ShiftRules")&","&GetEmpLbl("EmpDescription")&"["&strEmployeeDesc&"]")
	End Select
	
	Call fCloseADO()
	Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)	'"执行成功"
else
	Call fCloseADO()
	Call ReturnErrMsg(GetEmpLbl("PartError")) '"参数错误"
end if
%>