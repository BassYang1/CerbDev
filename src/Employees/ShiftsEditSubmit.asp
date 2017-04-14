<%Session.CodePage=65001%>
<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%


'//*********************  Declare Values  **********************//
	dim strFields, strValues, strFieldsTemp, strValuesTemp
	dim strSQL
	dim strShiftName, strStretchShift, strDegree, strNight, strFirstOnDuty, strShiftTime, strAonDuty
	dim strAonDutyStart, strAonDutyEnd, strAoffDuty, strAoffDutyStart, strAoffDutyEnd, strArestTime, strBonDuty, strBonDutyStart
	dim strBonDutyEnd, strBoffDuty, strBoffDutyStart, strBoffDutyEnd, strBrestTime, strConDuty, strConDutyStart, strConDutyEnd
	dim strCoffDuty, strCoffDutyStart, strCoffDutyEnd, strCrestTime
	dim strAdjustcheck, strAdjustDate
	dim TempTime
	dim strId


	dim iChangeNameORNot
	Dim iHaveNight, iIsAdd '覆盖标识
'//************************************************************//'"EmployeeWork"


	iflag = trim(Request.QueryString("iflag"))
	if iflag = "" then iflag = 0

'//************************************判断权限*******************************************
	
	lpage = Trim(Request.QueryString("lpage"))
'//***************************接收提交的数据************************************************
	strShiftName = trim(Request.form("ShiftName"))
	if strShiftName = "" Then  ReturnErrMsg GetEmpLbl("ShiftNameNull") '"[班次名称]不能为空"
	strShiftName = SetStringSafe( strShiftName ) 

	strFirstOnDuty       = trim(Request.form("FirstOnDuty"))
	If strFirstOnDuty = "" Then strFirstOnDuty = 0

	'时间类型判断
	strShiftTime = trim(Request.form("ShiftTime"))
	if strShiftTime = "" Then ReturnErrMsg GetEmpLbl("ShiftTimeNull") '"标准工时不能为空"
	if not isnumeric(strShiftTime) then
		ReturnErrMsg GetEmpLbl("ShiftTimeDigital")	'"标准工时只能用数字"
	end If

	strStretchShift = trim(Request.form("StretchShift"))
	if strStretchShift = "" then strStretchShift = "0"
	strDegree = trim(Request.form("Degree"))
	If strDegree = "" Then strDegree = 0           '弹性班次用
	strNight = trim(Request.form("Night"))
	if strNight = "" then strNight = 0

	If strOverTime = "" Then strOverTime = 0

	strAonDuty = trim(Request.form("AonDuty"))
	strAonDutyStart = trim(Request.form("AonDutyStart"))
	strAoffDuty = trim(Request.form("AoffDuty"))
	strAoffDutyEnd = trim(Request.form("AoffDutyEnd"))
	strAcalculateLate = trim(Request.form("AcalculateLate")) 
	strAcalculateEarly = trim(Request.form("AcalculateEarly"))                     
	strArestTime = trim(Request.form("ArestTime"))           '休息时间
	TempTime = "1900-01-01"
	PTempTime = "1899-12-31"
	NTempTime = "1900-01-02"
	iHaveNight = 0
	iflagA = "0"
	iflagB = "0"
	
	On Error Resume Next
	'判断是否为弹性班次
	if cint(strStretchShift) = 0 then   '固定班次
		
		if strDegree = "" Then ReturnErrMsg GetEmpLbl("DegreeNull")		'"[时段数]不能为空"
		If CInt(strFirstOnDuty) = 1 Then TempTime = PTempTime                 '上日(过夜才有的)
	
		if cint(strDegree) >= 1 then     '时间段1
			strAonDutyEnd = trim(Request.form("AonDutyEnd"))
			strAoffDutyStart = trim(Request.form("AoffDutyStart"))

			strAonDutyStart = CStr(TempTime) + " " + CStr(strAonDutyStart)
			strAonDutyEnd   = CStr(TempTime) + " " + CStr(strAonDutyEnd)
			strAonDuty      = CStr(TempTime) + " " + CStr(strAonDuty)
			strAoffDutyStart = CStr(TempTime) + " " + CStr(strAoffDutyStart)
			strAoffDuty     = CStr(TempTime) + " " + CStr(strAoffDuty)
			strAoffDutyEnd  = CStr(TempTime) + " " + CStr(strAoffDutyEnd)

			If CInt(strNight) = 0 Then   '非过夜
				If CDate(strAonDuty) < CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AOnDutyLtStartN") '"第一次上班开始时间必须早于上班标准时间或您没选择［过夜］！"
				If CDate(strAonDutyEnd) < CDate(strAonDuty)       Then ReturnErrMsg GetEmpLbl("AOnDutyLtEndN") '"第一次上班标准时间必须早于上班截止时间或您没选择［过夜］！"
				If CDate(strAoffDutyStart) < CDate(strAonDutyEnd) Then ReturnErrMsg GetEmpLbl("AOnDutyEndLtAoffDutyStartN") '"第一次上班截止时间必须早于下班开始时间或您没选择［过夜］！"
				If CDate(strAoffDuty)   < CDate(strAoffDutyStart) Then ReturnErrMsg GetEmpLbl("AoffDutyLtStartN") '"第一次下班开始时间必须早于下班标准时间或您没选择［过夜］！"
				If CDate(strAoffDutyEnd)< CDate(strAoffDuty)      Then ReturnErrMsg GetEmpLbl("AoffDutyEndLtoffDutyN") '"第一次下班标准时间必须早于下班截止时间或您没选择［过夜］！"
			Else
				'If CDate(strAonDuty)    = CDate(strAonDutyStart)  Then ReturnErrMsg "第一次上班开始时间不能等于上班标准时间！"
				'If CDate(strAonDutyEnd) = CDate(strAonDuty)       Then ReturnErrMsg "第一次上班标准时间不能等于上班截止时间！"
				'If CDate(strAoffDutyStart) = CDate(strAonDutyEnd) Then ReturnErrMsg "第一次上班截止时间不能等于下班开始时间！"
				'If CDate(strAoffDuty)   = CDate(strAoffDutyStart) Then ReturnErrMsg "第一次下班开始时间不能等于下班标准时间！"
				'If CDate(strAoffDutyEnd)= CDate(strAoffDuty)      Then ReturnErrMsg "第一次下班标准时间不能等于下班截止时间！"

				If CDate(strAonDuty)    < CDate(strAonDutyStart)  Then
					iHaveNight = 1
					If CDate(strAonDutyEnd) < CDate(strAonDuty)       Then ReturnErrMsg GetEmpLbl("AonDutyEndLtAonDuty") '"第一次上班标准时间必须早于上班截止时间！"
					If CDate(strAonDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
					If CDate(strAoffDutyStart) < CDate(strAonDutyEnd) Then ReturnErrMsg GetEmpLbl("AoffDutyStartLtAonDutyEnd") '"第一次上班截止时间必须早于下班开始时间！"
					If CDate(strAoffDutyStart) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
					If CDate(strAoffDuty)   < CDate(strAoffDutyStart) Then ReturnErrMsg GetEmpLbl("AoffDutyLtAoffDutyStart") '"第一次下班开始时间必须早于下班标准时间！"
					If CDate(strAoffDuty) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
					If CDate(strAoffDutyEnd)< CDate(strAoffDuty)      Then ReturnErrMsg GetEmpLbl("AoffDutyEndLtAoffDuty") '"第一次下班标准时间必须早于下班截止时间！"
					If CDate(strAoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
					
					'时间段是否加1,iflagA = 5 ,表示有5个时间段要加1 
					iflagA = "5"

				ElseIf CDate(strAonDutyEnd) < CDate(strAonDuty)   Then
					iHaveNight = 1
					If CDate(strAonDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
					If CDate(strAoffDutyStart) < CDate(strAonDutyEnd) Then ReturnErrMsg GetEmpLbl("AoffDutyStartLtAonDutyEnd") '"第一次上班截止时间必须早于下班开始时间！"
					If CDate(strAoffDutyStart) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
					If CDate(strAoffDuty)   < CDate(strAoffDutyStart) Then ReturnErrMsg GetEmpLbl("AoffDutyLtAoffDutyStart") '"第一次下班开始时间必须早于下班标准时间！"
					If CDate(strAoffDuty) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
					If CDate(strAoffDutyEnd)< CDate(strAoffDuty)      Then ReturnErrMsg GetEmpLbl("AoffDutyEndLtAoffDuty") '"第一次下班标准时间必须早于下班截止时间！"
					If CDate(strAoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
					
					'
					iflagA = "4"
				ElseIf CDate(strAoffDutyStart) < CDate(strAonDutyEnd)   Then
					iHaveNight = 1
					If CDate(strAoffDutyStart) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"

					If CDate(strAoffDuty)   < CDate(strAoffDutyStart) Then ReturnErrMsg GetEmpLbl("AoffDutyLtAoffDutyStart") '"第一次下班开始时间必须早于下班标准时间！"
					If CDate(strAoffDuty) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
					If CDate(strAoffDutyEnd)< CDate(strAoffDuty)      Then ReturnErrMsg GetEmpLbl("AoffDutyEndLtAoffDuty") '"第一次下班标准时间必须早于下班截止时间！"
					If CDate(strAoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"

					iflagA = "3"
				ElseIf CDate(strAoffDuty)   < CDate(strAoffDutyStart)   Then
					iHaveNight = 1
					If CDate(strAoffDuty) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
					If CDate(strAoffDutyEnd)< CDate(strAoffDuty)      Then ReturnErrMsg GetEmpLbl("AoffDutyEndLtAoffDuty") '"第一次下班标准时间必须早于下班截止时间！"
					If CDate(strAoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"

					iflagA = "2"
				ElseIf CDate(strAoffDutyEnd)< CDate(strAoffDuty)   Then
					iHaveNight = 1
					If CDate(strAoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"

					iflagA = "1"
				End If
				
				'判断第一次开始时间到最后截止时间是否大于２４
				strSumTotal = Datediff("n", CDate(strAoffDutyEnd), CDate(strAonDutyStart))

				If abs(strSumTotal) > 1440 Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
		
			End If
		end If
		

		if cint(strDegree) >= 2 then
			strBonDuty = trim(Request.form("BonDuty"))
			strBonDutyStart = trim(Request.form("BonDutyStart"))
			strBonDutyEnd = trim(Request.form("BonDutyEnd"))
			strBoffDuty = trim(Request.form("BoffDuty"))
			strBoffDutyStart = trim(Request.form("BoffDutyStart"))
			strBoffDutyEnd = trim(Request.form("BoffDutyEnd"))
			strBcalculateLate = trim(Request.form("BcalculateLate")) 
			strBcalculateEarly = trim(Request.form("BcalculateEarly"))                     
			strBrestTime = trim(Request.form("BrestTime"))           '休息时间
			If iHaveNight = 1 Then
				strBonDutyStart = CStr(NTempTime) + " " + CStr(strBonDutyStart)
				strBonDutyEnd   = CStr(NTempTime) + " " + CStr(strBonDutyEnd)
				strBonDuty      = CStr(NTempTime) + " " + CStr(strBonDuty)
				strBoffDutyStart = CStr(NTempTime) + " " + CStr(strBoffDutyStart)
				strBoffDuty     = CStr(NTempTime) + " " + CStr(strBoffDuty)
				strBoffDutyEnd  = CStr(NTempTime) + " " + CStr(strBoffDutyEnd)
			Else
				strBonDutyStart = CStr(TempTime) + " " + CStr(strBonDutyStart)
				strBonDutyEnd   = CStr(TempTime) + " " + CStr(strBonDutyEnd)
				strBonDuty      = CStr(TempTime) + " " + CStr(strBonDuty)
				strBoffDutyStart = CStr(TempTime) + " " + CStr(strBoffDutyStart)
				strBoffDuty     = CStr(TempTime) + " " + CStr(strBoffDuty)
				strBoffDutyEnd  = CStr(TempTime) + " " + CStr(strBoffDutyEnd)
			End if
			If CInt(strNight) = 0 Then   '非过夜
				If CDate(strBonDutyStart) < CDate(strAoffDutyEnd)  Then ReturnErrMsg GetEmpLbl("BonDutyStartLtAoffDutyEndN") '"第一次下班截止时间必须早于第二次上班开始时间或您没选择［过夜］！"
				If CDate(strBonDuty) < CDate(strBonDutyStart)  Then ReturnErrMsg GetEmpLbl("BOnDutyLtStartN") '"第二次上班开始时间必须早于上班标准时间或您没选择［过夜］！"
				If CDate(strBonDutyEnd) < CDate(strBonDuty)       Then ReturnErrMsg GetEmpLbl("BOnDutyLtEndN") '"第二次上班标准时间必须早于上班截止时间或您没选择［过夜］！"
				If CDate(strBoffDutyStart) < CDate(strBonDutyEnd) Then ReturnErrMsg GetEmpLbl("BOnDutyEndLtBoffDutyStartN") '"第二次上班截止时间必须早于下班开始时间或您没选择［过夜］！"
				If CDate(strBoffDuty)   < CDate(strBoffDutyStart) Then ReturnErrMsg GetEmpLbl("BoffDutyLtStartN") '"第二次下班开始时间必须早于下班标准时间或您没选择［过夜］！"
				If CDate(strBoffDutyEnd)< CDate(strBoffDuty)      Then ReturnErrMsg GetEmpLbl("BoffDutyEndLtoffDutyN") '"第二次下班标准时间必须早于下班截止时间或您没选择［过夜］！"
			Else
				'If CDate(strBonDutyStart)    = CDate(strAoffDutyEnd)  Then ReturnErrMsg "第一次下班截止时间不能等于第二次上班开始时间！"
				'If CDate(strBonDuty)    = CDate(strBonDutyStart)  Then ReturnErrMsg "第二次上班开始时间不能等于上班标准时间！"
				'If CDate(strBonDutyEnd) = CDate(strBonDuty)       Then ReturnErrMsg "第二次上班标准时间不能等于上班截止时间！"
				''If CDate(strBoffDutyStart) = CDate(strBonDutyEnd) Then ReturnErrMsg "第二次上班截止时间不能等于下班开始时间！"
				'If CDate(strBoffDuty)   = CDate(strBoffDutyStart) Then ReturnErrMsg "第二次下班开始时间不能等于下班标准时间！"
				'If CDate(strBoffDutyEnd)= CDate(strBoffDuty)      Then ReturnErrMsg "第二次下班标准时间不能等于下班截止时间！"

				If iHaveNight = 0 Then
					If CDate(strBonDutyStart) < CDate(strAoffDutyEnd) Then
						iHaveNight = 1
						If CDate(strBonDuty)    < CDate(strBonDutyStart) Then ReturnErrMsg GetEmpLbl("BonDutyLtBonDutyStart") '"第二次上班开始时间必须早于上班标准时间！"
						If CDate(strBonDuty) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBonDutyEnd) < CDate(strBonDuty)       Then ReturnErrMsg GetEmpLbl("BonDutyEndLtBonDuty") '"第二次上班标准时间必须早于上班截止时间！"
						If CDate(strBonDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDutyStart) < CDate(strBonDutyEnd) Then ReturnErrMsg GetEmpLbl("BoffDutyStartLtBonDutyEnd") '"第二次上班截止时间必须早于下班开始时间！"
						If CDate(strBoffDutyStart) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDuty)   < CDate(strBoffDutyStart) Then ReturnErrMsg GetEmpLbl("BoffDutyLtBoffDutyStart") '"第二次下班开始时间必须早于下班标准时间！"
						If CDate(strBoffDuty) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDutyEnd)< CDate(strBoffDuty)      Then ReturnErrMsg GetEmpLbl("BoffDutyEndLtBoffDuty") '"第二次下班标准时间必须早于下班截止时间！"
						If CDate(strBoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
	
						iflagB = "6"
					ElseIf CDate(strBonDuty)    < CDate(strBonDutyStart)  Then
						iHaveNight = 1
						If CDate(strBonDutyEnd) < CDate(strBonDuty)       Then ReturnErrMsg GetEmpLbl("BonDutyEndLtBonDuty") '"第二次上班标准时间必须早于上班截止时间！"
						If CDate(strBonDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDutyStart) < CDate(strBonDutyEnd) Then ReturnErrMsg GetEmpLbl("BoffDutyStartLtBonDutyEnd") '"第二次上班截止时间必须早于下班开始时间！"
						If CDate(strBoffDutyStart) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDuty)   < CDate(strBoffDutyStart) Then ReturnErrMsg GetEmpLbl("BoffDutyLtBoffDutyStart") '"第二次下班开始时间必须早于下班标准时间！"
						If CDate(strBoffDuty) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDutyEnd)< CDate(strBoffDuty)      Then ReturnErrMsg GetEmpLbl("BoffDutyEndLtBoffDuty") '"第二次下班标准时间必须早于下班截止时间！"
						If CDate(strBoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"

						iflagB = "5"
					ElseIf CDate(strBonDutyEnd) < CDate(strBonDuty)   Then
						iHaveNight = 1
						If CDate(strBonDutyEnd) > CDate(strBonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDutyStart) < CDate(strBonDutyEnd) Then ReturnErrMsg GetEmpLbl("BoffDutyStartLtBonDutyEnd") '"第二次上班截止时间必须早于下班开始时间！"
						If CDate(strBoffDutyStart) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDuty)   < CDate(strBoffDutyStart) Then ReturnErrMsg GetEmpLbl("BoffDutyLtBoffDutyStart") '"第二次下班开始时间必须早于下班标准时间！"
						If CDate(strBoffDuty) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDutyEnd)< CDate(strBoffDuty)      Then ReturnErrMsg GetEmpLbl("BoffDutyEndLtBoffDuty") '"第二次下班标准时间必须早于下班截止时间！"
						If CDate(strBoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
	
						iflagB = "4"
					ElseIf CDate(strBoffDutyStart) < CDate(strBonDutyEnd)   Then
						iHaveNight = 1
						If CDate(strBoffDutyStart) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDuty)   < CDate(strBoffDutyStart) Then ReturnErrMsg GetEmpLbl("BoffDutyLtBoffDutyStart") '"第二次下班开始时间必须早于下班标准时间！"
						If CDate(strBoffDuty) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDutyEnd)< CDate(strBoffDuty)      Then ReturnErrMsg GetEmpLbl("BoffDutyEndLtBoffDuty") '"第二次下班标准时间必须早于下班截止时间！"
						If CDate(strBoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
		
						iflagB = "3"
					ElseIf CDate(strBoffDuty)   < CDate(strBoffDutyStart)   Then
						iHaveNight = 1
						If CDate(strBoffDuty) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDutyEnd)< CDate(strBoffDuty)      Then ReturnErrMsg GetEmpLbl("BoffDutyEndLtBoffDuty") '"第二次下班标准时间必须早于下班截止时间！"
						If CDate(strBoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
				
						iflagB = "2"
					ElseIf CDate(strBoffDutyEnd)< CDate(strBoffDuty)   Then
						iHaveNight = 1
						If CDate(strBoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						
						iflagB = "1"
					End If
				Else
					If CDate(strBonDutyStart) < CDate(strAoffDutyEnd)  Then ReturnErrMsg GetEmpLbl("BonDutyStartLtAoffDutyEnd") '"第一次下班截止时间必须早于第二次上班开始时间！"
					If CDate(strBonDuty)    < CDate(strBonDutyStart)  Then ReturnErrMsg GetEmpLbl("BonDutyLtBonDutyStart") '"第二次上班开始时间必须早于上班标准时间！""
					If CDate(strBonDutyEnd) < CDate(strBonDuty)       Then ReturnErrMsg GetEmpLbl("BonDutyEndLtBonDuty") '"第二次上班标准时间必须早于上班截止时间！"
					If CDate(strBoffDutyStart) < CDate(strBonDutyEnd) Then ReturnErrMsg GetEmpLbl("BoffDutyStartLtBonDutyEnd") '"第二次上班截止时间必须早于下班开始时间！"
					If CDate(strBoffDuty)   < CDate(strBoffDutyStart) Then ReturnErrMsg GetEmpLbl("BoffDutyLtBoffDutyStart") '"第二次下班开始时间必须早于下班标准时间！"
					If CDate(strBoffDutyEnd)< CDate(strBoffDuty)      Then ReturnErrMsg GetEmpLbl("BoffDutyEndLtBoffDuty") '"第二次下班标准时间必须早于下班截止时间！"
				End If
				
				'判断第一次开始时间到最后截止时间是否大于２４
				strSumTotal = Datediff("n", CDate(strBoffDutyEnd), CDate(strAonDutyStart))

				If abs(strSumTotal) > 1440 Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
			End If
		end if


		if cint(strDegree) = 3 then
			strConDuty = trim(Request.form("ConDuty"))
			strConDutyStart = trim(Request.form("ConDutyStart"))
			strConDutyEnd = trim(Request.form("ConDutyEnd"))
			strCoffDuty = trim(Request.form("CoffDuty"))
			strCoffDutyStart = trim(Request.form("CoffDutyStart"))
			strCoffDutyEnd = trim(Request.form("CoffDutyEnd"))

			strCcalculateLate = trim(Request.form("CcalculateLate")) 
			strCcalculateEarly = trim(Request.form("CcalculateEarly"))                     
			strCrestTime = trim(Request.form("CrestTime"))           '休息时间
			If iHaveNight = 1 Then
				strConDutyStart = CStr(NTempTime) + " " + CStr(strConDutyStart)
				strConDutyEnd   = CStr(NTempTime) + " " + CStr(strConDutyEnd)
				strConDuty      = CStr(NTempTime) + " " + CStr(strConDuty)
				strCoffDutyStart = CStr(NTempTime) + " " + CStr(strCoffDutyStart)
				strCoffDuty     = CStr(NTempTime) + " " + CStr(strCoffDuty)
				strCoffDutyEnd  = CStr(NTempTime) + " " + CStr(strCoffDutyEnd)				
			Else
				strConDutyStart = CStr(TempTime) + " " + CStr(strConDutyStart)
				strConDutyEnd   = CStr(TempTime) + " " + CStr(strConDutyEnd)
				strConDuty      = CStr(TempTime) + " " + CStr(strConDuty)
				strCoffDutyStart = CStr(TempTime) + " " + CStr(strCoffDutyStart)
				strCoffDuty     = CStr(TempTime) + " " + CStr(strCoffDuty)
				strCoffDutyEnd  = CStr(TempTime) + " " + CStr(strCoffDutyEnd)				
			End if

			If CInt(strNight) = 0 Then   '非过夜
				If CDate(strConDutyStart) < CDate(strBoffDutyEnd)  Then ReturnErrMsg GetEmpLbl("ConDutyStartLtBoffDutyEndN") '"第二次下班截止时间必须早于第三次上班开始时间或您没选择［过夜］！"
				If CDate(strConDuty)    < CDate(strConDutyStart)  Then ReturnErrMsg GetEmpLbl("ConDutyLtConDutyStartN") '"第三次上班开始时间必须早于上班标准时间或您没选择［过夜］！"
				If CDate(strConDutyEnd) < CDate(strConDuty)       Then ReturnErrMsg GetEmpLbl("ConDutyEndLtConDutyN") '"第三次上班标准时间必须早于上班截止时间或您没选择［过夜］！"
				If CDate(strCoffDutyStart) < CDate(strConDutyEnd) Then ReturnErrMsg GetEmpLbl("CoffDutyStartLtConDutyEndN") '"第三次上班截止时间必须早于下班开始时间或您没选择［过夜］！"
				If CDate(strCoffDuty)   < CDate(strCoffDutyStart) Then ReturnErrMsg GetEmpLbl("CoffDutyLtCoffDutyStartN") '"第三次下班开始时间必须早于下班标准时间或您没选择［过夜］！"
				If CDate(strCoffDutyEnd)< CDate(strCoffDuty)      Then ReturnErrMsg GetEmpLbl("CoffDutyEndLtCoffDutyN") '"第三次下班标准时间必须早于下班截止时间或您没选择［过夜］！"
			Else
				'If CDate(strConDutyStart)    = CDate(strBoffDutyEnd)  Then ReturnErrMsg "第二次下班截止时间不能等于第三次上班开始时间！"
				'If CDate(strConDuty)    = CDate(strConDutyStart)  Then ReturnErrMsg "第三次上班开始时间不能等于上班标准时间！"
				'If CDate(strConDutyEnd) = CDate(strConDuty)       Then ReturnErrMsg "第三次上班标准时间不能等于上班截止时间！"
				'If CDate(strCoffDutyStart) = CDate(strConDutyEnd) Then ReturnErrMsg "第三次上班截止时间不能等于下班开始时间！"
				'If CDate(strCoffDuty)   = CDate(strCoffDutyStart) Then ReturnErrMsg "第三次下班开始时间不能等于下班标准时间！"
				'If CDate(strCoffDutyEnd)= CDate(strCoffDuty)      Then ReturnErrMsg "第三次下班标准时间不能等于下班截止时间！"

				If iHaveNight = 0 Then
					If CDate(strConDutyStart) < CDate(strBoffDutyEnd) Then
						iHaveNight = 1
						If CDate(strConDuty)    < CDate(strConDutyStart) Then ReturnErrMsg GetEmpLbl("ConDutyLtConDutyStart") '"第三次上班开始时间必须早于上班标准时间！"
						If CDate(strConDuty) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strConDutyEnd) < CDate(strConDuty)       Then ReturnErrMsg GetEmpLbl("ConDutyEndLtConDuty") '"第三次上班标准时间必须早于上班截止时间！"
						If CDate(strConDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDutyStart) < CDate(strConDutyEnd) Then ReturnErrMsg GetEmpLbl("CoffDutyStartLtConDutyEnd") '"第三次上班截止时间必须早于下班开始时间！"
						If CDate(strCoffDutyStart) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDuty)   < CDate(strCoffDutyStart) Then ReturnErrMsg GetEmpLbl("CoffDutyLtCoffDutyStart") '"第三次下班开始时间必须早于下班标准时间！"
						If CDate(strCoffDuty) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDutyEnd)< CDate(strCoffDuty)      Then ReturnErrMsg GetEmpLbl("CoffDutyEndLtCoffDuty") '"第三次下班标准时间必须早于下班截止时间！"
						If CDate(strCoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"

						iflagC = "6"	
					ElseIf CDate(strConDuty)    < CDate(strConDutyStart)  Then
						iHaveNight = 1
						If CDate(strConDutyEnd) < CDate(strConDuty)       Then ReturnErrMsg GetEmpLbl("ConDutyEndLtConDuty") '"第三次上班标准时间必须早于上班截止时间！"
						If CDate(strConDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDutyStart) < CDate(strConDutyEnd) Then ReturnErrMsg GetEmpLbl("CoffDutyStartLtConDutyEnd") '"第三次上班截止时间必须早于下班开始时间！"
						If CDate(strCoffDutyStart) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDuty)   < CDate(strCoffDutyStart) Then ReturnErrMsg GetEmpLbl("CoffDutyLtCoffDutyStart") '"第三次下班开始时间必须早于下班标准时间！"
						If CDate(strCoffDuty) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDutyEnd)< CDate(strCoffDuty)      Then ReturnErrMsg GetEmpLbl("CoffDutyEndLtCoffDuty") '"第三次下班标准时间必须早于下班截止时间！"
						If CDate(strCoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"


						iflagC = "5"
					ElseIf CDate(strConDutyEnd) < CDate(strConDuty)   Then
						iHaveNight = 1
						If CDate(strConDutyEnd) > CDate(strConDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDutyStart) < CDate(strConDutyEnd) Then ReturnErrMsg GetEmpLbl("CoffDutyStartLtConDutyEnd") '"第三次上班截止时间必须早于下班开始时间！"
						If CDate(strCoffDutyStart) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDuty)   < CDate(strCoffDutyStart) Then ReturnErrMsg GetEmpLbl("CoffDutyLtCoffDutyStart") '"第三次下班开始时间必须早于下班标准时间！"
						If CDate(strCoffDuty) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDutyEnd)< CDate(strCoffDuty)      Then ReturnErrMsg GetEmpLbl("CoffDutyEndLtCoffDuty") '"第三次下班标准时间必须早于下班截止时间！"
						If CDate(strCoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
			
						iflagC = "4"
					ElseIf CDate(strCoffDutyStart) < CDate(strConDutyEnd)   Then
						iHaveNight = 1
						If CDate(strCoffDutyStart) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDuty)   < CDate(strCoffDutyStart) Then ReturnErrMsg GetEmpLbl("CoffDutyLtCoffDutyStart") '"第三次下班开始时间必须早于下班标准时间！"
						If CDate(strCoffDuty) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDutyEnd)< CDate(strCoffDuty)      Then ReturnErrMsg GetEmpLbl("CoffDutyEndLtCoffDuty") '"第三次下班标准时间必须早于下班截止时间！"
						If CDate(strCoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
	
						iflagC = "3"
					ElseIf CDate(strCoffDuty)   < CDate(strCoffDutyStart)   Then
						iHaveNight = 1
						If CDate(strCoffDuty) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDutyEnd)< CDate(strCoffDuty)      Then ReturnErrMsg GetEmpLbl("CoffDutyEndLtCoffDuty") '"第三次下班标准时间必须早于下班截止时间！"
						If CDate(strCoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
			
						iflagC = "2"
					ElseIf CDate(strCoffDutyEnd)< CDate(strCoffDuty)   Then
						iHaveNight = 1
						If CDate(strCoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
		
						iflagC = "1"
					End If
				Else
					If CDate(strConDutyStart) < CDate(strBoffDutyEnd)  Then ReturnErrMsg GetEmpLbl("ConDutyStartLtBoffDutyEnd") '"第二次下班截止时间必须早于第三次上班开始时间！"
					If CDate(right(strConDutyStart,8)) >= CDate( right(strAonDutyStart,8) )  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"

					If CDate(strConDuty)    < CDate(strConDutyStart)  Then ReturnErrMsg GetEmpLbl("ConDutyLtConDutyStart") '"第三次上班开始时间必须早于上班标准时间！"
					If CDate( Right(strConDuty,8) ) >= CDate( right(strAonDutyStart,8) ) Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"

					If CDate(strConDutyEnd) < CDate(strConDuty)       Then ReturnErrMsg GetEmpLbl("ConDutyEndLtConDuty") '"第三次上班标准时间必须早于上班截止时间！"
					If CDate( Right(strConDutyEnd,8) ) >= CDate( right(strAonDutyStart,8) ) Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"

					If CDate(strCoffDutyStart) < CDate(strConDutyEnd) Then ReturnErrMsg GetEmpLbl("CoffDutyStartLtConDutyEnd") '"第三次上班截止时间必须早于下班开始时间！"
					If CDate( Right(strCoffDutyStart,8) ) >= CDate( right(strAonDutyStart,8) ) Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"

					If CDate(strCoffDuty)   < CDate(strCoffDutyStart) Then ReturnErrMsg GetEmpLbl("CoffDutyLtCoffDutyStart") '"第三次下班开始时间必须早于下班标准时间！"
					If CDate( Right(strCoffDuty,8) ) >= CDate( right(strAonDutyStart,8) ) Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"

					If CDate(strCoffDutyEnd)< CDate(strCoffDuty)      Then ReturnErrMsg GetEmpLbl("CoffDutyEndLtCoffDuty") '"第三次下班标准时间必须早于下班截止时间！"
					If CDate( Right(strCoffDutyEnd,8) ) >= CDate( right(strAonDutyStart,8) ) Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
				End If
				
				'判断第一次开始时间到最后截止时间是否大于２４
				strSumTotal = Datediff("n", CDate(strCoffDutyEnd), CDate(strAonDutyStart))
				If abs(strSumTotal) > 1440 Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
			End If

		end If
		
		
		''If CInt(strNight) <> 0 And iHaveNight = 0 Then   '非过夜
		''	ReturnErrMsg "输入数据不符合过夜要求！"
		''End If
		
		'对时间段的处理
		If iflagA = "5" Then 
			strAonDutyStart    = "DateAdd(day, 0, '"+strAonDutyStart+"')"
			strAonDuty       = "DateAdd(day, 1, '"+strAonDuty+"')"
			strAonDutyEnd    = "DateAdd(day, 1, '"+strAonDutyEnd+"')"			
			strAoffDutyStart = "DateAdd(day, 1, '"+strAoffDutyStart+"')"
			strAoffDuty      = "DateAdd(day, 1, '"+strAoffDuty+"')"
			strAoffDutyEnd   = "DateAdd(day, 1, '"+strAoffDutyEnd+"')"
		ElseIf iflagA = "4" Then 
			strAonDutyStart    = "DateAdd(day, 0, '"+strAonDutyStart+"')"
			strAonDuty       = "DateAdd(day, 0, '"+strAonDuty+"')"
			strAonDutyEnd    = "DateAdd(day, 1, '"+strAonDutyEnd+"')"			
			strAoffDutyStart = "DateAdd(day, 1, '"+strAoffDutyStart+"')"
			strAoffDuty      = "DateAdd(day, 1, '"+strAoffDuty+"')"
			strAoffDutyEnd   = "DateAdd(day, 1, '"+strAoffDutyEnd+"')"
		ElseIf iflagA = "3" Then 
			strAonDutyStart    = "DateAdd(day, 0, '"+strAonDutyStart+"')"
			strAonDuty       = "DateAdd(day, 0, '"+strAonDuty+"')"
			strAonDutyEnd    = "DateAdd(day, 0, '"+strAonDutyEnd+"')"			
			strAoffDutyStart = "DateAdd(day, 1, '"+strAoffDutyStart+"')"
			strAoffDuty      = "DateAdd(day, 1, '"+strAoffDuty+"')"
			strAoffDutyEnd   = "DateAdd(day, 1, '"+strAoffDutyEnd+"')"
		ElseIf iflagA = "2" Then 
			strAonDutyStart    = "DateAdd(day, 0, '"+strAonDutyStart+"')"
			strAonDuty       = "DateAdd(day, 0, '"+strAonDuty+"')"
			strAonDutyEnd    = "DateAdd(day, 0, '"+strAonDutyEnd+"')"			
			strAoffDutyStart = "DateAdd(day, 0, '"+strAoffDutyStart+"')"
			strAoffDuty      = "DateAdd(day, 1, '"+strAoffDuty+"')"
			strAoffDutyEnd   = "DateAdd(day, 1, '"+strAoffDutyEnd+"')"
		ElseIf iflagA = "1" Then 
			strAonDutyStart    = "DateAdd(day, 0, '"+strAonDutyStart+"')"
			strAonDuty       = "DateAdd(day, 0, '"+strAonDuty+"')"
			strAonDutyEnd    = "DateAdd(day, 0, '"+strAonDutyEnd+"')"			
			strAoffDutyStart = "DateAdd(day, 0, '"+strAoffDutyStart+"')"
			strAoffDuty      = "DateAdd(day, 0, '"+strAoffDuty+"')"
			strAoffDutyEnd   = "DateAdd(day, 1, '"+strAoffDutyEnd+"')"
		Else
			strAonDutyStart    = "DateAdd(day, 0, '"+strAonDutyStart+"')"
			strAonDuty       = "DateAdd(day, 0, '"+strAonDuty+"')"
			strAonDutyEnd    = "DateAdd(day, 0, '"+strAonDutyEnd+"')"			
			strAoffDutyStart = "DateAdd(day, 0, '"+strAoffDutyStart+"')"
			strAoffDuty      = "DateAdd(day, 0, '"+strAoffDuty+"')"
			strAoffDutyEnd   = "DateAdd(day, 0, '"+strAoffDutyEnd+"')"
		End If 

		If iflagB = "6" Then 
			strBonDutyStart    = "DateAdd(day, 1, '"+strBonDutyStart+"')"
			strBonDuty      = "DateAdd(day, 1, '"+strBonDuty+"')"
			strBonDutyEnd   = "DateAdd(day, 1, '"+strBonDutyEnd+"')"				
			strBoffDutyStart = "DateAdd(day, 1, '"+strBoffDutyStart+"')"
			strBoffDuty     = "DateAdd(day, 1, '"+strBoffDuty+"')"	
			strBoffDutyEnd  = "DateAdd(day, 1, '"+strBoffDutyEnd+"')"
		ElseIf iflagB = "5" Then 
			strBonDutyStart    = "DateAdd(day, 0, '"+strBonDutyStart+"')"
			strBonDuty      = "DateAdd(day, 1, '"+strBonDuty+"')"
			strBonDutyEnd   = "DateAdd(day, 1, '"+strBonDutyEnd+"')"				
			strBoffDutyStart = "DateAdd(day, 1, '"+strBoffDutyStart+"')"
			strBoffDuty     = "DateAdd(day, 1, '"+strBoffDuty+"')"	
			strBoffDutyEnd  = "DateAdd(day, 1, '"+strBoffDutyEnd+"')"
		ElseIf iflagB = "4" Then 
			strBonDutyStart    = "DateAdd(day, 0, '"+strBonDutyStart+"')"
			strBonDuty      = "DateAdd(day, 0, '"+strBonDuty+"')"
			strBonDutyEnd   = "DateAdd(day, 1, '"+strBonDutyEnd+"')"				
			strBoffDutyStart = "DateAdd(day, 1, '"+strBoffDutyStart+"')"
			strBoffDuty     = "DateAdd(day, 1, '"+strBoffDuty+"')"	
			strBoffDutyEnd  = "DateAdd(day, 1, '"+strBoffDutyEnd+"')"
		ElseIf iflagB = "3" Then 
			strBonDutyStart    = "DateAdd(day, 0, '"+strBonDutyStart+"')"
			strBonDuty      = "DateAdd(day, 0, '"+strBonDuty+"')"
			strBonDutyEnd   = "DateAdd(day, 0, '"+strBonDutyEnd+"')"				
			strBoffDutyStart = "DateAdd(day, 1, '"+strBoffDutyStart+"')"
			strBoffDuty     = "DateAdd(day, 1, '"+strBoffDuty+"')"	
			strBoffDutyEnd  = "DateAdd(day, 1, '"+strBoffDutyEnd+"')"
		ElseIf iflagB = "2" Then 
			strBonDutyStart    = "DateAdd(day, 0, '"+strBonDutyStart+"')"
			strBonDuty      = "DateAdd(day, 0, '"+strBonDuty+"')"
			strBonDutyEnd   = "DateAdd(day, 0, '"+strBonDutyEnd+"')"				
			strBoffDutyStart = "DateAdd(day, 0, '"+strBoffDutyStart+"')"
			strBoffDuty     = "DateAdd(day, 1, '"+strBoffDuty+"')"	
			strBoffDutyEnd  = "DateAdd(day, 1, '"+strBoffDutyEnd+"')"
		ElseIf iflagB = "1" Then 
			strBonDutyStart    = "DateAdd(day, 0, '"+strBonDutyStart+"')"
			strBonDuty      = "DateAdd(day, 0, '"+strBonDuty+"')"
			strBonDutyEnd   = "DateAdd(day, 0, '"+strBonDutyEnd+"')"				
			strBoffDutyStart = "DateAdd(day, 0, '"+strBoffDutyStart+"')"
			strBoffDuty     = "DateAdd(day, 0, '"+strBoffDuty+"')"	
			strBoffDutyEnd  = "DateAdd(day, 1, '"+strBoffDutyEnd+"')"
		Else
			strBonDutyStart    = "DateAdd(day, 0, '"+strBonDutyStart+"')"
			strBonDuty      = "DateAdd(day, 0, '"+strBonDuty+"')"
			strBonDutyEnd   = "DateAdd(day, 0, '"+strBonDutyEnd+"')"				
			strBoffDutyStart = "DateAdd(day, 0, '"+strBoffDutyStart+"')"
			strBoffDuty     = "DateAdd(day, 0, '"+strBoffDuty+"')"	
			strBoffDutyEnd  = "DateAdd(day, 0, '"+strBoffDutyEnd+"')"
		End If 
		
		If iflagC = "6" Then 
			strConDutyStart    = "DateAdd(day, 1, '"+strConDutyStart+"')"
			strConDuty       = "DateAdd(day, 1, '"+strConDuty+"')"
			strConDutyEnd    = "DateAdd(day, 1, '"+strConDutyEnd+"')"			
			strCoffDutyStart = "DateAdd(day, 1, '"+strCoffDutyStart+"')"
			strCoffDuty      = "DateAdd(day, 1, '"+strCoffDuty+"')"
			strCoffDutyEnd   = "DateAdd(day, 1, '"+strCoffDutyEnd+"')"
		ElseIf iflagC = "5" Then 
			strConDutyStart    = "DateAdd(day, 0, '"+strConDutyStart+"')"
			strConDuty       = "DateAdd(day, 1, '"+strConDuty+"')"
			strConDutyEnd    = "DateAdd(day, 1, '"+strConDutyEnd+"')"			
			strCoffDutyStart = "DateAdd(day, 1, '"+strCoffDutyStart+"')"
			strCoffDuty      = "DateAdd(day, 1, '"+strCoffDuty+"')"
			strCoffDutyEnd   = "DateAdd(day, 1, '"+strCoffDutyEnd+"')"
		ElseIf iflagC = "4" Then 
			strConDutyStart    = "DateAdd(day, 0, '"+strConDutyStart+"')"
			strConDuty       = "DateAdd(day, 0, '"+strConDuty+"')"
			strConDutyEnd    = "DateAdd(day, 1, '"+strConDutyEnd+"')"			
			strCoffDutyStart = "DateAdd(day, 1, '"+strCoffDutyStart+"')"
			strCoffDuty      = "DateAdd(day, 1, '"+strCoffDuty+"')"
			strCoffDutyEnd   = "DateAdd(day, 1, '"+strCoffDutyEnd+"')"
		ElseIf iflagC = "3" Then 
			strConDutyStart    = "DateAdd(day, 0, '"+strConDutyStart+"')"
			strConDuty       = "DateAdd(day, 0, '"+strConDuty+"')"
			strConDutyEnd    = "DateAdd(day, 0, '"+strConDutyEnd+"')"			
			strCoffDutyStart = "DateAdd(day, 1, '"+strCoffDutyStart+"')"
			strCoffDuty      = "DateAdd(day, 1, '"+strCoffDuty+"')"
			strCoffDutyEnd   = "DateAdd(day, 1, '"+strCoffDutyEnd+"')"
		ElseIf iflagC = "2" Then 
			strConDutyStart    = "DateAdd(day, 0, '"+strConDutyStart+"')"
			strConDuty       = "DateAdd(day, 0, '"+strConDuty+"')"
			strConDutyEnd    = "DateAdd(day, 0, '"+strConDutyEnd+"')"			
			strCoffDutyStart = "DateAdd(day, 0, '"+strCoffDutyStart+"')"
			strCoffDuty      = "DateAdd(day, 1, '"+strCoffDuty+"')"
			strCoffDutyEnd   = "DateAdd(day, 1, '"+strCoffDutyEnd+"')"
		ElseIf iflagC = "1" Then 
			strConDutyStart    = "DateAdd(day, 0, '"+strConDutyStart+"')"
			strConDuty       = "DateAdd(day, 0, '"+strConDuty+"')"
			strConDutyEnd    = "DateAdd(day, 0, '"+strConDutyEnd+"')"			
			strCoffDutyStart = "DateAdd(day, 0, '"+strCoffDutyStart+"')"
			strCoffDuty      = "DateAdd(day, 0, '"+strCoffDuty+"')"
			strCoffDutyEnd   = "DateAdd(day, 1, '"+strCoffDutyEnd+"')"
		Else
			strConDutyStart    = "DateAdd(day, 0, '"+strConDutyStart+"')"
			strConDuty       = "DateAdd(day, 0, '"+strConDuty+"')"
			strConDutyEnd    = "DateAdd(day, 0, '"+strConDutyEnd+"')"			
			strCoffDutyStart = "DateAdd(day, 0, '"+strCoffDutyStart+"')"
			strCoffDuty      = "DateAdd(day, 0, '"+strCoffDuty+"')"
			strCoffDutyEnd   = "DateAdd(day, 0, '"+strCoffDutyEnd+"')"
		End If 
	Else                             '弹性班次
		If CInt(strNight) = 0 Then   '非过夜
			If CDate(strAonDuty)    < CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("StretchOnDutyLtOnDutyStart") '"弹性班上班开始时间必须早于上班标准时间！"
			If CDate(strAoffDuty)   < CDate(strAonDuty)       Then ReturnErrMsg GetEmpLbl("StretchOffDutyLtOnDuty") '"弹性班上班标准时间必须早于下班标准时间！"
			If CDate(strAoffDutyEnd)< CDate(strAoffDuty)      Then ReturnErrMsg GetEmpLbl("StretchOffDutyEndLtOffDuty") '"弹性班下班标准时间必须早于下班截止时间！"

			strAonDutyStart = CStr(TempTime) + " " + CStr(strAonDutyStart)
			strAonDuty      = CStr(TempTime) + " " + CStr(strAonDuty)
			strAoffDuty     = CStr(TempTime) + " " + CStr(strAoffDuty)
			strAoffDutyEnd  = CStr(TempTime) + " " + CStr(strAoffDutyEnd)

			strAonDutyStart = "DateAdd(day, 0, '"+strAonDutyStart+"')"
			strAonDuty = "DateAdd(day, 0, '"+strAonDuty+"')"
			strAoffDuty = "DateAdd(day, 0, '"+strAoffDuty+"')"
			strAoffDutyEnd = "DateAdd(day, 0, '"+strAoffDutyEnd+"')"
		Else
			
			''If CDate(strAonDuty)    = CDate(strAonDutyStart)  Then ReturnErrMsg "弹性班上班开始时间不能等于上班标准时间！"
			''If CDate(strAonDuty)   = CDate(strAoffDuty)      Then ReturnErrMsg "弹性班上班标准时间不能等于下班标准时间！"
			''If CDate(strAoffDutyEnd)= CDate(strAoffDuty)      Then ReturnErrMsg "弹性班下班标准时间不能等于下班截止时间！"
			''If CInt(strFirstOnDuty) = 1 Then TempTime = PTempTime

			If CDate(strAonDuty)    < CDate(strAonDutyStart)  Then
				iHaveNight = 1

				If CDate(strAonDuty)   < CDate(strAoffDuty) Then ReturnErrMsg GetEmpLbl("StretchOnDutyLtOffDuty") '"弹性班下班标准时间必须早于上班标准时间！"
				If CDate(strAoffDuty) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
				If CDate(strAoffDutyEnd)< CDate(strAoffDuty)      Then ReturnErrMsg GetEmpLbl("StretchOffDutyEndLtOffDuty") '"弹性班下班标准时间必须早于下班截止时间！"
				If CDate(strAoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
				strAonDutyStart = CStr(TempTime) + " " + CStr(strAonDutyStart)
				'TempTime = (TempTime) + 1
				TempTime = "DateAdd(day, 1, '"+TempTime+"')"
				strAonDuty      = CStr(TempTime) + "+' " + CStr(strAonDuty) + "'"
				strAoffDuty     = CStr(TempTime) + "+' " + CStr(strAoffDuty) + "'"
				strAoffDutyEnd  = CStr(TempTime) + "+' " + CStr(strAoffDutyEnd) + "'"

				strAonDutyStart = "DateAdd(day, 0, '"+strAonDutyStart+"')"
				strAonDuty = "DateAdd(day, 0, "+strAonDuty+")"
				strAoffDuty = "DateAdd(day, 0, "+strAoffDuty+")"
				strAoffDutyEnd = "DateAdd(day, 0, "+strAoffDutyEnd+")"
			ElseIf CDate(strAoffDuty)    < CDate(strAonDuty)  Then
				iHaveNight = 1
				If CDate(strAoffDuty) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"

				If CDate(strAoffDutyEnd)< CDate(strAoffDuty)      Then ReturnErrMsg GetEmpLbl("StretchOffDutyEndLtOffDuty") '"弹性班下班标准时间必须早于下班截止时间！"
				If CDate(strAoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
				strAonDutyStart = CStr(TempTime) + " " + CStr(strAonDutyStart)
				strAonDuty      = CStr(TempTime) + " " + CStr(strAonDuty)
				'TempTime = (TempTime) + 1
				TempTime = "DateAdd(day, 1, '"+TempTime+"')"
				strAoffDuty     = CStr(TempTime) + "+' " + CStr(strAoffDuty) + "'"
				strAoffDutyEnd  = CStr(TempTime) + "+' " + CStr(strAoffDutyEnd) + "'"

				strAonDutyStart = "DateAdd(day, 0, '"+strAonDutyStart+"')"
				strAonDuty = "DateAdd(day, 0, '"+strAonDuty+"')"
				strAoffDuty = "DateAdd(day, 0, "+strAoffDuty+")"
				strAoffDutyEnd = "DateAdd(day, 0, "+strAoffDutyEnd+")"
			ElseIf CDate(strAoffDutyEnd)    < CDate(strAoffDuty)  Then
				iHaveNight = 1
				If CDate(strAoffDutyEnd) > CDate(strAonDutyStart)  Then ReturnErrMsg GetEmpLbl("AonDutyEndMtAonDutyStart") '"一个班次的时间段必须在二十四小时之内！"
				strAonDutyStart = CStr(TempTime) + " " + CStr(strAonDutyStart)
				strAonDuty      = CStr(TempTime) + " " + CStr(strAonDuty)
				strAoffDuty     = CStr(TempTime) + " " + CStr(strAoffDuty)
				'TempTime = (TempTime) + 1
				TempTime = "DateAdd(day, 1, '"+TempTime+"')"
				strAoffDutyEnd  = CStr(TempTime) + "+' " + CStr(strAoffDutyEnd) + "'"

				strAonDutyStart = "DateAdd(day, 0, '"+strAonDutyStart+"')"
				strAonDuty = "DateAdd(day, 0, '"+strAonDuty+"')"
				strAoffDuty = "DateAdd(day, 0, '"+strAoffDuty+"')"
				strAoffDutyEnd = "DateAdd(day, 0, "+strAoffDutyEnd+")"
			Else
				strAonDutyStart = "DateAdd(day, 0, '"+strAonDutyStart+"')"
				strAonDuty = "DateAdd(day, 0, '"+strAonDuty+"')"
				strAoffDuty = "DateAdd(day, 0, '"+strAoffDuty+"')"
				strAoffDutyEnd = "DateAdd(day, 0, '"+strAoffDutyEnd+"')"
			End If
			If iHaveNight = 0 Then ReturnErrMsg GetEmpLbl("DataIllegal") '"输入数据不符合过夜要求！"
			
		End if
		strDegree = 1
	end if

	if strArestTime = "" then strArestTime = 0
	if strBrestTime = "" then strBrestTime = 0
	if strCrestTime = "" then strCrestTime = 0
	if strAcalculateLate = "" then strAcalculateLate = 0
	if strBcalculateLate = "" then strBcalculateLate = 0
	if strCcalculateLate = "" then strCcalculateLate = 0
	if strAcalculateEarly = "" then strAcalculateEarly = 0
	if strBcalculateEarly = "" then strBcalculateEarly = 0
	if strCcalculateEarly = "" then strCcalculateEarly = 0
	'生效日期
	''strAdjustDate = trim(Request.form("AdjustDate"))
	if len( strShiftName ) > 50 Then ReturnErrMsg GetEmpLbl("ShiftNameIllegal") '"班次名非法！"
	''if len( strFirstOnDuty ) > 1 Then ReturnErrMsg "第一次上班非法！"
	'//******************************************************************************/

	if iflag = 0 then     '增加
		'判断班次名称唯一性
		''if fCheckExist("AttendanceShifts", " shiftId ", " shiftName='"+cstr(strShiftName)+"'") = 1 then
		''	ReturnErrMsg "班次名不能重复！", "parent.form1.ShiftsName.value='';parent.form1.ShiftsName.focus();"
		''end If
		
		if cint(strStretchShift) = 0 then   '固定班次
			if cint(strDegree) = 1 then     '时间段1
				strFields = "ShiftName,StretchShift,Degree,Night, FirstOnDuty,ShiftTime, AonDuty,AonDutyStart,AonDutyEnd, AoffDuty, AoffDutyStart, AoffDutyEnd, AcalculateLate,AcalculateEarly, ArestTime,"
				strValues = "'"+cstr(strShiftName)+"', "+cstr(strStretchShift)+", "+cstr(strDegree)+", "+cstr(strNight)+", "+cstr(strFirstOnDuty)+","+cstr(strShiftTime)+","+cstr(strAonDuty)+","+cstr(strAonDutyStart)+","+cstr(strAonDutyEnd)+","+cstr(strAoffDuty)+","+cstr(strAoffDutyStart)+","+cstr(strAoffDutyEnd)+","+cstr(strAcalculateLate)+","+CStr(strAcalculateEarly)+","+CStr(strArestTime)

				strFieldsTemp = "ShiftType,AdjustDate,ShiftId,ShiftName,StretchShift,Degree,Night, FirstOnDuty,ShiftTime, AonDuty,AonDutyStart,AonDutyEnd, AoffDuty, AoffDutyStart, AoffDutyEnd, AcalculateLate,AcalculateEarly, ArestTime"
				strValuesTemp = ",'"+cstr(strShiftName)+"', "+cstr(strStretchShift)+", "+cstr(strDegree)+", "+cstr(strNight)+", "+cstr(strFirstOnDuty)+","+cstr(strShiftTime)+","+cstr(strAonDuty)+", "+cstr(strAonDutyStart)+", "+cstr(strAonDutyEnd)+","+cstr(strAoffDuty)+","+cstr(strAoffDutyStart)+","+cstr(strAoffDutyEnd)+","+cstr(strAcalculateLate)+","+CStr(strAcalculateEarly)+","+CStr(strArestTime)
			ElseIf cint(strDegree) = 2 then     '时间段2
				strFields = "ShiftName,StretchShift,Degree,Night, FirstOnDuty,ShiftTime, AonDuty,AonDutyStart,AonDutyEnd, AoffDuty, AoffDutyStart, AoffDutyEnd, AcalculateLate,AcalculateEarly, ArestTime, BonDuty, BonDutyStart, BonDutyEnd, BoffDuty, BoffDutyStart, BoffDutyEnd, BcalculateLate,BcalculateEarly, BrestTime"
				strValues = "'"+cstr(strShiftName)+"', "+cstr(strStretchShift)+", "+cstr(strDegree)+", "+cstr(strNight)+", "+cstr(strFirstOnDuty)+","+cstr(strShiftTime)+","+cstr(strAonDuty)+","+cstr(strAonDutyStart)+","+cstr(strAonDutyEnd)+","+cstr(strAoffDuty)+","+cstr(strAoffDutyStart)+","+cstr(strAoffDutyEnd)+","+cstr(strAcalculateLate)+","+CStr(strAcalculateEarly)+","+CStr(strArestTime)+","+cstr(strBonDuty)+", "+cstr(strBonDutyStart)+","+cstr(strBonDutyEnd)+","+cstr(strBoffDuty)+","+cstr(strBoffDutyStart)+","+cstr(strBoffDutyEnd)+","+cstr(strBcalculateLate)+","+CStr(strBcalculateEarly)+","+CStr(strBrestTime)

				strFieldsTemp = "ShiftType,AdjustDate,ShiftId,ShiftName,StretchShift,Degree,Night, FirstOnDuty,ShiftTime, AonDuty,AonDutyStart,AonDutyEnd, AoffDuty, AoffDutyStart, AoffDutyEnd, AcalculateLate,AcalculateEarly, ArestTime, BonDuty, BonDutyStart, BonDutyEnd, BoffDuty, BoffDutyStart, BoffDutyEnd, BcalculateLate,BcalculateEarly, BrestTime"
				strValuesTemp = ",'"+cstr(strShiftName)+"', "+cstr(strStretchShift)+", "+cstr(strDegree)+", "+cstr(strNight)+", "+cstr(strFirstOnDuty)+","+cstr(strShiftTime)+","+cstr(strAonDuty)+", "+cstr(strAonDutyStart)+", "+cstr(strAonDutyEnd)+","+cstr(strAoffDuty)+","+cstr(strAoffDutyStart)+","+cstr(strAoffDutyEnd)+","+cstr(strAcalculateLate)+","+CStr(strAcalculateEarly)+","+CStr(strArestTime)+", "+cstr(strBonDuty)+", "+cstr(strBonDutyStart)+", "+cstr(strBonDutyEnd)+","+cstr(strBoffDuty)+","+cstr(strBoffDutyStart)+","+cstr(strBoffDutyEnd)+","+cstr(strBcalculateLate)+","+CStr(strBcalculateEarly)+","+CStr(strBrestTime)
			Else
				strFields = "ShiftName,StretchShift,Degree,Night, FirstOnDuty,ShiftTime, AonDuty,AonDutyStart,AonDutyEnd, AoffDuty, AoffDutyStart, AoffDutyEnd, AcalculateLate,AcalculateEarly, ArestTime, BonDuty, BonDutyStart, BonDutyEnd, BoffDuty, BoffDutyStart, BoffDutyEnd, BcalculateLate,BcalculateEarly, BrestTime, ConDuty, ConDutyStart, ConDutyEnd, CoffDuty, CoffDutyStart, CoffDutyEnd, CcalculateLate,CcalculateEarly, CrestTime"
				strValues = "'"+cstr(strShiftName)+"', "+cstr(strStretchShift)+", "+cstr(strDegree)+", "+cstr(strNight)+", "+cstr(strFirstOnDuty)+","+cstr(strShiftTime)+","+cstr(strAonDuty)+","+cstr(strAonDutyStart)+","+cstr(strAonDutyEnd)+","+cstr(strAoffDuty)+","+cstr(strAoffDutyStart)+","+cstr(strAoffDutyEnd)+","+cstr(strAcalculateLate)+","+CStr(strAcalculateEarly)+","+CStr(strArestTime)+","+cstr(strBonDuty)+", "+cstr(strBonDutyStart)+","+cstr(strBonDutyEnd)+","+cstr(strBoffDuty)+","+cstr(strBoffDutyStart)+","+cstr(strBoffDutyEnd)+","+cstr(strBcalculateLate)+","+CStr(strBcalculateEarly)+","+CStr(strBrestTime)+","+cstr(strConDuty)+","+cstr(strConDutyStart)+","+cstr(strConDutyEnd)+","+cstr(strCoffDuty)+","+cstr(strCoffDutyStart)+","+cstr(strCoffDutyEnd)+","+cstr(strCcalculateLate)+","+CStr(strCcalculateEarly)+","+CStr(strCrestTime)
							
				strFieldsTemp = "ShiftType,AdjustDate,ShiftId,ShiftName,StretchShift,Degree,Night, FirstOnDuty,ShiftTime, AonDuty,AonDutyStart,AonDutyEnd, AoffDuty, AoffDutyStartq AoffDutyEnd, AcalculateLate,AcalculateEarly, ArestTime, BonDuty, BonDutyStart, BonDutyEnd, BoffDuty, BoffDutyStart, BoffDutyEnd, BcalculateLate,BcalculateEarly, BrestTime, ConDuty, ConDutyStart, ConDutyEnd, CoffDuty, CoffDutyStart, CoffDutyEnd, CcalculateLate,CcalculateEarly, CrestTime"
				strValuesTemp = ",'"+cstr(strShiftName)+"', "+cstr(strStretchShift)+", "+cstr(strDegree)+", "+cstr(strNight)+", "+cstr(strFirstOnDuty)+","+cstr(strShiftTime)+","+cstr(strAonDuty)+","+cstr(strAonDutyStart)+", "+cstr(strAonDutyEnd)+","+cstr(strAoffDuty)+","+cstr(strAoffDutyStart)+","+cstr(strAoffDutyEnd)+","+cstr(strAcalculateLate)+","+CStr(strAcalculateEarly)+","+CStr(strArestTime)+", "+cstr(strBonDuty)+", "+cstr(strBonDutyStart)+", "+cstr(strBonDutyEnd)+","+cstr(strBoffDuty)+","+cstr(strBoffDutyStart)+","+cstr(strBoffDutyEnd)+","+cstr(strBcalculateLate)+","+CStr(strBcalculateEarly)+","+CStr(strBrestTime)+", "+cstr(strConDuty)+", "+cstr(strConDutyStart)+", "+cstr(strConDutyEnd)+","+cstr(strCoffDuty)+","+cstr(strCoffDutyStart)+","+cstr(strCoffDutyEnd)+","+cstr(strCcalculateLate)+","+CStr(strCcalculateEarly)+","+CStr(strCrestTime)
			End if
		Else
			strFields = "ShiftName,StretchShift,Degree,Night, FirstOnDuty,ShiftTime, AonDuty,AonDutyStart, AoffDuty, AoffDutyEnd, AcalculateLate,AcalculateEarly, ArestTime"
			strValues = "'"+cstr(strShiftName)+"', "+cstr(strStretchShift)+", "+cstr(strDegree)+", "+cstr(strNight)+", "+cstr(strFirstOnDuty)+","+cstr(strShiftTime)+","+cstr(strAonDuty)+","+cstr(strAonDutyStart)+","+cstr(strAoffDuty)+","+cstr(strAoffDutyEnd)+","+cstr(strAcalculateLate)+","+CStr(strAcalculateEarly)+","+CStr(strArestTime)
			strFieldsTemp = "ShiftType,AdjustDate,ShiftId,ShiftName,StretchShift,Degree,Night, FirstOnDuty,ShiftTime, AonDuty,AonDutyStart,AoffDuty, AoffDutyEnd, AcalculateLate,AcalculateEarly, ArestTime"
			strValuesTemp = ",'"+cstr(strShiftName)+"', "+cstr(strStretchShift)+", "+cstr(strDegree)+", "+cstr(strNight)+", "+cstr(strFirstOnDuty)+","+cstr(strShiftTime)+","+cstr(strAonDuty)+", "+cstr(strAonDutyStart)+", "+cstr(strAoffDuty)+","+cstr(strAoffDutyEnd)+","+cstr(strAcalculateLate)+","+CStr(strAcalculateEarly)+","+CStr(strArestTime)
		End If

		'''if AddInfoIntoTable( "AttendanceShifts", strFields, strValues ) = 1 Then
			''strId = fGetOneField("AttendanceShifts", "ShiftId", "ShiftName='"+CStr(strShiftName)+"'")
			'增加到临时班次表
			''If strId = "" Then
			''	DelInfoFromTable "AttendanceShifts", "ShiftName='"+CStr(strShiftName)+"'"
			''	ReturnErrMsg "添加失败！"
			''End if
			''strValues = "0,null,"+cstr(strId) + strValuesTemp
			''AddInfoIntoTable "TempShifts", strFieldsTemp, strValues
			''response.write JSErrorMsg( "", "parent.location.href='AttendShifts.asp';" )

			''AddLogEvent "考勤-正常班次", "增加", "班次名称："+cstr(strShiftName)             '增加日志
		'''else
			''ReturnErrMsg "添加失败！"
		'''end If
	else                  '修改
		strId = trim(Request.QueryString("strId"))
		if strId = "" or not isnumeric(strId) then
			ReturnErrMsg GetEmpLbl("IllegalOperate") '"非法操作！"
		end if
		'修改正常班次时[生效日期]不能为空;
		''if strAdjustDate = "" then
		''	ReturnErrMsg "生效日期不能为空！"	
		''end if
		''if CheckDate( strAdjustDate, 0, "" ) <> 1 then
		''	ReturnErrMsg "生效日期格式非法！"	
		''end if
		iChangeNameORNot = 0
		iIsAdd = Trim(Request.QueryString("isadd"))
		'判断班次名称唯一性
		''if fCheckExist("AttendanceShifts", "shiftId", " shiftName='"+cstr(strShiftName)+"' and shiftId="+cstr(strId)) <> 1 then
		''	if fCheckExist("AttendanceShifts", "shiftId", " shiftName='"+cstr(strShiftName)+"'") = 1 then
		''		ReturnErrMsg "班次名已被使用！", "parent.form1.ShiftsName.value='';parent.form1.ShiftsName.focus();"
		''	end if
			iChangeNameORNot = 1
		''end if
		'判断strId 为isnumeric
		if cint(strStretchShift) = 0 then   '固定班次
			if cint(strDegree) = 1 then     '时间段1
				strFields = "ShiftName='"+cstr(strShiftName) + "', StretchShift="+cstr(strStretchShift)+",Degree="+cstr(strDegree)+",Night="+cstr(strNight)+", FirstOnDuty="+cstr(strFirstOnDuty)+",ShiftTime="+cstr(strShiftTime)+ ", AonDuty="+cstr(strAonDuty)+",AonDutyStart="+cstr(strAonDutyStart)+",AonDutyEnd="+cstr(strAonDutyEnd)+", AoffDuty="+cstr(strAoffDuty)+", AoffDutyStart="+cstr(strAoffDutyStart)+", AoffDutyEnd="+cstr(strAoffDutyEnd)+", AcalculateLate="+cstr(strAcalculateLate)+", AcalculateEarly="+cstr(strAcalculateEarly)+", ArestTime="+cstr(strArestTime)+", BonDuty=null, BonDutyStart=null, BonDutyEnd=null, BoffDuty=null, BoffDutyStart=null, BoffDutyEnd=null, BcalculateLate=null, BcalculateEarly=null, BrestTime=null, ConDuty=null, ConDutyStart=null, ConDutyEnd=null, CoffDuty=null, CoffDutyStart=null, CoffDutyEnd=null, CcalculateLate=null, CcalculateEarly=null, CrestTime=null "

				strFieldsTemp = "ShiftType,AdjustDate,ShiftId,ShiftName,StretchShift,Degree,Night, FirstOnDuty,ShiftTime, AonDuty,AonDutyStart,AonDutyEnd, AoffDuty, AoffDutyStart, AoffDutyEnd, AcalculateLate,AcalculateEarly, ArestTime"

				strValues = "0,'"+cstr(strAdjustDate)+"',"+cstr(strId)+",'"+cstr(strShiftName)+"', "+cstr(strStretchShift)+", "+cstr(strDegree)+", "+cstr(strNight)+", "+cstr(strFirstOnDuty)+","+cstr(strShiftTime)+","+cstr(strAonDuty)+", "+cstr(strAonDutyStart)+", "+cstr(strAonDutyEnd)+","+cstr(strAoffDuty)+","+cstr(strAoffDutyStart)+","+cstr(strAoffDutyEnd)+","+cstr(strAcalculateLate)+","+CStr(strAcalculateEarly)+","+CStr(strArestTime)
			ElseIf cint(strDegree) = 2 then     '时间段2
				strFields = "ShiftName='"+cstr(strShiftName) + "', StretchShift="+cstr(strStretchShift)+",Degree="+cstr(strDegree)+",Night="+cstr(strNight)+", FirstOnDuty="+cstr(strFirstOnDuty)+",ShiftTime="+cstr(strShiftTime)+ ", AonDuty="+cstr(strAonDuty)+",AonDutyStart="+cstr(strAonDutyStart)+",AonDutyEnd="+cstr(strAonDutyEnd)+", AoffDuty="+cstr(strAoffDuty)+", AoffDutyStart="+cstr(strAoffDutyStart)+", AoffDutyEnd="+cstr(strAoffDutyEnd)+", AcalculateLate="+cstr(strAcalculateLate)+", AcalculateEarly="+cstr(strAcalculateEarly)+", ArestTime="+cstr(strArestTime)+", BonDuty="+cstr(strBonDuty)+", BonDutyStart="+cstr(strBonDutyStart)+", BonDutyEnd="+cstr(strBonDutyEnd)+", BoffDuty="+cstr(strBoffDuty)+", BoffDutyStart="+cstr(strBoffDutyStart)+", BoffDutyEnd="+cstr(strBoffDutyEnd)+", BcalculateLate="+cstr(strBcalculateLate)+", BcalculateEarly="+cstr(strBcalculateEarly)+", BrestTime="+cstr(strBrestTime)+", ConDuty=null, ConDutyStart=null, ConDutyEnd=null, CoffDuty=null, CoffDutyStart=null, CoffDutyEnd=null, CcalculateLate=null, CcalculateEarly=null, CrestTime=null "

				strFieldsTemp = "ShiftType,AdjustDate,ShiftId,ShiftName,StretchShift,Degree,Night, FirstOnDuty,ShiftTime, AonDuty,AonDutyStart,AonDutyEnd, AoffDuty, AoffDutyStart, AoffDutyEnd, AcalculateLate,AcalculateEarly, ArestTime, BonDuty, BonDutyStart, BonDutyEnd, BoffDuty, BoffDutyStart, BoffDutyEnd, BcalculateLate,BcalculateEarly, BrestTime"

				strValues = "0,'"+cstr(strAdjustDate)+"',"+cstr(strId)+",'"+cstr(strShiftName)+"', "+cstr(strStretchShift)+", "+cstr(strDegree)+", "+cstr(strNight)+", "+cstr(strFirstOnDuty)+","+cstr(strShiftTime)+","+cstr(strAonDuty)+", "+cstr(strAonDutyStart)+", "+cstr(strAonDutyEnd)+","+cstr(strAoffDuty)+","+cstr(strAoffDutyStart)+","+cstr(strAoffDutyEnd)+","+cstr(strAcalculateLate)+","+CStr(strAcalculateEarly)+","+CStr(strArestTime)+", "+cstr(strBonDuty)+", "+cstr(strBonDutyStart)+", "+cstr(strBonDutyEnd)+","+cstr(strBoffDuty)+","+cstr(strBoffDutyStart)+","+cstr(strBoffDutyEnd)+","+cstr(strBcalculateLate)+","+CStr(strBcalculateEarly)+","+CStr(strBrestTime)
			Else
				strFields = "ShiftName='"+cstr(strShiftName) + "', StretchShift="+cstr(strStretchShift)+",Degree="+cstr(strDegree)+",Night="+cstr(strNight)+", FirstOnDuty="+cstr(strFirstOnDuty)+",ShiftTime="+cstr(strShiftTime)+ ", AonDuty="+cstr(strAonDuty)+",AonDutyStart="+cstr(strAonDutyStart)+",AonDutyEnd="+cstr(strAonDutyEnd)+", AoffDuty="+cstr(strAoffDuty)+", AoffDutyStart="+cstr(strAoffDutyStart)+", AoffDutyEnd="+cstr(strAoffDutyEnd)+", AcalculateLate="+cstr(strAcalculateLate)+", AcalculateEarly="+cstr(strAcalculateEarly)+", ArestTime="+cstr(strArestTime)+", BonDuty="+cstr(strBonDuty)+", BonDutyStart="+cstr(strBonDutyStart)+", BonDutyEnd="+cstr(strBonDutyEnd)+", BoffDuty="+cstr(strBoffDuty)+", BoffDutyStart="+cstr(strBoffDutyStart)+", BoffDutyEnd="+cstr(strBoffDutyEnd)+", BcalculateLate="+cstr(strBcalculateLate)+", BcalculateEarly="+cstr(strBcalculateEarly)+", BrestTime="+cstr(strBrestTime)+", ConDuty="+cstr(strConDuty)+", ConDutyStart="+cstr(strConDutyStart)+", ConDutyEnd="+cstr(strConDutyEnd)+", CoffDuty="+cstr(strCoffDuty)+", CoffDutyStart="+cstr(strCoffDutyStart)+", CoffDutyEnd="+cstr(strCoffDutyEnd)+", CcalculateLate="+cstr(strCcalculateLate)+", CcalculateEarly="+cstr(strCcalculateEarly)+", CrestTime="+cstr(strCrestTime)

				strFieldsTemp = "ShiftType,AdjustDate,ShiftId,ShiftName,StretchShift,Degree,Night, FirstOnDuty,ShiftTime, AonDuty,AonDutyStart,AonDutyEnd, AoffDuty, AoffDutyStart, AoffDutyEnd, AcalculateLate,AcalculateEarly, ArestTime, BonDuty, BonDutyStart, BonDutyEnd, BoffDuty, BoffDutyStart, BoffDutyEnd, BcalculateLate,BcalculateEarly, BrestTime, ConDuty, ConDutyStart, ConDutyEnd, CoffDuty, CoffDutyStart, CoffDutyEnd, CcalculateLate,CcalculateEarly, CrestTime"

				strValues = "0,'"+cstr(strAdjustDate)+"',"+cstr(strId)+",'"+cstr(strShiftName)+"', "+cstr(strStretchShift)+", "+cstr(strDegree)+", "+cstr(strNight)+", "+cstr(strFirstOnDuty)+","+cstr(strShiftTime)+","+cstr(strAonDuty)+", "+cstr(strAonDutyStart)+", "+cstr(strAonDutyEnd)+","+cstr(strAoffDuty)+","+cstr(strAoffDutyStart)+","+cstr(strAoffDutyEnd)+","+cstr(strAcalculateLate)+","+CStr(strAcalculateEarly)+","+CStr(strArestTime)+", "+cstr(strBonDuty)+", "+cstr(strBonDutyStart)+", "+cstr(strBonDutyEnd)+","+cstr(strBoffDuty)+","+cstr(strBoffDutyStart)+","+cstr(strBoffDutyEnd)+","+cstr(strBcalculateLate)+","+CStr(strBcalculateEarly)+","+CStr(strBrestTime)+", "+cstr(strConDuty)+", "+cstr(strConDutyStart)+", "+cstr(strConDutyEnd)+","+cstr(strCoffDuty)+","+cstr(strCoffDutyStart)+","+cstr(strCoffDutyEnd)+","+cstr(strCcalculateLate)+","+CStr(strCcalculateEarly)+","+CStr(strCrestTime)
			End If
		Else
			strFields = "ShiftName='"+cstr(strShiftName) + "', StretchShift="+cstr(strStretchShift)+",Degree="+cstr(strDegree)+",Night="+cstr(strNight)+", FirstOnDuty="+cstr(strFirstOnDuty)+",ShiftTime="+cstr(strShiftTime)+ ", AonDuty="+cstr(strAonDuty)+",AonDutyStart="+cstr(strAonDutyStart)+",AonDutyEnd=null, AoffDuty="+cstr(strAoffDuty)+", AoffDutyStart=null, AoffDutyEnd="+cstr(strAoffDutyEnd)+", AcalculateLate="+cstr(strAcalculateLate)+", AcalculateEarly="+cstr(strAcalculateEarly)+", ArestTime="+cstr(strArestTime)+", BonDuty=null, BonDutyStart=null, BonDutyEnd=null, BoffDuty=null, BoffDutyStart=null, BoffDutyEnd=null, BcalculateLate=null, BcalculateEarly=null, BrestTime=null, ConDuty=null, ConDutyStart=null, ConDutyEnd=null, CoffDuty=null, CoffDutyStart=null, CoffDutyEnd=null, CcalculateLate=null, CcalculateEarly=null, CrestTime=null "

			strFieldsTemp = "ShiftType,AdjustDate,ShiftId,ShiftName,StretchShift,Degree,Night, FirstOnDuty,ShiftTime, AonDuty,AonDutyStart,AonDutyEnd, AoffDuty, AoffDutyStart, AoffDutyEnd, AcalculateLate,AcalculateEarly, ArestTime"

			strValues = "0,'"+cstr(strAdjustDate)+"',"+cstr(strId)+",'"+cstr(strShiftName)+"', "+cstr(strStretchShift)+", "+cstr(strDegree)+", "+cstr(strNight)+", "+cstr(strFirstOnDuty)+","+cstr(strShiftTime)+","+cstr(strAonDuty)+", "+cstr(strAonDutyStart)+", "+cstr(strAonDutyEnd)+","+cstr(strAoffDuty)+","+cstr(strAoffDutyStart)+","+cstr(strAoffDutyEnd)+","+cstr(strAcalculateLate)+","+CStr(strAcalculateEarly)+","+CStr(strArestTime)
		End If

		strSQL = "Update AttendanceShifts set " + cstr(strFields) + " where ShiftId=" + cstr(strId) + ";"


		''If fCheckExist("TempShifts", "TempShiftID", "ShiftType=0 and AdjustDate='"+cstr(strAdjustDate)+"' and  ShiftId="+cstr(strId)) = 1 Then
		''	strSQL = strSQL + "delete TempShifts where ShiftType=0 and AdjustDate='"+cstr(strAdjustDate)+"' and  ShiftId="+cstr(strId)+" ;insert into TempShifts("+CStr(strFieldsTemp)+")values("+CStr(strValues)+");"
		''Else
		''	If iIsAdd = "1" Then
		''		strSQL = strSQL + "delete TempShifts where ShiftType=0 and AdjustDate>'"+cstr(strAdjustDate)+"' and  ShiftId="+cstr(strId) + " ;"
		''	End If
		''	strSQL = strSQL + "insert into TempShifts("+CStr(strFieldsTemp)+")values("+CStr(strValues)+");"
		''End If
		
		call fConnectADODB()

		On Error Resume Next

		Conn.Execute strSQL
		if err.number <> 0 Then
			On Error GoTo 0
			Call fCloseADO()
			Call ReturnMsg("false",GetEmpLbl("EditFail"),0)	'"修改失败"
			response.End()
		end If
		'Call AddLogEvent("人事-考勤-班次",cstr(strLogEdit),cstr(strLogEdit)&"班次,班次名称["&cstr(strShiftName)&"]")
		Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("Attend")&"-"&GetEmpLbl("Shifts"),cstr(GetCerbLbl("strLogEdit")),cstr(GetCerbLbl("strLogEdit"))&GetEmpLbl("Shifts")&","&GetEmpLbl("ShiftName")&"["&cstr(strShiftName)&"]")
		
		''AddLogEvent "考勤-正常班次", "修改", "班次名称："+cstr(strShiftName)             '增加日志
		''	if iChangeNameORNot = 1 then
		''		ChangeInfoToTable "AttendanceOndutyRule", "Monday1='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Monday1<>'' and Monday1 is not Null and left(Monday1,charindex('-', Monday1)-1)="+cstr(strId)
			'	response.write "fds"
		''		ChangeInfoToTable "AttendanceOndutyRule", "Monday2='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Monday2<>'' and Monday2 is not Null and left(Monday2,charindex('-', Monday2)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOndutyRule", "Tuesday1='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Tuesday1<>'' and Tuesday1 is not Null and left(Tuesday1,charindex('-', Tuesday1)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOndutyRule", "Tuesday2='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Tuesday2<>'' and Tuesday2 is not Null and left(Tuesday2,charindex('-', Tuesday2)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOndutyRule", "Wednesday1='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Wednesday1<>'' and Wednesday1 is not Null and left(Wednesday1,charindex('-', Wednesday1)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOndutyRule", "Wednesday2='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Wednesday2<>'' and Wednesday2 is not Null and left(Wednesday2,charindex('-', Wednesday2)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOndutyRule", "Thursday1='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Thursday1<>'' and Thursday1 is not Null and left(Thursday1,charindex('-', Thursday1)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOndutyRule", "Thursday2='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Thursday2<>'' and Thursday2 is not Null and left(Thursday2,charindex('-', Thursday2)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOndutyRule", "Friday1='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Friday1<>'' and Friday1 is not Null and left(Friday1,charindex('-', Friday1)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOndutyRule", "Friday2='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Friday2<>'' and Friday2 is not Null and left(Friday2,charindex('-', Friday2)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOndutyRule", "Saturday1='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Saturday1<>'' and Saturday1 is not Null and left(Saturday1,charindex('-', Saturday1)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOndutyRule", "Saturday2='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Saturday2<>'' and Saturday2 is not Null and left(Saturday2,charindex('-', Saturday2)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOndutyRule", "Sunday1='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Sunday1<>'' and Sunday1 is not Null and left(Sunday1,charindex('-', Sunday1)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOndutyRule", "Sunday2='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Sunday2<>'' and Sunday2 is not Null and left(Sunday2,charindex('-', Sunday2)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOnDutyRuleChange", "Monday1='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Monday1<>'' and Monday1 is not Null and left(Monday1,charindex('-', Monday1)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOnDutyRuleChange", "Monday2='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Monday2<>'' and Monday2 is not Null and left(Monday2,charindex('-', Monday2)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOnDutyRuleChange", "Tuesday1='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Tuesday1<>'' and Tuesday1 is not Null and left(Tuesday1,charindex('-', Tuesday1)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOnDutyRuleChange", "Tuesday2='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Tuesday2<>'' and Tuesday2 is not Null and left(Tuesday2,charindex('-', Tuesday2)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOnDutyRuleChange", "Wednesday1='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Wednesday1<>'' and Wednesday1 is not Null and left(Wednesday1,charindex('-', Wednesday1)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOnDutyRuleChange", "Wednesday2='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Wednesday2<>'' and Wednesday2 is not Null and left(Wednesday2,charindex('-', Wednesday2)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOnDutyRuleChange", "Thursday1='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Thursday1<>'' and Thursday1 is not Null and left(Thursday1,charindex('-', Thursday1)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOnDutyRuleChange", "Thursday2='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Thursday2<>'' and Thursday2 is not Null and left(Thursday2,charindex('-', Thursday2)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOnDutyRuleChange", "Friday1='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Friday1<>'' and Friday1 is not Null and left(Friday1,charindex('-', Friday1)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOnDutyRuleChange", "Friday2='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Friday2<>'' and Friday2 is not Null and left(Friday2,charindex('-', Friday2)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOnDutyRuleChange", "Saturday1='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Saturday1<>'' and Saturday1 is not Null and left(Saturday1,charindex('-', Saturday1)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOnDutyRuleChange", "Saturday2='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Saturday2<>'' and Saturday2 is not Null and left(Saturday2,charindex('-', Saturday2)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOnDutyRuleChange", "Sunday1='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Sunday1<>'' and Sunday1 is not Null and left(Sunday1,charindex('-', Sunday1)-1)="+cstr(strId)
		''		ChangeInfoToTable "AttendanceOnDutyRuleChange", "Sunday2='"+cstr(strId)+"-"+cstr(strShiftName)+"'", " Sunday2<>'' and Sunday2 is not Null and left(Sunday2,charindex('-', Sunday2)-1)="+cstr(strId)
		''	end If
		''	ReturnErrMsg "", "parent.location.href='AttendShifts.asp?url_lpage="+CStr(lpage)+"';"
		
		Call fCloseADO()
		Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)
	end If
%>