<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()
	'//*********定义变量*********//
	Dim strSQL,iSQL
	Dim RoleId
	Dim Knowledge,Country,NativePlace,Headship,Position,DepartmentCode,Number,Name,BirthDate,JoinDate,IncumbencyStatus,TryoutDay,RetiringAge,NumberOfYear,Grade,Card,IdentityCard
	Dim strDept,strCode,strNewCode,strNewDept,strNewNumber,strNumber,strNumbers,strReNumbers,strAllNumbers,isNewDept
	Dim strField,strRowField,strValField
	Dim i,j,k,l,strTemp
	Dim Knowledge1,Country1,NativePlace1,Headship1,Position1
	Dim iBrowse,iOperate
	Dim CardFlag
	dim strUserId,strConWhere,strEmpWhere,strActions
	strUserId = session("UserId")
	if strUserId = "" then strUserId = "0" end if	
	'//*******************数据库连接***************//
	'--------------------------------------------------------------
		
	dim strValues
	strValues = trim(Request.Form("ListValues"))
	if strValues = "" then
		Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
		response.End()
	end if
	strNumbers=""

	
	Call fConnectADODB()	
	'//*********导入人事资料代码*********//
	'------------------------------------------------------------------------------
	'//获取数据库中[国籍]、[籍贯]、[学历]、[职位]、[职务]记录
	'TableFieldCode表中FieldId值
	Country=1
	NativePlace=2
	Headship=3
	Position=4
	Knowledge=5
	
	Headship1 = ""
	strSQL = "select FieldId,Content from TableFieldCode where fieldId="+Trim(Headship)
	Rs.Open strSQL, Conn, 1, 1
	While Not Rs.eof
		Headship1 = Headship1 + Trim(Rs.fields(1).value) + ","	
		Rs.movenext
	Wend
	Rs.close
	NativePlace1 = ""
	strSQL = "select FieldId,Content from TableFieldCode where fieldId="+Trim(NativePlace)
	Rs.Open strSQL, Conn, 1, 1
	While Not Rs.eof
		NativePlace1 = NativePlace1 + Trim(Rs.fields(1).value) + ","	
		Rs.movenext
	Wend
	Rs.close
	Country1 = ""
	strSQL = "select FieldId,Content from TableFieldCode where fieldId="+Trim(Country)
	Rs.Open strSQL, Conn, 1, 1
	While Not Rs.eof
		Country1 = Country1 + Trim(Rs.fields(1).value) + ","	
		Rs.movenext
	Wend
	Rs.close
	Position1 = ""
	strSQL = "select FieldId,Content from TableFieldCode where fieldId="+Trim(Position)
	Rs.Open strSQL, Conn, 1, 1
	While Not Rs.eof
		Position1 = Position1 + Trim(Rs.fields(1).value) + ","	
		Rs.movenext
	Wend
	Rs.close
	Knowledge1 = ""
	strSQL = "select FieldId,Content from TableFieldCode where fieldId="+Trim(Knowledge)
	Rs.Open strSQL, Conn, 1, 1
	While Not Rs.eof
		Knowledge1 = Knowledge1 + Trim(Rs.fields(1).value) + ","	
		Rs.movenext
	Wend
	Rs.close
	'//获取已存在的卡号和身份证号
	Card = ","
	strSQL = "select distinct Card from Employees where Card is not null"
	Rs.Open strSQL, Conn, 1, 1
	While Not Rs.eof
		If Rs.fields(0).value <> "" then
			Card = Card + Trim(Rs.fields(0).value) + ","
		End If
		Rs.movenext
	Wend
	Rs.close
	IdentityCard = ","
	strSQL = "select distinct IdentityCard from Employees where IdentityCard is not null"
	Rs.Open strSQL, Conn, 1, 1
	While Not Rs.eof
		If Rs.fields(0).value <> "" then
			IdentityCard = IdentityCard + Trim(Rs.fields(0).value) + ","
		End if
		Rs.movenext
	Wend 
	Rs.close
	'//获取数据库职员表的编号串
	Number = ","
	strSQL = "select distinct Number from Employees where Number is not null"
	Rs.Open strSQL, Conn, 1, 1
	While Not Rs.eof
		If Rs.fields(0).value <> "" then
			Number = Number + Trim(Rs.fields(0).value) + ","
		End if
		Rs.movenext
	Wend
	Rs.close

	strField=Split(strValues,"|")  '获取页面传递的Excel数据
	strCard = Split(strField(0),",")
	 
	strRowField=Split(strField(0)+",",",")  'Excel行数据 
	
	'先将工号存在重复的查出来。
	strReNumbers=""
	strAllNumbers=""
	For i=1 To UBound(strField)-1
		strValField=Split(strField(i)+",",",") '行数据
		
		j=0
		While j<UBound(strRowField)
			If strRowField(j)="Number" Then
				strAllNumbers = strAllNumbers&"'"&Trim(strValField(j))&"',"
				'exit do
			end if
			j=j+1
		Wend
	Next
	if strAllNumbers<>"" then 
		strAllNumbers=left(strAllNumbers,len(strAllNumbers)-1)
		strSQL = "select Number from Employees where Number in ("&strAllNumbers&") and Left(IncumbencyStatus,1)<>'1' "
		Rs.Open strSQL, Conn, 1, 1
		While Not Rs.eof
			If Rs.fields(0).value <> "" then
				strReNumbers = strReNumbers + Trim(Rs.fields(0).value) + ","
			End if
			Rs.movenext
		Wend
		Rs.close
	end if
	if strReNumbers <> "" then 
		Call fCloseADO()
		Call ReturnMsg("false",GetToolLbl("FollowingNum")&strReNumbers,0)	'"以下工号重复："
		response.End()
	end if

	'如果没有选卡号，要人为的加上，此字段在数据库中不能为空
	CardFlag = 1 
	For i = 0 To UBound(strCard)
		If strCard(i) = "Card" Then 
			CardFlag = 0
			Exit For 
		End If 
	Next 

	If CardFlag = "1" Then 
		strField(0) = "Card,"+strField(0)
	End If 
	
	''RoleId = fGetOneField("UserRole", "RoleId", "UserId="+cstr(UserId))
	'//新的部门编号，名称
	strNewDept=""
	strNewCode = ""
	isNewDept=0
	Number1 = 0
	Dim rowNum, n 'rowNum 修改成功的行数, n执行修改时受影响的行数
	rowNum = 0
	For i=1 To UBound(strField)-1
		n = 0
	 	strCode = ""

		'如果没有选卡号，要人为的加上卡号值0
		If CardFlag Then strField(i) = "0,"+strField(i)

	 	strValField=Split(strField(i)+",",",") '行数据
	 	'// 导入表的sql语句
	 	j=0
	 	iSQL = ""
	 	strSQL="insert into Employees("+Trim(strField(0))+")  select "
	 	While j<UBound(strRowField)
	 		If strRowField(j)="DepartmentId" Then
				isNewDept = 0
	 			'//判断数据库里部门是否存在
				'''如果是父部门，则选择该父部门最底级的部门。
	 			''sql="select DepartmentId,DepartmentCode from Departments where DepartmentCode like (select DepartmentCode+'%' from Departments where DepartmentName='"+Trim(strValField(j))+"') order by DepartmentCode"
	 			''Rs.open sql, Conn, 1, 1
	 			''Do While Not Rs.eof
	 			''	If Not IsNull(Trim(Rs("DepartmentId"))) Then
	 			''		strCode=Trim(Rs("DepartmentId"))
	 			''	End If
	 			''	Rs.movenext
	 			''	If Not Rs.eof Then
	 			''		If Not IsNull(Rs("DepartmentCode")) And Len(strCode)>=Len(Rs("DepartmentCode")) Then
	 			''			Exit Do
	 			''		End if
	 			''	ElseIf Rs.eof Then
	 			''		Exit do
	 			''	End if
	 			''loop
	 			''Rs.close
				'20141019 去掉上述注释的代码，直接将数据导入传入的部门名称的部门中。不再判断是否为父部门
				sql="select DepartmentId,DepartmentCode from Departments where DepartmentName='"+Trim(strValField(j))+"' order by DepartmentCode"
	 			Rs.open sql, Conn, 1, 1
	 			If Not Rs.eof Then
	 				If Not IsNull(Trim(Rs("DepartmentId"))) Then
	 					strCode=Trim(Rs("DepartmentId"))
	 				End If
				End If
				Rs.close
	 			'//判断导入的表中是否存在同名的部门
	 			If strCode ="" And strNewDept<>"" Then
	 				strTemp = Split(strNewDept,",")
	 				k = ""
	 				For l=0 To UBound(strTemp)-1
	 					If Trim(strTemp(l))=Trim(strValField(j)) Then
	 						k = l
	 					End if
	 				Next
	 				If k <> "" Then
	 					strTemp = Split(strNewCode,",")
	 					strCode = strTemp(k)
	 				End if
	 			End if
				
	 			If strCode="" then
	 				'部门名不存在，生成一个一级部门编码
	 				strTemp = Split(strNewCode,",")
	 				If UBound(strTemp)>0 then
						'ReturnErrMsg "111"&strNewCode&"|"
	 					k = CInt(Mid(trim(strTemp(UBound(strTemp)-1)),1,5))+1
	 				Else
						'ReturnErrMsg "222"&strNewCode&"|"
	 					sql="select top 1 DepartmentCode from Departments order by DepartmentCode desc"
	 					Rs.open sql, Conn, 1, 1
	 					If Not Rs.eof Then
	 						If Not IsNull(Trim(Rs.fields(0).value)) Then
	 							k=CInt(Mid(trim(Rs("DepartmentCode")),1,5))+1
	 						Else
	 							k = 1
	 						End If
	 					Else
	 						k = 1
	 					End If
	 					Rs.close
	 				End if	
	 				If Len(Trim(k))=1 Then
	 					strCode="0000"+Trim(k)
	 				ElseIf Len(Trim(k))=2 Then
	 					strCode="000"+Trim(k)
	 				ElseIf Len(Trim(k))=3 Then
	 					strCode="00"+Trim(k)
	 				ElseIf Len(Trim(k))=4 Then
	 					strCode="0"+Trim(k)
	 				ElseIf Len(Trim(k))=5 Then
	 					strCode=Trim(k)
	 				End If
	 				'//保存导入表中的不相同的部门名称
	 				strNewDept = strNewDept + Trim(strValField(j)) + ","
	 				strNewCode = strNewCode + Trim(strCode) + ","
					'ReturnErrMsg "222"&strNewCode&"|"&strCode
	 				iSQL = iSQL + "insert into Departments(DepartmentCode,DepartmentName,ParentDepartmentID) values('"+Trim(strCode)+"','"+Trim(strValField(j))+"',0);"
					isNewDept = 1
	 				'// 添加Admin用户的新部门访问权限 
	 				'iSQL = iSQL + "insert into RoleDepartment(UserId,DepartmentCode,Permission) values(1,'"+Trim(strCode)+"',1);"
	 			End If
				if isNewDept = 0 then 
	 				strSQL=strSQL+"'"+Trim(strCode)+"',"
				else
					strSQL=strSQL+"(select top 1 DepartmentID from Departments where DepartmentCode='"+Trim(strCode)+"') as DepartmentID,"
				end if	
	 		ElseIf strRowField(j)="Number" Then
	 			'//判断编号是否存在
	 			If strValField(j) <> "" then
					strNumbers = strNumbers&"'"&Trim(strValField(j))&"',"
	 				strTemp = ""
	 				If Number <> "" then
	 					strTemp = InStr(Trim(Number),","+Trim(strValField(j))+",")
	 					If strTemp > 0 Then
	 						'//存在相同的编号
	 						strSQL=strSQL+"null,"
	 						Number1 = 1
	 					Else
	 						strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 						Number = Number + Trim(strValField(j)) + ","
	 					End if
	 				Else
	 					strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 					Number = Number + Trim(strValField(j)) + ","
	 				End If
	 			Else
	 				strSQL=strSQL+"null,"
	 			End if
	 		ElseIf strRowField(j)="Card" Then
	 			'// 判断卡号是否重复
	 			If strValField(j) <> "" Then
	 				If Not IsNumeric(strValField(j))  Then 
						Call fCloseADO()
						Call ReturnMsg("false",GetToolLbl("CardDigital"),0)	'"卡号只能是数字"
						response.End()
					End If
					If Len(strValField(j)) > 10 Then 
						Call fCloseADO()
						Call ReturnMsg("false",GetToolLbl("CardMt10"),0)	'"卡号不能大于10位"
						response.End()
					End If
	 				strTemp = ""
	 				If Card <> "" Then
	 					strTemp = InStr(Trim(Card),","+Trim(strValField(j))+",")
	 					If strTemp > 0 Then
	 						'//存在相同的卡号
	 						strSQL=strSQL+"0,"
	 					Else
	 						strSQL=strSQL+Trim(strValField(j))+","
	 						Card = Card + Trim(strValField(j)) + ","
	 					End if
	 				Else
	 					strSQL=strSQL+Trim(strValField(j))+","
	 					Card = Card + Trim(strValField(j)) + ","
	 				End If
	 			Else
	 				strSQL=strSQL+"0,"
	 			End if
	 		ElseIf strRowField(j)="IdentityCard" Then
	 			'// 判断身份证号是否重复
	 			If strValField(j) <> "" then
	 				strTemp = ""
	 				If IdentityCard <> "" then
	 					strTemp = InStr(Trim(IdentityCard),","+Trim(strValField(j))+",")
	 					If strTemp > 0 Then
	 						'//存在相同的身份证号
	 						strSQL=strSQL+"null,"
	 					Else
	 						strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 						IdentityCard = IdentityCard + Trim(strValField(j)) + ","
	 					End if
	 				Else
	 					strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 					IdentityCard = IdentityCard + Trim(strValField(j)) + ","
	 				End If
	 			Else
	 				strSQL=strSQL+"null,"
	 			End if
	 		ElseIf strRowField(j)="Headship" Then
	 			'//判断职务是否存在
	 			If strValField(j) <> "" then
	 				strTemp = ""
	 				If Headship1 <> "" then
	 					strTemp = InStr(Trim(Headship1),Trim(strValField(j)))
	 					If strTemp > 0 Then
	 						strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 					else
	 						'//添加新职务
	 						iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(Headship)+",'"+Trim(strValField(j))+"');"
	 						strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 						Headship1 = Headship1 + Trim(strValField(j)) + ","
	 					End if
	 				Else
	 					iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(Headship)+",'"+Trim(strValField(j))+"');"
	 					strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 					Headship1 = Headship1 + Trim(strValField(j)) + ","
	 				End If
	 			Else
	 				strSQL=strSQL+"null,"
	 			End if
	 		ElseIf strRowField(j)="Country" Then
	 			'//判断国籍是否存在
	 			If strValField(j) <> "" Then
	 				strTemp = ""
	 				If Country1 <> "" then
	 					strTemp = InStr(Trim(Country1),Trim(strValField(j)))
	 					If strTemp > 0 Then
	 						strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 					else
	 						'//添加新国籍
	 						iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(Country)+",'"+Trim(strValField(j))+"');"
	 						strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 						Country1 = Country1 + Trim(strValField(j)) + ","
	 					End if
	 				Else
	 					iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(Country)+",'"+Trim(strValField(j))+"');"
	 					strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 					Country1 = Country1 + Trim(strValField(j)) + ","
	 				End If
	 			Else
	 				strSQL=strSQL+"null,"
	 			End if
	 		ElseIf strRowField(j)="NativePlace" Then
	 			'//判断籍贯是否存在
	 			If strValField(j) <> "" then
	 				strTemp = ""
	 				If NativePlace1 <> "" then
	 					strTemp = InStr(Trim(NativePlace1),Trim(strValField(j)))
	 					If strTemp > 0 Then
	 						strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 					else
	 						'//添加新籍贯
	 						iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(NativePlace)+",'"+Trim(strValField(j))+"');"
	 						strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 						NativePlace1 = NativePlace1 + Trim(strValField(j)) + ","
	 					End if
	 				Else
	 					iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(NativePlace)+",'"+Trim(strValField(j))+"');"
	 					strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 					NativePlace1 = NativePlace1 + Trim(strValField(j)) + ","
	 				End If
	 			Else
	 				strSQL=strSQL+"null,"
	 			End if
	 		ElseIf strRowField(j)="Position" Then
	 			'//判断职位是否存在
	 			If strValField(j) <> "" then
	 				strTemp = ""
	 				If Position1 <> "" then
	 					strTemp = InStr(Trim(Position1),Trim(strValField(j)))
	 					If strTemp > 0 Then
	 						strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 					else
	 						'//添加新职位
	 						iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(Position)+",'"+Trim(strValField(j))+"');"
	 						strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 						Position1 = Position1 + Trim(strValField(j)) + ","
	 					End if
	 				Else
	 					iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(Position)+",'"+Trim(strValField(j))+"');"
	 					strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 					Position1 = Position1 + Trim(strValField(j)) + ","
	 				End If
	 			Else
	 				strSQL=strSQL+"null,"
	 			End if
	 		ElseIf strRowField(j)="Knowledge" Then
	 			'//判断学历是否存在
	 			If strValField(j) <> "" then
	 				strTemp = ""
	 				If Knowledge1 <> "" then
	 					strTemp = InStr(Trim(Knowledge1),Trim(strValField(j)))
	 					If strTemp > 0 Then
	 						strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 					else
	 						'//添加新学历
	 						iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(Knowledge)+",'"+Trim(strValField(j))+"');"
	 						strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 						Knowledge1 = Knowledge1 + Trim(strValField(j)) + ","
	 					End if
	 				Else
	 					iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(Knowledge)+",'"+Trim(strValField(j))+"');"
	 					strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 					Knowledge1 = Knowledge1 + Trim(strValField(j)) + ","
	 				End If
	 			Else
	 				strSQL=strSQL+"null,"
	 			End If
	 		ElseIf strRowField(j)="JoinDate" Then
	 			'If strValField(j) <> "" Then
	 				If Not IsDate(strValField(j))  Then 
						Call fCloseADO()
						Call ReturnMsg("false",GetToolLbl("JoinDateFormatError"),0)	'"入职时间格式不对，应为（YYYY-MM-DD）"
						response.End()
					End If
	 				strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 			'Else
	 				'strSQL=strSQL+"'"+Trim(date)+"',"
					'Call fCloseADO()
					'Call ReturnMsg("false","入职时间格式不能为空",0)
					'response.End()
	 			'End If
	 		ElseIf strRowField(j)="Marry" Then
	 			If strValField(j) <> "" then
	 				If Trim(strValField(j)) = GetEquLbl("Married") Or Trim(strValField(j)) = GetToolLbl("Married2") Then	'已婚  '婚
	 					strSQL=strSQL+"'"&GetEquLbl("Married")&"',"	'已婚
	 				ElseIf Trim(strValField(j)) = GetEquLbl("Unmarried") Or Trim(strValField(j)) = GetToolLbl("Unmarried2") Then	''未婚  '否
	 					strSQL=strSQL+"'"&GetEquLbl("Unmarried")&"',"	'未婚 
	 				else
	 					strSQL=strSQL+"null,"
	 				End if
	 			Else
	 				strSQL=strSQL+"null,"
	 			End If
	 		ElseIf strRowField(j)="BirthDate" Then
				If Not IsNull(strValField(j)) And strValField(j) <> "" Then 
					If Not IsDate(strValField(j)) Then 
						Call fCloseADO()
						Call ReturnMsg("false",GetToolLbl("BirthDateFormatError"),0)	'"出生日期格式不对，应为（YYYY-MM-DD）"
						response.End()
					End If
				End If 
				strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 		Else
	 			If strValField(j) <> "" Then
	 				strSQL=strSQL+"'"+Trim(strValField(j))+"',"
	 			Else
	 				strSQL=strSQL+"null,"
	 			End if
	 		End If
	 		j=j+1
	 	Wend
	 	strSQL = Trim(Left(strSQL,Len(strSQL)-1))+" "
	 	iSQL = iSQL + strSQL + ";"

	 	
	 	On Error Resume Next
	 	Conn.execute iSQL, n
	 	
	 	if err.number <> 0 then 
	 		On Error GoTo 0
			Call fCloseADO()
			'Call ReturnMsg("false","导入第"+Trim(i)+"条人事资料出错！",0)
			Call ReturnMsg("false",GetToolLbl("AddFailMsg1")+Trim(i)+GetToolLbl("AddFailMsg2"),0)
			response.End()
		else
			if n <> 0 Then rowNum = rowNum + 1 
	 	end If
	 Next
			
	'Call AddLogEvent("工具-人事导入","导入新增","记录数: "+cstr(i-1))
	Call AddLogEvent(GetToolLbl("Tool")&"-"&GetToolLbl("EmpImport"),GetToolLbl("ImportAdd"),GetToolLbl("Records")+cstr(i-1))
	
	'导入的人事资料，按模板自动注册到设备
	if strNumbers <> "" then 
		strNumbers=left(strNumbers,InStrRev(strNumbers,",")-1)
		strEmpWhere = "Select Employeeid From Employees where Number in ("&strNumbers&") and Left(IncumbencyStatus,1)<>'1' "
		'取有访问权限的部门
		if strUserId<>"1" then '1 为admin用户
			strEmpWhere = strEmpWhere & " and DepartmentID in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1) "
		end if 
		
		'取有访问权限的设备
		strConWhere = ""
		if strUserId<>"1" then '1 为admin用户
			strConWhere = " select ControllerID from RoleController where UserId in ("&strUserId&") and Permission=1 "
		end if 
		
		On Error Resume Next		
		set recom = server.createobject("adodb.command")
		recom.activeconnection = Conn
		recom.commandtype = 4
		recom.CommandTimeout = 0
		recom.Prepared = true
		recom.Commandtext = "pRegCardTemplateRegisterAll"
		recom.Parameters(1) = "0"	'0为追加注册。（已注册的不做修改。当有多个模板时，ID最大的优先注册）
		recom.Parameters(2) = strEmpWhere	'员工ID
		recom.Parameters(3) = strConWhere	'有权限的设备 
		
		On Error Resume Next	
		recom.execute()
		strActions = GetCerbLbl("strLogAdd")
		if err.number <> 0 then
			'Call AddLogEvent("工具-人事导入-自动注册",cstr(strActions),cstr(strActions)&"注册卡号,模板自动注册到设备失败")
			Call AddLogEvent(GetToolLbl("Tool")&"-"&GetToolLbl("EmpImport")&"-"&GetEmpLbl("AutoReg"),cstr(strActions),cstr(strActions)&GetToolLbl("AutoRegFail"))
		End if	
		Call AddLogEvent(GetToolLbl("Tool")&"-"&GetToolLbl("EmpImport")&"-"&GetEmpLbl("AutoReg"),cstr(strActions),cstr(strActions)&GetToolLbl("AutoRegSuccess"))
	end if 
'//**************************************************************************************************************//
	Call fCloseADO()        '//销毁对象
	'Call ReturnMsg("true","导入"+Trim(rowNum)+"条人事资料成功！",0)
	Call ReturnMsg("true",GetToolLbl("AddImportSuccMsg1")+Trim(rowNum)+GetToolLbl("AddImportSuccMsg2"),0)
	response.End()
%>

