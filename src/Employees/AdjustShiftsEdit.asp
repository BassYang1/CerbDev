<%Session.CodePage=65001%>
<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

'//*********************  Declare Values  **********************//
dim strFields, strValues, strFieldsTemp, strValuesTemp
dim strSQL, strOper
dim strShiftId, strShiftName, strStretchShift, strDegree, strNight, strFirstOnDuty, strShiftTime, strAonDuty
dim strAonDutyStart, strAonDutyEnd, strAoffDuty, strAoffDutyStart, strAoffDutyEnd, strArestTime, strBonDuty, strBonDutyStart
dim strBonDutyEnd, strBoffDuty, strBoffDutyStart, strBoffDutyEnd, strBrestTime, strConDuty, strConDutyStart, strConDutyEnd
dim strCoffDuty, strCoffDutyStart, strCoffDutyEnd, strCrestTime
dim strAdjustcheck, strAdjustDate
dim strDepartmentCode, strEmployeeCode, strDepartmentName, strEmployeeName, strEmployeeDesc, strDescription
dim TempTime
dim strRecordID

dim iChangeNameORNot
Dim iHaveNight, iIsAdd '覆盖标识
'//************************************************************//'"EmployeeWork"

strOper = Request.Form("oper")

if strOper<>"add" and strOper<>"edit" and strOper<>"del" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if

if GetOperRole("ShiftAdjustment",strOper) <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

strRecordID = Replace(Request.Form("id"),"'","''")

strShiftId = Replace(Request.Form("ShiftId"),"'","''")
strDepartmentCode = Replace(Request.Form("DepartmentCode"),"'","''")
strDepartmentName = Replace(Request.Form("DepartmentName"),"'","''")
strEmployeeCode = Replace(Request.Form("EmployeeCode"),"'","''")
strEmployeeName = Replace(Request.Form("EmployeeName"),"'","''")
strAdjustDate = Replace(Request.Form("AdjustDate"),"'","''")
strDescription = Replace(Request.Form("Description"),"'","''")

if strOper <> "del" then 
	'//************************************判断权限*******************************************

	if strDepartmentName <> "" then
		strEmployeeDesc = strEmployeeDesc & "," & strDepartmentName
	end if

	if strEmployeeName <> "" then
		strEmployeeDesc = strEmployeeDesc & "," & strEmployeeName
	end if

	if strEmployeeCode = "" and strDepartmentCode = "" and strEmployeeDesc = "" then	
		Call ReturnMsg("false",GetEmpLbl("AdjustShiftCondition"),0)'未设置班次调整员工条件
		response.End()
	end if

	if strEmployeeDesc <> "" then
		strEmployeeDesc = right(strEmployeeDesc, len(strEmployeeDesc) - 1)  '注册员工描述
	end if

	if strAdjustDate = "" OR CDate(strAdjustDate) < Date then
		Call ReturnMsg("false",GetEmpLbl("AdjustShiftDate_Invalid"),0)'未设置班次调整员工条件
		response.End()
	end if

	lpage = Trim(Request.QueryString("lpage"))
	'//***************************接收提交的数据************************************************
	strShiftName = trim(Request.form("ShiftName"))
	if strShiftName = "" Then  
		Call ReturnErrMsg(GetEmpLbl("ShiftNameNull")) '"[班次名称]不能为空"
	end if
	strShiftName = SetStringSafe(strShiftName) 

	strFirstOnDuty       = trim(Request.form("FirstOnDuty"))
	If strFirstOnDuty = "" Then strFirstOnDuty = 0

	'时间类型判断
	strShiftTime = trim(Request.form("ShiftTime"))
	if strShiftTime = "" Then
		Call ReturnErrMsg(GetEmpLbl("ShiftTimeNull")) '"标准工时不能为空"
	end if
	if not isnumeric(strShiftTime) then
		Call ReturnErrMsg(GetEmpLbl("ShiftTimeNull")) '"标准工时只能用数字"
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
		if strDegree = "" Then
			Call ReturnErrMsg(GetEmpLbl("DegreeNull")) '"[时段数]不能为空"
		end if
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
				If CDate(strAonDuty) < CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AOnDutyLtStartN")) '"第一次上班开始时间必须早于上班标准时间或您没选择［过夜］！"
				If CDate(strAonDutyEnd) < CDate(strAonDuty)       Then Call ReturnErrMsg(GetEmpLbl("AOnDutyLtEndN")) '"第一次上班标准时间必须早于上班截止时间或您没选择［过夜］！"
				If CDate(strAoffDutyStart) < CDate(strAonDutyEnd) Then Call ReturnErrMsg(GetEmpLbl("AOnDutyEndLtAoffDutyStartN")) '"第一次上班截止时间必须早于下班开始时间或您没选择［过夜］！"
				If CDate(strAoffDuty)   < CDate(strAoffDutyStart) Then Call ReturnErrMsg(GetEmpLbl("AoffDutyLtStartN")) '"第一次下班开始时间必须早于下班标准时间或您没选择［过夜］！"
				If CDate(strAoffDutyEnd)< CDate(strAoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("AoffDutyEndLtoffDutyN")) '"第一次下班标准时间必须早于下班截止时间或您没选择［过夜］！"
			Else
				If CDate(strAonDuty) < CDate(strAonDutyStart)  Then
					iHaveNight = 1
					If CDate(strAonDutyEnd) < CDate(strAonDuty)       Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndLtAonDuty")) '"第一次上班标准时间必须早于上班截止时间！"
					If CDate(strAonDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
					If CDate(strAoffDutyStart) < CDate(strAonDutyEnd) Then Call ReturnErrMsg(GetEmpLbl("AoffDutyStartLtAonDutyEnd")) '"第一次上班截止时间必须早于下班开始时间！"
					If CDate(strAoffDutyStart) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
					If CDate(strAoffDuty)   < CDate(strAoffDutyStart) Then Call ReturnErrMsg(GetEmpLbl("AoffDutyLtAoffDutyStart")) '"第一次下班开始时间必须早于下班标准时间！"
					If CDate(strAoffDuty) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
					If CDate(strAoffDutyEnd)< CDate(strAoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("AoffDutyEndLtAoffDuty")) '"第一次下班标准时间必须早于下班截止时间！"
					If CDate(strAoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
					
					'时间段是否加1,iflagA = 5 ,表示有5个时间段要加1 
					iflagA = "5"

				ElseIf CDate(strAonDutyEnd) < CDate(strAonDuty)   Then
					iHaveNight = 1
					If CDate(strAonDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
					If CDate(strAoffDutyStart) < CDate(strAonDutyEnd) Then Call ReturnErrMsg(GetEmpLbl("AoffDutyStartLtAonDutyEnd")) '"第一次上班截止时间必须早于下班开始时间！"
					If CDate(strAoffDutyStart) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
					If CDate(strAoffDuty)   < CDate(strAoffDutyStart) Then Call ReturnErrMsg(GetEmpLbl("AoffDutyLtAoffDutyStart")) '"第一次下班开始时间必须早于下班标准时间！"
					If CDate(strAoffDuty) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
					If CDate(strAoffDutyEnd)< CDate(strAoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("AoffDutyEndLtAoffDuty")) '"第一次下班标准时间必须早于下班截止时间！"
					If CDate(strAoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
					
					'
					iflagA = "4"
				ElseIf CDate(strAoffDutyStart) < CDate(strAonDutyEnd)   Then
					iHaveNight = 1
					If CDate(strAoffDutyStart) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"

					If CDate(strAoffDuty)   < CDate(strAoffDutyStart) Then Call ReturnErrMsg(GetEmpLbl("AoffDutyLtAoffDutyStart")) '"第一次下班开始时间必须早于下班标准时间！"
					If CDate(strAoffDuty) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
					If CDate(strAoffDutyEnd)< CDate(strAoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("AoffDutyEndLtAoffDuty")) '"第一次下班标准时间必须早于下班截止时间！"
					If CDate(strAoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"

					iflagA = "3"
				ElseIf CDate(strAoffDuty)   < CDate(strAoffDutyStart)   Then
					iHaveNight = 1
					If CDate(strAoffDuty) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
					If CDate(strAoffDutyEnd)< CDate(strAoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("AoffDutyEndLtAoffDuty")) '"第一次下班标准时间必须早于下班截止时间！"
					If CDate(strAoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"

					iflagA = "2"
				ElseIf CDate(strAoffDutyEnd)< CDate(strAoffDuty)   Then
					iHaveNight = 1
					If CDate(strAoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"

					iflagA = "1"
				End If
				
				'判断第一次开始时间到最后截止时间是否大于２４
				strSumTotal = Datediff("n", CDate(strAoffDutyEnd), CDate(strAonDutyStart))

				If abs(strSumTotal) > 1440 Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
		
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
				If CDate(strBonDutyStart) < CDate(strAoffDutyEnd)  Then Call ReturnErrMsg(GetEmpLbl("BonDutyStartLtAoffDutyEndN")) '"第一次下班截止时间必须早于第二次上班开始时间或您没选择［过夜］！"
				If CDate(strBonDuty) < CDate(strBonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("BOnDutyLtStartN")) '"第二次上班开始时间必须早于上班标准时间或您没选择［过夜］！"
				If CDate(strBonDutyEnd) < CDate(strBonDuty)       Then Call ReturnErrMsg(GetEmpLbl("BOnDutyLtEndN")) '"第二次上班标准时间必须早于上班截止时间或您没选择［过夜］！"
				If CDate(strBoffDutyStart) < CDate(strBonDutyEnd) Then Call ReturnErrMsg(GetEmpLbl("BOnDutyEndLtBoffDutyStartN")) '"第二次上班截止时间必须早于下班开始时间或您没选择［过夜］！"
				If CDate(strBoffDuty)   < CDate(strBoffDutyStart) Then Call ReturnErrMsg(GetEmpLbl("BoffDutyLtStartN")) '"第二次下班开始时间必须早于下班标准时间或您没选择［过夜］！"
				If CDate(strBoffDutyEnd)< CDate(strBoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("BoffDutyEndLtoffDutyN")) '"第二次下班标准时间必须早于下班截止时间或您没选择［过夜］！"
			Else
				'If CDate(strBonDutyStart)    = CDate(strAoffDutyEnd)  Then Call ReturnErrMsg("第一次下班截止时间不能等于第二次上班开始时间！",0)
				'If CDate(strBonDuty)    = CDate(strBonDutyStart)  Then Call ReturnErrMsg("第二次上班开始时间不能等于上班标准时间！",0)
				'If CDate(strBonDutyEnd) = CDate(strBonDuty)       Then Call ReturnErrMsg("第二次上班标准时间不能等于上班截止时间！",0)
				''If CDate(strBoffDutyStart) = CDate(strBonDutyEnd) Then Call ReturnErrMsg("第二次上班截止时间不能等于下班开始时间！",0)
				'If CDate(strBoffDuty)   = CDate(strBoffDutyStart) Then Call ReturnErrMsg("第二次下班开始时间不能等于下班标准时间！",0)
				'If CDate(strBoffDutyEnd)= CDate(strBoffDuty)      Then Call ReturnErrMsg("第二次下班标准时间不能等于下班截止时间！",0)

				If iHaveNight = 0 Then
					If CDate(strBonDutyStart) < CDate(strAoffDutyEnd) Then
						iHaveNight = 1
						If CDate(strBonDuty)    < CDate(strBonDutyStart) Then Call ReturnErrMsg(GetEmpLbl("BonDutyLtBonDutyStart")) '"第二次上班开始时间必须早于上班标准时间！"
						If CDate(strBonDuty) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBonDutyEnd) < CDate(strBonDuty)       Then Call ReturnErrMsg(GetEmpLbl("BonDutyEndLtBonDuty")) '"第二次上班标准时间必须早于上班截止时间！"
						If CDate(strBonDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDutyStart) < CDate(strBonDutyEnd) Then Call ReturnErrMsg(GetEmpLbl("BoffDutyStartLtBonDutyEnd")) '"第二次上班截止时间必须早于下班开始时间！"
						If CDate(strBoffDutyStart) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDuty)   < CDate(strBoffDutyStart) Then Call ReturnErrMsg(GetEmpLbl("BoffDutyLtBoffDutyStart")) '"第二次下班开始时间必须早于下班标准时间！"
						If CDate(strBoffDuty) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDutyEnd)< CDate(strBoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("BoffDutyEndLtBoffDuty")) '"第二次下班标准时间必须早于下班截止时间！"
						If CDate(strBoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"

						iflagB = "6"
					ElseIf CDate(strBonDuty)    < CDate(strBonDutyStart)  Then
						iHaveNight = 1
						If CDate(strBonDutyEnd) < CDate(strBonDuty)       Then Call ReturnErrMsg(GetEmpLbl("BonDutyEndLtBonDuty")) '"第二次上班标准时间必须早于上班截止时间！"
						If CDate(strBonDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDutyStart) < CDate(strBonDutyEnd) Then Call ReturnErrMsg(GetEmpLbl("BoffDutyStartLtBonDutyEnd")) '"第二次上班截止时间必须早于下班开始时间！"
						If CDate(strBoffDutyStart) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDuty)   < CDate(strBoffDutyStart) Then Call ReturnErrMsg(GetEmpLbl("BoffDutyLtBoffDutyStart")) '"第二次下班开始时间必须早于下班标准时间！"
						If CDate(strBoffDuty) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDutyEnd)< CDate(strBoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("BoffDutyEndLtBoffDuty")) '"第二次下班标准时间必须早于下班截止时间！"
						If CDate(strBoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"

						iflagB = "5"
					ElseIf CDate(strBonDutyEnd) < CDate(strBonDuty)   Then
						iHaveNight = 1
						If CDate(strBonDutyEnd) > CDate(strBonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDutyStart) < CDate(strBonDutyEnd) Then Call ReturnErrMsg(GetEmpLbl("BoffDutyStartLtBonDutyEnd")) '"第二次上班截止时间必须早于下班开始时间！"
						If CDate(strBoffDutyStart) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDuty)   < CDate(strBoffDutyStart) Then Call ReturnErrMsg(GetEmpLbl("BoffDutyLtBoffDutyStart")) '"第二次下班开始时间必须早于下班标准时间！"
						If CDate(strBoffDuty) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDutyEnd)< CDate(strBoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("BoffDutyEndLtBoffDuty")) '"第二次下班标准时间必须早于下班截止时间！"
						If CDate(strBoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"

						iflagB = "4"
					ElseIf CDate(strBoffDutyStart) < CDate(strBonDutyEnd)   Then
						iHaveNight = 1
						If CDate(strBoffDutyStart) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDuty)   < CDate(strBoffDutyStart) Then Call ReturnErrMsg(GetEmpLbl("BoffDutyLtBoffDutyStart")) '"第二次下班开始时间必须早于下班标准时间！"
						If CDate(strBoffDuty) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDutyEnd)< CDate(strBoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("BoffDutyEndLtBoffDuty")) '"第二次下班标准时间必须早于下班截止时间！"
						If CDate(strBoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
		
						iflagB = "3"
					ElseIf CDate(strBoffDuty)   < CDate(strBoffDutyStart)   Then
						iHaveNight = 1
						If CDate(strBoffDuty) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
						If CDate(strBoffDutyEnd)< CDate(strBoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("BoffDutyEndLtBoffDuty")) '"第二次下班标准时间必须早于下班截止时间！"
						If CDate(strBoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
				
						iflagB = "2"
					ElseIf CDate(strBoffDutyEnd)< CDate(strBoffDuty)   Then
						iHaveNight = 1
						If CDate(strBoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
						
						iflagB = "1"
					End If
				Else
					If CDate(strBonDutyStart) < CDate(strAoffDutyEnd)  Then Call ReturnErrMsg(GetEmpLbl("BonDutyStartLtAoffDutyEnd")) '"第一次下班截止时间必须早于第二次上班开始时间！"
					If CDate(strBonDuty)    < CDate(strBonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("BonDutyLtBonDutyStart")) '"第二次上班开始时间必须早于上班标准时间！""
					If CDate(strBonDutyEnd) < CDate(strBonDuty)       Then Call ReturnErrMsg(GetEmpLbl("BonDutyEndLtBonDuty")) '"第二次上班标准时间必须早于上班截止时间！"
					If CDate(strBoffDutyStart) < CDate(strBonDutyEnd) Then Call ReturnErrMsg(GetEmpLbl("BoffDutyStartLtBonDutyEnd")) '"第二次上班截止时间必须早于下班开始时间！"
					If CDate(strBoffDuty)   < CDate(strBoffDutyStart) Then Call ReturnErrMsg(GetEmpLbl("BoffDutyLtBoffDutyStart")) '"第二次下班开始时间必须早于下班标准时间！"
					If CDate(strBoffDutyEnd)< CDate(strBoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("BoffDutyEndLtBoffDuty")) '"第二次下班标准时间必须早于下班截止时间！"
				End If
				
				'判断第一次开始时间到最后截止时间是否大于２４
				strSumTotal = Datediff("n", CDate(strBoffDutyEnd), CDate(strAonDutyStart))

				If abs(strSumTotal) > 1440 Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '"一个班次的时间段必须在二十四小时之内！"
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
				If CDate(strConDutyStart) < CDate(strBoffDutyEnd)  Then Call ReturnErrMsg(GetEmpLbl("ConDutyStartLtBoffDutyEndN")) '"第二次下班截止时间必须早于第三次上班开始时间或您没选择［过夜］！"
				If CDate(strConDuty)    < CDate(strConDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("ConDutyLtConDutyStartN")) '"第三次上班开始时间必须早于上班标准时间或您没选择［过夜］！"
				If CDate(strConDutyEnd) < CDate(strConDuty)       Then Call ReturnErrMsg(GetEmpLbl("ConDutyEndLtConDutyN")) '"第三次上班标准时间必须早于上班截止时间或您没选择［过夜］！"
				If CDate(strCoffDutyStart) < CDate(strConDutyEnd) Then Call ReturnErrMsg(GetEmpLbl("CoffDutyStartLtConDutyEndN")) '"第三次上班截止时间必须早于下班开始时间或您没选择［过夜］！"
				If CDate(strCoffDuty)   < CDate(strCoffDutyStart) Then Call ReturnErrMsg(GetEmpLbl("CoffDutyLtCoffDutyStartN")) '"第三次下班开始时间必须早于下班标准时间或您没选择［过夜］！"
				If CDate(strCoffDutyEnd)< CDate(strCoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("CoffDutyEndLtCoffDutyN")) '"第三次下班标准时间必须早于下班截止时间或您没选择［过夜］！"
			Else
				'If CDate(strConDutyStart)    = CDate(strBoffDutyEnd)  Then Call ReturnErrMsg("第二次下班截止时间不能等于第三次上班开始时间！",0)
				'If CDate(strConDuty)    = CDate(strConDutyStart)  Then Call ReturnErrMsg("第三次上班开始时间不能等于上班标准时间！",0)
				'If CDate(strConDutyEnd) = CDate(strConDuty)       Then Call ReturnErrMsg("第三次上班标准时间不能等于上班截止时间！",0)
				'If CDate(strCoffDutyStart) = CDate(strConDutyEnd) Then Call ReturnErrMsg("第三次上班截止时间不能等于下班开始时间！",0)
				'If CDate(strCoffDuty)   = CDate(strCoffDutyStart) Then Call ReturnErrMsg("第三次下班开始时间不能等于下班标准时间！",0)
				'If CDate(strCoffDutyEnd)= CDate(strCoffDuty)      Then Call ReturnErrMsg("第三次下班标准时间不能等于下班截止时间！",0)

				If iHaveNight = 0 Then
					If CDate(strConDutyStart) < CDate(strBoffDutyEnd) Then
						iHaveNight = 1
						If CDate(strConDuty)    < CDate(strConDutyStart) Then Call ReturnErrMsg(GetEmpLbl("ConDutyLtConDutyStart")) '第三次上班开始时间必须早于上班标准时间！"
						If CDate(strConDuty) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
						If CDate(strConDutyEnd) < CDate(strConDuty)       Then Call ReturnErrMsg(GetEmpLbl("ConDutyEndLtConDuty")) '第三次上班标准时间必须早于上班截止时间！"
						If CDate(strConDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDutyStart) < CDate(strConDutyEnd) Then Call ReturnErrMsg(GetEmpLbl("CoffDutyStartLtConDutyEnd")) '第三次上班截止时间必须早于下班开始时间！"
						If CDate(strCoffDutyStart) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDuty)   < CDate(strCoffDutyStart) Then Call ReturnErrMsg(GetEmpLbl("CoffDutyLtCoffDutyStart")) '第三次下班开始时间必须早于下班标准时间！"
						If CDate(strCoffDuty) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDutyEnd)< CDate(strCoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("CoffDutyEndLtCoffDuty")) '第三次下班标准时间必须早于下班截止时间！"
						If CDate(strCoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"

						iflagC = "6"	
					ElseIf CDate(strConDuty)    < CDate(strConDutyStart)  Then
						iHaveNight = 1
						If CDate(strConDutyEnd) < CDate(strConDuty)       Then Call ReturnErrMsg(GetEmpLbl("ConDutyEndLtConDuty")) '第三次上班标准时间必须早于上班截止时间！"
						If CDate(strConDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDutyStart) < CDate(strConDutyEnd) Then Call ReturnErrMsg(GetEmpLbl("CoffDutyStartLtConDutyEnd")) '第三次上班截止时间必须早于下班开始时间！"
						If CDate(strCoffDutyStart) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDuty)   < CDate(strCoffDutyStart) Then Call ReturnErrMsg(GetEmpLbl("CoffDutyLtCoffDutyStart")) '第三次下班开始时间必须早于下班标准时间！"
						If CDate(strCoffDuty) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDutyEnd)< CDate(strCoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("CoffDutyEndLtCoffDuty")) '第三次下班标准时间必须早于下班截止时间！"
						If CDate(strCoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"


						iflagC = "5"
					ElseIf CDate(strConDutyEnd) < CDate(strConDuty)   Then
						iHaveNight = 1
						If CDate(strConDutyEnd) > CDate(strConDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDutyStart) < CDate(strConDutyEnd) Then Call ReturnErrMsg(GetEmpLbl("CoffDutyStartLtConDutyEnd")) '第三次上班截止时间必须早于下班开始时间！"
						If CDate(strCoffDutyStart) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDuty)   < CDate(strCoffDutyStart) Then Call ReturnErrMsg(GetEmpLbl("CoffDutyLtCoffDutyStart")) '第三次下班开始时间必须早于下班标准时间！"
						If CDate(strCoffDuty) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDutyEnd)< CDate(strCoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("CoffDutyEndLtCoffDuty")) '第三次下班标准时间必须早于下班截止时间！"
						If CDate(strCoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
			
						iflagC = "4"
					ElseIf CDate(strCoffDutyStart) < CDate(strConDutyEnd)   Then
						iHaveNight = 1
						If CDate(strCoffDutyStart) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDuty)   < CDate(strCoffDutyStart) Then Call ReturnErrMsg(GetEmpLbl("CoffDutyLtCoffDutyStart")) '第三次下班开始时间必须早于下班标准时间！"
						If CDate(strCoffDuty) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDutyEnd)< CDate(strCoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("CoffDutyEndLtCoffDuty")) '第三次下班标准时间必须早于下班截止时间！"
						If CDate(strCoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"

						iflagC = "3"
					ElseIf CDate(strCoffDuty)   < CDate(strCoffDutyStart)   Then
						iHaveNight = 1
						If CDate(strCoffDuty) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
						If CDate(strCoffDutyEnd)< CDate(strCoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("CoffDutyEndLtCoffDuty")) '第三次下班标准时间必须早于下班截止时间！"
						If CDate(strCoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
			
						iflagC = "2"
					ElseIf CDate(strCoffDutyEnd)< CDate(strCoffDuty)   Then
						iHaveNight = 1
						If CDate(strCoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
		
						iflagC = "1"
					End If
				Else
					If CDate(strConDutyStart) < CDate(strBoffDutyEnd)  Then Call ReturnErrMsg(GetEmpLbl("ConDutyStartLtBoffDutyEnd")) '第二次下班截止时间必须早于第三次上班开始时间！"
					If CDate(right(strConDutyStart,8)) >= CDate( right(strAonDutyStart,8) )  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"

					If CDate(strConDuty)    < CDate(strConDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("ConDutyLtConDutyStart")) '第三次上班开始时间必须早于上班标准时间！"
					If CDate( Right(strConDuty,8) ) >= CDate( right(strAonDutyStart,8) ) Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"

					If CDate(strConDutyEnd) < CDate(strConDuty)       Then Call ReturnErrMsg(GetEmpLbl("ConDutyEndLtConDuty")) '第三次上班标准时间必须早于上班截止时间！"
					If CDate( Right(strConDutyEnd,8) ) >= CDate( right(strAonDutyStart,8) ) Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"

					If CDate(strCoffDutyStart) < CDate(strConDutyEnd) Then Call ReturnErrMsg(GetEmpLbl("CoffDutyStartLtConDutyEnd")) '第三次上班截止时间必须早于下班开始时间！"
					If CDate( Right(strCoffDutyStart,8) ) >= CDate( right(strAonDutyStart,8) ) Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"

					If CDate(strCoffDuty)   < CDate(strCoffDutyStart) Then Call ReturnErrMsg(GetEmpLbl("CoffDutyLtCoffDutyStart")) '第三次下班开始时间必须早于下班标准时间！"
					If CDate( Right(strCoffDuty,8) ) >= CDate( right(strAonDutyStart,8) ) Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"

					If CDate(strCoffDutyEnd)< CDate(strCoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("CoffDutyEndLtCoffDuty")) '第三次下班标准时间必须早于下班截止时间！"
					If CDate( Right(strCoffDutyEnd,8) ) >= CDate( right(strAonDutyStart,8) ) Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
				End If
				
				'判断第一次开始时间到最后截止时间是否大于２４
				strSumTotal = Datediff("n", CDate(strCoffDutyEnd), CDate(strAonDutyStart))
				If abs(strSumTotal) > 1440 Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！",0)
			End If


		end If

		''If CInt(strNight) <> 0 And iHaveNight = 0 Then   '非过夜
		''	Call ReturnErrMsg("输入数据不符合过夜要求！"
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
			If CDate(strAonDuty)    < CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("StretchOnDutyLtOnDutyStart")) '弹性班上班开始时间必须早于上班标准时间！"
			If CDate(strAoffDuty)   < CDate(strAonDuty)       Then Call ReturnErrMsg(GetEmpLbl("StretchOffDutyLtOnDuty")) '弹性班上班标准时间必须早于下班标准时间！"
			If CDate(strAoffDutyEnd)< CDate(strAoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("StretchOffDutyEndLtOffDuty")) '弹性班下班标准时间必须早于下班截止时间！"

			strAonDutyStart = CStr(TempTime) + " " + CStr(strAonDutyStart)
			strAonDuty      = CStr(TempTime) + " " + CStr(strAonDuty)
			strAoffDuty     = CStr(TempTime) + " " + CStr(strAoffDuty)
			strAoffDutyEnd  = CStr(TempTime) + " " + CStr(strAoffDutyEnd)

			strAonDutyStart = "DateAdd(day, 0, '"+strAonDutyStart+"')"
			strAonDuty = "DateAdd(day, 0, '"+strAonDuty+"')"
			strAoffDuty = "DateAdd(day, 0, '"+strAoffDuty+"')"
			strAoffDutyEnd = "DateAdd(day, 0, '"+strAoffDutyEnd+"')"
		Else
			''If CDate(strAonDuty)    = CDate(strAonDutyStart)  Then Call ReturnErrMsg("弹性班上班开始时间不能等于上班标准时间！",0)
			''If CDate(strAonDuty)   = CDate(strAoffDuty)      Then Call ReturnErrMsg("弹性班上班标准时间不能等于下班标准时间！",0)
			''If CDate(strAoffDutyEnd)= CDate(strAoffDuty)      Then Call ReturnErrMsg("弹性班下班标准时间不能等于下班截止时间！",0)
			''If CInt(strFirstOnDuty) = 1 Then TempTime = PTempTime

			If CDate(strAonDuty)    < CDate(strAonDutyStart)  Then
				iHaveNight = 1

				If CDate(strAonDuty)   < CDate(strAoffDuty) Then Call ReturnErrMsg(GetEmpLbl("StretchOnDutyLtOffDuty")) '弹性班下班标准时间必须早于上班标准时间！"
				If CDate(strAoffDuty) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
				If CDate(strAoffDutyEnd)< CDate(strAoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("StretchOffDutyEndLtOffDuty")) '弹性班下班标准时间必须早于下班截止时间！"
				If CDate(strAoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
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
				If CDate(strAoffDuty) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"

				If CDate(strAoffDutyEnd)< CDate(strAoffDuty)      Then Call ReturnErrMsg(GetEmpLbl("StretchOffDutyEndLtOffDuty")) '弹性班下班标准时间必须早于下班截止时间！"
				If CDate(strAoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
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
				If CDate(strAoffDutyEnd) > CDate(strAonDutyStart)  Then Call ReturnErrMsg(GetEmpLbl("AonDutyEndMtAonDutyStart")) '一个班次的时间段必须在二十四小时之内！"
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
			If iHaveNight = 0 Then Call ReturnErrMsg(GetEmpLbl("DataIllegal")) '输入数据不符合过夜要求！"
			
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
end if

Call fConnectADODB()

'判断模板名称是否存在
strSQL=""

Select Case strOper
	Case "add": 'Add Record
		if cint(strStretchShift) = 0 then   '固定班次
			if cint(strDegree) = 1 then     '时间段1
				strFieldsTemp = "ShiftType,AdjustDate,Description,EmployeeDesc,DepartmentCode,EmployeeCode,ShiftId,ShiftName,StretchShift,Degree,Night, FirstOnDuty,ShiftTime, AonDuty,AonDutyStart,AonDutyEnd, AoffDuty, AoffDutyStart, AoffDutyEnd, AcalculateLate,AcalculateEarly, ArestTime"
				strValuesTemp = cstr(strFirstOnDuty)+",'"+cstr(strAdjustDate)+"','"+cstr(strDescription)+"','"+cstr(strEmployeeDesc)+"','"+cstr(strDepartmentCode)+"','"+cstr(strEmployeeCode)+"',"+cstr(strShiftId)+",'"+cstr(strShiftName)+"', "+cstr(strStretchShift)+", "+cstr(strDegree)+", "+cstr(strNight)+", "+cstr(strFirstOnDuty)+","+cstr(strShiftTime)+","+cstr(strAonDuty)+", "+cstr(strAonDutyStart)+", "+cstr(strAonDutyEnd)+","+cstr(strAoffDuty)+","+cstr(strAoffDutyStart)+","+cstr(strAoffDutyEnd)+","+cstr(strAcalculateLate)+","+CStr(strAcalculateEarly)+","+CStr(strArestTime)
			ElseIf cint(strDegree) = 2 then     '时间段2
				strFieldsTemp = "ShiftType,AdjustDate,Description,EmployeeDesc,DepartmentCode,EmployeeCode,ShiftId,ShiftName,StretchShift,Degree,Night, FirstOnDuty,ShiftTime, AonDuty,AonDutyStart,AonDutyEnd, AoffDuty, AoffDutyStart, AoffDutyEnd, AcalculateLate,AcalculateEarly, ArestTime, BonDuty, BonDutyStart, BonDutyEnd, BoffDuty, BoffDutyStart, BoffDutyEnd, BcalculateLate,BcalculateEarly, BrestTime"
				strValuesTemp = cstr(strFirstOnDuty)+",'"+cstr(strAdjustDate)+"','"+cstr(strDescription)+"','"+cstr(strEmployeeDesc)+"','"+cstr(strDepartmentCode)+"','"+cstr(strEmployeeCode)+"',"+cstr(strShiftId)+",'"+cstr(strShiftName)+"', "+cstr(strStretchShift)+", "+cstr(strDegree)+", "+cstr(strNight)+", "+cstr(strFirstOnDuty)+","+cstr(strShiftTime)+","+cstr(strAonDuty)+", "+cstr(strAonDutyStart)+", "+cstr(strAonDutyEnd)+","+cstr(strAoffDuty)+","+cstr(strAoffDutyStart)+","+cstr(strAoffDutyEnd)+","+cstr(strAcalculateLate)+","+CStr(strAcalculateEarly)+","+CStr(strArestTime)+", "+cstr(strBonDuty)+", "+cstr(strBonDutyStart)+", "+cstr(strBonDutyEnd)+","+cstr(strBoffDuty)+","+cstr(strBoffDutyStart)+","+cstr(strBoffDutyEnd)+","+cstr(strBcalculateLate)+","+CStr(strBcalculateEarly)+","+CStr(strBrestTime)
			Else		
				strFieldsTemp = "ShiftType,AdjustDate,Description,EmployeeDesc,DepartmentCode,EmployeeCode,ShiftId,ShiftName,StretchShift,Degree,Night, FirstOnDuty,ShiftTime, AonDuty,AonDutyStart,AonDutyEnd, AoffDuty, AoffDutyStartq AoffDutyEnd, AcalculateLate,AcalculateEarly, ArestTime, BonDuty, BonDutyStart, BonDutyEnd, BoffDuty, BoffDutyStart, BoffDutyEnd, BcalculateLate,BcalculateEarly, BrestTime, ConDuty, ConDutyStart, ConDutyEnd, CoffDuty, CoffDutyStart, CoffDutyEnd, CcalculateLate,CcalculateEarly, CrestTime"
				strValuesTemp = cstr(strFirstOnDuty)+",'"+cstr(strAdjustDate)+"','"+cstr(strDescription)+"','"+cstr(strEmployeeDesc)+"','"+cstr(strDepartmentCode)+"','"+cstr(strEmployeeCode)+"',"+cstr(strShiftId)+",'"+cstr(strShiftName)+"', "+cstr(strStretchShift)+", "+cstr(strDegree)+", "+cstr(strNight)+", "+cstr(strFirstOnDuty)+","+cstr(strShiftTime)+","+cstr(strAonDuty)+","+cstr(strAonDutyStart)+", "+cstr(strAonDutyEnd)+","+cstr(strAoffDuty)+","+cstr(strAoffDutyStart)+","+cstr(strAoffDutyEnd)+","+cstr(strAcalculateLate)+","+CStr(strAcalculateEarly)+","+CStr(strArestTime)+", "+cstr(strBonDuty)+", "+cstr(strBonDutyStart)+", "+cstr(strBonDutyEnd)+","+cstr(strBoffDuty)+","+cstr(strBoffDutyStart)+","+cstr(strBoffDutyEnd)+","+cstr(strBcalculateLate)+","+CStr(strBcalculateEarly)+","+CStr(strBrestTime)+", "+cstr(strConDuty)+", "+cstr(strConDutyStart)+", "+cstr(strConDutyEnd)+","+cstr(strCoffDuty)+","+cstr(strCoffDutyStart)+","+cstr(strCoffDutyEnd)+","+cstr(strCcalculateLate)+","+CStr(strCcalculateEarly)+","+CStr(strCrestTime)
			End if
		Else
			strFieldsTemp = "ShiftType,AdjustDate,Description,EmployeeDesc,DepartmentCode,EmployeeCode,ShiftId,ShiftName,StretchShift,Degree,Night, FirstOnDuty,ShiftTime, AonDuty,AonDutyStart,AoffDuty, AoffDutyEnd, AcalculateLate,AcalculateEarly, ArestTime"
			strValuesTemp = cstr(strFirstOnDuty)+",'"+cstr(strAdjustDate)+"','"+cstr(strDescription)+"','"+cstr(strEmployeeDesc)+"','"+cstr(strDepartmentCode)+"','"+cstr(strEmployeeCode)+"',"+cstr(strShiftId)+",'"+cstr(strShiftName)+"', "+cstr(strStretchShift)+", "+cstr(strDegree)+", "+cstr(strNight)+", "+cstr(strFirstOnDuty)+","+cstr(strShiftTime)+","+cstr(strAonDuty)+", "+cstr(strAonDutyStart)+", "+cstr(strAoffDuty)+","+cstr(strAoffDutyEnd)+","+cstr(strAcalculateLate)+","+CStr(strAcalculateEarly)+","+CStr(strArestTime)
		End If

 		strSQL = "INSERT INTO TempShifts(" & strFieldsTemp & ") VALUES(" & strValuesTemp & ") "
	Case "edit": 'Edit Record             '修改
		if strRecordID = "" or not isnumeric(strRecordID) then
			Call ReturnErrMsg(GetEmpLbl("IllegalOperate")) '非法操作！"
		end if

		if cint(strStretchShift) = 0 then   '固定班次
			if cint(strDegree) = 1 then     '时间段1
				strFieldsTemp = "ShiftType="+cstr(strFirstOnDuty) + ",AdjustDate='"+cstr(strAdjustDate) + "',Description='" + cstr(strDescription)+ "',EmployeeDesc='"+cstr(strEmployeeDesc) + "',DepartmentCode='"+cstr(strDepartmentCode) + "',EmployeeCode='"+cstr(strEmployeeCode) + "',ShiftId="+cstr(strShiftId) + ",ShiftName='"+cstr(strShiftName) + "', StretchShift="+cstr(strStretchShift)+",Degree="+cstr(strDegree)+",Night="+cstr(strNight)+", FirstOnDuty="+cstr(strFirstOnDuty)+",ShiftTime="+cstr(strShiftTime)+ ", AonDuty="+cstr(strAonDuty)+",AonDutyStart="+cstr(strAonDutyStart)+",AonDutyEnd="+cstr(strAonDutyEnd)+", AoffDuty="+cstr(strAoffDuty)+", AoffDutyStart="+cstr(strAoffDutyStart)+", AoffDutyEnd="+cstr(strAoffDutyEnd)+", AcalculateLate="+cstr(strAcalculateLate)+", AcalculateEarly="+cstr(strAcalculateEarly)+", ArestTime="+cstr(strArestTime)+", BonDuty=null, BonDutyStart=null, BonDutyEnd=null, BoffDuty=null, BoffDutyStart=null, BoffDutyEnd=null, BcalculateLate=null, BcalculateEarly=null, BrestTime=null, ConDuty=null, ConDutyStart=null, ConDutyEnd=null, CoffDuty=null, CoffDutyStart=null, CoffDutyEnd=null, CcalculateLate=null, CcalculateEarly=null, CrestTime=null "
			ElseIf cint(strDegree) = 2 then     '时间段2
				strFieldsTemp = "ShiftType="+cstr(strFirstOnDuty) + ",AdjustDate='"+cstr(strAdjustDate) + "',Description='" + cstr(strDescription)+ "',EmployeeDesc='"+cstr(strEmployeeDesc) + "',DepartmentCode='"+cstr(strDepartmentCode) + "',EmployeeCode='"+cstr(strEmployeeCode) + "',ShiftId="+cstr(strShiftId) + ",ShiftName='"+cstr(strShiftName) + "', StretchShift="+cstr(strStretchShift)+",Degree="+cstr(strDegree)+",Night="+cstr(strNight)+", FirstOnDuty="+cstr(strFirstOnDuty)+",ShiftTime="+cstr(strShiftTime)+ ", AonDuty="+cstr(strAonDuty)+",AonDutyStart="+cstr(strAonDutyStart)+",AonDutyEnd="+cstr(strAonDutyEnd)+", AoffDuty="+cstr(strAoffDuty)+", AoffDutyStart="+cstr(strAoffDutyStart)+", AoffDutyEnd="+cstr(strAoffDutyEnd)+", AcalculateLate="+cstr(strAcalculateLate)+", AcalculateEarly="+cstr(strAcalculateEarly)+", ArestTime="+cstr(strArestTime)+", BonDuty="+cstr(strBonDuty)+", BonDutyStart="+cstr(strBonDutyStart)+", BonDutyEnd="+cstr(strBonDutyEnd)+", BoffDuty="+cstr(strBoffDuty)+", BoffDutyStart="+cstr(strBoffDutyStart)+", BoffDutyEnd="+cstr(strBoffDutyEnd)+", BcalculateLate="+cstr(strBcalculateLate)+", BcalculateEarly="+cstr(strBcalculateEarly)+", BrestTime="+cstr(strBrestTime)+", ConDuty=null, ConDutyStart=null, ConDutyEnd=null, CoffDuty=null, CoffDutyStart=null, CoffDutyEnd=null, CcalculateLate=null, CcalculateEarly=null, CrestTime=null "
			Else
				strFieldsTemp = "ShiftType="+cstr(strFirstOnDuty) + ",AdjustDate='"+cstr(strAdjustDate) + "',Description='" + cstr(strDescription)+ "',EmployeeDesc='"+cstr(strEmployeeDesc) + "',DepartmentCode='"+cstr(strDepartmentCode) + "',EmployeeCode='"+cstr(strEmployeeCode) + "',ShiftId="+cstr(strShiftId) + ",ShiftName='"+cstr(strShiftName) + "', StretchShift="+cstr(strStretchShift)+",Degree="+cstr(strDegree)+",Night="+cstr(strNight)+", FirstOnDuty="+cstr(strFirstOnDuty)+",ShiftTime="+cstr(strShiftTime)+ ", AonDuty="+cstr(strAonDuty)+",AonDutyStart="+cstr(strAonDutyStart)+",AonDutyEnd="+cstr(strAonDutyEnd)+", AoffDuty="+cstr(strAoffDuty)+", AoffDutyStart="+cstr(strAoffDutyStart)+", AoffDutyEnd="+cstr(strAoffDutyEnd)+", AcalculateLate="+cstr(strAcalculateLate)+", AcalculateEarly="+cstr(strAcalculateEarly)+", ArestTime="+cstr(strArestTime)+", BonDuty="+cstr(strBonDuty)+", BonDutyStart="+cstr(strBonDutyStart)+", BonDutyEnd="+cstr(strBonDutyEnd)+", BoffDuty="+cstr(strBoffDuty)+", BoffDutyStart="+cstr(strBoffDutyStart)+", BoffDutyEnd="+cstr(strBoffDutyEnd)+", BcalculateLate="+cstr(strBcalculateLate)+", BcalculateEarly="+cstr(strBcalculateEarly)+", BrestTime="+cstr(strBrestTime)+", ConDuty="+cstr(strConDuty)+", ConDutyStart="+cstr(strConDutyStart)+", ConDutyEnd="+cstr(strConDutyEnd)+", CoffDuty="+cstr(strCoffDuty)+", CoffDutyStart="+cstr(strCoffDutyStart)+", CoffDutyEnd="+cstr(strCoffDutyEnd)+", CcalculateLate="+cstr(strCcalculateLate)+", CcalculateEarly="+cstr(strCcalculateEarly)+", CrestTime="+cstr(strCrestTime)
			End If
		Else
			strFieldsTemp = "ShiftType="+cstr(strFirstOnDuty) + ",AdjustDate='"+cstr(strAdjustDate) + "',Description='" + cstr(strDescription)+ "',EmployeeDesc='"+cstr(strEmployeeDesc) + "',DepartmentCode='"+cstr(strDepartmentCode) + "',EmployeeCode='"+cstr(strEmployeeCode) + "',ShiftId="+cstr(strShiftId) + ",ShiftName='"+cstr(strShiftName) + "', StretchShift="+cstr(strStretchShift)+",Degree="+cstr(strDegree)+",Night="+cstr(strNight)+", FirstOnDuty="+cstr(strFirstOnDuty)+",ShiftTime="+cstr(strShiftTime)+ ", AonDuty="+cstr(strAonDuty)+",AonDutyStart="+cstr(strAonDutyStart)+",AonDutyEnd=null, AoffDuty="+cstr(strAoffDuty)+", AoffDutyStart=null, AoffDutyEnd="+cstr(strAoffDutyEnd)+", AcalculateLate="+cstr(strAcalculateLate)+", AcalculateEarly="+cstr(strAcalculateEarly)+", ArestTime="+cstr(strArestTime)+", BonDuty=null, BonDutyStart=null, BonDutyEnd=null, BoffDuty=null, BoffDutyStart=null, BoffDutyEnd=null, BcalculateLate=null, BcalculateEarly=null, BrestTime=null, ConDuty=null, ConDutyStart=null, ConDutyEnd=null, CoffDuty=null, CoffDutyStart=null, CoffDutyEnd=null, CcalculateLate=null, CcalculateEarly=null, CrestTime=null "
		End If

		strSQL = "Update TempShifts set " + cstr(strFieldsTemp) + " where TempShiftID=" + cstr(strRecordID) + ";"
	Case "del": 'Delete Record
		if strRecordID = "" or not isnumeric(strRecordID) then
			Call ReturnErrMsg(GetEmpLbl("IllegalOperate")) '非法操作！"
		end if

		strSQL = " Delete From TempShifts where TempShiftID in ("&strRecordID&") "
End Select

'response.write strSQL
'response.end

if	strSQL<>"" then 
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",Err.Description,0)
		On Error GoTo 0
		response.End()
	end if
	
	Select Case strOper
		Case "add": 'Add Record		
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("Attend")&"-"&GetEmpLbl("ShiftsAdjustment"),cstr(GetCerbLbl("strLogAdd")),cstr(GetCerbLbl("strLogAdd"))&GetEmpLbl("ShiftsAdjustment")&","&GetEmpLbl("ShiftName")&"["&cstr(strShiftName)&"]")
		Case "edit": 'Edit Record
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("Attend")&"-"&GetEmpLbl("ShiftsAdjustment"),cstr(GetCerbLbl("strLogEdit")),cstr(GetCerbLbl("strLogEdit"))&GetEmpLbl("ShiftsAdjustment")&","&GetEmpLbl("ShiftName")&"["&cstr(strShiftName)&"]")
		Case "del": 'Delete Record
			strActions = GetCerbLbl("strLogDel")
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("Attend")&"-"&GetEmpLbl("ShiftsAdjustment"),cstr(GetCerbLbl("strLogDel")),cstr(GetCerbLbl("strLogDel"))&GetEmpLbl("ShiftsAdjustment")&",ID["&strRecordID&"]")
	End Select
	
	Call fCloseADO()
	Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)	'"执行成功"
else
	Call fCloseADO()
	Call ReturnErrMsg(GetEmpLbl("PartError")) '"参数错误"
end if
%>