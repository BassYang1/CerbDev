<!--#include file="..\Conn\conn.asp"-->
<%
function getBinData(path)
	dim bindata,objstream
	set objstream=server.createobject("Adodb.Stream")
	objstream.Type=1'1为2进制,2为文本
	objstream.mode=3
	objstream.open
	objstream.Position=0
	objstream.loadfromfile path
	bindata=objstream.read(objstream.Size)
	objstream.close
	set objstream=nothing
	getBinData=bindata
end function

	dim id,strNumber
	id = request("id")
	strNumber = request("number")
	If Not IsNumeric(id) Then response.end
	
	if id = "-1" then 
		response.contentType = "image/jpeg"
		response.BinaryWrite getBinData(Server.MapPath("../images/illegal.gif"))
		response.End()
	end if
	if strNumber <> "" then
		response.contentType = "image/jpeg"
		response.BinaryWrite getBinData(Server.MapPath("../../../"&strNumber&".jpg"))
		response.End()
	end if
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
			'response.contenttype = "image/*"
			'response.BinaryWrite ReadBinFile(RealUrl) 
			response.contentType = "image/jpeg"
			response.BinaryWrite getBinData(Server.MapPath("../images/photo.gif"))
			'response.Write("../images/photo.gif")
		End if
	Else
		response.contentType = "image/jpeg"
		response.BinaryWrite getBinData(Server.MapPath("../images/photo.gif"))
	End if
	Rs.close
	fCloseADO()              '//销毁对象
%> 
