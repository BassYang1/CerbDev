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
if sidx = "" then sidx = "RuleId" end if
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

	If strField = "OnDutyMode" Then
		strWhere = "and OnDutyMode " 
		Select Case strSearchOper
			Case "eq" : 'Equal
				strWhere = strWhere & " = '"&strFieldData&"' "
		End Select
	ElseIf strField = "NoBrushCard" Then
		strWhere = "and NoBrushCard " 
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
strSQL = "select RuleId,EmployeeDesc,OnDutyMode,'' AS RuleDetail,NoBrushCard,DepartmentCode,EmployeeCode,OtherCode,FirstWeekDate,Monday1,Tuesday1,Wednesday1,Thursday1,Friday1,Saturday1,Sunday1,Monday2,Tuesday2,Wednesday2,Thursday2,Friday2,Saturday2,Sunday2,day15,day16,day17,day18,day19,day20,day21,day22,day23,day24,day25,day26,day27,day28,day29,day30,day31,CONVERT(varchar(10),ISNULL((select top 1 ChangeDate from AttendanceOnDutyRuleChange where RuleId = R.RuleId order by ChangeId desc),''), 121) AS ChangeDate " 
strSQL = strSQL & " from AttendanceOndutyRule R where 1 > 0 " & strWhere & " order by "& sidx & " " & sord

'response.write strSQL
'response.end
a.Sqlstring=strSQL

'导出
strExportSql = "select RuleId,EmployeeDesc,OnDutyMode,NoBrushCard,FirstWeekDate,ISNULL(substring(Monday1,charindex('-',Monday1)+1, len(Monday1) )+ ',','') + ISNULL(substring(Tuesday1,charindex('-',Tuesday1)+1, len(Tuesday1) )+ ',','') + ISNULL(substring(Wednesday1,charindex('-',Wednesday1)+1, len(Wednesday1) )+ ',','') + ISNULL(substring(Thursday1,charindex('-',Thursday1)+1, len(Thursday1) )+ ',','') + ISNULL(substring(Friday1,charindex('-',Friday1)+1, len(Friday1) )+ ',','') + ISNULL(substring(Saturday1,charindex('-',Saturday1)+1, len(Saturday1) )+ ',','') + ISNULL(substring(Sunday1,charindex('-',Sunday1)+1, len(Sunday1) )+ ';','') + ISNULL(substring(Monday2,charindex('-',Monday2)+1, len(Monday2) )+ ',','') + ISNULL(substring(Tuesday2,charindex('-',Tuesday2)+1, len(Tuesday2) )+ ',','') + ISNULL(substring(Wednesday2,charindex('-',Wednesday2)+1, len(Wednesday2) )+ ',','') + ISNULL(substring(Thursday2,charindex('-',Thursday2)+1, len(Thursday2) )+ ',','') + ISNULL(substring(Friday2,charindex('-',Friday2)+1, len(Friday2) )+ ',','') + ISNULL(substring(Saturday2,charindex('-',Saturday2)+1, len(Saturday2) )+ ',','') + ISNULL(substring(Sunday2,charindex('-',Sunday2)+1, len(Sunday2)),'') + ISNULL(substring(day15,charindex('-',day15)+1, len(day15)),'')+ ISNULL(substring(day16,charindex('-',day16)+1, len(day16)),'')+ ISNULL(substring(day17,charindex('-',day17)+1, len(day17)),'')+ ISNULL(substring(day18,charindex('-',day18)+1, len(day18)),'')+ ISNULL(substring(day19,charindex('-',day19)+1, len(day19)),'')+ ISNULL(substring(day20,charindex('-',day20)+1, len(day20)),'')+ ISNULL(substring(day21,charindex('-',day21)+1, len(day21)),'')+ ISNULL(substring(day22,charindex('-',day22)+1, len(day22)),'')+ ISNULL(substring(day23,charindex('-',day23)+1, len(day23)),'')+ ISNULL(substring(day24,charindex('-',day24)+1, len(day24)),'')+ ISNULL(substring(day25,charindex('-',day25)+1, len(day25)),'')+ ISNULL(substring(day26,charindex('-',day26)+1, len(day26)),'')+ ISNULL(substring(day27,charindex('-',day27)+1, len(day27)),'')+ ISNULL(substring(day28,charindex('-',day28)+1, len(day28)),'')+ ISNULL(substring(day29,charindex('-',day29)+1, len(day29)),'')+ ISNULL(substring(day30,charindex('-',day30)+1, len(day30)),'')+ ISNULL(substring(day31,charindex('-',day31)+1, len(day31)),'') as RuleDetail,CONVERT(varchar(10),ISNULL((select top 1 ChangeDate from AttendanceOnDutyRuleChange where RuleId = R.RuleId order by ChangeId desc),''), 121) AS ChangeDate "
strExportSql = strExportSql & "from AttendanceOndutyRule R where 1 > 0 " & strWhere & " order by "& sidx & " " & sord

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

