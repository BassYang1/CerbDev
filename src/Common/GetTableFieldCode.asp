<!--#include file="Page.asp" -->
<!--#include file="..\Conn\conn.asp" -->
<%
dim strType,strSQL,strJS,selID
strType = Request.QueryString("type")
selID = Cstr(Trim(Request.QueryString("selID")))
fConnectADODB()

if strType = "headship" then 
	strSQL = "select FieldId,Content from TableFieldCode where FieldID=3 order by RecordID "
	if selID <>  "" then 
		strJS = "<select  id='"+selID+"'  class='FormElement ui-widget-content ui-corner-all' >"
	else
		strJS = "<select class='FormElement ui-widget-content ui-corner-all' >"
	end if
	Rs.open strSQL, Conn, 1, 1
	while NOT Rs.EOF
		if instr(trim(Rs.fields("Content").value), "'") > 0 then
			strJS = strJS + "<option value ='"+trim(Rs.fields("Content").value)+"'>" + GetSafeJs(trim(Rs.fields("Content").value)) + "</option>"
		else
			strJS = strJS + "<option value ='"+trim(Rs.fields("Content").value)+"'>" + trim(Rs.fields("Content").value) + "</option>"
		end if
		Rs.movenext
		i = i + 1
	wend
	Rs.close

	strJS = strJS + "</select>"
	response.write strJS
ElseIF strType = "position" then 
	strSQL = "select FieldId,Content from TableFieldCode where FieldID=4 order by RecordID "
	if selID <>  "" then 
		strJS = "<select  id='"+selID+"'  class='FormElement ui-widget-content ui-corner-all' >"
	else
		strJS = "<select class='FormElement ui-widget-content ui-corner-all' >"
	end if
	Rs.open strSQL, Conn, 1, 1
	while NOT Rs.EOF
		if instr(trim(Rs.fields("Content").value), "'") > 0 then
			strJS = strJS + "<option value ='"+trim(Rs.fields("Content").value)+"'>" + GetSafeJs(trim(Rs.fields("Content").value)) + "</option>"
		else
			strJS = strJS + "<option value ='"+trim(Rs.fields("Content").value)+"'>" + trim(Rs.fields("Content").value) + "</option>"
		end if
		Rs.movenext
		i = i + 1
	wend
	Rs.close

	strJS = strJS + "</select>"
	response.write strJS
ElseIF strType = "country" then 
	strSQL = "select FieldId,Content from TableFieldCode where FieldID=1 order by Content "
	if selID <>  "" then 
		strJS = "<select  id='"+selID+"'  class='FormElement ui-widget-content ui-corner-all' >"
	else
		strJS = "<select class='FormElement ui-widget-content ui-corner-all' >"
	end if
	Rs.open strSQL, Conn, 1, 1
	while NOT Rs.EOF
		if instr(trim(Rs.fields("Content").value), "'") > 0 then
			strJS = strJS + "<option value ='"+trim(Rs.fields("Content").value)+"'>" + GetSafeJs(trim(Rs.fields("Content").value)) + "</option>"
		else
			strJS = strJS + "<option value ='"+trim(Rs.fields("Content").value)+"'>" + trim(Rs.fields("Content").value) + "</option>"
		end if
		Rs.movenext
		i = i + 1
	wend
	Rs.close

	strJS = strJS + "</select>"
	response.write strJS
ElseIF strType = "nativeplace" then 
	strSQL = "select FieldId,Content from TableFieldCode where FieldID=2 order by RecordID "
	if selID <>  "" then 
		strJS = "<select  id='"+selID+"'  class='FormElement ui-widget-content ui-corner-all' >"
	else
		strJS = "<select class='FormElement ui-widget-content ui-corner-all' >"
	end if
	Rs.open strSQL, Conn, 1, 1
	while NOT Rs.EOF
		if instr(trim(Rs.fields("Content").value), "'") > 0 then
			strJS = strJS + "<option value ='"+trim(Rs.fields("Content").value)+"'>" + GetSafeJs(trim(Rs.fields("Content").value)) + "</option>"
		else
			strJS = strJS + "<option value ='"+trim(Rs.fields("Content").value)+"'>" + trim(Rs.fields("Content").value) + "</option>"
		end if
		Rs.movenext
		i = i + 1
	wend
	Rs.close

	strJS = strJS + "</select>"
	response.write strJS
ElseIF strType = "knowledge" then 
	strSQL = "select FieldId,Content from TableFieldCode where FieldID=5 order by RecordID "
	if selID <>  "" then 
		strJS = "<select  id='"+selID+"'  class='FormElement ui-widget-content ui-corner-all' >"
	else
		strJS = "<select class='FormElement ui-widget-content ui-corner-all' >"
	end if
	Rs.open strSQL, Conn, 1, 1
	while NOT Rs.EOF
		if instr(trim(Rs.fields("Content").value), "'") > 0 then
			strJS = strJS + "<option value ='"+trim(Rs.fields("Content").value)+"'>" + GetSafeJs(trim(Rs.fields("Content").value)) + "</option>"
		else
			strJS = strJS + "<option value ='"+trim(Rs.fields("Content").value)+"'>" + trim(Rs.fields("Content").value) + "</option>"
		end if
		Rs.movenext
		i = i + 1
	wend
	Rs.close

	strJS = strJS + "</select>"
	response.write strJS
End IF
fCloseADO()
%>