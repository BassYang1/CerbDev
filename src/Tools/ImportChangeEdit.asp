<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
'response.Charset="gb2312"
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()
	'//*********定义变量*********//
	Dim strSQL,iSQL
	Dim RoleId
	Dim Knowledge,Country,NativePlace,Headship,Position,DepartmentCode,Number,Name,BirthDate,JoinDate,IncumbencyStatus,TryoutDay,RetiringAge,NumberOfYear,Grade,Card,IdentityCard
	Dim strDept,strCode,strNewCode,strNewDept,strNewNumber,strNumber,strNumbers
	Dim strField,strRowField,strValField
	Dim i,j,k,l,strTemp
	Dim Knowledge1,Country1,NativePlace1,Headship1,Position1
	Dim iBrowse,iOperate
	Dim CardFlag
	
	'//*******************数据库连接***************//
	'---------------------------------------------------------------

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

	'如果没有选卡号，要人为的加上，此字段在数据库中不能为空
	CardFlag = 1 
	For i = 0 To UBound(strCard)
		If strCard(i) = "Card" Then 
			CardFlag = 0
			Exit For 
		End If 
	Next 

	'If CardFlag = "1" Then 
		'strField(0) = "Card,"+strField(0)
	'End If 
	 

	strRowField=Split(strField(0)+",",",")  'Excel行数据 
	
	'VBErrorMsg "参数错误！"&CStr(strRowField), ""
	''RoleId = fGetOneField("UserRole", "RoleId", "UserId="+cstr(UserId))
	'//新的部门编号，名称
	strNewDept=""
	strNewCode = ""
	Number1 = 0
	
	Dim strNum '要修改的人事关联系条件:编号Number
	Dim rowNum, n 'rowNum 修改成功的行数, n执行修改时受影响的行数
	rowNum = 0
	For i=1 To UBound(strField)-1
		n = 0
	 	strCode = ""
		strCond = ""
		'如果没有选卡号，要人为的加上卡号值0
		'If CardFlag Then strField(i) = "0,"+strField(i)

	 	strValField=Split(strField(i)+",",",") '行数据
	 	'// 导入表的sql语句
	 	j=0
	 	iSQL = ""
	 	'strSQL="update Employees set "
		strSQL = ""
		strNum = ""
	 	While j<UBound(strRowField)
	 		If strRowField(j)="DepartmentId" Then
	 			'//判断数据库里部门是否存在
	 			sql="select DepartmentId,DepartmentCode from Departments where DepartmentCode like (select DepartmentCode+'%' from Departments where DepartmentName='"+Trim(strValField(j))+"') order by DepartmentCode"
	 			Rs.open sql, Conn, 1, 1
	 			Do While Not Rs.eof
	 				If Not IsNull(Trim(Rs("DepartmentId"))) Then
	 					strCode=Trim(Rs("DepartmentId"))
	 				End If
	 				Rs.movenext
	 				If Not Rs.eof Then
	 					If Not IsNull(Rs("DepartmentCode")) And Len(strCode)>=Len(Rs("DepartmentCode")) Then
	 						Exit Do
	 					End if
	 				ElseIf Rs.eof Then
	 					Exit do
	 				End if
	 			loop
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
	 					k = CInt(Mid(trim(strTemp(UBound(strTemp)-1)),1,5))+1
	 				Else
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
	 				iSQL = iSQL + "insert into Departments(DepartmentCode,DepartmentName,ParentDepartmentID) values('"+Trim(strCode)+"','"+Trim(strValField(j))+"',0);"
	 				'iSQL = iSQL + "insert into RoleDepartment(RoleId,DepartmentCode,Permission) values("+Trim(RoleId)+",'"+Trim(strCode)+"',1);"
	 				'// 添加Admin用户的新部门访问权限 
	 				'iSQL = iSQL + "insert into RoleDepartment(UserId,DepartmentCode,Permission) values(1,'"+Trim(strCode)+"',1);"
	 			End If
	 			strSQL=strSQL+",DepartmentId='"+Trim(strCode)+"'"
	 		ElseIf strRowField(j)="Number" Then
	 			'//条件:编号
				strNumbers = strNumbers&"'"&Trim(strValField(j))&"',"
				strNum = Trim(strValField(j))
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
	 			
					strSQL=strSQL + ",card="+Trim(strValField(j))
					Card = Card + Trim(strValField(j)) + ","
	 			Else
	 				strSQL=strSQL+",card=0"
	 			End if
	 		ElseIf strRowField(j)="IdentityCard" Then
	 			'// 判断身份证号是否重复
	 			If strValField(j) <> "" then
					strSQL=strSQL+",IdentityCard='"+Trim(strValField(j))+"'"
					IdentityCard = IdentityCard + Trim(strValField(j)) + ","
	 			Else
	 				strSQL=strSQL+",IdentityCard=null"
	 			End if
	 		ElseIf strRowField(j)="Headship" Then
	 			'//判断职务是否存在
	 			If strValField(j) <> "" then
	 				strTemp = ""
	 				If Headship1 <> "" then
	 					strTemp = InStr(Trim(Headship1),Trim(strValField(j)))
	 					If strTemp > 0 Then
	 						strSQL=strSQL+",Headship='"+Trim(strValField(j))+"'"
	 					else
	 						'//添加新职务
	 						iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(Headship)+",'"+Trim(strValField(j))+"');"
	 						strSQL=strSQL+",Headship='"+Trim(strValField(j))+"'"
	 						Headship1 = Headship1 + Trim(strValField(j)) + ","
	 					End if
	 				Else
	 					iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(Headship)+",'"+Trim(strValField(j))+"');"
	 					strSQL=strSQL+",Headship='"+Trim(strValField(j))+"'"
	 					Headship1 = Headship1 + Trim(strValField(j)) + ","
	 				End If
	 			Else
	 				strSQL=strSQL+",Headship=null"
	 			End if
	 		ElseIf strRowField(j)="Country" Then
	 			'//判断国籍是否存在
	 			If strValField(j) <> "" Then
	 				strTemp = ""
	 				If Country1 <> "" then
	 					strTemp = InStr(Trim(Country1),Trim(strValField(j)))
	 					If strTemp > 0 Then
	 						strSQL=strSQL+",Country='"+Trim(strValField(j))+"'"
	 					else
	 						'//添加新职务
	 						iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(Country)+",'"+Trim(strValField(j))+"');"
	 						strSQL=strSQL+",Country='"+Trim(strValField(j))+"'"
	 						Country1 = Country1 + Trim(strValField(j)) + ","
	 					End if
	 				Else
	 					iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(Country)+",'"+Trim(strValField(j))+"');"
	 					strSQL=strSQL+",Country='"+Trim(strValField(j))+"'"
	 					Country1 = Country1 + Trim(strValField(j)) + ","
	 				End If
	 			Else
	 				strSQL=strSQL+",Country=null"
	 			End if
	 		ElseIf strRowField(j)="NativePlace" Then
	 			'//判断籍贯是否存在
	 			If strValField(j) <> "" then
	 				strTemp = ""
	 				If NativePlace1 <> "" then
	 					strTemp = InStr(Trim(NativePlace1),Trim(strValField(j)))
	 					If strTemp > 0 Then
	 						strSQL=strSQL+",NativePlace='"+Trim(strValField(j))+"'"
	 					else
	 						'//添加新职务
	 						iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(NativePlace)+",'"+Trim(strValField(j))+"');"
	 						strSQL=strSQL+"NativePlace='"+Trim(strValField(j))+"'"
	 						NativePlace1 = NativePlace1 + Trim(strValField(j)) + ","
	 					End if
	 				Else
	 					iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(NativePlace)+",'"+Trim(strValField(j))+"');"
	 					strSQL=strSQL+",NativePlace='"+Trim(strValField(j))+"'"
	 					NativePlace1 = NativePlace1 + Trim(strValField(j)) + ","
	 				End If
	 			Else
	 				strSQL=strSQL+",NativePlace=null,"
	 			End if
	 		ElseIf strRowField(j)="Position" Then
	 			'//判断职位是否存在
	 			If strValField(j) <> "" then
	 				strTemp = ""
	 				If Position1 <> "" then
	 					strTemp = InStr(Trim(Position1),Trim(strValField(j)))
	 					If strTemp > 0 Then
	 						strSQL=strSQL+",Position='"+Trim(strValField(j))+"'"
	 					else
	 						'//添加新职务
	 						iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(Position)+",'"+Trim(strValField(j))+"');"
	 						strSQL=strSQL+",Position='"+Trim(strValField(j))+"'"
	 						Position1 = Position1 + Trim(strValField(j)) + ","
	 					End if
	 				Else
	 					iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(Position)+",'"+Trim(strValField(j))+"');"
	 					strSQL=strSQL+",Position='"+Trim(strValField(j))+"',="
	 					Position1 = Position1 + Trim(strValField(j)) + ","
	 				End If
	 			Else
	 				strSQL=strSQL+",Position=null"
	 			End if
	 		ElseIf strRowField(j)="Knowledge" Then
	 			'//判断学历是否存在
	 			If strValField(j) <> "" then
	 				strTemp = ""
	 				If Knowledge1 <> "" then
	 					strTemp = InStr(Trim(Knowledge1),Trim(strValField(j)))
	 					If strTemp > 0 Then
	 						strSQL=strSQL+",Knowledge='"+Trim(strValField(j))+"'"
	 					else
	 						'//添加新职务
	 						iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(Knowledge)+",'"+Trim(strValField(j))+"');"
	 						strSQL=strSQL+",Knowledge='"+Trim(strValField(j))+"'"
	 						Knowledge1 = Knowledge1 + Trim(strValField(j)) + ","
	 					End if
	 				Else
	 					iSQL = iSQL + "insert into TableFieldCode(FieldId,Content)  values("+Trim(Knowledge)+",'"+Trim(strValField(j))+"');"
	 					strSQL=strSQL+",Knowledge='"+Trim(strValField(j))+"'"
	 					Knowledge1 = Knowledge1 + Trim(strValField(j)) + ","
	 				End If
	 			Else
	 				strSQL=strSQL+",Knowledge=null"
	 			End If
	 		ElseIf strRowField(j)="JoinDate" Then
	 			If strValField(j) <> "" Then
	 				If Not IsDate(strValField(j))  Then 
						Call fCloseADO()
						Call ReturnMsg("false",GetToolLbl("JoinDateFormatError"),0)	'"入职时间格式不对，应为（YYYY-MM-DD）"
						response.End()
					End If
	 				strSQL=strSQL+",JoinDate='"+Trim(strValField(j))+"'"
				End if
	 			'Else
	 				'strSQL=strSQL+"'"+Trim(date)+"',"
					'Call fCloseADO()
					'Call ReturnMsg("false","入职时间格式不能为空",0)
					'response.End()
	 			'End If
	 		ElseIf strRowField(j)="Marry" Then
	 			If strValField(j) <> "" then
	 				If Trim(strValField(j)) = GetEquLbl("Married") Or Trim(strValField(j)) = GetToolLbl("Married2") Then	'已婚  '婚
	 					strSQL=strSQL+",Marry='"&GetEquLbl("Married")&"'"	'已婚
	 				ElseIf Trim(strValField(j)) = GetEquLbl("Unmarried") Or Trim(strValField(j)) = GetToolLbl("Unmarried2") Then	'未婚  '否
	 					strSQL=strSQL+",Marry='"&GetEquLbl("Unmarried")&"'"	'未婚 
	 				else
	 					strSQL=strSQL+",Marry=null"
	 				End if
	 			Else
	 				strSQL=strSQL+",Marry=null"
	 			End If
	 		ElseIf strRowField(j)="BirthDate" Then
				If Not IsNull(strValField(j)) And strValField(j) <> "" Then 
					If Not IsDate(strValField(j)) Then 
						Call fCloseADO()
						Call ReturnMsg("false",GetToolLbl("BirthDateFormatError"),0)	'"出生日期格式不对，应为（YYYY-MM-DD）"
						response.End()
					End If
				End If 
				strSQL=strSQL+",BirthDate='"+Trim(strValField(j))+"'"
			ElseIf strRowField(j)="Name" Then
	 			If strValField(j) <> "" Then
	 				strSQL=strSQL+",Name='"+Trim(strValField(j))+"'"
	 			Else
	 				strSQL=strSQL+",Name=null"
	 			End if
			ElseIf strRowField(j)="Sex" Then
	 			If strValField(j) <> "" Then
	 				strSQL=strSQL+",Sex='"+Trim(strValField(j))+"'"
	 			Else
	 				strSQL=strSQL+",Sex=null"
	 			End if
			ElseIf strRowField(j)="IncumbencyStatus" Then
				'不做处理
	 		Else
	 			If strValField(j) <> "" Then
	 				strSQL=strSQL+"," + strRowField(j) + "='"+Trim(strValField(j))+"'"
	 			Else
	 				strSQL=strSQL+"," + strRowField(j) + "=null"
	 			End if
	 		End If
	 		j=j+1
	 	Wend
		
		strSQL = right(strSQL,Len(strSQL)-1)
		strSQL = "update employees set " + strSQL + " where left(IncumbencyStatus,1)<>'1' and number='" + strNum + "'"
		iSQL = iSQL + strSQL
		
	 	On Error Resume Next
	 	Conn.execute iSQL, n
	 	
	 	if err.number <> 0 then 
	 		On Error GoTo 0
			Call fCloseADO()
			'Call ReturnMsg("false","修改第"+Trim(i)+"条人事资料出错！",0)
			Call ReturnMsg("false",GetToolLbl("EditFailMsg1")+Trim(i)+GetToolLbl("EditFailMsg2"),0)
			response.End()
			strNum = "" 
		else
			if n <> 0 Then rowNum = rowNum + 1
	 	end If

	 Next
		
	'导入的人事资料（修改），重新同步到设备
	if strNumbers <> "" then 
		strNumbers=left(strNumbers,InStrRev(strNumbers,",")-1)
		strSQL = "Update ControllerEmployee set Status='0' where employeeid in (Select Employeeid From Employees where Number in ("&strNumbers&")) "
		strSQL = strSQL & "; Update ControllerDataSync Set SyncStatus='0' where SyncType='register' "
		On Error Resume Next	
		Conn.Execute strSQL
	end if	
	
	'Call AddLogEvent("工具-人事导入","导入修改","记录数: "+cstr(i-1))
	Call AddLogEvent(GetToolLbl("Tool")&"-"&GetToolLbl("EmpImport"),GetToolLbl("ImportEdit"),GetToolLbl("Records")+cstr(i-1))
	
'//**************************************************************************************************************//
	Call fCloseADO()        '//销毁对象
	'Call ReturnMsg("true","修改"+Trim(rowNum)+"条人事资料成功！",0)
	Call ReturnMsg("true",GetToolLbl("EditSuccessMsg1")+Trim(rowNum)+GetToolLbl("EditSuccessMsg2"),0)
	response.End()
%>

