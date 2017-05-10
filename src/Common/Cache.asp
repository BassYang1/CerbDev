<!--#include file="..\Conn\GetLbl.asp"-->

<%
response.Charset="utf-8"

'---------------------------------------
' Controller类
' 设备管理
'------------------------------------------

Class CacheManager 
	Dim DBConnection

	'缓存部门数据
	Public Function GetDepartments()
		Dim cacheKey, strSQL
		cacheKey = "CacheDepartments"

		Dim allDepts
		allDepts = Application(cacheKey)

		if isarray(allDepts) then
			GetDepartments = allDepts
			exit Function
		end if

		if isobject(DBConnection) = false then
			GetDepartments = "Failed to connect database."
			exit Function
		end if

		strSQL = "SELECT DepartmentId, DepartmentCode, DepartmentName, ParentDepartmentID FROM Departments ORDER BY DepartmentCode;"

		On Error Resume Next		
		Dim rsDept		
		if dbType = 0 then  ''1为MSSQL 0为SQLCE 
			Set rsDept= CreateObject("ADOCE.Recordset.3.1")
		else 
			Set rsDept= Server.CreateObject("ADODB.Recordset")
		end if

		rsDept.Open strSQL, Conn, 1, 1

		allDepts = RecordSetToArray(rsDept)

		Application.Lock
		Application(cacheKey) = allDepts
		GetDepartments = allDepts
		Application.UnLock

		if err.number <> 0 then
			Call fCloseADO()
			GetDepartments = Err.Description
			On Error GoTo 0
			exit Function
		end if
	end Function

	'缓存用户权限部门数据
	Public Function GetRoleDepartments()
		Dim cacheKey, strSQL
		cacheKey = "CacheRoleDepartments"

		Dim allDepts
		allDepts = Application(cacheKey)

		if isarray(allDepts) then
			GetRoleDepartments = allDepts
			exit Function
		end if

		if isobject(DBConnection) = false then
			GetRoleDepartments = "Failed to connect database."
			exit Function
		end if

		strSQL = "SELECT UD.DepartmentID,UD.DepartmentName, UD.DepartmentCode, UD.ParentDepartmentID, ISNULL(R.Permission,0) AS Permission, UD.UserId"
		strSQL = strSQL & " FROM (SELECT D.DepartmentID,D.DepartmentName, D.DepartmentCode, D.ParentDepartmentID, U.UserId FROM Departments D, Users U) UD"
		strSQL = strSQL & " LEFT JOIN RoleDepartment R ON UD.DepartmentId = R.DepartmentId AND UD.UserId = R.UserId"
		strSQL = strSQL & " WHERE ISNUMERIC(UD.DepartmentCode) = 1 ORDER BY UD.UserId, UD.DepartmentCode;"

		On Error Resume Next		
		Dim rsDept		
		if dbType = 0 then  ''1为MSSQL 0为SQLCE 
			Set rsDept= CreateObject("ADOCE.Recordset.3.1")
		else 
			Set rsDept= Server.CreateObject("ADODB.Recordset")
		end if

		rsDept.Open strSQL, Conn, 1, 1

		allDepts = RecordSetToArray(rsDept)

		Application.Lock
		Application(cacheKey) = allDepts
		GetRoleDepartments = allDepts
		Application.UnLock

		if err.number <> 0 then
			Call fCloseADO()
			GetRoleDepartments = Err.Description
			On Error GoTo 0
			exit Function
		end if
	end Function

	Public Function RecordSetToArray(rs)
		if isobject(rs) = false then
			RecordSetToArray = null
			exit Function
		end if

		if rs.EOF and rs.BOF then
			RecordSetToArray = null
			exit Function
		end if

		dim arr()
		dim n 
		redim arr(rs.recordcount, rs.Fields.count)
		n = 0

		while NOT rs.EOF
			for i = 0 to rs.Fields.Count -1
				arr(n, i) = rs.Fields(i).value
			Next
			n = n + 1
			rs.MoveNext
		wend

		rs.close
		RecordSetToArray = arr
	end Function
End Class
%>

<%	
	fConnectADODB()

	Dim Cache
	set Cache = new CacheManager
	set Cache.DBConnection = Conn

	Dim CacheDepatments
	CacheDepatments = Cache.GetRoleDepartments

	'response.write isarray(depts)
	'response.write ubound(depts)

	fCloseADO()
%>