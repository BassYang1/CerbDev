﻿<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<%
dim page,rows,sidx,sord,strDepartmentId
page = request.QueryString("page") 'page
rows = request.QueryString("rows") 'pagesize
sidx = request.QueryString("sidx") 'order by ??
sord = request.QueryString("sord")
strDepartmentId = trim(request.QueryString("DepartmentId"))
if strDepartmentId = "" then strDepartmentId = "0" end if
if page="" then page = 1 end if
if rows = "" then rows = 10 end if
if sidx = "" then sidx = "UserId" end if
if sord = "" then sord ="asc" end if
dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

Dim strSearchOn, strField, strFieldData, strSearchOper, strWhere,strExportSql
strSearchOn = request.QueryString("_search")
'response.Write("strSearchOn:"&strSearchOn&",strField:"&request.QueryString("searchField")&",strFieldData:"&request.QueryString("searchString")&",strSearchOper:"&request.QueryString("searchOper")
strWhere = ""
If (strSearchOn = "true") Then
	strField = request.QueryString("searchField")
	If (strField = "LoginName" Or  strField = "Name" ) Then
		strFieldData = request.QueryString("searchString")
		strSearchOper = request.QueryString("searchOper")
		'construct where
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
			Case "nc" : 'not Contains
			strWhere = strWhere & " NOT LIKE '%" & strFieldData & "%'"
		End Select
	End if
ELSE

	if strDepartmentId = "0" then '0 我的记录  	-1 所有部门
		strWhere = strWhere & " and E.Employeeid in ("&session("EmId")&") "
	elseif strDepartmentId = "-1" then '	-1 所有部门
		'所有部门时，只需要直接取具有访问权限的部门
	else
		'20140512 前台选择某个部门时，将子部门的ID一起返回
		strWhere = strWhere & " and E.DepartmentId in ("&strDepartmentId&") "
	end if

End If
'取有访问权限的部门
if strUserId<>"1" then '1 为admin用户
	if  strDepartmentId = "-1" and strSearchOn <> "true" then '-1所有部门搜索时，需将当前用户的数据也加入
		strWhere = strWhere & " and (E.DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
		strWhere = strWhere & " or E.Employeeid in ("&session("EmId")&") )"
	elseif strDepartmentId <> "0" then 
		strWhere = strWhere & " and E.DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
	end if
end if 

'server.ScriptTimeout=9000
fConnectADODB()
dim a
set a=new JSONClass
'a.Sqlstring="Select RecordID,Employeeid,Card,Controllerid,BrushTime From BrushCardTest"&strWhere&" "&"order by "& sidx & " " & sord
a.Sqlstring="Select UserId,LoginName,U.UserPassword,E.EmployeeId,E.Name,OperPermissions,OperPermDesc from Users U Left join Employees E on U.EmployeeId=E.EmployeeId where U.UserId>0 "&strWhere&" "&"order by "& sidx & " " & sord
strExportSql="select LoginName,E.Name,OperPermDesc from Users U Left join Employees E on U.EmployeeId=E.EmployeeId where U.UserId>0 "&strWhere&" "&"order by "& sidx & " " & sord
Session("exportdata")=strExportSql

set a.dbconnection=conn
response.Write(a.GetJSon())
'conn.close()
'set conn = nothing
fCloseADO()
%>
