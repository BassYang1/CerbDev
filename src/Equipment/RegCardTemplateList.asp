﻿<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Conn\GetLbl.asp" -->
<%
dim lblYes, lblNo
lblYes = GetEquLbl("Yes")
lblNo = GetEquLbl("No")

dim page,rows,sidx,sord
page = request.QueryString("page") 'page
rows = request.QueryString("rows") 'pagesize
sidx = request.QueryString("sidx") 'order by ??
sord = request.QueryString("sord")
if page="" then page = 1 end if
if rows = "" then rows = 10 end if
if sidx = "" then sidx = "TemplateId" end if
if sord = "" then sord ="asc" end if
sidx = "CT."&sidx

dim strUserId
strUserId = session("UserId")

if strUserId = "" then 
	Call ReturnMsg("false",GetCerbLbl("ReLoginSystem"),0) '重新登录系统
	response.End()
end if

Dim strSearchOn, strField, strFieldData, strSearchOper, strWhere
strSearchOn = request.QueryString("_search")
'response.Write("strSearchOn:"&strSearchOn&",strField:"&request.QueryString("searchField")&",strFieldData:"&request.QueryString("searchString")&",strSearchOper:"&request.QueryString("searchOper")
If (strSearchOn = "true") Then
	strField = request.QueryString("searchField")
	If ( strField = "TemplateName") Then
		strFieldData = request.QueryString("searchString")
		strSearchOper = request.QueryString("searchOper")
		'construct where
		strField = "CT."&strField
		strWhere = " and " & strField
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

if strUserId <> "1" then
	strWhere = strWhere & " AND EXISTS (select 1 from Controllers where (left(CT.EmployeeController, 1) = '0' OR CHARINDEX(CAST(ControllerId AS VARCHAR) + ',', CT.EmployeeController + ',') >= 1 ) and ControllerId IN (select ControllerID from RoleController where UserId in (" & strUserId & ") and Permission=1))"
end if

fConnectADODB()
dim a
set a=new JSONClass
a.Sqlstring="select CT.TemplateId,CT.TemplateName, CT.DepartmentCode, '' AS DepartmentList, CT.EmployeeCode, '' AS EmployeeList, CT.OtherCode,CT.EmployeeController,'',CST.TemplateName as  EmployeeScheName,CT.EmployeeScheID,CT.EmployeeDoor,CT.ValidateMode, ISNULL(CT.OnlyByCondition, 0) AS OnlyByCondition from ControllerTemplates CT left join  ControllerTemplates CST on CT.EmployeeScheID=CST.TemplateId where   CT.TemplateType='4' "&strWhere&" "&"order by "& sidx & " " & sord
set a.dbconnection=conn
response.Write(a.GetJSon())
'conn.close()
'set conn = nothing
fCloseADO()
%>
