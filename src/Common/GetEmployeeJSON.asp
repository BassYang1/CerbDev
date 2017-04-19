<!--#include file="Page.asp" -->
<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<%
response.Charset="utf-8"
fConnectADODB()

dim jsonObj
set jsonObj = new JSONClass
set jsonObj.dbconnection=conn

jsonObj.Sqlstring = "SELECT EmployeeId as id, name, number FROM Employees E WHERE LEFT(IncumbencyStatus,1)<>'1'"
response.Write(jsonObj.GetAllJSON())

fCloseADO()
%>