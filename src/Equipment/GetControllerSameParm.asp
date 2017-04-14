<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
fConnectADODB()
dim strSQL,strJS,strIP

strSQL = "select top 1 IP,MASK,GateWay,DNS,DNS2,ServerIP,WorkType,DataUpdateTime,WaitTime,CloseLightTime,Sound,convert(Nvarchar(2),DownPhoto) as DownPhoto,convert(Nvarchar(2),DownFingerprint) as DownFingerprint,convert(Nvarchar(2),IsFingerprint) as IsFingerprint from controllers order by ControllerId desc "
strJS = ""
Rs.open strSQL, Conn, 1, 1
if Rs.eof=false and Rs.Bof=false then
	if NOT ISNULL(Rs.Fields(0).Value) then
		strIP = Rs.Fields(0).Value
		strIP = left(strIP,instrrev(strIP,"."))
		strJS = strIP & "|"
	else
		strJS = "|"
	end if
	for i=1 to Rs.Fields.Count -1
		if NOT ISNULL(Rs.Fields(i).Value) then
			strJS = strJS & trim(Rs.Fields(i).Value) & "|"
		else
			strJS = strJS & "|"
		end if
	Next
end if
Rs.close


if strJS <> "" then 
	strJS=left(strJS,len(strJS)-1)
else
	strJS="192.168.1.218|255.255.255.0|192.168.1.1|||192.168.1.1/sync|"&GetEquLbl("WorkType2")&"|60|3|120|8|0|0|0"		'2 - 上下班+进出入
end if
response.write strJS
	
fCloseADO()
%>