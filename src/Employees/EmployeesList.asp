<%'Session.CodePage=65001%>
<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<!--#include file="..\Common\Page.asp" -->
<!--#include file="..\Equipment\SearchExec.asp" -->
<!--#include file="..\Conn\GetLbl.asp"-->

<%
response.Charset="utf-8"

dim page,rows,sidx,sord,strDepartmentId
page = request.QueryString("page") 'page
rows = request.QueryString("rows") 'pagesize
sidx = request.QueryString("sidx") 'order by ??
sord = request.QueryString("sord")
strDepartmentId = trim(request.QueryString("DepartmentId"))
if strDepartmentId = "" then strDepartmentId = "0" end if

if page="" then page = 1 end if
if rows = "" then rows = 10 end if
if sidx = "" then sidx = "Employeeid" end if
if sord = "" then sord ="asc" end if
if sidx = "DepartmentID" then sidx = "E.DepartmentID" end if

dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

Dim strSearchOn,strField, strFieldData, strSearchOper,strWhere,strExportSql
strSearchOn = request.QueryString("search")

strWhere = " where Left(IncumbencyStatus,1)<>'1' "

If (strSearchOn = "true") Then
	strField = request.QueryString("searchField")
	strFieldData = request.QueryString("searchString")
	strSearchOper = request.QueryString("searchOper")
	IF strField = "IncumbencyStatus" then 
		strWhere = ""
	End if
	
	if strWhere = "" then 
		strWhere = "where "
	else
		strWhere = strWhere & " and "
	end if
	strWhere = strWhere & GetSearchSQLWhere(strField,strSearchOper,strFieldData)
ELSE

	if strDepartmentId = "0" then '0 我的记录  	-1 所有部门
		strWhere = strWhere & " and Employeeid in ("&session("EmId")&") "
	elseif strDepartmentId = "-1" then '	-1 所有部门
		'所有部门时，只需要直接取具有访问权限的部门
	else
		'strWhere = strWhere & " where D.DepartmentId in (select DepartmentID from departments where DepartmentCode like (select DepartmentCode+'%' from Departments where DepartmentID='"&strDepartmentId&"')) "
		'20140512 前台选择某个部门时，将子部门的ID一起返回
		strWhere = strWhere & " and D.DepartmentId in ("&strDepartmentId&") "
	end if

End If

'取有访问权限的部门
if strUserId<>"1" then '1 为admin用户
	if  strDepartmentId = "-1" and strSearchOn <> "true" then '-1所有部门搜索时，需将当前用户的数据也加入
		strWhere = strWhere & " and (D.DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
		strWhere = strWhere & " or Employeeid in ("&session("EmId")&") )"
	elseif strDepartmentId <> "0" then 
		strWhere = strWhere & " and D.DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
	end if
end if 
'server.ScriptTimeout=9000

fConnectADODB()
'fConnectADOCE()
dim a
set a=new JSONClass
a.Sqlstring="select EmployeeId,DepartmentName,Name,'' as photo1 ,Number,Card,IdentityCard,Sex,Headship,Position,Telephone,Email,CONVERT(nvarchar(20),BirthDate,120) as  BirthDate,CONVERT(nvarchar(20),JoinDate,120) as JoinDate,Marry,Knowledge,Country,NativePlace,Address,IncumbencyStatus,(Case when Datalength(IsNULL(FingerPrint1,''))>=512 then '"+GetEmpLbl("Yes")+"' else '"+GetEmpLbl("No")+"' end) as isFingerPrint,DimissionDate,DimissionReason,Photo,E.DepartmentID from Employees E Left Join Departments D ON E.departmentID=D.DepartmentID "&strWhere&" "&"order by "& sidx & " " & sord

strExportSql="select DepartmentName,Name,Number,Card,IdentityCard,Sex,Headship,Position,Telephone,Email,CONVERT(nvarchar(20),BirthDate,120) as  BirthDate,CONVERT(nvarchar(20),JoinDate,120) as JoinDate,Marry,Knowledge,Country,NativePlace,Address,IncumbencyStatus,(Case when Datalength(IsNULL(FingerPrint1,''))>=512 then '"+GetEmpLbl("Yes")+"' else '"+GetEmpLbl("No")+"' end) as isFingerPrint,(Case when Datalength(IsNULL(Photo,''))>10 then '"+GetEmpLbl("Yes")+"' else '"+GetEmpLbl("No")+"' end) as isPhoto from Employees E Left Join Departments D ON E.departmentID=D.DepartmentID "&strWhere&" "&"order by "& sidx & " " & sord

set a.dbconnection=conn

'strExportSql = "employees||\ResidentFlash\www\wwwpub\download\employees.csv||" & strExportSql
'Response.Cookies("ExportData")=strExportSql
Session("exportdata")=strExportSql
 
response.Write(a.GetJSon())
'conn.close()
'set conn = nothing
fCloseADO()
%>
