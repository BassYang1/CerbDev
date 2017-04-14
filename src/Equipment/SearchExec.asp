<%



'返回SQL where 语句 （不包括 'where' ）
Function GetSearchSQLWhere(strField,strSearchOper,strFieldData)
	Dim strWhere,isMultiFieldData
	isMultiFieldData = 0
	GetSearchSQLWhere = ""
	strWhere = "  Left(IncumbencyStatus,1)<>'1' and E.Card>0  "
	'construct where
	IF strField = "DepartmentID" then 
		Select Case strSearchOper
		Case "eq" : 'Equal
			'strWhere = strWhere & " and D.DepartmentCode like (select DepartmentCode+'%' from Departments where DepartmentID='"&strFieldData&"') "
			'20140512 前台选择某个部门时，将子部门的ID一起返回
			strWhere = strWhere & " and E.DepartmentID in ("&strFieldData&")  "
		Case "ne": 'Not Equal
			'strWhere = strWhere & " and D.DepartmentCode NOT like (select DepartmentCode+'%' from Departments where DepartmentID='"&strFieldData&"') "
			'20140512 前台选择某个部门时，将子部门的ID一起返回
			strWhere = strWhere & " and E.DepartmentID not in ("&strFieldData&")  "
		End Select
		'后面条件判断不再使用
		strSearchOper=""
		strFieldData=""
	ELSEIF strField = "IncumbencyStatus" then 
		strWhere="  E.Card>0 and Left(IncumbencyStatus,1) "
		if Len(strFieldData) >=1 then 
			strFieldData = Left(strFieldData,1)
		end if
	ELSEIF strField = "Card" then 
		strWhere="  Left(IncumbencyStatus,1)<>'1' and E." & strField
	ELSE
		strWhere = strWhere&" and E." & strField
	End if
	
	if strField = "Card" or strField = "Number" or strField = "Name" then
		if InStr(strFieldData,",") > 0 or InStr(strFieldData,"，") > 0 then 
			strFieldData = Replace(strFieldData,"，",",")
			strFieldData = Replace(strFieldData,",","','")
			strFieldData = "'"&strFieldData&"'"
			isMultiFieldData = 1
		end if
	end if
	
	Select Case strSearchOper
		Case "bw" : 'Begin With
			strFieldData = strFieldData & "%"
			strWhere = strWhere & " LIKE '" & strFieldData & "'"
		Case "eq" : 'Equal
			If isMultiFieldData = 1 then 
				strWhere = strWhere & " IN (" & strFieldData & ")"
			Else
				strWhere = strWhere & " = '" & strFieldData & "'"
			End If
		Case "ne": 'Not Equal
			If isMultiFieldData = 1 then 
				strWhere = strWhere & " NOT IN (" & strFieldData & ")"
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
	
	GetSearchSQLWhere = strWhere				
End Function


'返回SQL where 语句 （不包括 'where' ）  '不前前缀（E. / D.）
Function GetSearchSQLWhereForReport(strField,strSearchOper,strFieldData)
	Dim strWhere,isMultiFieldData
	isMultiFieldData = 0
	GetSearchSQLWhereForReport = ""
	strWhere = "  "
	'construct where
	IF strField = "DepartmentID" then 
		Select Case strSearchOper
		Case "eq" : 'Equal
			'strWhere = strWhere & " DepartmentId in (select DepartmentID from departments where DepartmentCode like (select DepartmentCode+'%' from Departments where DepartmentID='"&strFieldData&"')) "
			'20140512 前台选择某个部门时，将子部门的ID一起返回
			strWhere = strWhere & " DepartmentID in ("&strFieldData&")  "
		Case "ne": 'Not Equal
			'strWhere = strWhere & " DepartmentId in (select DepartmentID from departments where DepartmentCode NOT like (select DepartmentCode+'%' from Departments where DepartmentID='"&strFieldData&"')) "
			'20140512 前台选择某个部门时，将子部门的ID一起返回
			strWhere = strWhere & " DepartmentID not in ("&strFieldData&")  "
		End Select
		'后面条件判断不再使用
		strSearchOper=""
		strFieldData=""
	ELSEIF strField = "IncumbencyStatus" then 
		strWhere="  "
		if Len(strFieldData) >=1 then 
			strFieldData = Left(strFieldData,1)
		end if
	ELSE
		strWhere = strWhere&" " & strField
	End if
	
	if strField = "Card" or strField = "Number" or strField = "Name" then
		if InStr(strFieldData,",") > 0 or InStr(strFieldData,"，") > 0 then 
			strFieldData = Replace(strFieldData,"，",",")
			strFieldData = Replace(strFieldData,",","','")
			strFieldData = "'"&strFieldData&"'"
			isMultiFieldData = 1
		end if
	end if
		
	Select Case strSearchOper
		Case "bw" : 'Begin With
			strFieldData = strFieldData & "%"
			strWhere = strWhere & " LIKE '" & strFieldData & "'"
		Case "eq" : 'Equal
			If isMultiFieldData = 1 then 
				strWhere = strWhere & " IN (" & strFieldData & ")"
			Else
				strWhere = strWhere & " = '" & strFieldData & "'"
			End If
		Case "ne": 'Not Equal
			If isMultiFieldData = 1 then 
				strWhere = strWhere & " NOT IN (" & strFieldData & ")"
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
	
	GetSearchSQLWhereForReport = strWhere				
End Function

%>