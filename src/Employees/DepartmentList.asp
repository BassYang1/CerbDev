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

'evel_field  	节点的级别，默认最高级为0
'parent_id_field 	该行数据父节点的id
'leaf_field 	是否为叶节点，为true时表示该节点下面没有子节点了
'expanded_field 	是否默认展开状态
'DepartmentID, DepartmentID, ParentDepartmentID, DepartmentName, DepartmentLevel, level_field, parent_id_field, leaf_field, expanded_field
strSQL = "select count(1), (select '{"&chr(34)&"id"&chr(34)&":"&chr(34)&"' + CAST(D.DepartmentID AS NVARCHAR(10)) + '"&chr(34)&",' + '"&chr(34)&"cell"&chr(34)&":["&chr(34)&"' + CAST(D.DepartmentID AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"' + CAST(D.DepartmentID AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"' + CAST(D.ParentDepartmentID AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"' + D.DepartmentName + '"&chr(34)&","&chr(34)&"' + CAST(len(D.DepartmentCode)/5 as NVARCHAR(2)) + '"&chr(34)&","&chr(34)&"' + CAST(len(D.DepartmentCode)/5-1 AS NVARCHAR(2)) + '"&chr(34)&","&chr(34)&"' + CAST(ISNULL(D.ParentDepartmentID,0) AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"' + (Case when C.DepartmentID is NULL then 'false' else 'true' end) + '"&chr(34)&","&chr(34)&"' + 'false' + '"&chr(34)&"]},'  from Departments D left join (SELECT DepartmentId FROM Departments D1 WHERE EXISTS(SELECT 1 FROM Departments WHERE D1.DepartmentCode != DepartmentCode and LEFT(DepartmentCode, len(D1.DepartmentCode)) = D1.DepartmentCode)) C ON C.DepartmentID = D.DepartmentID "
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


strSQL = strSQL & " order by D.DepartmentCode for xml path('')) as JsonData from Departments  "
strExportSql = strExportSql & " order by D.DepartmentCode  "

Session("exportdata")=strExportSql

dim strJS, strJsonData
strJS = "{ "&chr(34)&"total"&chr(34)&": 1, "&chr(34)&"page"&chr(34)&": 1, "

Rs.open strSQL, Conn, 2, 1
If Not Rs.eof Then
	strJS = strJS & chr(34)&"records"&chr(34)&": " & Trim(Rs.fields(0).value) & ", "

	strJsonData = Trim(Rs.fields(1).value)
	'strJsonData = replace(strJsonData, "&amp;", "&")

	if len(strJsonData) > 1 then
		strJS = strJS & chr(34)&"rows"&chr(34)&":[" & left(strJsonData,len(strJsonData)-1) & "]}"
	else
		strJS = strJS & chr(34)&"rows"&chr(34)&":[]}"
	end if
End If

response.Write(strJS)
'conn.close()
'set conn = nothing
fCloseADO()
%>
