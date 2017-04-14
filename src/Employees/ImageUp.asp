<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
	dim  lEmployeeId,delPhoto
	dim executeflag
	dim formsize
	dim bncrlf, divider,datastart,dataend,mydata

	lEmployeeId = request.QueryString("id")
	delPhoto = request.QueryString("delPhoto")
	if Not IsNumeric(lEmployeeId) then
		Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
		response.End()
	end if

	'//图片
	formsize=request.totalbytes
		
	if delPhoto <> "1" and formsize > 10240 then
		Call ReturnMsg("false",GetEmpLbl("PhotoBeyond10K"),0) '上传照片不能超过10K
		response.end
	end if
	formdata=request.binaryread(formsize)
	bncrlf=chrB(13) & chrB(10)
	divider=leftB(formdata,clng(instrb(formdata,bncrlf))-1)
	datastart=instrb(formdata,bncrlf & bncrlf)+4
	dataend=instrb(datastart+1,formdata,divider)-datastart
	mydata=midb(formdata,datastart,dataend)
	
	Call fConnectADODB()
	'response.write CStr(len(mydata))
	'response.end
	On Error Resume next
	
	if delPhoto = "1" then 
		Conn.Execute "update Employees set photo=NULL where EmployeeId="+CStr(lEmployeeId)
		If Err.number<>0 then
			Call fCloseADO()
			Call ReturnMsg("false",GetEmpLbl("DelPhotoFail"),0)	'"照片删除失败"
			response.End()
		End If
		fCloseADO()
		Call ReturnMsg("true",GetEmpLbl("DelPhotoSuccess"),0)	'"图片删除成功"
	else
		Rs.open "select EmployeeId,Photo from Employees where EmployeeId="+CStr(lEmployeeId), Conn, 2,2
	
		if not Rs.eof then
			Rs("Photo").AppendChunk mydata
			Rs.update
		end if
		Rs.close
	
		If Err.number<>0 then
			Call fCloseADO()
			Call ReturnMsg("false",GetEmpLbl("UpPhotoFail"),0)	'图片上传失败
			response.End()
		End If
		fCloseADO()
		Call ReturnMsg("true",GetEmpLbl("UpPhotoSuccess"),0)	'图片上传成功
	end if
%>