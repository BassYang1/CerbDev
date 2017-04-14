<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
dim page,rows,sidx,sord,strFieldId
dim strVariableValue,values,iTpye,iStatus,sString


Call fConnectADODB()

On Error Resume Next 
Rs.open "select ISNULL(VariableValue,'') as VariableValue from Options where VariableName='strTotal'", Conn, 1, 1
If Not Rs.eof Then
	strVariableValue = Trim(Rs.fields("VariableValue").value)
Else
	Call ReturnMsg("false","0",0)
	Rs.close
	fCloseADO()              '//销毁对象
	response.end
End if

 If Err.number <> 0 Then
	Call ReturnMsg("false",Err.description,0)
	Rs.close
	fCloseADO()              '//销毁对象
	response.end
End If
	
Rs.close
fCloseADO()

If strVariableValue <> "" then
	values  = Split(strVariableValue, ",")
	iTpye	= values(0)
	iStatus	= values(1)
	sString	= values(2)
End if

'2,1,,2015-04-1,2015-4-15
'第2位为1表示正在统计或者还未开始， 为3统计完成，为2统计失败
if iStatus = "1" then 
	Call ReturnMsg("true",GetToolLbl("Totaling"),0)	'正在统计中，请稍后...
	response.end
else
	Call ReturnMsg("false","1",0)
	response.end	
end if


%>
