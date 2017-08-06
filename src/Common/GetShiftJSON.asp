<!--#include file="Page.asp" -->
<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<%
dim strUserId
dim strSQL,strJS

strUserId = Cstr(Trim(Request.QueryString("userId")))
if strUserId = "" then strUserId = "0" end if

dim strShiftId, strOper
strShiftId = Cstr(Trim(Request.QueryString("id")))
strOper = Cstr(Trim(Request.QueryString("oper")))

fConnectADODB()

if lcase(strOper) = "shiftlist" then
	strSQL = "select(select '{"&chr(34)&"id"&chr(34)&":"&chr(34)&"'+ CAST(ShiftId AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"name"&chr(34)&":"&chr(34)&"' + ShiftName + '"&chr(34)&"},' from AttendanceShifts order by ShiftId DESC for xml path('')) JsonData"


	Rs.open strSQL, Conn, 2, 1
	strJS = "["

	If Not Rs.eof Then
		strJS = strJS & Trim(Rs.fields(0).value)
	End If

	Rs.close
	if len(strJS) >= 2 then 
		strJS=left(strJS,InStrRev(strJS,",")-1)
	end if
	strJS=strJS & "]"

	response.write strJS
elseif lcase(strOper) = "shiftdetail" then
	if strShiftId <> "" then
		strSQL = "select(select '{"

		strSQL = strSQL&chr(34)&"ShiftId"&chr(34)&":"&chr(34)&"'+ CAST(ShiftId AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"ShiftName"&chr(34)&":"&chr(34)&"' + ShiftName + '"&chr(34)&","&chr(34)&"StretchShift"&chr(34)&":"&chr(34)&"' + (case when StretchShift = 1 then '1' else '0' end) + '"&chr(34)&","&chr(34)&"ShiftTime"&chr(34)&":"&chr(34)&"' + CAST(ShiftTime AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"Degree"&chr(34)&":"&chr(34)&"' + CAST(Degree AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"Night"&chr(34)&":"&chr(34)&"' + (case when Night = 1 then '1' else '0' end) + '"&chr(34)&","&chr(34)&"FirstOnDuty"&chr(34)&":"&chr(34)&"' + CAST(FirstOnDuty AS NVARCHAR(10)) + '"&chr(34)&","
		
		strSQL = strSQL&chr(34)&"AonDuty"&chr(34)&":"&chr(34)&"' + RTRIM(ISNULL(CONVERT(CHAR(5),AonDuty,108), '')) + '"&chr(34)&","&chr(34)&"AonDutyStart"&chr(34)&":"&chr(34)&"' + RTRIM(ISNULL(CONVERT(CHAR(5),AonDutyStart,108), '')) + '"&chr(34)&","&chr(34)&"AonDutyEnd"&chr(34)&":"&chr(34)&"' + RTRIM(ISNULL(CONVERT(CHAR(5),AonDutyEnd,108), '')) + '"&chr(34)&","&chr(34)&"AoffDuty"&chr(34)&":"&chr(34)&"' + RTRIM(ISNULL(CONVERT(CHAR(5),AoffDuty,108), '')) + '"&chr(34)&","&chr(34)&"AoffDutyStart"&chr(34)&":"&chr(34)&"' + RTRIM(ISNULL(CONVERT(CHAR(5),AoffDutyStart,108), '')) + '"&chr(34)&","&chr(34)&"AoffDutyEnd"&chr(34)&":"&chr(34)&"' + RTRIM(ISNULL(CONVERT(CHAR(5),AoffDutyEnd,108), '')) + '"&chr(34)&","&chr(34)&"AcalculateLate"&chr(34)&":"&chr(34)&"' + ISNULL(CAST(AcalculateLate AS NVARCHAR(10)), '') + '"&chr(34)&","&chr(34)&"AcalculateEarly"&chr(34)&":"&chr(34)&"' + ISNULL(CAST(AcalculateEarly AS NVARCHAR(10)), '') + '"&chr(34)&","&chr(34)&"ArestTime"&chr(34)&":"&chr(34)&"' + ISNULL(CAST(ArestTime AS NVARCHAR(10)), '') + '"&chr(34)&","

		strSQL = strSQL&chr(34)&"BonDuty"&chr(34)&":"&chr(34)&"' + RTRIM(ISNULL(CONVERT(CHAR(5),BonDuty,108), '')) + '"&chr(34)&","&chr(34)&"BonDutyStart"&chr(34)&":"&chr(34)&"' + RTRIM(ISNULL(CONVERT(CHAR(5),BonDutyStart,108), '')) + '"&chr(34)&","&chr(34)&"BonDutyEnd"&chr(34)&":"&chr(34)&"' + RTRIM(ISNULL(CONVERT(CHAR(5),BonDutyEnd,108), '')) + '"&chr(34)&","&chr(34)&"BoffDuty"&chr(34)&":"&chr(34)&"' + RTRIM(ISNULL(CONVERT(CHAR(5),BoffDuty,108), '')) + '"&chr(34)&","&chr(34)&"BoffDutyStart"&chr(34)&":"&chr(34)&"' + RTRIM(ISNULL(CONVERT(CHAR(5),BoffDutyStart,108), '')) + '"&chr(34)&","&chr(34)&"BoffDutyEnd"&chr(34)&":"&chr(34)&"' + RTRIM(ISNULL(CONVERT(CHAR(5),BoffDutyEnd,108), '')) + '"&chr(34)&","&chr(34)&"BcalculateLate"&chr(34)&":"&chr(34)&"' + ISNULL(CAST(BcalculateLate AS NVARCHAR(10)), '') + '"&chr(34)&","&chr(34)&"BcalculateEarly"&chr(34)&":"&chr(34)&"' + ISNULL(CAST(BcalculateEarly AS NVARCHAR(10)), '') + '"&chr(34)&","&chr(34)&"BrestTime"&chr(34)&":"&chr(34)&"' + ISNULL(CAST(BrestTime AS NVARCHAR(10)), '') + '"&chr(34)&","

		strSQL = strSQL&chr(34)&"ConDuty"&chr(34)&":"&chr(34)&"' + RTRIM(ISNULL(CONVERT(CHAR(5),ConDuty,108), '')) + '"&chr(34)&","&chr(34)&"ConDutyStart"&chr(34)&":"&chr(34)&"' + RTRIM(ISNULL(CONVERT(CHAR(5),ConDutyStart,108), '')) + '"&chr(34)&","&chr(34)&"ConDutyEnd"&chr(34)&":"&chr(34)&"' + RTRIM(ISNULL(CONVERT(CHAR(5),ConDutyEnd,108), '')) + '"&chr(34)&","&chr(34)&"CoffDuty"&chr(34)&":"&chr(34)&"' + RTRIM(ISNULL(CONVERT(CHAR(5),CoffDuty,108), '')) + '"&chr(34)&","&chr(34)&"CoffDutyStart"&chr(34)&":"&chr(34)&"' + RTRIM(ISNULL(CONVERT(CHAR(5),CoffDutyStart,108), '')) + '"&chr(34)&","&chr(34)&"CoffDutyEnd"&chr(34)&":"&chr(34)&"' + RTRIM(ISNULL(CONVERT(CHAR(5),CoffDutyEnd,108), '')) + '"&chr(34)&","&chr(34)&"CcalculateLate"&chr(34)&":"&chr(34)&"' + ISNULL(CAST(CcalculateLate AS NVARCHAR(10)), '') + '"&chr(34)&","&chr(34)&"CcalculateEarly"&chr(34)&":"&chr(34)&"' + ISNULL(CAST(CcalculateEarly AS NVARCHAR(10)), '') + '"&chr(34)&","&chr(34)&"CrestTime"&chr(34)&":"&chr(34)&"' + ISNULL(CAST(CrestTime AS NVARCHAR(10)), '') + '"&chr(34)

		strSQL = strSQL&"}' from AttendanceShifts where ShiftId = " & cstr(strShiftId) & " for xml path('')) JsonData"

		'response.write strSQL
		'response.end

		Rs.open strSQL, Conn, 2, 1

		If Not Rs.eof Then
			strJS = strJS & Trim(Rs.fields(0).value)
		End If

		Rs.close
		response.write strJS
	end if
end if

	
fCloseADO()
%>