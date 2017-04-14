<%
response.Charset="utf-8"

dim ConnSys
dim RsSys

'Create ADOCE.Connection Object and ADOCE.Recordset Object
Function fConnectADODBSys()
	fConnectADODBSys = 0
	On Error Resume Next
	set ConnSys=CreateObject("ADOCE.Connection.3.1")
	set RsSys=CreateObject ("ADOCE.Recordset.3.1")
	
	if err.number <> 0 then
		response.write Err.Description
		On Error GoTo 0
		response.end
	end if
	
	ConnSys.ConnectionString = "Provider=Microsoft.SQLSERVER.CE.OLEDB.3.5; Data Source=\ResidentFlash\SystemDb.sdf;"
	ConnSys.open
	
	if err.number <> 0 then
		response.write Err.Description
		set ConnSys = nothing
		set RsSys   = nothing
		On Error GoTo 0
		response.end
	end if
	
	fConnectADODBSys=1
End Function



Function fCloseADOSys()
	if not RsSys is  nothing then
		if RsSys.state then
			RsSys.close
		end if
		set RsSys = nothing
	end if

	if not ConnSys is nothing then
		if ConnSys.state then
			ConnSys.close
		end if
		set ConnSys = nothing
	end if
End Function


%>