<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\GetLbl.asp"-->
<%

dim strConId,strEmpId,iDoor,iSearch

strConId = Cstr(Trim(Request.QueryString("ControllerID")))
strEmpId = Cstr(Trim(Request.QueryString("EmployeeID")))

%>
<div id="divFormError" class="ui-state-error" style="display:none;"></div>
<table width=100% border=0 cellpadding=2 cellspacing=1 bgcolor="#d3d3d3">
	<tr bgcolor="#FFFFFF">
	  <td colspan=2 align="center"><%=GetEquLbl("RegMode")%><!--注册方式：--></td>
	  <td colspan=16 align="center"><div align="left" class="ui-jqdialog-content ui-widget-content">
		<input type="radio" name="regCrad" value="0" id="reg1"  onClick="fCheckRegCardType()"><label for="reg1"><%=GetEquLbl("RegModeVal0")%></label>        
		<input type="radio" name="regCrad" value="1" id="reg2" checked onClick="fCheckRegCardType()"><label for="reg2"><%=GetEquLbl("RegModeVal1")%></label>
		<input type="radio" name="regCrad" value="2" id="reg3" onClick="fCheckRegCardType()"><label for="reg3"><%=GetEquLbl("RegModeVal2")%></label> <input type="radio" name="regCrad" value="3" id="reg4" onClick="fCheckRegCardType()"><label for="reg4"><%=GetEquLbl("RegModeVal3")%></label>
		</div>                
	  </td>
	</tr>
	<tr bgcolor="#FFFFFF" id="trTypeValue" >
	  <td colspan=2 align="center"><div id="selRegCardTypeLabel"></div></td>
	  <td colspan=16 align="center"><div align="left">
		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td width="42%"><div id="selRegCardTypeValue" class="ui-jqdialog-content ui-widget-content" ><select name="selChange" id="selChange" class="FormElement ui-widget-content ui-corner-all" style="width:210px " onchange="SelCon(this)">
            </select></div></td>
			<td width="58%"></td>
		  </tr>
		</table>
		</div>                
	  </td>
	</tr>
	<tr bgcolor="#FFFFFF">
	  <td colspan=2 align="center"><%=GetEquLbl("EmpList")%><!--职员列表：--></td>
	  <td colspan=16 align="center"><div align="left">
		<TABLE width="100%" border="0" cellPadding=0 cellSpacing=0>
		  <TBODY>
			<TR  id="Act_Buttons">
			  <TD width="30%" valign="top"><div align="left" onDblClick="fInsertEm()" class="ui-jqdialog-content ui-widget-content"><select id="selSrc" name="selSrc" class="FormElement ui-widget-content ui-corner-all" size=10 multiple style="WIDTH: 240px"></select></div></TD>
			  <td width="18%"align=middle valign="middle" class="EditButton">
<a class="fm-button ui-state-default ui-corner-all fm-button-icon-left " id="add" onclick="fInsertEm()"><span class="ui-icon ui-icon-carat-1-e " style="position:relative;left: -13px;top: 8px;"></span><span class="ui-icon ui-icon-carat-1-e " style="position:relative;left: -8px;top: 0px;"></span></a>
<p>
<a class="fm-button ui-state-default ui-corner-all fm-button-icon-left" id="del" onclick="fDelEm()"><span class="ui-icon ui-icon-carat-1-w " style="position:relative;left: -13px;top: 8px;"></span><span class="ui-icon ui-icon-carat-1-w " style="position:relative;left: -8px;top: 0px;"></span></a>
 </td>
			  <TD width="52%" valign="top">
			  <div onDblClick="fDelEm()" class="ui-jqdialog-content ui-widget-content"><select id="selDesc" name="selDesc" style="WIDTH: 240px" multiple size=10 class="FormElement ui-widget-content ui-corner-all">
														  </select></div></TD>
			</TR>
		  </TBODY>
		</TABLE>
	  </div>                </td>
	</tr>
<tr bgcolor="#FFFFFF">
	  <td colspan=2 align="center"><%=GetEquLbl("ConList")%><!--设备列表：--></td>
	  <td colspan=16 align="center"><div align="left">
		<TABLE width="100%" border="0" cellPadding=0 cellSpacing=0>
		  <TBODY>
			<TR>
			  <TD width="30%" valign="top"><div onDblClick="fInsertCon()" class="ui-jqdialog-content ui-widget-content"><select id="selConSrc" name="selConSrc" class="FormElement ui-widget-content ui-corner-all" size=7 multiple style="WIDTH: 240px">
			  </select></div></TD>
			  <TD width="18%"align=middle valign="middle"><div align="center">
<a class="fm-button ui-state-default ui-corner-all fm-button-icon-left " id="conadd" onclick="fInsertCon()"><span class="ui-icon ui-icon-carat-1-e " style="position:relative;left: -13px;top: 8px;"></span><span class="ui-icon ui-icon-carat-1-e " style="position:relative;left: -8px;top: 0px;"></span></a>
<p>
<a class="fm-button ui-state-default ui-corner-all fm-button-icon-left" id="condel" onclick="fDelCon()"><span class="ui-icon ui-icon-carat-1-w " style="position:relative;left: -13px;top: 8px;"></span><span class="ui-icon ui-icon-carat-1-w " style="position:relative;left: -8px;top: 0px;"></span></a>
			  </div></TD>
			  <TD width="52%" valign="top"><div onDblClick="fDelCon()" class="ui-jqdialog-content ui-widget-content"><select id="selConDesc" name="selConDesc" class="FormElement ui-widget-content ui-corner-all" style="WIDTH: 240px" multiple size=7 >
			  </select></div>                      </TD>
			</TR>
		  </TBODY>
		</TABLE>
	  </div>                </td>
	</tr>
	<tr bgcolor="#FFFFFF">
	  <td colspan=2 align="center"  style="width:14%" ><%=GetEquLbl("ValidateMode")%><!--验证方式：--></td>
	  <td colspan=7 align="center" style="width:28%" >
		<div align="left" class="ui-jqdialog-content ui-widget-content">
		<select id="selMode" name="selMode" class="FormElement ui-widget-content ui-corner-all">
		  <option value="<%=GetEquLbl("ValidateModeVal0")%>"><%=GetEquLbl("ValidateModeVal0")%></option>
		  <option value="<%=GetEquLbl("ValidateModeVal1")%>"><%=GetEquLbl("ValidateModeVal1")%></option>
		  <option value="<%=GetEquLbl("ValidateModeVal2")%>"><%=GetEquLbl("ValidateModeVal2")%></option>
		  <option value="<%=GetEquLbl("ValidateModeVal3")%>"><%=GetEquLbl("ValidateModeVal3")%></option>
		</select>
		</div></td>
		<td colspan=2 align="center" style="width:12%"><div id="divFloorName"><%=GetEquLbl("Floor")%><!--楼层(信箱)：--></div></td>
	  <td colspan=7 align="center" style="width:40% ">
		<div align="left" id = "divFloorValue" class="ui-jqdialog-content ui-widget-content"><input id="txtFloor" name="txtFloor" type="text" class="txtBox1 FormElement ui-widget-content ui-corner-all" size="11" style="width:210px " onKeyDown="checkkey(); ">
		<input name='button' type='button' value='<%=GetEquLbl("Custom")%>' onclick='ShowSelect(txtFloor)'><%=GetEquLbl("FloorMu")%>
		</div></td>
	</tr>
	<tr bgcolor="#FFFFFF" id="timeAndDoor">
	  <td colspan=2 align="center"><%=GetEquLbl("InOutSchedule")%><!--进出时间表：--></td>
	  <td colspan=7 align="center">
		<div align="left" id="divselSchedule" class="ui-jqdialog-content ui-widget-content">
		  <select id="selSchedule" name="selSchedule" class="FormElement ui-widget-content ui-corner-all" style="width:210px ">
		  </select>
		</div></td>
	   <td colspan=2 align="center"><%=GetEquLbl("InOutDoor")%><!--进出门：--></td>
	  <td colspan=7 align="center">
		<div align="left" class="ui-jqdialog-content ui-widget-content">
		  <select id="selDoor" name="selDoor" class="FormElement ui-widget-content ui-corner-all" style="width:210px ">
		  </select>
		</div></td>
	</tr>
</table>
<script type="text/javascript">
$("a").hover(
	function() {
		$( this ).addClass( "ui-state-hover" );
	},function() {
		$( this ).removeClass( "ui-state-hover" );
	}
);
$("#divFloorName").hide();
$("#divFloorValue").hide();
Init();
function Init()
{
	var i,j,k,selobject;
	//Card.style.display="none";
	GetSchedule();
	GetController();
<%	
	if iDoor = "1" then
%>
	document.getElementById("selDoor").options[0] = new Option("<%=GetEquLbl("InOutDoorVal1")%>","<%=GetEquLbl("InOutDoorVal1")%>");
<%
	else
%>
	document.getElementById("selDoor").options[0] = new Option("<%=GetEquLbl("InOutDoorVal1")%>","<%=GetEquLbl("InOutDoorVal1")%>");	//"1 - 门1","1 - 门1"
	document.getElementById("selDoor").options[1] = new Option("<%=GetEquLbl("InOutDoorVal2")%>","<%=GetEquLbl("InOutDoorVal2")%>");//"2 - 门2","2 - 门2"
	document.getElementById("selDoor").options[2] = new Option("<%=GetEquLbl("InOutDoorVal3")%>","<%=GetEquLbl("InOutDoorVal3")%>");//"3 - 双门","3 - 双门"
<%
	end if
%>

<%
	if strEmpId <> "" then
%>	
	GetDescEmpName("<%=strEmpId%>","<%=strConId%>");
	
<%
	end if 
	
	if strConId <> "" then
%>
	var strConId = "<%=strConId%>";
	var arrSelCon = strConId.toString().split(",");
	selobject = document.getElementById("selConDesc").options;
	k=0; 
	for(i=0; i<arrSelCon.length; i++){
		for(j=document.getElementById("selConSrc").options.length-1; j>=0; j--){
			if(document.getElementById("selConSrc").options[j].value == arrSelCon[i]){
				selobject[k++] = new Option(document.getElementById("selConSrc").options[j].text, document.getElementById("selConSrc").options[j].value);
				break;
			}
		}
	}
	selConDescChange();	

<%
	end if 
%>
//默认显示部门
<% If trim(cstr(iSearch)) = "" Then %>
	$("#reg2").attr("checked", "checked");
	fCheckRegCardType();
<% end if %>
}


function fCheckRegCardType()
{
	var regCradType = $("input[name='regCrad']:checked").val();
	if (regCradType == "0")
	{
		//待注册卡号
		$("#trTypeValue").hide();
		GetSrcEmpName(0,0); //获取待注册人员
		GetController();  //获取全部控制器
	}
	else if (regCradType == "1")
	{
		$("#selRegCardTypeLabel").html("<%=GetEquLbl("DeptName")%>");//部门名称
		$("#trTypeValue").show();

		GetDepartments();
		GetController();  //获取全部控制器
	}
	else if (regCradType == "2")
	{
		$("#selRegCardTypeLabel").html("<%=GetEquLbl("TempName")%>");//模板名称
		$("#trTypeValue").show();
		
		GetRegTemplates(); //获取注册卡号模板
		GetController();  //获取全部控制器
	}
	else
	{
		//if($("#divSearch").html().trim() == "")
			$("#divSearch").load("search.asp?submitfun=SearchSubmit()");
		$("#divSearch").show();
	}
}
function SearchSubmit()
{
	//alert($("#searRetColVal").html()+","+$("#searRetOperVal").html()+","+$("#searRetDataVal").html());
	var strsearchField=$("#searRetColVal").html();
	var strsearchOper=$("#searRetOperVal").html();
	var strsearchString=$("#searRetDataVal").html();
	var DataArray;
	//strsearchString = jQuery.encodeURL(strsearchString); //参数注意编码，否则会乱码
	strsearchString = strsearchString; //参数注意编码，否则会乱码
	var strUrl = 'GetEmpName.asp?nd='+getRandom()+'&iflag=3&search=true&searchField='+strsearchField+'&searchOper='+strsearchOper+'&searchString='+encodeURI(strsearchString);
	//strUrl = encodeURI(strUrl);
	var htmlObj = $.ajax({url:strUrl,async:false});
	var strData = htmlObj.responseText;
	$("#selSrc").empty();
	if(strData != "")
	{
		var strResult1, strResult2;
		DataArray = strData.split("','");
		if (DataArray.length > 0)
		{
			for(var i=1; i<DataArray.length; i++)
			{
				strResult1 = DataArray[i].substr(0, DataArray[i].indexOf(","));
				strResult2 = DataArray[i].substr(DataArray[i].indexOf(",")+1);
				//seloptions[i-1] = new Option(strResult2,strResult1);
				$("#selSrc").append($("<option></option>").attr("value", strResult1).text(strResult2));
			}
		}
	}
				
}

function GetSrcEmpName(striflag,strId)
{
	var seloptions;
	var DataArray;
	var htmlObj = $.ajax({url: 'GetEmpName.asp?nd='+getRandom()+'&iflag='+striflag+'&TempId='+strId,async:false});
	var strData = htmlObj.responseText;
	$("#selSrc").empty();
	if(strData != "")
	{
		var strResult1, strResult2;
		DataArray = strData.split("','");
		if (DataArray.length > 0)
		{
			for(var i=1; i<DataArray.length; i++)
			{
				strResult1 = DataArray[i].substr(0, DataArray[i].indexOf(","));
				strResult2 = DataArray[i].substr(DataArray[i].indexOf(",")+1);
				//seloptions[i-1] = new Option(strResult2,strResult1);
				$("#selSrc").append($("<option></option>").attr("value", strResult1).text(strResult2));
			}
		}
	}
}

//根据页面传进来的员工ID，获取员工信息
function GetDescEmpName(strEmployeeId,strControllerId)
{
	var seloptions;
	var DataArray;
	$.ajax({
		url: 'GetEmpName.asp?nd='+getRandom()+'&iflag=6&EmployeeId='+strEmployeeId,
		async:false,
		success: function(data) {
			try {
				if(data != "")
				{
					var strResult1, strResult2;
					DataArray = data.split("','");
					$("#selDesc").empty();
					if (DataArray.length > 0)
					{
						for(var i=1; i<DataArray.length; i++)
						{
							strResult1 = DataArray[i].substr(0, DataArray[i].indexOf(","));
							strResult2 = DataArray[i].substr(DataArray[i].indexOf(",")+1);
							$("#selDesc").append($("<option></option>").attr("value", strResult1).text(strResult2));
						}
					}
				}
			}
			catch(exception) {
				//alert(exception);
			}
		}
	});
	//验证方式、时间表、进出门及楼层等信息
	var htmlObj = $.ajax({url: 'GetEmpName.asp?nd='+getRandom()+'&iflag=7&EmployeeId='+strEmployeeId+'&ControllerId='+strControllerId,async:false});
	var strResult =  htmlObj.responseText;
	try {
		if(strResult != "")
		{
			//ScheduleCode,EmployeeDoor,ValidateMode,Floor,CombinationID
			DataArray = strResult.split("','");
			if (DataArray.length >= 5)
			{
				$("#selSchedule").val(DataArray[0]);
				$("#selDoor").val(DataArray[1]);
				$("#selMode").val(DataArray[2]);
				$("#txtFloor").val(DataArray[3]);
			}
		}
	}
	catch(exception) {
		//alert(exception);
	}
}

function GetController()
{
	var seloptions;
	var DataArray;
	$.ajax({
		type: 'Post',
		url: 'GetController.asp?nd='+getRandom(),
		data:{"":""},
		async:false,
		success: function(data) {
			try {
				if(data != "")
				{
					eval(data);
					$("#selConSrc").find('option').remove();
					for(i=0; i<ConArray[1].length; i++)
					{
						$("#selConSrc").append($("<option></option>").attr("value", ConArray[0][i]).text(ConArray[1][i]));
					}
					//alert($("#selConSrc").find("option").length);
					//$("#selConSrc option[value='2']").remove();
				}
			}
			catch(exception) {
				alert(exception);
			}
		}
	});
}

//获取部门
function GetDepartments()
{
	var strData;	
	$.ajax({
		url:'../Common/GetDepartment.asp?nd='+getRandom()+'&selID=selChange&DeptId=',
		async:false,
		success: function(data) {
			if(data != ""){
				$("#selRegCardTypeValue").html(data);
				$("#selChange").prepend("<option value='0'>"+"<%=GetEquLbl("AllDept0")%>"+"</option>");	//0 - 所有部门
				$("#selChange").prepend("<option value=''></option>");
				$("#selChange").val('');
				$("#selChange").css('width','210');
				$("#selChange").change(function(){
					SelCon(1,this);
				})
			}
		}
	});
}

//注册卡号模板
function GetRegTemplates()
{
	var strData;	
	$.ajax({
		url:'GetRegTemplate.asp?nd='+getRandom()+'&selectId=selChange',
		async:false,
		success: function(data) {
			if(data != ""){
				$("#selRegCardTypeValue").html(data);
				$("#selChange").prepend("<option value=''></option>");
				$("#selChange").val('');
				$("#selChange").css('width','210');
				$("#selChange").change(function(){
					SelCon(2,this);
				})
			}
		}
	});
}

function SelCon(striflag,name)
{
	var i;
	var value = "";
	var test = name;
	if(striflag == 1){
		//按部门
		//value = name.options[name.options.selectedIndex].value;
		//获取所选部门的子部门ID
		value = GetDeptSelChildIds(name.getAttribute("id"));
		//alert(value);
	}
	else{
		value = name.options[name.options.selectedIndex].value;
	}
	$("#selSrc").empty();

	if(value != "")
	{	
		GetSrcEmpName(striflag,value);
	}
}

function fInsertEm()
{
	var i,j, k,selSrcLength;
	var bExist,isInsertNew;
	var selobject = document.getElementById("selDesc").options;
	var strSrcValue, strSrcText;
	isInsertNew = false;
	//selSrcLength = $("#selSrc").find("option").length;
	selSrcLength = document.getElementById("selSrc").options.length;
	for(i=selSrcLength-1; i>=0; i--)
	{
		bExist = false;
		if(document.getElementById("selSrc").options[i].selected == true)
		{
			strSrcValue = document.getElementById("selSrc").options[i].value;
			strSrcText  = document.getElementById("selSrc").options[i].text;
			j = selobject.length;
			for(k=0; k<j; k++)
			{
				if(selobject[k].value == strSrcValue)
				{
					bExist = true;
					break;
				}
			}
			if(!bExist)
			{
				selobject[j] = new Option(strSrcText, strSrcValue);
				isInsertNew = true;
			}
		}
	}
	
	//20091225修改 mike  已选数据按工号排序
	//有新增加的才重新排序
	if(isInsertNew)
	{
		var strDescArr=new Array(document.getElementById("selDesc").options.length); 
	  
		for(i=0; i< document.getElementById("selDesc").options.length; i++)
		{
			strDescArr[i] = document.getElementById("selDesc").options[i].text+",,"+document.getElementById("selDesc").options[i].value;
		}
		//将数组按本土习惯排序(即拼音排序)
		strDescArr.sort(function(a, b){return a.localeCompare(b);});
		document.getElementById("selDesc").options.length = 0;
		
		for(i=0; i< strDescArr.length; i++)
		{
			var tempArr = strDescArr[i].split(",,");
			selobject[i] = new Option(tempArr[0], tempArr[1]);
		}
	}
	$("#divFormError").hide();
}

function fDelEm()
{
	var i;
	for(i=document.getElementById("selDesc").options.length-1; i>=0; i--)
	{
		if(document.getElementById("selDesc").options[i].selected == true)
			document.getElementById("selDesc").options.remove(i);
	}
	$("#divFormError").hide();
}

function fInsertCon()
{
	var i,j, k;
	var bExist;
	var selobject = document.getElementById("selConDesc").options;
	var strSrcValue, strSrcText;
	for(i=document.getElementById("selConSrc").options.length-1; i>=0; i--)
	{
		bExist = false;
		if(document.getElementById("selConSrc").options[i].selected == true)
		{
			strSrcValue = document.getElementById("selConSrc").options[i].value;
			strSrcText  = document.getElementById("selConSrc").options[i].text;
			j = selobject.length;
			for(k=0; k<j; k++)
			{
				if(selobject[k].value == strSrcValue)
				{
					bExist = true;
					break;
				}
			}
			if(!bExist)
			{
				selobject[j] = new Option(strSrcText, strSrcValue);
			}
		}
	}
	selConDescChange();
}

function fDelCon()
{
	var i;
	for(i=document.getElementById("selConDesc").options.length-1; i>=0; i--)
	{
		if(document.getElementById("selConDesc").options[i].selected == true)
			document.getElementById("selConDesc").remove(i);
	}
	selConDescChange();
}

function CheckIsInOut()
{
	var id = "";
	for(i=0; i<document.getElementById("selConDesc").options.length; i++){
		id = id  + "," + document.getElementById("selConDesc").options[i].value;
	}
	if (id  != ""){
		id = id.substr(1);
	}
	if(id.length == 0)
		return false;
	
	var strData;	
	$.ajax({
		url:'GetControllerParam.asp?nd='+getRandom()+'&param=worktype&id='+id,
		async:false,
		success: function(data) {
			strData = data;
		}
	});
	if(strData == "0")
		return false
	else
		return true;
}

function CheckBoardType()
{
	var id = "";
	for(i=0; i<document.getElementById("selConDesc").options.length; i++){
		id = id  + "," + document.getElementById("selConDesc").options[i].value;
	}
	if (id  != ""){
		id = id.substr(1);
	}
	if(id.length == 0)
		return false;
	
	var strData;	
	$.ajax({
		url:'GetControllerParam.asp?nd='+getRandom()+'&param=boardtype&id='+id,
		async:false,
		success: function(data) {
			strData = data;
		}
	});
	if(strData == "0")
		return false
	else
		return true;
}

//获取时间表，并加载显示
function GetSchedule()
{
	var strData;	
	$.ajax({
		url:'../Common/GetSchedule.asp?nd='+getRandom()+'&SelectID=selSchedule&IsShow24HSchedule=1&strControllerID=',
		async:false,
		success: function(data) {
			if(data != ""){
				$("#divselSchedule").html(data);
			}
		}
	});
}

//显示或隐藏时间表\进出门\控制板类型
function selConDescChange()
{
	if(CheckIsInOut())
		$("#timeAndDoor").show();
	else
		$("#timeAndDoor").hide();
		
	if(CheckBoardType()){
		$("#divFloorName").show();
		$("#divFloorValue").show();
	}
	else{
		$("#divFloorName").hide();
		$("#divFloorValue").hide();
	}
	$("#divFormError").hide();
}

//返回密码是字符的职员姓名
function GetNameString()
{
	var id = "";
	var strResult = "0";
	for(i=0; i<document.getElementById("selDesc").options.length; i++)
	{
		id  = id  + "," + document.getElementById("selDesc").options[i].value;
	}
	if (id  != "")
	{
		id = id.substr(1);
	}

	if(id.length == 0)
		return strResult;
	
	var htmlObj = $.ajax({url:'CheckPasswordIsString.asp?nd='+getRandom()+'&id='+id,async:false});
	strResult =  htmlObj.responseText;

	return strResult;
}

function CheckPasswordIsString()
{
	var strResult;
	strResult = GetNameString();	
	if(strResult == "0")
		return false;
	return true;
}

//注册卡号提交 
function RegCardSubmit()
{
	var i,retVal;
	retVal = false;
	var strselSchedule,strselDoor,strEmvalues,strConvalues,strselMode,strtxtFloor;
	strEmvalues = ""; 
	for(i=0; i<document.getElementById("selDesc").options.length; i++){
		strEmvalues = strEmvalues + "," + document.getElementById("selDesc").options[i].value;
	}
	if (strEmvalues != ""){
		strEmvalues = strEmvalues.substr(1);
	}
	else{
		$("#divFormError").show();
		$("#divFormError").html("<%=GetEquLbl("NotSelEmp")%>");//没有选择职员！
		return false;
	}
	
	strConvalues = "";
	for(i=0; i<document.getElementById("selConDesc").options.length; i++){
		strConvalues = strConvalues + "," + document.getElementById("selConDesc").options[i].value;
	}
	if (strConvalues != ""){
		strConvalues = strConvalues.substr(1);
	}
	else{
		$("#divFormError").show();
		$("#divFormError").html("<%=GetEquLbl("NotSelCon")%>");//没有选择设备！
		return false;
	}
	
	strselMode = $("#selMode").val();
	strselSchedule = $("#selSchedule").val();
	strselDoor = $("#selDoor").val();
	strtxtFloor = $("#txtFloor").val();
	if(strselMode == "" || strselMode == undefined){
		$("#divFormError").show();
		$("#divFormError").html("<%=GetEquLbl("NotSelValidate")%>");//没有选择验证方式！
		return false;
	}
	if(strselSchedule == "" || strselSchedule == undefined) 
		strselSchedule = "1";
	if(strselDoor == "" || strselDoor == undefined) 
		strselDoor = "1 - 门1";
	//Check password
	if( CheckPasswordIsString() && "3" == $("#selMode").val().substr(0, 1))
	{
		$("#divFormError").show();
		//$("#divFormError").html("请先将"+GetNameString().substr(1)+" 用户的密码修改为[数字]型，然后再修改其验证方式为[卡+密码]！");
		$("#divFormError").html("<%=GetEquLbl("CheckPwdMsg1")%>"+GetNameString().substr(1)+" <%=GetEquLbl("CheckPwdMsg2")%>");
		return false;
	}
	
	$("#divFormError").hide();
	$("#divFormError").html("");
	
	$.ajax({
		type: 'Post',
		url: 'RegcardEdit.asp',
		data:{'oper':'add','selSchedule':strselSchedule,'selDoor':strselDoor,'Emvalues':strEmvalues,'Convalues':strConvalues,'selMode':strselMode,'txtFloor':strtxtFloor},
		async:false,
		success: function(data) {
			try  {
				var responseMsg = $.parseJSON(data);
				if(responseMsg.success == false){
					$("#divFormError").show();
					$("#divFormError").html(responseMsg.message);
				}else if(responseMsg.success == true){
					//成功
					retVal = true;
				}else{
					$("#divFormError").show();
					$("#divFormError").html("exception");
				}
			}
			catch(exception) {
				$("#divFormError").show();
				$("#divFormError").html(exception+"," + data);
			}
		},
		error:function(XmlHttpRequest,textStatus, errorThrown){
			$("#divFormError").show();
			$("#divFormError").html(textStatus+XmlHttpRequest.responseText);
		}
	});
	return retVal;
}

function RegCardReset()
{
	$("#selDesc").empty();
	$("#selConDesc").empty();
	$("#divFormError").hide();
	$("#divFormError").html("");
	selConDescChange();
	return false;
}
</script>