﻿<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Equipment\SearchExec.asp" -->
<%
dim page,rows,sidx,sord,isExport,strExportSql
dim strControllerId,strDepartmentId,strProperty,strshowAllRow,startTime,endTime
page = request.QueryString("page") 'page
rows = request.QueryString("rows") 'pagesize
sidx = request.QueryString("sidx") 'order by ??
sord = request.QueryString("sord")
strDepartmentId = trim(request.QueryString("DepartmentId"))
strshowAllRow = trim(request.QueryString("showAllRow"))
if strDepartmentId = "" then strDepartmentId = "0" end if

startTime = request.QueryString("startTime")
endTime = request.QueryString("endTime")
isExport = request.QueryString("isExport")

if page="" then page = 1 end if
if rows = "" then rows = 10 end if
if sidx = "" then sidx = "EmployeeId" end if
if sord = "" then sord ="asc" end if
if sidx = "DepartmentID" then sidx = "E.DepartmentID" end if
Dim strSearchOn, strField, strFieldData, strSearchOper, strWhere
dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

strWhere = ""
endTime = endTime & " 23:59:59"
strSearchOn = request.QueryString("search")

If (strSearchOn = "true") Then
	strField = request.QueryString("searchField")
	strFieldData = request.QueryString("searchString")
	strSearchOper = request.QueryString("searchOper")
	'If (strField = "ControllerId" Or strField = "ControllerNumber" Or strField = "ControllerName" Or strField = "Location" Or strField = "ServerIP" ) Then
	if strWhere = "" then 
		strWhere = "where "
	else
		strWhere = strWhere & " and "
	end if
	strWhere = strWhere & GetSearchSQLWhere(strField,strSearchOper,strFieldData)
	'取有访问权限的部门
	if strUserId<>"1" then '1 为admin用户
		strWhere = strWhere & " and E.DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
	end if 
	strWhere = strWhere & " and Left(IncumbencyStatus,1)<>'1' "
ELSE

	if strDepartmentId = "0" then	'0 我的记录  	-1 所有部门
		strWhere = strWhere & " where E.Employeeid in ("&session("EmId")&") "
		strWhere = strWhere & " and Left(IncumbencyStatus,1)<>'1' "
	elseif strDepartmentId = "-1" then 
		'取有访问权限的部门
		if strUserId<>"1" then '1 为admin用户
			strWhere = strWhere & " where (E.DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
			strWhere = strWhere & " or  E.Employeeid in ("&session("EmId")&") ) "
			strWhere = strWhere & " and Left(IncumbencyStatus,1)<>'1' "
		else
			strWhere = strWhere & " where Left(IncumbencyStatus,1)<>'1' "
		end if 	
	else
		'20140512 前台选择某个部门时，将子部门的ID一起返回
		strWhere = strWhere & " where D.DepartmentId in ("&strDepartmentId&") "
		'取有访问权限的部门
		if strUserId<>"1" then '1 为admin用户
			strWhere = strWhere & " and E.DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
		end if 
		strWhere = strWhere & " and Left(IncumbencyStatus,1)<>'1' "
	end if
	
End If

'server.ScriptTimeout=9000
fConnectADODB()
dim a
set a=new JSONClass
a.Sqlstring="select E.EmployeeID,D.DepartmentName,E.Name,E.Number,E.Card,E.Sex,E.Headship,E.JoinDate from Employees E left join Departments D on E.DepartmentID = D.DepartmentID  "&strWhere&" "&"order by "& sidx & " " & sord

set a.dbconnection=conn

strExportSql = strWhere&" "&"order by "& sidx & " " & sord
'参数说明 ：报表类型|参数个数|参数.....
Session("exportdata")="attend|4|"&startTime&"|"&endTime&"|"&strshowAllRow&"|"&strExportSql

response.Write(a.GetJSon())
'conn.close()
'set conn = nothing
fCloseADO()
%>
