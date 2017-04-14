<%
'获取计算周期的开始结束时间
'入口参数
'strYear               : 年
'strMonth              : 月
'返回值：  1为时间周期.    0为操作失败
Function GetStartEndDate( strYear, strMonth )
	GetStartEndDate=0
	
	dim StartDate,arrtotalcycle,EndDate,datDate,iday

	strSQL = "select convert(varchar(10),StartDate, 121) as StartDate,convert(varchar(10),EndDate, 121) as EndDate from TotalMonth where PostMonth='"+Trim(strYear)+"-"+Trim(strMonth)+"'"
	
	Rs.open strSQL, Conn, 1, 1
	If Not Rs.eof Then
		If Not IsNull(Rs("StartDate")) And Not IsNull(Rs("EndDate")) Then
			GetStartEndDate="'"+Trim(Rs("StartDate"))+"' and '"+Trim(Rs("EndDate"))+"'"
			Rs.close
			Exit function
		End If 
	End if
	Rs.close
				
	strSQL = "select * from Options where variablename='StrTotalCycle'"
	Rs.open strSQL, Conn, 1, 1

	datDate = GetDate(Trim(Year(date)),Trim(Month(date)),Trim(Day(date))) '当前日期

	If Not Rs.eof Then
		If Not IsNull(Rs("VariableValue")) Then
			arrtotalcycle = Split(Rs("VariableValue"), ",")
			If Left(arrtotalcycle(0), 1) = "0" Then
				iday = GetMonthDay( strYear, strMonth)
				If CInt(arrtotalcycle(1)) > CInt(iday) Then
					StartDate = GetDate(strYear, strMonth, iday)
				Else
					StartDate = GetDate(strYear, strMonth, arrtotalcycle(1))
				End if
			ElseIf Left(arrtotalcycle(0), 1) = "1" Then
				If strMonth="01" Or strMonth="1" Then
					StartDate = GetDate(cstr(CInt(strYear)-1), "12", cstr(arrtotalcycle(1)))
				Else
					iday=DateDiff("D",CStr(strYear)+"-"+CStr(CInt(strMonth)-1)+"-1",CStr(strYear)+"-"+CStr(strMonth)+"-1")
					If CInt(arrtotalcycle(1)) > CInt(iday) then
						StartDate = GetDate(cstr(strYear), cstr(cint(strMonth)-1), cstr(iday))
					Else
						StartDate = GetDate(cstr(strYear), cstr(cint(strMonth)-1), cstr(arrtotalcycle(1))) 
					End if
				End if
			End If

			If Left(arrtotalcycle(2), 1) = "0" Then
				iday = GetMonthDay( strYear, strMonth)
				If CInt(arrtotalcycle(3)) > CInt(iday) Then
					EndDate = GetDate(cstr(strYear),cstr(strMonth),cstr(iday))
				Else
					EndDate = GetDate(cstr(strYear),cstr(strMonth),cstr(arrtotalcycle(3)))
				End if
			ElseIf Left(arrtotalcycle(2), 1) = "1" Then
				If strMonth="01" Or strMonth="1" Then
					EndDate = GetDate(cstr(CInt(strYear)-1), "12", cstr(arrtotalcycle(3)))
				Else
					iday=DateDiff("D",CStr(strYear)+"-"+CStr(CInt(strMonth)-1)+"-1",CStr(strYear)+"-"+CStr(strMonth)+"-1")
					If CInt(arrtotalcycle(1)) > CInt(iday) then
						EndDate = GetDate(cstr(strYear), cstr(cint(strMonth)-1), cstr(iday))
					Else
						EndDate = GetDate(cstr(strYear), cstr(cint(strMonth)-1), cstr(arrtotalcycle(3))) 
					End if
				End if
			End If

		End if
	End If
	Rs.close
	If CDate(EndDate) < CDate(StartDate) Then
		GetStartEndDate="'' and ''"
		Exit function
	End If
	If CDate(datDate) > CDate(StartDate) And CDate(datDate) < CDate(EndDate) Then EndDate = datDate
	If CDate(datDate) < CDate(StartDate) Then
		GetStartEndDate="'' and ''"
		Exit Function
	End If
	GetStartEndDate="'"+trim(StartDate)+"' and '"+trim(EndDate)+"'"
End Function


'获取用户选择月份的天数
Function GetMonthDay( strYear, strMonth )
	GetMonthDay=0
	dim iday

	if strYear = "" or strMonth = "" then
		GetMonthDay =0
		exit function
	end If
	
	If CInt(strMonth)=12 then
		iday=DateDiff("D",CStr(strYear)+"-"+CStr(strMonth)+"-1",CStr(CInt(strYear)+1)+"-1-1")
	Else
		iday=DateDiff("D",CStr(strYear)+"-"+CStr(strMonth)+"-1",CStr(strYear)+"-"+CStr(CInt(strMonth)+1)+"-1")
	End If
	
	GetMonthDay = iday
End function

'求没有子部门的部门ID串
'入口参数
'lUserId (long)  : 用户ID
'返回值： 部门ID串
function GetChildDepart()
	GetChildDepart = ""
	dim strSQL
	dim strResult
	dim strPrev, strTemp
	strResult = ""
	strPrev = ""
	strTemp = ""
	strSQL = "select DepartmentCode From Departments order by DepartmentCode"
'	response.write strSQL
	ON ERROR RESUME NEXT
	Rs.open strSQL, Conn, 0, 1
	While NOT Rs.EOF
		if not isnull(Rs.fields("DepartmentCode").value) then
			strTemp = trim(Rs.fields("DepartmentCode").value)
			if len(strTemp) <= len(strPrev) then
				strResult = strResult + ",'" + strPrev + "'"
			'elseif len(strTemp) = len(strPrev) then
			end if
			strPrev = strTemp
		end if
		Rs.movenext
	wend
	Rs.close


	if strPrev <> "" then strResult = strResult + ",'" + strPrev + "'"
		
	if strResult <> "" then strResult = mid(strResult,2)

	GetChildDepart = strResult
end Function


Function GetDate(strYear, strMonth, strDay)
	GetDate = cstr(strYear) + "-" + cstr(strMonth) + "-" + cstr(strDay)
	
	If Len(strMonth) = 1 Then
		strMonth = "0" + cstr(strMonth)
	End If
	
	If Len(strDay) = 1 Then
		strDay = "0" + cstr(strDay)
	End If
	
	GetDate = cstr(strYear) + "-" + cstr(strMonth) + "-" + cstr(strDay)
End function

%>