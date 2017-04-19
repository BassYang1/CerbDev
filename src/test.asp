<!--#include file="common\Page.asp" -->
<!--#include file="Conn\conn.asp" -->
<!--#include file="Conn\json.asp" -->
<%
fConnectADODB()

dim sqlstring 
sqlstring = "SELECT EmployeeId as Id, Name FROM Employees E WHERE LEFT(IncumbencyStatus,1)<>'1'"

		dim Rs1
		dim returnStr
		dim i
		dim oneRecord
		' 获取数据
		if dbType = 0 then  ''1为MSSQL 0为SQLCE 
			Set Rs1= CreateObject("ADOCE.Recordset.3.1")
		else 
			Set Rs1= Server.CreateObject("ADODB.Recordset")
		end if
		
		On Error Resume Next
		Rs1.open sqlstring,conn,1,1
		if err.number <> 0 then
			Rs1.pagesize = 1
			Rs1.close
			set Rs1=Nothing
			response.write("none")
		end if	

		' 生成JSON字符串
		if Rs1.EOF=false and Rs1.BOF=false then		
			returnStr="["

			while NOT Rs1.EOF
				oneRecord = "{"

				for i=1 to Rs1.Fields.Count -1
					oneRecord = oneRecord & Rs1.Fields(i).name & ":" & chr(34) & Rs1.Fields(i).value & chr(34) & ","
				Next

				oneRecord = left(oneRecord, InStrRev(oneRecord, ",") - 1)
				returnStr = returnStr & oneRecord & "},"

				Rs1.movenext
				i = i + 1
			wend

			' 去除所有记录数组后的","
			returnStr = left(returnStr, InStrRev(returnStr, ",") - 1)
			returnStr = returnStr & "]"
		end if

		Rs1.close
		set Rs1=Nothing		
		response.write(returnStr)
		
fCloseADO()
%>