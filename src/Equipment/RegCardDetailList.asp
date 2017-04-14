<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<!--#include file="SearchExec.asp" -->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
dim page,rows,sidx,sord
page = request.QueryString("page") 'page
rows = request.QueryString("rows") 'pagesize
sidx = request.QueryString("sidx") 'order by ??
sord = request.QueryString("sord")
if page="" then page = 1 end if
if rows = "" then rows = 10 end if
if sidx = "" then sidx = "CE.ControllerId" end if
if sord = "" then sord ="asc" end if
if sidx = "DepartmentID" then 
	sidx = "E."&sidx
elseif sidx = "ScheduleCode" or sidx = "ControllerID" then 
	sidx = "CE."&sidx
end if
Dim strControllerId
strControllerId = request.QueryString("ControllerId")
strWhere = ""
if strControllerId <> "" then 
	strWhere = " where CE.ControllerID in ("&strControllerId&") "
else
	strWhere = ""
end if 
Dim strSearchOn, strField, strFieldData, strSearchOper, strWhere
strSearchOn = request.QueryString("search")
dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

If (strSearchOn = "true") Then
	strField = request.QueryString("searchField")
	strFieldData = request.QueryString("searchString")
	strSearchOper = request.QueryString("searchOper")
	'If (strField = "ControllerId" Or strField = "ControllerNumber" Or strField = "ControllerName" Or strField = "Location" Or strField = "ServerIP" ) Then
		if strWhere = "" then 
			strWhere = " where "
		else
			strWhere = strWhere & " and "
		end if
		strWhere = strWhere & GetSearchSQLWhere(strField,strSearchOper,strFieldData)
		'construct where
	'End if
End If
'server.ScriptTimeout=9000

'删除标记的数据不显示
if strWhere = "" then 
	strWhere = " where CE.DeleteFlag <> 1 "
else
	strWhere = strWhere & " and CE.DeleteFlag <> 1 "
end if
		
fConnectADODB()
dim a
set a=new JSONClass
'取有访问权限的设备
if strUserId<>"1" then '1 为admin用户
	if strWhere = "" then 
		strWhere = " where "
	else
		strWhere = strWhere & " and "
	end if
	strWhere = strWhere & " CE.ControllerId in (select ControllerID from RoleController where UserId in ("&strUserId&") and Permission=1 ) "
	strWhere = strWhere & " and E.DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
end if 
a.Sqlstring="select CE.RecordID,C.ControllerNumber,D.DepartmentName, E.Name,E.Number,E.Card,CE.ValidateMode,CS.TemplateName, CE.EmployeeDoor,(Case when Datalength(IsNULL(photo,''))>2 then '"+GetEmpLbl("Yes")+"' else '"+GetEmpLbl("No")+"' end) as IsPhoto,(Case when Datalength(IsNULL(FingerPrint1,''))>=512 then '"+GetEmpLbl("Yes")+"' else '"+GetEmpLbl("No")+"' end) as isFingerPrint, CE.Status,CE.Employeeid,CE.ControllerId as ControllerID1 from ControllerEmployee CE LEFT OUTER JOIN  ControllerSchedule CS on CE.ScheduleCode=CS.TemplateId and CS.ControllerId=CE.ControllerId  LEFT OUTER JOIN  Controllers C on  CE.ControllerId=C.ControllerId left join Employees E on E.Employeeid=CE.Employeeid left join Departments D on E.DepartmentID=D.DepartmentID "&strWhere&" order by "& sidx & " " & sord

Session("exportdata")="select C.ControllerNumber,D.DepartmentName, E.Name,E.Number,E.Card,CE.ValidateMode,CS.TemplateName, CE.EmployeeDoor,(Case when Datalength(IsNULL(photo,''))>2 then '"+GetEmpLbl("Yes")+"' else '"+GetEmpLbl("No")+"' end) as IsPhoto,(Case when Datalength(IsNULL(FingerPrint1,''))>=512 then '"+GetEmpLbl("Yes")+"' else '"+GetEmpLbl("No")+"' end) as isFingerPrint,(Case when ISNULL(CE.Status,0)=1 then '"+GetEquLbl("SyncEd")+"' else '"+GetEquLbl("UnSync")+"' end) as SyncStatus from ControllerEmployee CE LEFT OUTER JOIN  ControllerSchedule CS on CE.ScheduleCode=CS.TemplateId and CS.ControllerId=CE.ControllerId  LEFT OUTER JOIN  Controllers C on  CE.ControllerId=C.ControllerId left join Employees E on E.Employeeid=CE.Employeeid left join Departments D on E.DepartmentID=D.DepartmentID "&strWhere&" order by "& sidx & " " & sord

set a.dbconnection=conn
response.Write(a.GetJSon())
'conn.close()
'set conn = nothing
fCloseADO()
%>
