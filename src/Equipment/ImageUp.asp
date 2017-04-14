<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
	dim  lEmployeeId,delPhoto,ScreenFile
	dim executeflag
	dim formsize
	dim bncrlf, divider,datastart,dataend,mydata

	lEmployeeId = request.QueryString("id")
	ScreenFile = request.QueryString("ScreenFile")
	delPhoto = request.QueryString("delPhoto")
	if Not IsNumeric(lEmployeeId) then
		Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
		response.End()
	end if

	'//图片
	formsize=request.totalbytes
		
	if delPhoto <> "1" and formsize > 204800 then
		Call ReturnMsg("false",GetEquLbl("PhotoBeyond200K"),0)	'"上传图片不能超过200K"
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
		if ScreenFile = "2" then 
			Conn.Execute "update Controllers set ScreenFile2=NULL where ControllerId="+CStr(lEmployeeId)
		else 
			Conn.Execute "update Controllers set ScreenFile1=NULL where ControllerId="+CStr(lEmployeeId)
		end if
		If Err.number<>0 then
			Call fCloseADO()
			Call ReturnMsg("false",GetEmpLbl("DelPhotoFail"),0)	'"照片删除失败"
			response.End()
		End If
		fCloseADO()
		Call ReturnMsg("true",GetEmpLbl("DelPhotoSuccess"),0)	'"图片删除成功"
	else
		if ScreenFile = "2" then 
			Rs.open "select ControllerId,ScreenFile2 from Controllers where ControllerId="+CStr(lEmployeeId), Conn, 2,2
		else 
			Rs.open "select ControllerId,ScreenFile1 from Controllers where ControllerId="+CStr(lEmployeeId), Conn, 2,2
		end if
	
		if not Rs.eof then
			if ScreenFile = "2" then 
				Rs("ScreenFile2").AppendChunk mydata
			else
				Rs("ScreenFile1").AppendChunk mydata
			end if
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