<%
'判断加载标签数据是否出错
If Application("p_error") <> "" Then
	aspPath = request.servervariables("path_info")
	If UBound(Split(aspPath, "/")) = 3 Then '根目录
	    response.write Application("p_error")
	Else '子目录
	    response.write Application("p_error")
	End If
	response.End()
End If

'入口参数
'strLblId(String)     : 页面名称_标签ID
'返回值：  标签值
Function GetCerbLbl(strLblId)  'Cerb 目录
    Dim Cerb
    Cerb = Application("Cerb")
    
    Dim i
	GetCerbLbl = "未找到标签"
	FOR i = 0 to UBOUND(Cerb,1)
		IF LCase(Cerb(i,0)) = LCase(strLblId) THEN
			GetCerbLbl = Cerb(i,1)		
			EXIT Function
		END IF
	NEXT
End Function

Function GetEmpLbl(strLblId)  'Employees 目录
    Dim Emp
    Emp = Application("Employees")
    
    Dim i
	GetEmpLbl = "未找到标签"
	FOR i = 0 to UBOUND(Emp,1)
		IF LCase(Emp(i,0)) = LCase(strLblId) THEN
			GetEmpLbl = Emp(i,1)		
			EXIT Function
		END IF
	NEXT
End Function

Function GetEquLbl(strLblId)  'Employees 目录
    Dim Equ
    Equ = Application("Equipment")
    
    Dim i
	GetEquLbl = "未找到标签"
	FOR i = 0 to UBOUND(Equ,1)
		IF LCase(Equ(i,0)) = LCase(strLblId) THEN
			GetEquLbl = Equ(i,1)		
			EXIT Function
		END IF
	NEXT
End Function

Function GetReportLbl(strLblId)  'Report 目录
    Dim Report
    Report = Application("Report")
    
    Dim i
	GetReportLbl = "未找到标签"
	FOR i = 0 to UBOUND(Report,1)
		IF LCase(Report(i,0)) = LCase(strLblId) THEN
			GetReportLbl = Report(i,1)		
			EXIT Function
		END IF
	NEXT
End Function


Function GetToolLbl(strLblId)  'Tool 目录
    Dim Tool
    Tool = Application("Tool")
    
    Dim i
	GetToolLbl = "未找到标签"
	FOR i = 0 to UBOUND(Tool,1)
		IF LCase(Tool(i,0)) = LCase(strLblId) THEN
			GetToolLbl = Tool(i,1)		
			EXIT Function
		END IF
	NEXT
End Function

Function GetMonitorLbl(strLblId)  'Monitor 目录
    Dim Monitor
    Monitor = Application("Monitor")
    
    Dim i
	GetMonitorLbl = "未找到标签"
	FOR i = 0 to UBOUND(Monitor,1)
		IF LCase(Monitor(i,0)) = LCase(strLblId) THEN
			GetMonitorLbl = Monitor(i,1)		
			EXIT Function
		END IF
	NEXT
End Function

Function GetControllerLbl(strLblId)  'Controller 目录
    Dim Controller
    Controller = Application("Controller")
    
    Dim i
	GetControllerLbl = "未找到标签"
	FOR i = 0 to UBOUND(Controller,1)
		IF LCase(Controller(i,0)) = LCase(strLblId) THEN
			GetControllerLbl = Controller(i,1)		
			EXIT Function
		END IF
	NEXT
End Function

Function GetPrintLbl(strLblId)  'Print 目录
    Dim Print
    Print = Application("Print")
    
    Dim i
	GetPrintLbl = "未找到标签"
	FOR i = 0 to UBOUND(Print,1)
		IF LCase(Print(i,0)) = LCase(strLblId) THEN
			GetPrintLbl = Print(i,1)		
			EXIT Function
		END IF
	NEXT
End Function

Function GetPDALbl(strLblId)  'PDA 目录
    Dim PDA
    PDA = Application("PDA")
    
    Dim i
	GetPDALbl = "未找到标签"
	FOR i = 0 to UBOUND(PDA,1)
		IF LCase(PDA(i,0)) = LCase(strLblId) THEN
			GetPDALbl = PDA(i,1)		
			EXIT Function
		END IF
	NEXT
End Function

Function GetBasicDataLbl(strLblId)  'BasicData 目录
    Dim BasicData
    BasicData = Application("BasicData")
    
    Dim i
	GetBasicDataLbl = "未找到标签"
	FOR i = 0 to UBOUND(BasicData,1)
		IF LCase(BasicData(i,0)) = LCase(strLblId) THEN
			GetBasicDataLbl = BasicData(i,1)		
			EXIT Function
		END IF
	NEXT
End Function

Function GetHelpLbl(strLblId)  'Help 目录
    Dim Help
    Help = Application("Help")
    
    Dim i
	GetHelpLbl = "未找到标签"
	FOR i = 0 to UBOUND(Help,1)
		IF LCase(Help(i,0)) = LCase(strLblId) THEN
			GetHelpLbl = Help(i,1)		
			EXIT Function
		END IF
	NEXT
End Function

Function GetVbsLbl(strLblId)  'Vbs 目录
    Dim Vbs
    Vbs = Application("Vbs")
    
    Dim i
	GetVbsLbl = "未找到标签"
	FOR i = 0 to UBOUND(Vbs,1)
		IF LCase(Vbs(i,0)) = LCase(strLblId) THEN
			GetVbsLbl = Vbs(i,1)		
			EXIT Function
		END IF
	NEXT
End Function

%>

<%

'格式化Label
Function FormatLbl(str)
    FormatLbl = str
    If Application("p_language") <> 3 Then
        FormatLbl = Replace(str," ", "&nbsp;")
    End if
End Function

%>