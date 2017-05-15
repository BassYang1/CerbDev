<%'Session.CodePage=65001%>
<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<!--#include file="..\Common\Page.asp" -->
<%
response.Charset="utf-8"
dim page,rows,sidx,sord
dim strTemplateId,strSQL,strExportSql
page = request.QueryString("page") 'page
rows = request.QueryString("rows") 'pagesize
sidx = request.QueryString("sidx") 'order by ??
sord = request.QueryString("sord")
if page="" then page = 1 end if
if rows = "" then rows = 10 end if
if sidx = "" then sidx = "HolidayId" end if
if sord = "" then sord ="asc" end if

dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if
strTemplateId = trim(request.QueryString("templateId"))

Dim strSearchOn, strField, strFieldData, strSearchOper, strWhere
strSearchOn = request.QueryString("_search")
'response.Write("strSearchOn:"&strSearchOn&",strField:"&request.QueryString("searchField")&",strFieldData:"&request.QueryString("searchString")&",strSearchOper:"&request.QueryString("searchOper")

'construct where
strWhere = ""
if strTemplateId <> "" then strWhere = " and TemplateId=" & strTemplateId

If (strSearchOn = "true") Then
	strField = request.QueryString("searchField")
	strFieldData = request.QueryString("searchString")
	strSearchOper = request.QueryString("searchOper")

	If strField = "HolidayName" Then
		strWhere = "and HolidayName " 
		Select Case strSearchOper
			Case "eq" : 'Equal
				strWhere = strWhere & " = '"&strFieldData&"' "
			Case "ne" : 'Not Equal
				strWhere = strWhere & " != '"&strFieldData&"' "
			Case "cn" : 'Contain
				strWhere = strWhere & " LIKE '%"&strFieldData&"%' "
			Case "nc" : 'Not Contain
				strWhere = strWhere & " NOT LIKE '%"&strFieldData&"%' "
		End Select
	End if
End If



'server.ScriptTimeout=9000
fConnectADODB()
'fConnectADOCE()
dim a
set a=new JSONClass
strSQL = "select HolidayId,HolidayDate,TransposalDate,HolidayName,TempLateId " 
strSQL = strSQL & " from AttendanceHoliday H where 1 > 0 " & strWhere & " order by "& sidx & " " & sord

'response.write strSQL
'response.end
a.Sqlstring=strSQL

'导出
strExportSql = "select HolidayId,HolidayDate,TransposalDate,HolidayName,(select top 1 TemplateName FROM ControllerTemplates WHERE TemplateType=1 AND TempLateId=H.TempLateId) AS TemplateName "
strExportSql = strExportSql & "from AttendanceHoliday H where 1 > 0 " & strWhere & " order by "& sidx & " " & sord

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

