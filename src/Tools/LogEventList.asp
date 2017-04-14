<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<%
dim page,rows,sidx,sord,startTime,endTime,strDepartmentId
page = request.QueryString("page") 'page
rows = request.QueryString("rows") 'pagesize
sidx = request.QueryString("sidx") 'order by ??
sord = request.QueryString("sord")
startTime = request.QueryString("startTime")
endTime = request.QueryString("endTime")
strDepartmentId = trim(request.QueryString("DepartmentId"))
if strDepartmentId = "" then strDepartmentId = "0" end if

if page="" then page = 1 end if
if rows = "" then rows = 10 end if
if sidx = "" then sidx = "EventID" end if
if sord = "" then sord ="asc" end if
dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

Dim strSearchOn, strField, strFieldData, strSearchOper, strWhere,strExportSql
strSearchOn = request.QueryString("_search")
if	startTime <> "" and endTime <> "" then 
	strWhere = " and OperateTime between '"&startTime&"' and '"&endTime&"' "
else
	strWhere = " and OperateTime > '1900-01-01' "	
end if
strWhere =  strWhere & " "
'response.Write("test:"&request.QueryString("test")&"strSearchOn:"&strSearchOn&",strField:"&request.QueryString("searchField")&",strFieldData:"&request.QueryString("searchString")&",strSearchOper:"&request.QueryString("searchOper"))
If (strSearchOn = "true") Then
	strField = request.QueryString("searchField")
	If (strField = "LoginName" Or strField = "LoginIP" Or strField = "OperateTime" Or strField = "Modules" Or strField = "Actions" Or strField = "Objects") Then
		strFieldData = request.QueryString("searchString")
		strSearchOper = request.QueryString("searchOper")
		'construct where
		strWhere = strWhere & " and " & strField	
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
		'取有访问权限的部门
		if strUserId<>"1" then '1 为admin用户
			strWhere = strWhere & " and LoginName in ( select U.LoginName from Employees E INNER Join Users U on E.employeeid=U.employeeid where left(E.IncumbencyStatus,1) <> '1' and E.DepartmentID IN  (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) ) "
		end if 
	End if
Else

	if strDepartmentId = "0" then '0 我的记录  	-1 所有部门
		strWhere = strWhere & " and LoginName in (select U.LoginName from Employees E INNER Join Users U on E.employeeid=U.employeeid where left(E.IncumbencyStatus,1) <> '1' and E.EmployeeId IN  ("&session("EmId")&") ) "
	elseif strDepartmentId = "-1" then '	-1 所有部门
		'取有访问权限的部门
		if strUserId<>"1" then '1 为admin用户
			strWhere = strWhere & " and ( LoginName in ( select U.LoginName from Employees E INNER Join Users U on E.employeeid=U.employeeid where left(E.IncumbencyStatus,1) <> '1' and E.DepartmentID IN  (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) ) "
			strWhere = strWhere & " or LoginName in (select U.LoginName from Employees E INNER Join Users U on E.employeeid=U.employeeid where left(E.IncumbencyStatus,1) <> '1' and E.EmployeeId IN  ("&session("EmId")&") )  )"
		end if 
		
	else
		'20140512 前台选择某个部门时，将子部门的ID一起返回
		strWhere = strWhere & " and LoginName in ( select U.LoginName from Employees E INNER Join Users U on E.employeeid=U.employeeid where left(E.IncumbencyStatus,1) <> '1' and E.DepartmentID IN  ("&strDepartmentId&") )"
		'取有访问权限的部门
		if strUserId<>"1" then '1 为admin用户
			strWhere = strWhere & " and LoginName in ( select U.LoginName from Employees E INNER Join Users U on E.employeeid=U.employeeid where left(E.IncumbencyStatus,1) <> '1' and E.DepartmentID IN  (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) ) "
		end if 
	end if

End If

'server.ScriptTimeout=9000
fConnectADODB()
dim a
set a=new JSONClass
a.Sqlstring="select EventID,LoginName,LoginIP,convert(varchar(20),OperateTime, 120) as OperateTime,Modules,Actions,Objects from LogEvent where EventID>0 "&strWhere&" "&" order by "& sidx & " " & sord
strExportSql="select LoginName,LoginIP,convert(varchar(20),OperateTime, 120) as OperateTime,Modules,Actions,Objects from LogEvent where EventID>0 "&strWhere&" "&" order by "& sidx & " " & sord
Session("exportdata")=strExportSql

set a.dbconnection=conn
response.Write(a.GetJSon())
'conn.close()
'set conn = nothing
fCloseADO()
%>
