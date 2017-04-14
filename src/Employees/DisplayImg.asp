<!--#include file="..\Conn\conn.asp"-->
<%
	dim id
	id = request("id")
	If Not IsNumeric(id) Then response.end

	'if EmId = "" or UserId = "" Then response.end
	'if fConnectADODB() = 0 Then response.end
	Call fConnectADODB()

	On Error Resume next
	Rs.open "select Photo from Employees where EmployeeId="+cstr(id), Conn ,1, 1

	if not Rs.eof then
		If Not IsNull(Rs("Photo")) Then
			response.contentType = "image/jpeg"
			response.BinaryWrite Rs("Photo")
		Else
			'response.contentType = "image/jpeg"
			'response.BinaryWrite cbyte("../images/photo.gif")
		End if
	Else
		'response.contentType = "application/octet-stream"
		'response.BinaryWrite "../images/photo.jpg"
	End if
	Rs.close
	fCloseADO()              '//销毁对象
%> 
