<!--#include file="Page.asp" -->
<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<%
response.Charset="utf-8"

dim strUserId
strUserId = session("UserId")

if strUserId = "" then strUserId = "0" end if

dim conidtionStr, empIds, strSQL, sqlCondition
conidtionStr = Replace(Request.Form("condition"),"'","''")
empIds = Replace(Request.Form("empIds"),"'","''")
strSQL = "SELECT EmployeeId as id, name, number FROM Employees E WHERE LEFT(IncumbencyStatus,1)<>'1'"

if conidtionStr <> "" then 
	arr = split(conidtionStr,"|,")

	if IsArray(arr) and UBound(arr) >= 2 then 
		sqlCondition = GetSearchSQLConidtion(arr(0), arr(1), arr(2))

		if sqlCondition <> "" then
			strSQL = strSQL & " and " & sqlCondition
		end if
	end if
end if

if empIds <> "" then
	strSQL = strSQL & " and EmployeeId IN (" & empIds & ")"
end if

if strUserId <> "1" then
	strSQL = strSQL + " and exists(select 1 from RoleDepartment where DepartmentId=E.DepartmentId and UserId = '"&strUserId&"')"
end if

fConnectADODB()

dim jsonObj
set jsonObj = new JSONClass
set jsonObj.dbconnection=conn

jsonObj.Sqlstring = strSQL
response.Write(jsonObj.GetAllJSON())

fCloseADO()
%>