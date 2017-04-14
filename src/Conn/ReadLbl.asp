<%

	Dim Cerb(), Employees(), Equipment(), Report(), Tool(),Help(),Monitor()
	Dim strSQL,strSQL1,nIndex

	If Application("p_szCon") <> "" and Application("isRead") <> "1" Then	
		
		Dim ConnLan,rsLan
		Set ConnLan = Server.CreateObject("ADODB.Connection")
		Set rsLan = Server.CreateObject("ADODB.RecordSet")
		'On Error Resume Next				
		ConnLan.open Application("p_szCon")
		
		Application("p_error") = ""
		If Err.number <> 0 Then '判断连接数据库是否出错
			Application("p_error") = Err.description
			set rsLan = nothing
			set ConnLan = nothing
			On Error GoTo 0
		Else
			'On Error Resume Next
			
			'strSQL = "SELECT 1 FROM sysobjects WHERE Name='LabelText' AND  type='U'"
			'rsLan.open strSQL, ConnLan, 1, 1
			'On Error Resume Next	
			'rsLan.close()
			
			If Application("p_language") = "1" Then
				strSQL = "SELECT DISTINCT LabelId, LabelZhcnText as Label FROM LabelText "
				Application("p_file") = "_f"	
			ELSEIf Application("p_language") = "2" Then
				strSQL = "SELECT DISTINCT LabelId, LabelZhtwText as Label FROM LabelText "
				Application("p_file") = "_f"
			ElseIf Application("p_language") = "3" Then
				strSQL = "SELECT DISTINCT LabelId, LabelEnText as Label FROM LabelText "
				Application("p_file") = "_e"
			ElseIf Application("p_language") = "4" Then
				strSQL = "SELECT DISTINCT LabelId, LabelCustomText as Label FROM LabelText "
				Application("p_file") = "_e"
			Else 
				strSQL = "SELECT DISTINCT LabelId, LabelEnText as Label FROM LabelText "
				Application("p_file") = "_j"
			End If
			
			'Cerb
			nIndex = 0
			strSQL1 = strSQL + "WHERE PageFolder = 'Cerb'" 
			rsLan.open strSQL1, ConnLan, 1, 1	
			REDIM Cerb(rsLan.recordcount, 2)    
			While Not rsLan.EOF
				Cerb(nIndex, 0) = trim(rsLan(0))
				Cerb(nIndex, 1) = rsLan(1)
				nIndex = nIndex + 1
				rsLan.MoveNext
			Wend
			rsLan.close 
			
			'Employees
			nIndex = 0
			strSQL1 = strSQL + "WHERE PageFolder = 'Employees'" 
			rsLan.open strSQL1, ConnLan, 1, 1	 
			REDIM Employees(rsLan.recordcount, 2)
			While Not rsLan.EOF
				Employees(nIndex, 0) = trim(rsLan(0))
				Employees(nIndex, 1) = rsLan(1)
				nIndex = nIndex + 1
				rsLan.MoveNext
			Wend
			rsLan.close
			
			'Equipment
			nIndex = 0
			strSQL1 = strSQL + "WHERE PageFolder = 'Equipment'" 		
			rsLan.open strSQL1, ConnLan, 1, 1	  
			REDIM Equipment(rsLan.recordcount, 2)     
			While Not rsLan.EOF
				Equipment(nIndex, 0) = trim(rsLan(0))
				Equipment(nIndex, 1) = rsLan(1)
				nIndex = nIndex + 1
				rsLan.MoveNext
			Wend
			rsLan.close
	
			'Report
			nIndex = 0
			strSQL1 = strSQL + "WHERE PageFolder = 'Report'" 		
			rsLan.open strSQL1, ConnLan, 1, 1	  
			REDIM Report(rsLan.recordcount, 2)     
			While Not rsLan.EOF
				Report(nIndex, 0) = trim(rsLan(0))
				Report(nIndex, 1) = rsLan(1)
				nIndex = nIndex + 1
				rsLan.MoveNext
			Wend
			rsLan.close
	
			'Tool
			nIndex = 0
			strSQL1 = strSQL + "WHERE PageFolder = 'Tool'" 		
			rsLan.open strSQL1, ConnLan, 1, 1	  
			REDIM Tool(rsLan.recordcount, 2)     
			While Not rsLan.EOF
				Tool(nIndex, 0) = trim(rsLan(0))
				Tool(nIndex, 1) = rsLan(1)
				nIndex = nIndex + 1
				rsLan.MoveNext
			Wend
			rsLan.close
			
			'Monitor
			nIndex = 0
			strSQL1 = strSQL + "WHERE PageFolder = 'Monitor'" 		
			rsLan.open strSQL1, ConnLan, 1, 1	  
			REDIM Monitor(rsLan.recordcount, 2)     
			While Not rsLan.EOF
				Monitor(nIndex, 0) = trim(rsLan(0))
				Monitor(nIndex, 1) = rsLan(1)
				nIndex = nIndex + 1
				rsLan.MoveNext
			Wend
			rsLan.close
			
			set rsLan = nothing
			set ConnLan = nothing
			
			Application.Lock	    
			Application("Cerb") = Cerb
			Application("Employees") = Employees
			Application("Equipment") = Equipment
			Application("Report") = Report
			Application("Tool") = Tool
			Application("Monitor") = Monitor
			Application("isRead") = "1"
			Application.UnLock 
			
			Application("p_error") = ""
			if err.number <> 0 Then '判断读取数据表是否出错
				Application("p_error") = Err.description
				On Error GoTo 0
			End if
			
		End if				
	End if	

%>