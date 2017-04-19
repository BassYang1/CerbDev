<!--#include file="..\Conn\GetLbl.asp"-->
<%
response.Charset="utf-8"
'---------------------------------------
' JSONClass类
' 将Select语句的执行结果转换成JSON
'------------------------------------------
Class JSONClass
	' 定义类属性，默认为Private
	Dim SqlString ' 用于设置Select
	Dim JSON ' 返回的JSON对象的名称
	Dim DBConnection ' 连接到数据库的Connection对象
	' 可以外部调用的公共方法
	'页面显示数据，jqGrid使用
	Public Function GetJSON ()
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
		Rs1.open SqlString,DBConnection,1,1
		if err.number <> 0 then
			Rs1.pagesize = 1
			Rs1.close
			set Rs1=Nothing
			GetJSON=returnStr
			exit Function
		end if
	
		if page<>"" then 
			epage=cint(page)
			if epage<1 then epage=1
			if epage>Rs1.pagecount then  epage=Rs1.pagecount
		else
			epage=1
		end if
		Rs1.pagesize = rows
		'Rs1.absolutepage = epage
		' 生成JSON字符串
		if Rs1.eof=false and Rs1.Bof=false then
			Rs1.absolutepage = epage
			returnStr="{ "&chr(34)&"total"&chr(34)&": "& Rs1.pagecount &", "&chr(34)&"page"&chr(34)&": "& page &", "&chr(34)&"records"&chr(34)&": "& Rs1.recordcount &", "&chr(34)&"rows"&chr(34)&":["
			for j=0 to Rs1.pagesize-1
				if Rs1.bof or Rs1.eof then exit for
				' -------
				oneRecord = "{"&chr(34)&"id"&chr(34)&":" &chr(34)&Rs1.Fields(0).Value&chr(34)&","&chr(34)&"cell"&chr(34)&":["&chr(34)&Rs1.Fields(0).Value&chr(34)&","
				'oneRecord = "{id:" &chr(34)&Rs1.Fields(0).Value&chr(34)&",cell:["&chr(34)&Rs1.Fields(0).Value&chr(34)&","
				for i=1 to Rs1.Fields.Count -1
					'oneRecord=oneRecord & chr(34) &Rs1.Fields(i).Name&chr(34)&":"
					oneRecord=oneRecord & chr(34) &Rs1.Fields(i).Value&chr(34) &","
				Next
				'去除记录最后一个字段后的","
				oneRecord=left(oneRecord,InStrRev(oneRecord,",")-1)
				oneRecord=oneRecord & "]},"
				'------------
				returnStr=returnStr & oneRecord
				Rs1.MoveNext
			next
			' 去除所有记录数组后的","
			returnStr=left(returnStr,InStrRev(returnStr,",")-1)
			returnStr=returnStr & "]}"
		else
			'returnStr="{ total: 0, page: 0, records: 0,rows:[{RecordID:193861,cell:[193861,0,999985,0,'2012-12-6 16:31:29']}]}"
			'{ "total": 2, "page": 1, "records": 15, "rows":[{"id":"15","cell":["15","行政部","test15","NO15","15","0-卡"]}]}
			returnStr= "{ "&chr(34)&"total"&chr(34)&": 0, "&chr(34)&"page"&chr(34)&": 0, "&chr(34)&"records"&chr(34)&": 0, "&chr(34)&"rows"&chr(34)&":[{"&chr(34)&"id"&chr(34)&":"&chr(34)&" "&chr(34)&","&chr(34)&"cell"&chr(34)&":["
			for i=1 to Rs1.Fields.Count -1
					returnStr=returnStr & chr(34) &" "&chr(34) &","
			Next
			returnStr=left(returnStr,InStrRev(returnStr,",")-1)
			returnStr=returnStr & "]}]}"
		end if
		Rs1.close
		set Rs1=Nothing
		GetJSON=returnStr
	End Function

	Public Function GetAllJSON()
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
		Rs1.open SqlString,DBConnection,1,1
		if err.number <> 0 then
			Rs1.pagesize = 1
			Rs1.close
			set Rs1=Nothing
			GetAllJSON=returnStr
			exit Function
		end if	

		' 生成JSON字符串
		if Rs1.EOF=false and Rs1.BOF=false then		
			returnStr="["

			while NOT Rs1.EOF
				oneRecord = "{"

				for i = 0 to Rs1.Fields.Count -1
					oneRecord= oneRecord & chr(34) & Rs1.Fields(i).name & chr(34) & ":" & chr(34) & Rs1.Fields(i).value & chr(34) & ","
				Next

				oneRecord = left(oneRecord,InStrRev(oneRecord,",")-1)
				returnStr = returnStr & oneRecord & "},"

				Rs1.movenext
				i = i + 1
			wend

			' 去除所有记录数组后的","
			returnStr=left(returnStr,InStrRev(returnStr,",")-1)
			returnStr = returnStr & "]"
		end if

		Rs1.close
		set Rs1=Nothing

		GetAllJSON=returnStr
	End Function
	
	'页面显示数据，jqGrid使用，通过存储过程获取数据
	Public Function GetJSONByProc (ProcName,arrParam,arrLen)
		dim Rs1
		dim returnStr,returnStrPageMsg
		dim i
		
		dim oneRecord
		
		On Error Resume Next
		set recom = server.createobject("adodb.command")
		recom.activeconnection = DBConnection
		recom.commandtype = 4
		recom.CommandTimeout = 0
		recom.Prepared = true
		recom.Commandtext = ProcName
		for i = 0 to arrLen-1
			recom.Parameters(i+1) = arrParam(i)
		Next
		'recom.Parameters(1) = "V_Employees_BrushCardAcs" 	'@tblName
		'recom.Parameters(2) = "RecordID"					'@fldName
		'recom.Parameters(3) = strSQL						'@listFldName
		'recom.Parameters(4) = strOrderBy					'@orderFldName
		'recom.Parameters(5) = strOrderType					'@orderFldType
		'recom.Parameters(6) = 20							'@PageSize
		'recom.Parameters(7) = lPageNum						'@PageIndex
		'recom.Parameters(8) = orderType						'@OrderType
		'recom.Parameters(9) = strCondition					'@strWhere
		''PageNo = Clng(Request("PageNo"))'int最大值只有到32767. 
		''If PageNo<=0 or PageNo="" Then    PageNo=1
		set Rs1 = recom.execute()
			
		On Error Resume Next
		if err.number <> 0 then
			Rs1.pagesize = 1
			Rs1.close
			set Rs1=Nothing
			GetJSONByProc=returnStr
			exit Function
		end if
	
		if page<>"" then 
			epage=cint(page)
			if epage<1 then epage=1
		'	if epage>Rs1.pagecount then  epage=Rs1.pagecount
		else
			epage=1
		end if
		'Rs1.pagesize = rows
		'Rs1.absolutepage = epage
		' 生成JSON字符串
		if Rs1.eof=false and Rs1.Bof=false then
			'Rs1.absolutepage = epage
			'returnStr="{ "&chr(34)&"total"&chr(34)&": "& Rs1.pagecount &", "&chr(34)&"page"&chr(34)&": "& page &", "&chr(34)&"records"&chr(34)&": "& Rs1.recordcount &", "&chr(34)&"rows"&chr(34)&":["
			'for j=0 to Rs1.pagesize-1
			for j=0 to 1000
				if Rs1.bof or Rs1.eof then exit for
				' -------
				oneRecord = "{"&chr(34)&"id"&chr(34)&":" &chr(34)&Rs1.Fields(0).Value&chr(34)&","&chr(34)&"cell"&chr(34)&":["&chr(34)&Rs1.Fields(0).Value&chr(34)&","
				'oneRecord = "{id:" &chr(34)&Rs1.Fields(0).Value&chr(34)&",cell:["&chr(34)&Rs1.Fields(0).Value&chr(34)&","
				for i=1 to Rs1.Fields.Count -1
					'oneRecord=oneRecord & chr(34) &Rs1.Fields(i).Name&chr(34)&":"
					oneRecord=oneRecord & chr(34) &Rs1.Fields(i).Value&chr(34) &","
				Next
				'去除记录最后一个字段后的","
				oneRecord=left(oneRecord,InStrRev(oneRecord,",")-1)
				oneRecord=oneRecord & "]},"
				'------------
				returnStr=returnStr & oneRecord
				Rs1.MoveNext
			next
			' 去除所有记录数组后的","
			returnStr=left(returnStr,InStrRev(returnStr,",")-1)
			returnStr=returnStr & "]}"
			
			set Rs1 = Rs1.NextRecordset    '取得第2个记录集即总记录。
			lCount = Rs1("RecordCount")   '得到记录总数
			lMaxPage = Rs1("TotalPage")   '得到总页数
			returnStrPageMsg="{ "&chr(34)&"total"&chr(34)&": "& lMaxPage &", "&chr(34)&"page"&chr(34)&": "& page &", "&chr(34)&"records"&chr(34)&": "& lCount &", "&chr(34)&"rows"&chr(34)&":["
			returnStr = returnStrPageMsg & returnStr 
		else
			'returnStr="{ total: 0, page: 0, records: 0,rows:[{RecordID:193861,cell:[193861,0,999985,0,'2012-12-6 16:31:29']}]}"
			'{ "total": 2, "page": 1, "records": 15, "rows":[{"id":"15","cell":["15","行政部","test15","NO15","15","0-卡"]}]}
			returnStr= "{ "&chr(34)&"total"&chr(34)&": 0, "&chr(34)&"page"&chr(34)&": 0, "&chr(34)&"records"&chr(34)&": 0, "&chr(34)&"rows"&chr(34)&":[{"&chr(34)&"id"&chr(34)&":"&chr(34)&" "&chr(34)&","&chr(34)&"cell"&chr(34)&":["
			for i=1 to Rs1.Fields.Count -1
					returnStr=returnStr & chr(34) &" "&chr(34) &","
			Next
			returnStr=left(returnStr,InStrRev(returnStr,",")-1)
			returnStr=returnStr & "]}]}"
		end if
		
		Rs1.close
		set Rs1=Nothing
		GetJSONByProc=returnStr
	End Function
	
	'IE导出数据，返回JSON格式 
	Public Function GetJSONForExport (ColumnName)
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
		Rs1.open SqlString,DBConnection,1,1
		if err.number <> 0 then
			Rs1.pagesize = 1
			Rs1.close
			set Rs1=Nothing
			GetJSONForExport=Err.Description
			exit Function
		end if
		epage=1

		' 生成JSON字符串
		if Rs1.eof=false and Rs1.Bof=false then
			returnStr="{ "&chr(34)&"total"&chr(34)&": "& epage &", "&chr(34)&"page"&chr(34)&": "& epage &", "&chr(34)&"records"&chr(34)&": "& Rs1.recordcount &", "&chr(34)&"rows"&chr(34)&":["
			if ColumnName <> "" then 
				ColumnName = Replace(ColumnName,",",chr(34)&","&chr(34))
				ColumnName = "{"&chr(34)&"cell"&chr(34)&":["&chr(34)&ColumnName&chr(34) & "]},"
				returnStr=returnStr & ColumnName
			end if
			while NOT Rs1.EOF
				' -------
				oneRecord = "{"&chr(34)&"cell"&chr(34)&":["
				for i=0 to Rs1.Fields.Count -1
					'oneRecord=oneRecord & chr(34) &Rs1.Fields(i).Name&chr(34)&":"
					oneRecord=oneRecord & chr(34) &Rs1.Fields(i).Value&chr(34) &","
				Next
				'去除记录最后一个字段后的","
				oneRecord=left(oneRecord,InStrRev(oneRecord,",")-1)
				oneRecord=oneRecord & "]},"
				'------------
				returnStr=returnStr & oneRecord
				Rs1.MoveNext
			Wend
			' 去除所有记录数组后的","
			returnStr=left(returnStr,InStrRev(returnStr,",")-1)
			returnStr=returnStr & "]}"
		end if
		Rs1.close
		set Rs1=Nothing
		GetJSONForExport=returnStr
	End Function
	
	'IE导出数据，返回JSON格式 。通过存储过程获取的数据
	Public Function GetJSONForExportByProc (ColumnName,ProcName,arrParam,arrLen)
		dim Rs1
		dim returnStr
		dim i
		dim oneRecord
		
		On Error Resume Next
		set recom = server.createobject("adodb.command")
		recom.activeconnection = DBConnection
		recom.commandtype = 4
		recom.CommandTimeout = 0
		recom.Prepared = true
		recom.Commandtext = ProcName
		for i = 0 to arrLen-1
			recom.Parameters(i+1) = arrParam(i)
		Next
			
		set Rs1 = recom.execute()
		if err.number <> 0 then
			Rs1.pagesize = 1
			Rs1.close
			set Rs1=Nothing
			GetJSONForExportByProc=Err.Description
			exit Function
		end if
		epage=1
		' 生成JSON字符串
		if Rs1.eof=false and Rs1.Bof=false then
			returnStr="{ "&chr(34)&"total"&chr(34)&": "& epage &", "&chr(34)&"page"&chr(34)&": "& epage &", "&chr(34)&"records"&chr(34)&": "& Rs1.recordcount &", "&chr(34)&"rows"&chr(34)&":["
			if ColumnName <> "" then 
				ColumnName = Replace(ColumnName,",",chr(34)&","&chr(34))
				ColumnName = "{"&chr(34)&"cell"&chr(34)&":["&chr(34)&ColumnName&chr(34) & "]},"
				returnStr=returnStr & ColumnName
			end if
			while NOT Rs1.EOF
				' -------
				oneRecord = "{"&chr(34)&"cell"&chr(34)&":["
				for i=0 to Rs1.Fields.Count -1
					'oneRecord=oneRecord & chr(34) &Rs1.Fields(i).Name&chr(34)&":"
					oneRecord=oneRecord & chr(34) &Rs1.Fields(i).Value&chr(34) &","
				Next
				'去除记录最后一个字段后的","
				oneRecord=left(oneRecord,InStrRev(oneRecord,",")-1)
				oneRecord=oneRecord & "]},"
				'------------
				returnStr=returnStr & oneRecord
				Rs1.MoveNext
			Wend
			' 去除所有记录数组后的","
			returnStr=left(returnStr,InStrRev(returnStr,",")-1)
			returnStr=returnStr & "]}"
		end if
		Rs1.close
		set Rs1=Nothing
		GetJSONForExportByProc=returnStr
	End Function


	'IE导出数据，返回JSON格式 。通过存储过程获取的数据. 导出考勤卡使用
	Public Function GetJSONForExportAttendCardByProc (ColumnName,ProcName,arrParam,arrLen)
		dim Rs1
		dim returnStr
		dim i
		dim oneRecord
		
		On Error Resume Next
		set recom = server.createobject("adodb.command")
		recom.activeconnection = DBConnection
		recom.commandtype = 4
		recom.CommandTimeout = 0
		recom.Prepared = true
		recom.Commandtext = ProcName
		for i = 0 to arrLen-1
			recom.Parameters(i+1) = arrParam(i)
		Next
			
		set Rs1 = recom.execute()
		if err.number <> 0 then
			Rs1.pagesize = 1
			Rs1.close
			set Rs1=Nothing
			GetJSONForExportAttendCardByProc=Err.Description
			exit Function
		end if
		epage=1
		' 生成JSON字符串
		if Rs1.eof=false and Rs1.Bof=false then
			returnStr="{ "&chr(34)&"total"&chr(34)&": "& epage &", "&chr(34)&"page"&chr(34)&": "& epage &", "&chr(34)&"records"&chr(34)&": "& Rs1.recordcount &", "&chr(34)&"rows"&chr(34)&":["
			if ColumnName <> "" then 
				ColumnName = Replace(ColumnName,",",chr(34)&","&chr(34))
				'ColumnName = "{"&chr(34)&"cell"&chr(34)&":["&chr(34)&ColumnName&chr(34) & "]},"
				'增加第一列数据，值为0
				ColumnName = "{"&chr(34)&"cell"&chr(34)&":["&chr(34)&"0"&chr(34)&","&chr(34)&ColumnName&chr(34) & "]},"
				returnStr=returnStr & ColumnName
			end if
			while NOT Rs1.EOF
				' -------
				oneRecord = "{"&chr(34)&"cell"&chr(34)&":["
				If Not IsNull(Rs1("DataType")) And Rs1("DataType") Then
					'增加第一列数据，值为1，表示头，这一行存储 部门，工号，姓名 
					oneRecord=oneRecord&chr(34)&"1"&chr(34) &","
					oneRecord=oneRecord&chr(34)&GetToolLbl("ExportDept")&Rs1("DepartmentName")&chr(34) &","	'部门：
					oneRecord=oneRecord&chr(34)&GetToolLbl("ExportNumber")&Rs1("Number")&chr(34) &","			'工号：
					oneRecord=oneRecord&chr(34)&GetToolLbl("ExportName")&Rs1("Name")&chr(34) &","				'姓名：
				else
					oneRecord=oneRecord&chr(34)&"0"&chr(34) &","
					oneRecord=oneRecord&chr(34)&Rs1("OnDutyDate")&chr(34) &","
					oneRecord=oneRecord&chr(34)&Rs1("OnDuty1")&chr(34) &","
					oneRecord=oneRecord&chr(34)&Rs1("OffDuty1")&chr(34) &","
					oneRecord=oneRecord&chr(34)&Rs1("OnDuty2")&chr(34) &","
					oneRecord=oneRecord&chr(34)&Rs1("OffDuty2")&chr(34) &","
					oneRecord=oneRecord&chr(34)&Rs1("OnDuty3")&chr(34) &","
					oneRecord=oneRecord&chr(34)&Rs1("OffDuty3")&chr(34) &","
					If Not IsNull(Rs1("WorkTime")) And Rs1("WorkTime") <> "0" Then
						oneRecord=oneRecord&chr(34)&Rs1("WorkTime")&chr(34) &","
					else
						oneRecord=oneRecord&chr(34)&" "&chr(34) &","
					end if
					If Not IsNull(Rs1("LateTime")) And Rs1("LateTime") <> "0" Then
						oneRecord=oneRecord&chr(34)&Rs1("LateTime")&chr(34) &","
					else
						oneRecord=oneRecord&chr(34)&" "&chr(34) &","
					end if
					If Not IsNull(Rs1("LeaveEarlyTime")) And Rs1("LeaveEarlyTime") <> "0" Then
						oneRecord=oneRecord&chr(34)&Rs1("LeaveEarlyTime")&chr(34) &","
					else
						oneRecord=oneRecord&chr(34)&" "&chr(34) &","
					end if
				end if

				'去除记录最后一个字段后的","
				oneRecord=left(oneRecord,InStrRev(oneRecord,",")-1)
				oneRecord=oneRecord & "]},"
				'------------
				returnStr=returnStr & oneRecord
				Rs1.MoveNext
			Wend
			' 去除所有记录数组后的","
			returnStr=left(returnStr,InStrRev(returnStr,",")-1)
			returnStr=returnStr & "]}"
		end if
		Rs1.close
		set Rs1=Nothing
		GetJSONForExportAttendCardByProc=returnStr
	End Function


	'私用方法，在类中使用
	Private Function check()
	End Function
	'
End Class
%>