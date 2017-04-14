<!--#include file="..\Conn\conn.asp"-->
<%
	dim id,ScreenFile
	id = request("id")
	ScreenFile = request("ScreenFile")
	If Not IsNumeric(id) Then response.end

	'if EmId = "" or UserId = "" Then response.end
	'if fConnectADODB() = 0 Then response.end
	Call fConnectADODB()

	On Error Resume next
	if ScreenFile = "2" then 
		Rs.open "select ScreenFile2 as Photo from Controllers where ControllerId="+cstr(id), Conn ,1, 1
	else 
		Rs.open "select ScreenFile1 as Photo from Controllers where ControllerId="+cstr(id), Conn ,1, 1
	end if

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
