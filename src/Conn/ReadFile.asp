<%
	On Error Resume next
	Session.Timeout   =   1400
'读取INI文件信息_Start
	Dim objFS
	Dim objFile
	Dim intCnt
	Set objFS = server.createobject("Scripting.FileSystemObject")

	If Err.number<>0 Then
		Set objFS = Nothing
		response.write Err.description
		On Error GoTo 0
	End if

	If Not objFS.FileExists(Server.mapPath("Conn/dbconn.ini")) Then
		Set objFS = Nothing
		response.write Err.description
		On Error GoTo 0
	End If

	'///////////////////////
	Set objFile = objFS.OpenTextFile( Server.mapPath("Conn/dbconn.ini") )
	If Err.number <> 0 Then
		Set objFS = Nothing
		response.write Err.description
		On Error GoTo 0
	End if

	'///////////////////////
	While Not objFile.AtEndOfLine
		ReDim Preserve strFile(intCnt)
		strFile(intCnt) = objFile.ReadLine
		intCnt = intCnt + 1
	Wend
	Set objFile = Nothing
	Set objFS = Nothing

	p_szServer   = mid(strFile(1), instr(strFile(1), "=") + 1)
	p_szDatabase = mid(strFile(2), instr(strFile(2), "=") + 1)
	p_szUser	 = mid(strFile(3), instr(strFile(3), "=") + 1)
	p_szPwd      = mid(strFile(4), instr(strFile(4), "=") + 1)
	Application("p_language") = mid(strFile(5), instr(strFile(5), "=") + 1, 1)
	Application("p_SeverURLForMonitor") = mid(strFile(6), instr(strFile(6), "=") + 1)
	Response.Cookies("CerbLan") = Application("p_language")
	Response.Cookies("CerbLan").Expires=date()+1095
	Response.Cookies("CerbSeverURLForMonitor") = vbsEscape(Application("p_SeverURLForMonitor"))
	Response.Cookies("CerbSeverURLForMonitor").Expires=date()+1095
	Application("p_error") = ""
	
Application.Lock
	'If Application("p_szCon") = "" then
	Application("p_szCon") = "Driver={sql server}; SERVER="+CStr(p_szServer)+"; DATABASE="+CStr(p_szDatabase)+"; uid="+CStr(p_szUser)+"; pwd="+CStr(p_szPwd)+";"
	'End If 
Application.Unlock 

Function vbsEscape(str)
    dim i,s,c,a
    s=""
    For i=1 to Len(str)
        c=Mid(str,i,1)
        a=ASCW(c)
        If (a>=48 and a<=57) or (a>=65 and a<=90) or (a>=97 and a<=122) Then
            s = s & c
        ElseIf InStr("@*_+-./",c)>0 Then
            s = s & c
        ElseIf a>0 and a<16 Then
            s = s & "%0" & Hex(a)
        ElseIf a>=16 and a<256 Then
            s = s & "%" & Hex(a)
        Else
            s = s & "%u" & Hex(a)
        End If
    Next
    vbsEscape = s
End Function

%>