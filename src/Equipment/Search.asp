<!--#include file="..\Conn\GetLbl.asp"-->
<%
dim strSubmit
strSubmit = trim(Request.QueryString("submitfun"))

%>
<div  id='searchmodfbox_Custom' class='ui-widget ui-widget-content ui-corner-all ui-jqdialog jqmID1' dir='ltr' style='width: 550px; height: auto; overflow: hidden; top: 10px; left: 358px; z-index: 960; display: block;' tabindex='-1' role='dialog' aria-labelledby='searchhdfbox_Custom' aria-hidden='false'>
<div class='ui-jqdialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix' id='searchhdfbox_Custom' style='cursor: move;'>
	<span class='ui-jqdialog-title' style='float: left;'><%=GetEquLbl("ConditionSelect")%><!--条件选择--></span>
	<a id="fbox_Custom_close" class='ui-jqdialog-titlebar-close ui-corner-all' style='right: 0.3em;'>
		<span class='ui-icon ui-icon-closethick'></span>
	</a>
</div>
<div id='searchcntfbox_Custom' class='ui-jqdialog-content ui-widget-content'>
	<div>
		<div style='overflow:auto' class='searchFilter' id='fbox_Custom'>
			<table style='border:0px none; width:99%' class='group ui-widget ui-widget-content' >
				<tbody>
					<tr style='display:none;' class='error'>
						<th align='left' class='ui-state-error' colspan='5'></th>
					</tr>
					<tr>
						<th align='left' colspan='5'><span></span></th>
					</tr>
					<tr>
						<td class='first'></td>
						<td class='columns' id='tdCol' style="height:21px;">
							<select id="selCol" class="FormElement ui-widget-content ui-corner-all" onchange="selColChange()" style=" width:100px" >
								<option value="DepartmentID" selected="selected"><%=GetEmpLbl("Dept")%></option>
								<option value="Name"><%=GetEquLbl("Name")%></option>
								<option value="Number"><%=GetEquLbl("Number")%></option>
								<option value="Card"><%=GetEquLbl("Card")%></option>
								<option value="Sex"><%=GetEquLbl("Sex")%></option>
								<option value="Headship"><%=GetEquLbl("Headship")%></option>
								<option value="Position"><%=GetEquLbl("Position")%></option>
								<option value="Marry"><%=GetEquLbl("Marry")%></option>
								<option value="Knowledge"><%=GetEquLbl("Knowledge")%></option>
								<option value="Country"><%=GetEquLbl("Country")%></option>
								<option value="NativePlace"><%=GetEquLbl("NativePlace")%></option>
								<option value="IncumbencyStatus"><%=GetEquLbl("IncumbencyStatus")%></option>
							</select></td>
						<td class='operators' id='tdOper'>
							<select id="selOper" class='selectopts FormElement ui-widget-content ui-corner-all'  style=" width:70px" >
								<option selected='selected' value='eq'><%=GetEquLbl("eq")%></option>
								<option value='ne'><%=GetEquLbl("ne")%></option>
							</select></td>
						<td class='data' id='tdData' style='width:55%'>
							<div id="divtxtData"><input type='text' id='txtData' style='width: 98%;' role='textbox' class='input-elm FormElement ui-widget-content ui-corner-all'></div></td>
						<td id='tdCustom' style="width:12%">
							<div id="divbtnCustom"><input type='button' id='btnCustom'  role='button' class='input-elm' value='<%=GetEquLbl("Custom")%>'></div></td>
					</tr>
				</tbody>
			</table>
		</div>
		<table id='fbox_Custom_2' style='border:0px none;margin-top:5px' class='EditTable'>
			<tbody>
				<tr>
					<td colspan='2'><hr style='margin:1px' class='ui-widget-content'></td>
				</tr>
				<tr>
					<td style='text-align:left' class='EditButton'>
						<a class='fm-button ui-state-default ui-corner-all fm-button-icon-left ui-search' id='fbox_Custom_reset'>
							<span class='ui-icon ui-icon-arrowreturnthick-1-w'></span><%=GetEquLbl("reset")%><!--重置--></a>
					</td>
					<td class='EditButton'><a class='fm-button ui-state-default ui-corner-all fm-button-icon-right ui-reset' id='fbox_Custom_search'><span class='ui-icon ui-icon-search'></span><%=GetEquLbl("search")%><!--查找--></a>
					</td>
				</tr>
			</tbody>
		</table>
        <div id='searRetColVal' style='display:none;'></div>
        <div id='searRetOperVal' style='display:none;'></div>
        <div id='searRetDataVal' style='display:none;'></div>
		<div id='searRetColText' style='display:none;'></div>
        <div id='searRetOperText' style='display:none;'></div>
        <div id='searRetDataText' style='display:none;'></div>
	</div>
</div>
<div class='jqResize ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se'></div>
</div>
<script type="text/javascript">
$("a").hover(
	function() {
		$( this ).addClass( "ui-state-hover" );
	},function() {
		$( this ).removeClass( "ui-state-hover" );
	}
);
selColChange();

function selColChange()
{
	$("#divbtnCustom").hide();
	var selColVal = $("#selCol").val();
	if(selColVal == "DepartmentID" || selColVal == "Sex" || selColVal == "Headship" || selColVal == "Position" || selColVal == "Marry" || selColVal == "Knowledge" 
		 || selColVal == "Country"  || selColVal == "NativePlace" || selColVal == "IncumbencyStatus"  ){
		$("#selOper").empty();
		$("#selOper").append("<option value='eq'><%=GetEquLbl("eq")%></option>");	//等于&nbsp;&nbsp;&nbsp;&nbsp;
		$("#selOper").append("<option value='ne'><%=GetEquLbl("ne")%></option>>");	//不等&nbsp;&nbsp;&nbsp;&nbsp;
		$("#selOper ").val("eq");
	}
	else if(selColVal == "Name" || selColVal == "Number"){
		$("#selOper").empty();
		$("#selOper").append("<option value='eq'><%=GetEquLbl("eq")%></option>");	//等于&nbsp;&nbsp;&nbsp;&nbsp;
		$("#selOper").append("<option value='ne'><%=GetEquLbl("ne")%></option>>");//不等&nbsp;&nbsp;&nbsp;&nbsp;
		$("#selOper").append("<option value='cn'><%=GetEquLbl("cn")%></option>");//包含&nbsp;&nbsp;&nbsp;&nbsp;
		$("#selOper").append("<option value='nc'><%=GetEquLbl("nc")%></option>>");//不包含
		$("#selOper ").val("eq");
	}
	else if(selColVal == "Card"){
		$("#selOper").empty();
		$("#selOper").append("<option value='eq'><%=GetEquLbl("eq")%></option>");		//等于&nbsp;&nbsp;&nbsp;&nbsp;
		$("#selOper").append("<option value='ne'><%=GetEquLbl("ne")%></option>>");	//不等&nbsp;&nbsp;&nbsp;&nbsp;
		$("#selOper").append("<option value='lt'><%=GetEquLbl("lt")%></option>");		//小于&nbsp;&nbsp;&nbsp;&nbsp;
		$("#selOper").append("<option value='le'><%=GetEquLbl("le")%></option>");		//小于等于
		$("#selOper").append("<option value='gt'><%=GetEquLbl("gt")%></option>");		//大于&nbsp;&nbsp;&nbsp;&nbsp;
		$("#selOper").append("<option value='ge'><%=GetEquLbl("ge")%></option>");		//大于等于
		$("#selOper ").val("eq");
	}
	
	if(selColVal == "DepartmentID" ){
		InitDepartments();
	}
	else if(selColVal == "Name" ){
		$("#divtxtData").html("<input type='text' id='txtData' style='width: 98%;' role='textbox' class='input-elm FormElement ui-widget-content ui-corner-all'>");
		$("#txtData").css('width','260');
	}
	else if(selColVal == "Number" ){
		$("#divtxtData").html("<input type='text' id='txtData' style='width: 98%;' role='textbox' class='input-elm FormElement ui-widget-content ui-corner-all'>");
		$("#txtData").css('width','260');
		//$("#divbtnCustom").show();
	}
	else if(selColVal == "Card" ){
		$("#divtxtData").html("<input type='text' id='txtData' style='width: 98%;' role='textbox' class='input-elm FormElement ui-widget-content ui-corner-all'>");
		$("#txtData").css('width','260');
	}
	else if(selColVal == "Sex" ){
		var strHtml = "<select  id='txtData' role='select' class='input-elm FormElement ui-widget-content ui-corner-all'>";
		strHtml = strHtml + "<option role='option' value=''></option>" ;
		strHtml = strHtml + "<option role='option' value='<%=GetEquLbl("Male")%>'><%=GetEquLbl("Male")%></option>" ;	//男
		strHtml = strHtml + "<option role='option' value='<%=GetEquLbl("Female")%>'><%=GetEquLbl("Female")%></option>" ;	//女
		strHtml = strHtml + "</select>" ;
		$("#divtxtData").html(strHtml);
		$("#txtData").css('width','270');
	}
	else if(selColVal == "Headship" ){
		var htmlObj = $.ajax({url:'../Common/GetTableFieldCode.asp?nd='+getRandom()+'&selID=txtData&type=headship',async:false});
		$("#divtxtData").html(htmlObj.responseText);
		$("#txtData").prepend("<option value=''></option>");
		$("#txtData").css('width','270');
	}
	else if(selColVal == "Position" ){
		var htmlObj = $.ajax({url:'../Common/GetTableFieldCode.asp?nd='+getRandom()+'&selID=txtData&type=position',async:false});
		$("#divtxtData").html(htmlObj.responseText);
		$("#txtData").prepend("<option value=''></option>");
		$("#txtData").css('width','270');
	}
	else if(selColVal == "Marry" ){
		var strHtml = "<select  id='txtData' role='select' class='input-elm FormElement ui-widget-content ui-corner-all'>";
		strHtml = strHtml + "<option role='option' value=''></option>" ;
		strHtml = strHtml + "<option role='option' value='<%=GetEquLbl("Married")%>'><%=GetEquLbl("Married")%></option>" ;	//已婚
		strHtml = strHtml + "<option role='option' value='<%=GetEquLbl("Unmarried")%>'><%=GetEquLbl("Unmarried")%></option>" ;	//未婚
		strHtml = strHtml + "</select>" ;
		$("#divtxtData").html(strHtml);
		$("#txtData").css('width','270');
	}
	else if(selColVal == "Knowledge" ){
		var strHtml = "<select  id='txtData' role='select' class='input-elm FormElement ui-widget-content ui-corner-all'>";
		strHtml = strHtml + "<option role='option' value=''></option>" ;
		strHtml = strHtml + "<option value='<%=GetEquLbl("Knowledge1")%>' role='option'><%=GetEquLbl("Knowledge1")%></option>" ;	//小学
		strHtml = strHtml + "<option value='<%=GetEquLbl("Knowledge2")%>' role='option'><%=GetEquLbl("Knowledge2")%></option>" ;	//初中
		strHtml = strHtml + "<option value='<%=GetEquLbl("Knowledge3")%>' role='option'><%=GetEquLbl("Knowledge3")%></option>" ;	//中专	
		strHtml = strHtml + "<option value='<%=GetEquLbl("Knowledge4")%>' role='option'><%=GetEquLbl("Knowledge4")%></option>" ;	//高中
		strHtml = strHtml + "<option value='<%=GetEquLbl("Knowledge5")%>' role='option'><%=GetEquLbl("Knowledge5")%></option>" ;	//大专
		strHtml = strHtml + "<option value='<%=GetEquLbl("Knowledge6")%>' role='option'><%=GetEquLbl("Knowledge6")%></option>" ;	//本科
		strHtml = strHtml + "<option value='<%=GetEquLbl("Knowledge7")%>' role='option'><%=GetEquLbl("Knowledge7")%></option>" ;	//硕士
		strHtml = strHtml + "<option value='<%=GetEquLbl("Knowledge8")%>' role='option'><%=GetEquLbl("Knowledge8")%></option>" ;	//博士
		strHtml = strHtml + "</select>" ;
		$("#divtxtData").html(strHtml);
		$("#txtData").css('width','270');
	}
	else if(selColVal == "Country" ){
		var htmlObj = $.ajax({url:'../Common/GetTableFieldCode.asp?nd='+getRandom()+'&selID=txtData&type=country',async:false});
		$("#divtxtData").html(htmlObj.responseText);
		$("#txtData").prepend("<option value=''></option>");
		$("#txtData").css('width','270');
	}
	else if(selColVal == "NativePlace" ){
		var htmlObj = $.ajax({url:'../Common/GetTableFieldCode.asp?nd='+getRandom()+'&selID=txtData&type=nativeplace',async:false});
		$("#divtxtData").html(htmlObj.responseText);
		$("#txtData").prepend("<option value=''></option>");
		$("#txtData").css('width','270');
	}
	else if(selColVal == "IncumbencyStatus" ){
		var strHtml = "<select  id='txtData' role='select' class='input-elm FormElement ui-widget-content ui-corner-all'>";
		strHtml = strHtml + "<option role='option' value='<%=GetEquLbl("IncumbencyStatus0")%>'><%=GetEquLbl("IncumbencyStatus0")%></option>" ;	//0-在职
		strHtml = strHtml + "<option role='option' value='<%=GetEquLbl("IncumbencyStatus1")%>'><%=GetEquLbl("IncumbencyStatus1")%></option>" ;	//1-离职
		strHtml = strHtml + "</select>" ;
		$("#divtxtData").html(strHtml);
		$("#txtData").css('width','270');
	}

}

//初使化部门
function InitDepartments(){
	var id, name, code, sBlank, len;
	var arrDepts = getUserDeptJSON();

	var deptListHtml = "<select id='txtData' name='txtData' style='width:270px' class='FormElement ui-widget-content ui-corner-all'>";
	for(var i in arrDepts){
		id = arrDepts[i].id;
		name = arrDepts[i].name;
		code = arrDepts[i].code;
		sBlank = "";
		len = code.length / 5;

		if(len == 1){
			deptListHtml += "<option value='" + id + "' code='" + code + "'>" + name + "</option>";			
		}
		else{
			for(var i = 1; i < len; i ++){
				if(i==1)
					sBlank += "&nbsp;&nbsp;";
				else
					sBlank += "|&nbsp;";
			}

			deptListHtml += "<option value='" + id + "' code='" + code + "'>" + sBlank + "|-" + name + "</option>";
		}
	}

	deptListHtml += "</select>";

	$("#divtxtData").html(deptListHtml);
}

//关闭对话框 
$("#fbox_Custom_close").click(function(){
	$("#searchmodfbox_Custom").parent().hide();
})

//重置
$("#fbox_Custom_reset").click(function(){
	$("#selCol").val("DepartmentID");
	selColChange();
})
//提交
$("#fbox_Custom_search").click(function(){
	var strSubmit = "<%=strSubmit%>";
	//$("#searRetColVal").show();
	$("#searRetColVal").html($("#selCol").val());
	$("#searRetOperVal").html($("#selOper").val());
	if($("#selCol").val() == "DepartmentID" ){
		$("#searRetDataVal").html(GetDeptSelChildIds("txtData"));
	}
	else{
		$("#searRetDataVal").html($("#txtData").val());
	}
	
	$("#searRetColText").html($("#selCol").find("option:selected").text());
	$("#searRetOperText").html($("#selOper").find("option:selected").text());
	//alert($("#txtData").attr("tagName").toLowerCase());
	if($("#selCol").val() == "Name" || $("#selCol").val() == "Card" || $("#selCol").val() == "Number"){
		$("#searRetDataText").html($("#txtData").val());
	}
	else{
		$("#searRetDataText").html($("#txtData").find("option:selected").text());
	}
	//alert($("#txtData").val());
	eval(strSubmit);
	$("#searchmodfbox_Custom").parent().hide();
})


drag("searchhdfbox_Custom");
function drag(obj)
{
	if (typeof obj == "string") {
		var obj = document.getElementById(obj);
		obj.orig_index=obj.style.zIndex;//设置当前对象永远显示在最上层
	}
	obj.onmousedown=function (a){//鼠标按下
		this.style.cursor="move";//设置鼠标样式
		this.style.zIndex=1000;
		var d=document;
		if(!a) a=window.event;//按下时创建一个事件
		var x=a.clientX;//x=鼠标相对于网页的x坐标-网页被卷去的宽-待移动对象的左外边距
		var y=a.clientY;//y=鼠标相对于网页的y左边-网页被卷去的高-待移动对象的左上边距
		//var OldLeft = parseInt(obj.style.left.replace("px",""));
		//var OldTop = parseInt(obj.style.top.replace("px",""));
		var OldLeft = parseInt($("#searchmodfbox_Custom").css('left').replace("px",""));
		var OldTop = parseInt($("#searchmodfbox_Custom").css('top').replace("px",""));
		d.onmousemove=function(a){//鼠标移动
			if(!a) a=window.event;//移动时创建一个事件
			var Newleft=OldLeft + a.clientX-x;
			var Newtop=OldTop + a.clientY-y;
			if (Newleft<0) Newleft = 0;
			if (Newtop<0) Newtop = 0;
			$("#searchmodfbox_Custom").css('left', Newleft + 'px').css('top', Newtop + 'px');
		}
		d.onmouseup=function (){//鼠标放开
			document.onmousemove=null;
			document.onmouseup = null;
			obj.style.cursor="normal";//设置放开的样式
			obj.style.zIndex=obj.orig_index;
		}
	}  
	
}
</script>