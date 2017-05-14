<%
response.Charset="utf-8"

dim Conn
dim Rs
Dim EmId, UserId
Dim strLongError, strChError, strNULLError
Dim dbType	'1为MSSQL 0为SQLCE 

dbType = 1
Function fConnectADODB()
	if dbType = 0 then 
		Call fConnectADODB_CE()
	else
		Call fConnectADODB_MSSQL()
	end if
End Function
'Create ADOCE.Connection Object and ADOCE.Recordset Object
Function fConnectADODB_CE()
	fConnectADODB_CE = 0
	On Error Resume Next
	set Conn=CreateObject("ADOCE.Connection.3.1")
	set Rs=CreateObject ("ADOCE.Recordset.3.1")
	
	if err.number <> 0 then
		response.write Err.Description
		On Error GoTo 0
		response.end
	end if
	
	Conn.ConnectionString = "Provider=Microsoft.SQLSERVER.CE.OLEDB.3.5; Data Source=\ResidentFlash\Cerb\CerbDb.sdf;SSCE:Database Password='TEST'"
	Conn.open
	
	if err.number <> 0 then
		response.write Err.Description
		set Conn = nothing
		set Rs   = nothing
		On Error GoTo 0
		response.end
	end if
	
	fConnectADODB_CE=1
End Function

'PC机
Function fConnectADODB_MSSQL()
	fConnectADODB_MSSQL = 0
	On Error Resume Next

	Dim strConnetionString
	set Conn = Server.CreateObject("ADODB.Connection")
	set Rs = Server.CreateObject("ADODB.RecordSet")
	
	if err.number <> 0 Then
		response.write Err.description
		On Error GoTo 0
		exit function
	end If

	'strConnetionString = "Driver={sql server}; SERVER=.; DATABASE=TEST; uid=sa; pwd=mike;"
	strConnetionString = Application("p_szCon")
	Conn.open strConnetionString
	'Conn.CursorLocation = 1
	
	if err.number <> 0 Then
		response.write Err.description
		set Rs   = nothing
		set Conn = nothing
		On Error GoTo 0
		exit function
	end if

	fConnectADODB_MSSQL = 1
End Function




Function fCloseADO()
	if not Rs is  nothing then
		if Rs.state then
			Rs.close
		end if
		set Rs = nothing
	end if

	if not Conn is nothing then
		if Conn.state then
			Conn.close
		end if
		set Conn = nothing
	end if
End Function

'
Function SetStringSafe( strValue )
	if strValue <> "" and instr(strValue, "'")>0 then
		strValue = replace(strValue, "'", "''")
	end if
	SetStringSafe = strValue
End Function

Function FormatStringSafe( strValue )
	if strValue <> "" and instr(strValue, "'")>0 then
		strValue = replace(strValue, "'", "''")
	end if
	FormatStringSafe = trim(strValue)
End Function

'iType:类型标识:  0:字符,时间类型;  1:整型.BOOL型;
Function GetDBValues( strTemp, iType)
	If Not IsNull(strTemp) Then
		If iType = 0 then
			GetDBValues = Trim(strTemp)
		Else
			GetDBValues = strTemp
		End If
	Else
		If iType = 0 Then
			GetDBValues = ""
		Else
			GetDBValues = 0
		End if
	End if
End Function
%>