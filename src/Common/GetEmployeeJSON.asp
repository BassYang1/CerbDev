<!--#include file="Page.asp" -->
<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<%
response.Charset="utf-8"

dim conidtionStr, sqlStr, sqlCondition
conidtionStr = Replace(Request.Form("condition"),"'","''")
sqlStr = "SELECT EmployeeId as id, name, number FROM Employees E WHERE LEFT(IncumbencyStatus,1)<>'1'"

if conidtionStr <> "" then 
	arr = split(conidtionStr,"|,")

	if IsArray(arr) and UBound(arr) >= 2 then 
		sqlCondition = GetSearchSQLConidtion(arr(0), arr(1), arr(2))

		if sqlCondition <> "" then
			sqlStr = sqlStr & " and " & sqlCondition
		end if
	end if
end if

fConnectADODB()

dim jsonObj
set jsonObj = new JSONClass
set jsonObj.dbconnection=conn

jsonObj.Sqlstring = sqlStr
response.Write(jsonObj.GetAllJSON())

fCloseADO()
%>