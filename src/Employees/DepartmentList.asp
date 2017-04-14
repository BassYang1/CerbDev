<%'Session.CodePage=65001%>
<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<!--#include file="..\Common\Page.asp" -->
<%
response.Charset="utf-8"
dim page,rows,sidx,sord
dim departmentId,strSQL,strExportSql
page = request.QueryString("page") 'page
rows = request.QueryString("rows") 'pagesize
sidx = request.QueryString("sidx") 'order by ??
sord = request.QueryString("sord")
departmentId = Request.QueryString("departmentId")
if page="" then page = 1 end if
if rows = "" then rows = 10 end if
if sidx = "" then sidx = "DepartmentID" end if
if sord = "" then sord ="asc" end if

dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

Dim strSearchOn, strField, strFieldData, strSearchOper, strWhere
strSearchOn = request.QueryString("_search")
'response.Write("strSearchOn:"&strSearchOn&",strField:"&request.QueryString("searchField")&",strFieldData:"&request.QueryString("searchString")&",strSearchOper:"&request.QueryString("searchOper")
strWhere = ""
If (strSearchOn = "true") Then
	strField = request.QueryString("searchField")
	If ( strField = "DepartmentName") Then
		strFieldData = request.QueryString("searchString")
		strSearchOper = request.QueryString("searchOper")
		'construct where
		strWhere = "  D.DepartmentCode " 
		Select Case strSearchOper
			Case "bw" : 'Begin With
			'strFieldData = strFieldData & "%"
			'strWhere = strWhere & " LIKE '" & strFieldData & "'"
			Case "eq" : 'Equal
			strWhere = strWhere & " like (select DepartmentCode+'%' from Departments where DepartmentName = '"&strFieldData&"') " 
			Case "ne": 'Not Equal
			strWhere = strWhere & " NOT like (select DepartmentCode+'%' from Departments where DepartmentName = '"&strFieldData&"') " 
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
			'strWhere = strWhere & " LIKE '%" & strFieldData & "%'"
			strWhere =  " D.DepartmentId IN (select distinct a.DepartmentID from Departments a,Departments b where patindex(b.DepartmentCode+'%',a.DepartmentCode)>0 and b.DepartmentName like '%"&strFieldData&"%' ) " 
			Case "nc" : 'Contains
			strWhere = strWhere & " NOT LIKE '%" & strFieldData & "%'"
		End Select
	End if
End If


'server.ScriptTimeout=9000
fConnectADODB()
'fConnectADOCE()
dim a
set a=new JSONClass
dim strChildDepartId
strChildDepartId = GetChildDepart()
if strChildDepartId = "" then 
	strChildDepartId = "0"
end if
'evel_field  	节点的级别，默认最高级为0
'parent_id_field 	该行数据父节点的id
'leaf_field 	是否为叶节点，为true时表示该节点下面没有子节点了
'expanded_field 	是否默认展开状态
strSQL = "select D.DepartmentID,D.DepartmentID,D.ParentDepartmentID,D.DepartmentName,len(D.DepartmentCode)/5 as DepartmentLevel,len(D.DepartmentCode)/5-1 as level_field,ISNULL(D.ParentDepartmentID,0) as parent_id_field,(Case when C.DepartmentID is NULL then 'false' else 'true' end) as leaf_field,'false' as expanded_field  from Departments D left join  (select DepartmentID from Departments where DepartmentID in ("&strChildDepartId&")) C on D.DepartmentID = C.DepartmentID  "
strExportSql="select D.DepartmentID,D.DepartmentName,cast(D.DepartmentCode as Nvarchar(100))  from Departments D "
'取有访问权限的部门
if strUserId<>"1" then '1 为admin用户
	strSQL = strSQL & " Where D.DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
	strExportSql = strExportSql & " Where D.DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
	if strWhere <> "" then 
		strSQL = strSQL & " and " &strWhere
		strExportSql = strExportSql & " and " &strWhere
	end if 
else
	if strWhere <> "" then 
		strSQL = strSQL & " Where " &strWhere
		strExportSql = strExportSql & " Where " &strWhere
	end if 	
end if 


strSQL = strSQL & " order by D.DepartmentCode  "
strExportSql = strExportSql & " order by D.DepartmentCode  "
Session("exportdata")=strExportSql

a.Sqlstring=strSQL
set a.dbconnection=conn
response.Write(a.GetJSon())
'conn.close()
'set conn = nothing
fCloseADO()
%>
