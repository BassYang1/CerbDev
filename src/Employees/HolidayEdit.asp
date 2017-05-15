<%Session.CodePage=65001%>
<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

'//*********************  Declare Values  **********************//
dim strSQL, strOper
dim strTemplateId, strHolidayDate, strTransposalDate, strHolidayDesc
dim strRecordID
dim strFields, strValues
'//************************************************************//'"EmployeeWork"

strRecordID = FormatStringSafe(Request.Form("id")) '规则Id
strOper = FormatStringSafe(Request.Form("oper"))  '操作
strTemplateId = FormatStringSafe(Request.Form("TemplateId"))  '假期模板Id
If strTemplateId = "" Then strTemplateId = 0

if strOper<>"add" and strOper<>"edit" and strOper<>"del" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if

if GetOperRole("ShiftRules",strOper) <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

if strOper<>"add" and strRecordID = "" then
	Call ReturnErrMsg(GetEmpLbl("IllegalOperate")) '非法操作！"
end if

if strOper <> "del" then 
	strHolidayDate = FormatStringSafe(Request.Form("HolidayDate"))
	strTransposalDate = FormatStringSafe(Request.Form("TransposalDate"))
	strHolidayDesc = FormatStringSafe(Request.Form("HolidayName"))

	if len(strHolidayDesc) > 50 then	
		Call ReturnErrMsg(GetEmpLbl("Holiday_Name_More_50_Char"))'假期说明只允许50个字符
	end if

	if strHolidayDate = "" then
			Call ReturnErrMsg(GetEmpLbl("Holiday_Date_Null")) '"假期日期不能为空"
	end if

	if CheckDate(strHolidayDate, 0, "")<>1 then
			Call ReturnErrMsg(GetEmpLbl("Holiday_Date_Invalid")) '"假期日期非法"
	end if

	if strTransposalDate <> "" AND CheckDate(strTransposalDate, 0, "")<>1 then
			Call ReturnErrMsg(GetEmpLbl("Holiday_Trans_Date_Invalid")) '"调换日期非法"
	end If
end if

Call fConnectADODB()

'判断模板名称是否存在
strSQL=""
if strOper <> "del" then 
	strSQL = "Select 1 from AttendanceHoliday where HolidayDate='"+cstr(strHolidayDate)+"' and templateid="+CStr(strTemplateId)

	if IsExistsValue(strSQL) = true then 
		Call fCloseADO()
		Call ReturnErrMsg(GetEmpLbl("Holiday_Dupl_Holi_Date"))	'"法定假期日期不可重复"
	end if

	if strTransposalDate<> "" then			
		if strOper = "add" then 'Add Record	
			strSQL = "Select 1 from AttendanceHoliday where TransposalDate='"+cstr(strTransposalDate)+"'"
		else
			strSQL = "Select 1 from AttendanceHoliday where TransposalDate='"+cstr(strTransposalDate)+"' and HolidayId<>" & strRecordID
		end if

		if IsExistsValue(strSQL) = true then 
			Call fCloseADO()
			Call ReturnErrMsg(GetEmpLbl("Holiday_Dupl_Date_Exch"))	'"调换日期不可重复"
		end if	
	end if
end if

'判断模板名称是否存在
strSQL=""

Select Case strOper
	Case "add": 'Add Record		
		strFields = "HolidayDate,HolidayName, TemplateId"
		strValues = "'"+cstr(strHolidayDate)+"','"+cstr(strHolidayDesc)+"',"+CStr(strTemplateId)

		if strTransposalDate <> "" then
			strFields = strFields & ",TransposalDate"
			strValues = strValues & ",'"&cstr(strTransposalDate)&"'"
		end if

		strSQL = "INSERT INTO AttendanceHoliday(" & strFields & ") VALUES (" & strValues & ") "
	Case "edit": 'Edit Record             '修改				
		strSQL = strSQL & "UPDATE AttendanceHoliday SET HolidayDate='" & strHolidayDate & "',HolidayName='" & strHolidayDesc & "'"

		if strTransposalDate <> "" then
			strSQL = strSQL & ",TransposalDate='"&cstr(strTransposalDate)&"'"
		end if

		 strSQL = strSQL & " WHERE HolidayId=" & strRecordID
	Case "del": 'Delete Record
		strSQL = "SELECT(SELECT HolidayName + ',' FROM AttendanceHoliday WHERE HolidayId in ("+strRecordID+") for xml path('')) AS HolidayName"

		Rs.open strSQL, Conn, 2, 1

		If Not Rs.eof Then
			strHolidayDesc = Trim(Rs.fields(0).value)
		End If
			
		strSQL = "DELETE AttendanceHoliday WHERE HolidayId in ("+cstr(strRecordID)+")"
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
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("Attend")&"-"&GetEmpLbl("Holiday"),cstr(GetCerbLbl("strLogAdd")),cstr(GetCerbLbl("strLogAdd"))&GetEmpLbl("Holiday")&","&GetEmpLbl("HolidayName")&"["&cstr(strHolidayDesc)&"]")
		Case "edit": 'Edit Record
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("Attend")&"-"&GetEmpLbl("Holiday"),cstr(GetCerbLbl("strLogEdit")),cstr(GetCerbLbl("strLogEdit"))&GetEmpLbl("Holiday")&","&GetEmpLbl("HolidayName")&"["&cstr(strHolidayDesc)&"]")
		Case "del": 'Delete Record
			strActions = GetCerbLbl("strLogDel")
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("Attend")&"-"&GetEmpLbl("Holiday"),cstr(GetCerbLbl("strLogDel")),cstr(GetCerbLbl("strLogDel"))&GetEmpLbl("Holiday")&","&GetEmpLbl("HolidayName")&"["&strHolidayDesc&"]")
	End Select
	
	Call fCloseADO()
	Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)	'"执行成功"
else
	Call fCloseADO()
	Call ReturnErrMsg(GetEmpLbl("PartError")) '"参数错误"
end if
%>