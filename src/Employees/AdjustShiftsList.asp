<%'Session.CodePage=65001%>
<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<!--#include file="..\Common\Page.asp" -->
<%
response.Charset="utf-8"
dim page,rows,sidx,sord
dim departmentId,strSQL,strExportSql
page = request.QueryString("page") 'page
rows = request.QueryString("rows") 'pagesize
sidx = request.QueryString("sidx") 'order by ??
sord = request.QueryString("sord")
if page="" then page = 1 end if
if rows = "" then rows = 10 end if
if sidx = "" then sidx = "ShiftId" end if
if sord = "" then sord ="asc" end if

dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

Dim strSearchOn, strField, strFieldData, strSearchOper, strWhere
strSearchOn = request.QueryString("_search")
'response.Write("strSearchOn:"&strSearchOn&",strField:"&request.QueryString("searchField")&",strFieldData:"&request.QueryString("searchString")&",strSearchOper:"&request.QueryString("searchOper")

'construct where
strWhere = ""
If (strSearchOn = "true") Then
	strField = request.QueryString("searchField")
	strFieldData = request.QueryString("searchString")
	strSearchOper = request.QueryString("searchOper")

	If strField = "ShiftName" Then
		strWhere = "and ShiftId " 
		Select Case strSearchOper
			Case "eq" : 'Equal
				strWhere = strWhere & " = "&strFieldData&" "
		End Select
	ElseIf strField = "StretchShift" Then
		strWhere = "and StretchShift " 
		Select Case strSearchOper
			Case "eq" : 'Equal
				strWhere = strWhere & " = '"&strFieldData&"' " 
		End Select
	ElseIf strField = "Night" Then
		strWhere = "and Night " 
		Select Case strSearchOper
			Case "eq" : 'Equal
				strWhere = strWhere & " = '"&strFieldData&"' " 
		End Select
	End if
End If

'server.ScriptTimeout=9000
fConnectADODB()
'fConnectADOCE()
dim a
set a=new JSONClass
strSQL = "select TempShiftID,ShiftType,AdjustDate,ShiftId,ShiftName,EmployeeDesc,Description,StretchShift,ShiftTime,Degree,Night,FirstOnDuty,DepartmentCode,EmployeeCode,OtherCode,"
strSQL = strSQL & "CONVERT(CHAR(5),AonDuty,108),CONVERT(CHAR(5),AonDutyStart,108),CONVERT(CHAR(5),AonDutyEnd,108),CONVERT(CHAR(5),AoffDuty,108), CONVERT(CHAR(5),AoffDutyStart,108), CONVERT(CHAR(5),AoffDutyEnd,108),AcalculateLate,AcalculateEarly,ArestTime,"
strSQL = strSQL & "CONVERT(CHAR(5),BonDuty,108),CONVERT(CHAR(5),BonDutyStart,108),CONVERT(CHAR(5),BonDutyEnd,108),CONVERT(CHAR(5),BoffDuty,108), CONVERT(CHAR(5),BoffDutyStart,108), CONVERT(CHAR(5),BoffDutyEnd,108),BcalculateLate,BcalculateEarly,BrestTime,"
strSQL = strSQL & "CONVERT(CHAR(5),ConDuty,108),CONVERT(CHAR(5),ConDutyStart,108),CONVERT(CHAR(5),ConDutyEnd,108),CONVERT(CHAR(5),CoffDuty,108), CONVERT(CHAR(5),CoffDutyStart,108), CONVERT(CHAR(5),CoffDutyEnd,108),CcalculateLate,CcalculateEarly,CrestTime"
strSQL = strSQL & " from TempShifts where 1 > 0 " & strWhere & " order by "& sidx & " " & sord

'response.write strSQL
'response.end
a.Sqlstring=strSQL

'导出
strExportSql = "select TempShiftID,ShiftType,AdjustDate,ShiftName,ShiftTime,Night,FirstOnDuty,Degree,StretchShift,EmployeeDesc,"
strExportSql = strExportSql & "CONVERT(CHAR(5),AonDuty,108),CONVERT(CHAR(5),AonDutyStart,108),CONVERT(CHAR(5),AonDutyEnd,108),CONVERT(CHAR(5),AoffDuty,108), CONVERT(CHAR(5),AoffDutyStart,108), CONVERT(CHAR(5),AoffDutyEnd,108),AcalculateLate,AcalculateEarly,ArestTime,"
strExportSql = strExportSql & "CONVERT(CHAR(5),BonDuty,108),CONVERT(CHAR(5),BonDutyStart,108),CONVERT(CHAR(5),BonDutyEnd,108),CONVERT(CHAR(5),BoffDuty,108), CONVERT(CHAR(5),BoffDutyStart,108), CONVERT(CHAR(5),BoffDutyEnd,108),BcalculateLate,BcalculateEarly,BrestTime,"
strExportSql = strExportSql & "CONVERT(CHAR(5),ConDuty,108),CONVERT(CHAR(5),ConDutyStart,108),CONVERT(CHAR(5),ConDutyEnd,108),CONVERT(CHAR(5),CoffDuty,108), CONVERT(CHAR(5),CoffDutyStart,108), CONVERT(CHAR(5),CoffDutyEnd,108),CcalculateLate,CcalculateEarly,CrestTime"
strExportSql = strExportSql & " from TempShifts where 1 > 0 " & strWhere & "order by "& sidx & " " & sord

'response.write strExportSql
'response.end
set a.dbconnection=conn

'strExportSql = "employees||\ResidentFlash\www\wwwpub\download\employees.csv||" & strExportSql
'Response.Cookies("ExportData")=strExportSql
Session("exportdata")=strExportSql
 
'response.Write(Session("exportdata"))
response.Write(a.GetJSon())
'conn.close()
'set conn = nothing
fCloseADO()
%>
