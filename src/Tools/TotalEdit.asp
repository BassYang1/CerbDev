<%Session.CodePage=65001%>
<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL,strOper, strRecordID,strFieldId,strContent,strActions,strBy,strMsg
DIM startTime,strblnTotalDimission
dim intRound 

Dim datDate
Dim strMonth
Dim arrTotalCycle, strTotalCycle
Dim StartDate 
Dim EndDate   
Dim SStardate
Dim SEndDate
Dim blnDimission
Dim DatTemp

dim rsZ
dim blnTotalDimission

Dim strYearMonth
response.Charset="utf-8"

strFieldId = Trim(Request.Form("FieldId"))
strOper = request.QueryString(("oper"))
strRecordID = Replace(request.Form("id"),"'","''")
startTime = Replace(request.Form("startTime"),"'","''")
strblnTotalDimission = Replace(request.Form("blnTotalDimission"),"'","''")
strBy = request.QueryString(("by"))

if GetOperRole("total",strOper) <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

if strOper = "cancel" then 
	strSQL = "Update Options set VariableValue='' where VariableName='strTotal'"
else
	if strOper<>"total" or startTime=""  then 
		Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
		response.End()
	end if 
end if

Call fConnectADODB()
'if fConnectADODB() = 0 then
'	Call ReturnMsg("false","数据库连接失败！",0)
'	response.End()
'end if
'取消考勤统计
if strOper = "cancel" and strSQL<> "" then

	On Error Resume Next 
	 conn.execute strSQL
	 If Err.number <> 0 Then
		Call ReturnMsg("false",Err.number,0)
		fCloseADO()              '//销毁对象
		response.end
	End If
	
	'Call AddLogEvent("工具-考勤统计-统计","统计","取消统计")
	Call AddLogEvent(GetToolLbl("Tool")&"-"&GetToolLbl("AttendTotal")&"-"&GetToolLbl("Total"),GetToolLbl("Total"),GetToolLbl("CancelTotal"))
	
	Call ReturnMsg("true",GetToolLbl("CancelSuccess"),0)	'"取消成功"
	fCloseADO()              '//销毁对象
	response.end
	
end if
    Server.ScriptTimeout=999 
'//************************************************************/

	Dim strVariableValue
	Dim iTpye, iStatus, sString


	On Error Resume Next 
	Rs.open "select VariableValue from Options where VariableName='strTotal'", Conn, 1, 1
	If Not Rs.eof Then
		strVariableValue = Trim(Rs.fields("VariableValue").value)
	Else
		Call ReturnMsg("false",GetToolLbl("DataEx"),0)	'数据异常！
		Rs.close
		fCloseADO()              '//销毁对象
		response.end
	End if
	Rs.close
		
	If Err.number <> 0 Then
		Call ReturnMsg("false",GetToolLbl("DataEx"),0)	'数据异常！
		fCloseADO()              '//销毁对象
		response.end
	End If
	
	If strVariableValue <> "" then
		values  = Split(strVariableValue, ",")
		iTpye	= values(0)
		iStatus	= values(1)
		sString	= values(2)
	End if
	
	If iStatus = 1 Then		'统计中
		fCloseADO()              '//销毁对象
		response.end
	End if
'//************************************************************/
	conn.CommandTimeout=0
	set Rstemp=server.createobject("adodb.recordset")
	rsTemp.Open "Select OBJECT_ID('tempdb..#AttendanceDetail') as TempTable",Conn,,3
	if rstemp.RecordCount > 0  then 
		Call ReturnMsg("false",GetToolLbl("OtherUserTotal"),0)	'"可能有其他的用户正在统计,统计不能继续！"
		fCloseADO()              '//销毁对象
		response.end
	end if
	rstemp.Close 

	if strblnTotalDimission="1" then 
		blndimission=1
	else
		blndimission=0
	end if
	
	conn.execute "Update Options set VariableValue='" & blndimission & "' Where Variablename='BlnTotaldimission'"

    '*********************************************************************************
    '统计时间的合法性判断
    '*********************************************************************************
    Set rsz = Conn.Execute("select getdate() as SDate")
    datDate = Year(rsz("SDate")) & "-" & Month(rsz("SDate")) & "-" & Day(rsz("SDate")) '当前日期
    rsz.Close


	Rs.open "Select VariableValue from Options where variablename='StrTotalCycle'", Conn, 1, 1
	If Not Rs.eof Then
		strTotalCycle = Trim(Rs.fields("VariableValue").value)
	End if

    if strTotalCycle = "" then     
    	strTotalCycle="0-"&GetToolLbl("ThisMonth")&",1,0-"&GetToolLbl("ThisMonth")&",31"	'本月
    end if
	Rs.close

	arrtotalcycle=Split(strTotalCycle,",")	'本月

	for intround=0 to ubound(arrtotalcycle)
		if arrtotalcycle(intround)="" or isempty(arrtotalcycle(intround)) then 
			Call ReturnMsg("false",GetToolLbl("TotalCycleError"),0)	'统计周期设置有误！无法统计！
			fCloseADO()              '//销毁对象
			response.end
		end if
	next
    strmonth = startTime

    If Left(arrtotalcycle(0), 1) = "0" Then
        If Day(CDate(DateAdd("M", 1, strmonth & "-01")) - 1) < CInt(arrtotalcycle(1)) Then
            StartDate = strmonth & "-" & CStr(Day(DateAdd("M", 1, strmonth & "-01") - 1))
        Else
            StartDate = strmonth & "-" & arrtotalcycle(1)
        End If
    ElseIf Left(arrtotalcycle(0), 1) = "1" Then
        If Day(DateAdd("d", -1, strmonth & "-01")) < CInt(arrtotalcycle(1)) Then
            StartDate = DateAdd("d", -1, strmonth & "-01")
        Else
            StartDate = Year(DateAdd("d", -1, strmonth & "-01")) & "-" & Month(DateAdd("d", -1, strmonth & "-01")) & "-" & arrtotalcycle(1)
        End If
    End If

    If Left(arrtotalcycle(2), 1) = "0" Then
        If Day(CDate(DateAdd("M", 1, strmonth & "-01")) - 1) < CInt(arrtotalcycle(3)) Then
            EndDate = strmonth & "-" & CStr(Day(DateAdd("M", 1, strmonth & "-01") - 1))
        Else
            EndDate = strmonth & "-" & arrtotalcycle(3)
        End If
    ElseIf Left(arrtotalcycle(2), 1) = "1" Then
        If Day(DateAdd("d", -1, strmonth & "-01")) < CInt(arrtotalcycle(3)) Then
            EndDate = DateAdd("d", -1, strmonth & "-01")
        Else
            EndDate = Year(DateAdd("d", -1, strmonth & "-01")) & "-" & Month(DateAdd("d", -1, strmonth & "-01")) & "-" & arrtotalcycle(3)
        End If
    End If

	SStartdate=Startdate
	SEndDate=Enddate
	strYearMonth = CInt(Month(Startdate))
	If strYearMonth < 10 Then 
		strYearMonth = CStr(Year(Startdate)) + "-0" + CStr(strYearMonth)
	Else 
		strYearMonth = CStr(Year(Startdate)) + "-" + CStr(Month(Startdate))
	End If 


'response.write CStr(EndDate)+"..."+CStr(StartDate)

    If CDate(EndDate) < CDate(StartDate) Then
		Call ReturnMsg("false",GetToolLbl("EndDateLtStartDate"),0)	'"统计截止日期小于开始日期！无法统计！"
		fCloseADO()   	
		response.end        
    End If
    
    If cdate(datDate) >= cdate(StartDate) And cdate(datDate) =< cdate(EndDate) Then EndDate = datDate
  

    If cdate(datDate) < cdate(StartDate) Then
		Call ReturnMsg("false",GetToolLbl("datDateLtStartDate"),0)	'不能统计将来的数据！
		fCloseADO()              '//销毁对象
        response.end
    End If

    '*********************************************************************************
    '统计时间的合法性判断结束
    '*********************************************************************************
	If thedelete(strmonth)=1 Then
		Call ReturnMsg("false",GetToolLbl("TotalDeleteMonth"),0)	'不能统计已删除月份之前的数据！
		fCloseADO()              '//销毁对象
		response.end
	End if
	
	if blndimission = "1" then 
		strMsg = GetEmpLbl("Yes")	'"是"
	else
		strMsg = GetEmpLbl("No")	'"否"
	end if

	'Call ReturnErrMsg(StartDate & " " & EndDate & " " & strmonth & " 1 " & blndimission)

	if strBy = "page" then 
		'页面立即调用统计
		Conn.Execute "Update Options set VariableValue='' where VariableName='strTotal'"
		
		If Err.number <> 0 Then
			Call ReturnMsg("false",GetToolLbl("ExecEx"),0)	'"执行异常！"
			fCloseADO()              '//销毁对象
			response.end
		End If
		
		'Call AddLogEvent("工具-考勤统计-统计","统计","立即统计["+startdate+"]-["+enddate+"]，仅统计离职:"+strMsg)
		Call AddLogEvent(GetToolLbl("Tool")&"-"&GetToolLbl("AttendTotal")&"-"&GetToolLbl("Total"),GetToolLbl("Total"),GetToolLbl("ImmediatelyTotal")&"["&startdate&"]-["&enddate&"], "&GetToolLbl("TotalDimission")&strMsg)

		Set MyComm = Server.CreateObject("ADODB.Command")
		MyComm.ActiveConnection = Conn 'MyConStr是数据库连接字串
		MyComm.CommandTimeout=0
		MyComm.CommandText = "pAttendTotal" '指定存储过程名
		MyComm.CommandType = 4 '表明这是一个存储过程
		MyComm.Prepared = true '要求将SQL命令先行编译
		Mycomm.Parameters(1) = StartDate
		Mycomm.Parameters(2) = EndDate
		Mycomm.Parameters(3) = strmonth
		Mycomm.parameters(4)="1"
		Mycomm.parameters(5)=blndimission
		Mycomm.Execute
	
		If Err.number<>0 Then 
			Call ReturnMsg("false",err.Description,0)
			fCloseADO() 
			response.End
		End If 
		
		Call ReturnMsg("true",GetToolLbl("TotalComplete"),0)	'"统计完成！"
		fCloseADO()              '//销毁对象
		response.end
	else
		'由服务调用执行
		Conn.Execute "Update Options set VariableValue='2,1,"+CStr(UserId)+","+CStr(startdate)+","+CStr(enddate)+"' where VariableName='strTotal'"
		
		If Err.number <> 0 Then
			Call ReturnMsg("false",GetToolLbl("ExecEx"),0)	'"执行异常！"
			fCloseADO()              '//销毁对象
			response.end
		End If
		
		'Call AddLogEvent("工具-考勤统计-统计","统计","服务执行统计["+startdate+"]-["+enddate+"]，仅统计离职:"+strMsg)
		Call AddLogEvent(GetToolLbl("Tool")&"-"&GetToolLbl("AttendTotal")&"-"&GetToolLbl("Total"),GetToolLbl("Total"),GetToolLbl("ServiceTotal")&"["&startdate&"]-["&enddate&"],"&GetToolLbl("TotalDimission")&strMsg)
		
		Call ReturnMsg("true",GetToolLbl("ExecIng"),0)	'正在执行
		fCloseADO()              '//销毁对象
		response.end
	end if

Function TheDelete( strmonth )
	Dim rstemp
	Set rstemp=conn.execute("select count(*) as recordnum from attendancetotalyear where len(attendmonth)=7 and attendmonth>='"+strmonth+"'")


	If rstemp.fields("recordnum")>0 Then 
		TheDelete=1
	Else
		TheDelete=0
	End If 
End function


%>