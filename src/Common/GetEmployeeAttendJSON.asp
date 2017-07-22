<!--#include file="Page.asp" -->
<!--#include file="..\Conn\conn.asp" -->
<%
dim strEmpId, strYear
dim strSQL,strJS

strEmpId = Cstr(Trim(Request.QueryString("empId")))
if strEmpId = "" then strEmpId = "0" end if

strYear = Cstr(Trim(Request.QueryString("year")))
if strYear = "" then strYear = year(now()) end if

'SELECT * FROM Tables WHERE TableName = 'AttendanceTotalYear';
'SELECT  * FROM TableStructure WHERE TableId = '51';

fConnectADODB()

strSQL = "select '{"&chr(34)&"Annual0"&chr(34)&":"&chr(34)&"'+ CAST(AnnualVacationYear AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"Annual1"&chr(34)&":"&chr(34)&"'+ CAST(AnnualVacationRemanent AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"Annual2"&chr(34)&":"&chr(34)&"'+ CAST(AnnualVacation AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"Personal"&chr(34)&":"&chr(34)&"'+ CAST(PersonalLeave AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"Sick"&chr(34)&":"&chr(34)&"'+ CAST(SickLeave AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"Compensatory"&chr(34)&":"&chr(34)&"'+ CAST(CompensatoryLeave AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"Maternity"&chr(34)&":"&chr(34)&"'+ CAST(MaternityLeave AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"Wedding"&chr(34)&":"&chr(34)&"'+ CAST(WeddingLeave AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"Visit"&chr(34)&":"&chr(34)&"'+ CAST(VisitLeave AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"Lactation"&chr(34)&":"&chr(34)&"'+ CAST(LactationLeave AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"Funeral"&chr(34)&":"&chr(34)&"'+ CAST(FuneralLeave AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"Other"&chr(34)&":"&chr(34)&"+ 0 + "&chr(34)&"}' from AttendanceTotalYear where EmployeeId="&strEmpId & " and AttendMonth=" & strYear

'response.write strSQL
'response.end

Rs.open strSQL, Conn, 2, 1

If Not Rs.eof Then
	strJS = Trim(Rs.fields(0).value)
End If

Rs.close
response.write strJS
	
fCloseADO()
%>