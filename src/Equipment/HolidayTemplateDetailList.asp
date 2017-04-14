<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<%
dim page,rows,sidx,sord,TemplateId
page = request.QueryString("page") 'page
rows = request.QueryString("rows") 'pagesize
sidx = request.QueryString("sidx") 'order by ??
sord = request.QueryString("sord")
TemplateId = request.QueryString("TemplateId")
if page="" then page = 1 end if
if rows = "" then rows = 10 end if
if sidx = "" then sidx = "RecordID" end if
if sord = "" then sord ="asc" end if

Dim strSearchOn, strField, strFieldData, strSearchOper, strWhere
strSearchOn = request.QueryString("_search")
'response.Write("strSearchOn:"&strSearchOn&",strField:"&request.QueryString("searchField")&",strFieldData:"&request.QueryString("searchString")&",strSearchOper:"&request.QueryString("searchOper")
If (strSearchOn = "true") Then
	strField = request.QueryString("searchField")
	If ( strField = "TemplateName") Then
		strFieldData = request.QueryString("searchString")
		strSearchOper = request.QueryString("searchOper")
		'construct where
		strWhere = " Where " & strField
		Select Case strSearchOper
			Case "bw" : 'Begin With
			strFieldData = strFieldData & "%"
			strWhere = strWhere & " LIKE '" & strFieldData & "'"
			Case "eq" : 'Equal
			If(IsNumeric(strFieldData)) Then
				strWhere = strWhere & " = " & strFieldData
			Else
				strWhere = strWhere & " = '" & strFieldData & "'"
			End If
			Case "ne": 'Not Equal
			If(IsNumeric(strFieldData)) Then
				strWhere = strWhere & " <> " & strFieldData
			Else
				strWhere = strWhere & " <> '"& strFieldData &"'"
			End If
			Case "lt": 'Less Than
			If(IsNumeric(strFieldData)) Then
				strWhere = strWhere & " <" & strFieldData
			Else
				strWhere = strWhere & " <'"& strFieldData &"'"
			End If
			Case "le": 'Less Or Equal
			If(IsNumeric(strFieldData)) Then
				strWhere = strWhere & " <= " & strFieldData
			Else
				strWhere = strWhere & " <= '"& strFieldData &"'"
			End If
			Case "gt": 'Greater Than
			If(IsNumeric(strFieldData)) Then
				strWhere = strWhere & " > " & strFieldData
			Else
				strWhere = strWhere & " > '"& strFieldData &"'"
			End If
			Case "ge": 'Greater Or Equal
			If(IsNumeric(strFieldData)) Then
				strWhere = strWhere & " >= " & strFieldData
			Else
				strWhere = strWhere & " >= '"& strFieldData &"'"
			End If
			Case "ew" : 'End With
			strWhere = strWhere & " LIKE '%" & strFieldData & "'"
			Case "cn" : 'Contains
			strWhere = strWhere & " LIKE '%" & strFieldData & "%'"
			Case "nc" : 'Contains
			strWhere = strWhere & " NOT LIKE '%" & strFieldData & "%'"
		End Select
	End if
End If
'server.ScriptTimeout=9000
fConnectADODB()
dim a
set a=new JSONClass
'a.Sqlstring="Select RecordID,Employeeid,Card,Controllerid,BrushTime From BrushCardTest"&strWhere&" "&"order by "& sidx & " " & sord
a.Sqlstring="select HolidayNumber,HolidayName,HolidayDate from ControllerTemplateHoliday Where TemplateId="&TemplateId&" "&"order by "& sidx & " " & sord
set a.dbconnection=conn
response.Write(a.GetJSon())
'conn.close()
'set conn = nothing
fCloseADO()
%>
