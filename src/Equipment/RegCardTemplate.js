CheckLoginStatus();
//获取操作权限
var role = GetOperRole("RegCardTemplate");
var iedit=false,iadd=false,idel=false,iview=false,irefresh=false,isearch=false;
try{
	iedit=role.edit;
	iadd=role.add;
	idel=role.del;
	iview=role.view;
	irefresh=role.refresh;
	isearch=role.search;
}
catch(exception) {
	alert(exception);
}

$("#DataGrid").jqGrid({
	url:'RegCardTemplateList.asp',
	editurl:"RegCardTemplateEdit.asp",
	datatype: "json",
	//colNames:['模板ID','模板名称','职员','EmployeeCode','DepartmentCode','部门列表',OtherCode',设备','选择设备','时间表','EmployeeScheID','进出门','验证方式', 'OnlyByCondition'],
	colNames:[getlbl("con.TempID"),getlbl("con.TempName"),getlbl("con.ByDept"),getlbl("con.DeptList"),getlbl("con.ByEmp"),getlbl("con.EmpList"),'OtherCode',getlbl("con.Controller"),getlbl("con.SelController"),getlbl("con.Schedule"),'EmployeeScheID',getlbl("con.InOutDoor"),getlbl("con.ValidateMode"),getlbl("con.OnlyByCond")],
	colModel :[
		{name:'TemplateId',index:'TemplateId',align:'center',width:100,hidden:false,editrules:{edithidden:false},search:false},
		{name:'TemplateName',index:'TemplateName',align:'center',editable:true,editrules:{required:true},
			searchoptions:{sopt:["eq","ne",'cn','nc']},
			formoptions:{elmsuffix:"<font color=#FF0000>*</font>"}},
		{name:'DepartmentCode',index:'DepartmentCode',align:'center',hidden:true,editable:true,editrules:{edithidden:true,required:false},edittype:'checkbox',search:false},
		{name:'DepartmentList',index:'DepartmentList',edittype:'none',hidden:true,align:'center',editable:true,editrules:{edithidden:true,required:true},search:false},
		{name:'EmployeeCode',index:'EmployeeCode',align:'center',hidden:true,editable:true,editrules:{edithidden:true,required:false},edittype:'checkbox',search:false,
			formoptions:{elmsuffix:"&nbsp;<a class='fm-button ui-state-default ui-corner-all fm-button-icon-left' id='btnSearchEmployee'  onclick='fSearchEmployee()'>"+getlbl("hr.Search")+"<span class='ui-icon ui-icon-search'></span></a>"}},
		{name:'EmployeeList',index:'EmployeeList',edittype:'none',hidden:true,align:'center',editable:true,editrules:{edithidden:true,required:true},search:false},
		{name:'OtherCode',index:'OtherCode',align:'center',hidden:true,editable:true,editrules:{edithidden:false,required:false},search:false},
		{name:'EmployeeController',index:'EmployeeController',align:'center',editable:true,editrules:{required:true},search:false},
		{name:'ControllerID',index:'ControllerID',hidden:true,align:'center',editable:true,editrules:{required:true},search:false},
		{name:'EmployeeScheName',index:'EmployeeScheName',align:'center',editable:true,editrules:{required:false},search:false,
			edittype:'select',},
		{name:'EmployeeScheID',index:'EmployeeScheID',hidden:true,editrules:{edithidden:false},search:false},
		{name:'EmployeeDoor',index:'EmployeeDoor', align:'center',editable:true,editrules:{required:false},search:false,
			edittype:'select', editoptions:{value:getlbl("con.InOutDoorVal1")+":"+getlbl("con.InOutDoorVal1")+";"+getlbl("con.InOutDoorVal2")+":"+getlbl("con.InOutDoorVal2")+";"+getlbl("con.InOutDoorVal3")+":"+getlbl("con.InOutDoorVal3")},},	//"1 - 门1:1 - 门1;2 - 门2:2 - 门2;3 - 双门:3 - 双门"
		{name:'ValidateMode',index:'ValidateMode',align:'center',editable:true,editrules:{required:false},search:false,
			edittype:'select', editoptions:{value:getlbl("con.ValidateModeVal0")+":"+getlbl("con.ValidateModeVal0")+";"+getlbl("con.ValidateModeVal1")+":"+getlbl("con.ValidateModeVal1")+";"+getlbl("con.ValidateModeVal2")+":"+getlbl("con.ValidateModeVal2")+";"+getlbl("con.ValidateModeVal3")+":"+getlbl("con.ValidateModeVal3")},},//"0 - 卡:0 - 卡;1 - 指纹:1 - 指纹;2 - 卡＋指纹:2 - 卡＋指纹;3 - 卡＋密码:3 - 卡＋密码"
		{name:"OnlyByCondition",index:"OnlyByCondition",align:'center',hidden:true,editable:true,editrules:{edithidden:true,required:false}, search:false,
			edittype:"checkbox",formoptions:{elmsuffix:"&nbsp;<label class=''>" + getlbl('con.OnlyByCondDesc') + "</label>"}},
		], 
	caption:getlbl("con.RegCardTemp"),//"注册卡号模板",
	imgpath:'/images',
	rowNum:irowNum,
	rowList:[10,16,20,30],
	prmNames: {search: "_search"},  
	//jsonReader: { repeatitems: false },
	pager: '#pager',
	//sortname: 'RecordID',
	multiselect: true,
	multiboxonly: true,
	viewrecords: true,
	sortorder: "desc",
	height: 'auto',
	width:970,
	forceFit:true, //调整列宽度不会改变表格的宽度
	hidegrid:false,//禁用控制表格显示、隐藏的按钮
	loadtext:strloadtext,
	toppager:true,
	loadComplete:function(data){ //完成服务器请求后，回调函数 
		if(data == null || data.records==0){ 
			$("#DataGrid").jqGrid('clearGridData');
	}},
});

$("#DataGrid").jqGrid('navGrid','#DataGrid_toppager', 
	{
		edit:iedit,add:iadd,del:idel,view:false,refresh:irefresh,search:isearch,edittext:stredittext,addtext:straddtext,deltext:strdeltext,searchtext:strsearchtext,refreshtext:strrefreshtext,viewtext:strviewtext,
		alerttext : stralerttext ,
	}, 
	{
		top:0,width:600,height:"auto",dataheight:"auto",
		reloadAfterSubmit :true,
		closeAfterEdit: true,
		afterSubmit:getEditafterSubmit,
		afterShowForm:function(formid){
			InitEditForm();
			
			var rowid = $("#DataGrid").jqGrid('getGridParam', 'selrow');
			var ret = $("#DataGrid").jqGrid('getRowData',rowid);
			var EmployeeController = ret.EmployeeController; //获取设备ID

			//加载部门
			if(LoadSelDept(ret.DepartmentCode)){
				$("#tr_DepartmentCode").children("td.DataTD").children("input").attr("checked", true);
			}

			//加载职员列表
			if(LoadSelEmp(ret.EmployeeCode)){
				$("#tr_EmployeeCode").children("td.DataTD").children("input").attr("checked", true);
			}

			if(EmployeeController != "" && EmployeeController.trim().substring(0,1) == "0"){
				$("input[name='ControllerSel']").get(0).checked = true;
				fCheckController();
			}else if (EmployeeController != ""){
				$("input[name='ControllerSel']").get(1).checked = true;
				fCheckController();
				var strConId = EmployeeController;
				var arrSelCon = strConId.toString().split(",");
				var i,j,k,selobject;
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
			}

			$("#tr_EmployeeScheName").children("td.DataTD").children("select").val(ret.EmployeeScheID);//根据时间表ID，选择时间表

			fCheckDept();
			fCheckEmp();
		},
		onclickSubmit: function(params) {
			return fGetFormData();
		},
		//selarrrow
	},  //  default settings for edit
	{
		top:0,width:600,height:"auto",dataheight:"auto",
		closeAfterAdd: true,
		reloadAfterSubmit :true,
		afterSubmit:getAddafterSubmit,
		afterShowForm:function(formid){
			InitEditForm();

			$("#tr_EmployeeDesc").children("td.DataTD").children("input").val(getlbl("con.AllEmp0"));	//"0 - 所有职员"			
			$("#tr_DepartmentCode").children("td.DataTD").children("input").attr("checked", 'true');  //[按部门]默认选中			
			$("#tr_OnlyByCondition").children("td.DataTD").children("input").attr("checked", 'true');  //[仅按此条件]默认选中

			fCheckDept();
			fCheckEmp();
		},
		onclickSubmit: function(params) {
			return fGetFormData(); 
		},
	},  //  default settings for add
	{
		top:0,
		reloadAfterSubmit :true,
		afterSubmit:getDelafterSubmit
	},  // delete instead that del:false we need this
	{multipleSearch:false, multipleGroup:false, showQuery: false,closeAfterSearch: true,caption:strsearchcaption,top:60} ,// search options
	{top:0,}	//view parameters
	);

var topPagerDiv = $('#DataGrid_toppager')[0];         // "#list_toppager"
$("#DataGrid_toppager_center", topPagerDiv).remove(); // "#list_toppager_center"
$(".ui-paging-info", topPagerDiv).remove();
$("#DataGrid_toppager_right").css("width","1%");
$("#DataGrid_toppager_left").css("width","99%");
if(iadd){
	$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
		caption:getlbl("con.RegToCon"),//"注册到设备",
		buttonicon:"ui-icon-plusthick",
		title:getlbl("con.RegToConTitle"),//"将模板注册到设备",
		id:"DataGrid_btnSync",
		onClickButton: RegController,
		position:"last"
	});
}

function InitEditForm(){
	InitDepartments(); //初使化部门列表
	InitEmployees(); //初使化员工列表
	$("#DepartmentCode").bind("change", fCheckDept);
	$("#EmployeeCode").bind("change", fCheckEmp);

	//员工
	var $tr = $("#tr_EmployeeDesc"), 
		$label = $tr.children("td.CaptionTD"),
		$data = $tr.children("td.DataTD");
	$label.css("width", "16%"); //设置标签宽度
	$data.children("input").css("width", "70%");
	
	$tr = $("#tr_EmployeeController"), 
		$label = $tr.children("td.CaptionTD"),
		$data = $tr.children("td.DataTD");	
	
	//部分设备
	var ctrlOptionHtml = "<div align='left' class='ui-jqdialog-content ui-widget-content'>" +
				"<input type='radio' name='ControllerSel' checked value='0' id='Sel1'  onClick='fCheckController()' class='ui-jqdialog-content ui-widget-content'>&nbsp;" +
				"<label for='Sel1'>"+getlbl("con.AllCon")+"</label>&nbsp;&nbsp;&nbsp;&nbsp;" +
				"<input type='radio' name='ControllerSel' value='1' id='Sel2'  onClick='fCheckController()' class='ui-jqdialog-content ui-widget-content'>&nbsp;" +
				"<label for='Sel2'>"+getlbl("con.PartCon")+"</label></div>";

	$data.html(ctrlOptionHtml);
	
	$tr = $("#tr_ControllerID"), 
		$label = $tr.children("td.CaptionTD"),
		$data = $tr.children("td.DataTD");

    //设备列表
	var ctrlListHtml = "<TABLE width='100%' border='0' cellPadding=0 cellSpacing=0>" + 
			"<TBODY><TR>" + 
			"<TD width='30%' valign='top'><div onDblClick='fInsertCon()' class='ui-jqdialog-content ui-widget-content'>" + 
			"<select id='selConSrc' name='selConSrc' class='FormElement ui-widget-content ui-corner-all' size=8 multiple style='WIDTH: 180px'></select>" + 
			"</div></TD>" + 
			"<TD width='18%'align=middle valign='middle'>" + 
			"<div align='center'>" + 
			"<a class='fm-button ui-state-default ui-corner-all fm-button-icon-left ' id='conadd' onclick='fInsertCon()'>" + 
			"<span class='ui-icon ui-icon-carat-1-e ' style='position:relative;left: -13px;top: 8px;'></span>" + 
			"<span class='ui-icon ui-icon-carat-1-e ' style='position:relative;left: -8px;top: 0px;'></span>" + 
			"</a><p>" + 
			"<a class='fm-button ui-state-default ui-corner-all fm-button-icon-left' id='condel' onclick='fDelCon()'>" + 
			"<span class='ui-icon ui-icon-carat-1-w ' style='position:relative;left: -13px;top: 8px;'></span>" + 
			"<span class='ui-icon ui-icon-carat-1-w ' style='position:relative;left: -8px;top: 0px;'></span>" + 
			"</a></div></TD>" + 
			"<TD width='52%' valign='top'><div onDblClick='fDelCon()' class='ui-jqdialog-content ui-widget-content'>" + 
			"<select id='selConDesc' name='selConDesc' class='FormElement ui-widget-content ui-corner-all' style='WIDTH: 180px' multiple size=8 ></select>" + 
			"</div></TD></TR></TBODY></TABLE>";

	$data.html(ctrlListHtml);
	
	GetSchedule();
	$("#tr_TemplateName").children("td.DataTD").children("input").css("width", "40%");
	$("#tr_EmployeeScheName").children("td.DataTD").children("select").css("width", "40%");
	$("#tr_EmployeeDoor").children("td.DataTD").children("select").css("width", "40%");
	//$("#tr_ValidateMode").children("td.DataTD").children("select").css("width", "40%");
	$("#tr_OnlyByCondition").after("<tr class='FormData'><td class='CaptionTD' colspan='2' style='color:red'>" + getlbl('con.TempNotice') + "</td></tr>");
}

//初使化部门
function InitDepartments(){
	var $tr = $("#tr_DepartmentList"), 
		$label = $tr.children("td.CaptionTD"),
		$data = $tr.children("td.DataTD");

	var arrDepts = GetDeptJSON();
	var deptListHtml = "<TABLE width='100%' border='0' cellPadding=0 cellSpacing=0>" + 
			"<TBODY><TR>" + 
			"<TD width='30%' valign='top'><div onDblClick='fInsertDept()' class='ui-jqdialog-content ui-widget-content'>" + 
			"<select id='selDeptSrc' name='selDeptSrc' class='FormElement ui-widget-content ui-corner-all' size=8 multiple style='WIDTH: 180px'>";

	deptListHtml += "<option value='0' code='00000'>" + getlbl("con.AllDept") + "</option>";

	var id, name, code, sBlank, len;

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
			for(var i = 0; i < len; i ++){
				sBlank += "&nbsp;";
			}

			deptListHtml += "<option value='" + id + "' code='" + code + "'>" + sBlank + "|-" + name + "</option>";
		}
	}

	deptListHtml += "</select></div></TD>" + 
			"<TD width='18%'align=middle valign='middle'>" + 
			"<div align='center'>" + 
			"<a class='fm-button ui-state-default ui-corner-all fm-button-icon-left ' id='deptadd' onclick='fInsertDept()'>" + 
			"<span class='ui-icon ui-icon-carat-1-e ' style='position:relative;left: -13px;top: 8px;'></span>" + 
			"<span class='ui-icon ui-icon-carat-1-e ' style='position:relative;left: -8px;top: 0px;'></span>" + 
			"</a><p>" + 
			"<a class='fm-button ui-state-default ui-corner-all fm-button-icon-left' id='deptdel' onclick='fDelDept()'>" + 
			"<span class='ui-icon ui-icon-carat-1-w ' style='position:relative;left: -13px;top: 8px;'></span>" + 
			"<span class='ui-icon ui-icon-carat-1-w ' style='position:relative;left: -8px;top: 0px;'></span>" + 
			"</a></div></TD>" + 
			"<TD width='52%' valign='top'><div onDblClick='fDelDept()' class='ui-jqdialog-content ui-widget-content'>" + 
			"<select id='selDeptDesc' name='selDeptDesc' class='FormElement ui-widget-content ui-corner-all' style='WIDTH: 180px' multiple size=8 >" + 
			"</select></div></TD></TR></TBODY></TABLE>";

	$data.html(deptListHtml);
}

function LoadSelDept(deptIds){
	if(deptIds == undefined || typeof deptIds != "string" || deptIds == ""|| deptIds.search(/[a-zA-Z]+/g) >= 0){
		return false;
	}

	//所选部门列表
	var $selObj = $("#selDeptDesc");
	var arrIds = deptIds.split(",");	

	$selObj.empty();

	if($.inArray("0", arrIds) >= 0){
		$selObj.append("<option value='0' code='00000'>" + getlbl("con.AllDept") + "</option>");
	}
	else{
		var arrDepts = GetDeptJSON(null, deptIds); //获取部门数据
		var id, name, code, pcode, sBlank;

		for(var i in arrDepts){
			id = arrDepts[i].id;
			name = arrDepts[i].name;
			code = arrDepts[i].code;
			pcode = code.substr(0, code.length - 5);
			sBlank = "";

			if(pcode && pcode.length >= 5 && $selObj.find("option[code='" + pcode + "']").size() > 0){
				for(var i = 0; i <  code.length / 5; i ++){
					sBlank += "&nbsp;";
				}

				$selObj.append("<option value='" + id + "' code='" + code + "'>" + sBlank + "|-" + name + "</option>");		
			}
			else{
				$selObj.append("<option value='" + id + "' code='" + code + "'>" + name + "</option>");	
			}
		}
	}

	return true;
}

function InitEmployees(){
	var condition = "";
	if(arguments.length > 0) {
		condition = arguments[0];
	}

	var $tr = $("#tr_EmployeeList"), 
		$label = $tr.children("td.CaptionTD"),
		$data = $tr.children("td.DataTD");

	var empListHtml = "<TABLE width='100%' border='0' cellPadding=0 cellSpacing=0>" + 
			"<TBODY><TR>" + 
			"<TD width='30%' valign='top'><div onDblClick='fInsertEmp()' class='ui-jqdialog-content ui-widget-content'>" + 
			"<select id='selEmpSrc' name='selEmpSrc' class='FormElement ui-widget-content ui-corner-all' size=8 multiple style='WIDTH: 180px'>";

	empListHtml += "</select></div></TD>" + 
			"<TD width='18%'align=middle valign='middle'>" + 
			"<div align='center'>" + 
			"<a class='fm-button ui-state-default ui-corner-all fm-button-icon-left ' id='empadd' onclick='fInsertEmp()'>" + 
			"<span class='ui-icon ui-icon-carat-1-e ' style='position:relative;left: -13px;top: 8px;'></span>" + 
			"<span class='ui-icon ui-icon-carat-1-e ' style='position:relative;left: -8px;top: 0px;'></span>" + 
			"</a><p>" + 
			"<a class='fm-button ui-state-default ui-corner-all fm-button-icon-left' id='empdel' onclick='fDelEmp()'>" + 
			"<span class='ui-icon ui-icon-carat-1-w ' style='position:relative;left: -13px;top: 8px;'></span>" + 
			"<span class='ui-icon ui-icon-carat-1-w ' style='position:relative;left: -8px;top: 0px;'></span>" + 
			"</a></div></TD>" + 
			"<TD width='52%' valign='top'><div onDblClick='fDelEmp()' class='ui-jqdialog-content ui-widget-content'>" + 
			"<select id='selEmpDesc' name='selEmpDesc' class='FormElement ui-widget-content ui-corner-all' style='WIDTH: 180px' multiple size=8 >" + 
			"</select></div></TD></TR></TBODY></TABLE>";

	$data.html(empListHtml);
}

//获取员工JSON数据
function GetEmpJSON(){
	var condition = "";
	if(arguments.length > 0){
		condition = arguments[0];
	}

	var empIds = "";
	if(arguments.length > 1){
		empIds = arguments[1];
	}

	var result = $.ajax({type:'post',url:'../Common/GetEmployeeJSON.asp?nd='+getRandom(),data:{condition: condition, empIds: empIds},async:false});
	var data = result.responseText;
	var arrEmps = data ? ($.parseJSON(data) || []) : [];

	return arrEmps;
}

//获取员工JSON数据
function GetDeptJSON(){
	var condition = "";
	if(arguments.length > 0){
		condition = arguments[0];
	}

	var deptIds = "";
	if(arguments.length > 1){
		deptIds = arguments[1];
	}

	var result = $.ajax({type:"post",url:'../Common/GetDepartmentJSON.asp?nd='+getRandom()+'&userId=',data:{deptIds: deptIds},async:false});
	var data = result.responseText;
	var arrDepts = data ? ($.parseJSON(data) || []) : [];

	return arrDepts;
}


function LoadSelEmp(empIds){
	if(empIds == undefined || typeof empIds != "string" || empIds == "" || empIds.search(/[a-zA-Z]+/g) >= 0){
		return false;
	}

	var arrEmps = GetEmpJSON(null, empIds); //获取员工JSON数据

	//所选职员列表
	var $selObj = $("#selEmpDesc");

	for(var i in arrEmps){
		$selObj.append("<option value='" + arrEmps[i].id + "'>" + arrEmps[i].number + "-" + arrEmps[i].name + "</option>");
	}

	return true;
}

function fCheckController(){
	var con = $("input[name='ControllerSel']:checked").val();
	if (con == "0")
	{
		//全部设备
		$("#tr_ControllerID").hide();
		$("#editmodDataGrid").css("height","auto");
		$("#FrmGrid_DataGrid").css("height","auto");
	}
	else
	{
		$("#tr_ControllerID").show();
		$("#editmodDataGrid").css("height","auto");
		$("#FrmGrid_DataGrid").css("height","auto");
		GetController();
	}
}

function GetController(){
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
				}
			}
			catch(exception) {
				alert(exception);
			}
		}
	});
}

//获取时间表，并加载显示
function GetSchedule(){
	var strData;	
	$.ajax({
		url:'../Common/GetSchedule.asp?nd='+getRandom()+'&SelectID=EmployeeScheID&IsShow24HSchedule=1&strControllerID=',
		async:false,
		success: function(data) {
			if(data != ""){
			var $tr = $("#tr_EmployeeScheName"), 
				$data = $tr.children("td.DataTD");
				$data.html("&nbsp;"+data);
				//$("#divselSchedule").html(data);
			}
		}
	});
}

function fInsertCon(){
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
}

function fDelCon(){
	var i;
	for(i=document.getElementById("selConDesc").options.length-1; i>=0; i--)
	{
		if(document.getElementById("selConDesc").options[i].selected == true)
			document.getElementById("selConDesc").remove(i);
	}
}

function fInsertDept(){
	//部门列表
	var srcCode;
	var $srcObj = $("#selDeptSrc");
	var $selOptions = $srcObj.find("option:selected")

	//所选部门列表
	var $selObj = $("#selDeptDesc");

	//是否选择所有部门
	if($selObj.find("option[value='0']").length <= 0){
		if($selOptions.filter("option[value='0']").length > 0){
			$selObj.empty();
			$selObj.append("<option value='0' code='00000'>" + getlbl("con.AllDept") + "</option>");
		}
		else{
			var deptIds = "";
			var optCode;

			$selOptions.each(function(i){
				srcCode = $(this).attr("code");

				$srcObj.find("option[code^='" +  srcCode + "']").each(function(j){
					deptIds += "," + $(this).val();
				});
			});

			$selObj.find("option").each(function(i){
				deptIds += "," + $(this).val();
			});

			if(deptIds != ""){
				LoadSelDept(deptIds.substr(1));
			}
		}
	}
}

function fDelDept(){
	//所选部门列表
	var $selObj = $("#selDeptDesc");
	var $selOptions = $selObj.find("option:selected"); //待移出的选项
	var $selOption;
	var optCode;

	$selOptions.each(function(i){
		$selOption = $(this);
		optCode = $selOption.attr("code");

		$selObj.find("option[code^='" + optCode + "']").each(function(j){
			$(this).remove();
		});
	});
}

function fInsertEmp(){
	//职员列表
	var srcValue, srcText;
	var $srcObj = $("#selEmpSrc");
	var $selOptions = $srcObj.find("option:selected"); //选中职员
	var $selOption, $allOptions; //包括子部门

	//所选职员列表
	var $selObj = $("#selEmpDesc");

	//是否选择所有职员
	if($selObj.find("option[value='0']").length <= 0){ //未选择所有员工，则继续添加
		if($selOptions.filter("option[value='0']").length > 0){
			$selObj.empty();
			$selObj.append("<option value='0'>" + getlbl("con.AllEmp") + "</option>");
		}
		else{
			$selOptions.each(function(i){
				$selOption = $(this);
				srcValue = $selOption.val();
				srcText = $selOption.text();			
				
				if($selObj.find("option[value='" + srcValue + "']").length <= 0){
					$selObj.append("<option value='" + srcValue + "'>" + srcText + "</option>");
				}
			});
		}
	}
}

function fDelEmp(){
	//所选职员列表
	var $selObj = $("#selEmpDesc");
	var $selOptions = $selObj.find("option:selected"); //待移出的选项

	$selOptions.each(function(i){
		$(this).remove();
	});
}

function fSearchEmployee(){
	$("#divSearch").load("search.asp?submitfun=fSearchEmployeeSubmit()");
	$("#divSearch").show();
}

function fSearchEmployeeSubmit(){
	var strsearchField=$("#searRetColVal").html();
	var strsearchOper=$("#searRetOperVal").html();
	var strsearchString=$("#searRetDataVal").html();
	
	condition = strsearchField + "|," + strsearchOper + "|," + encodeURI(strsearchString);
	
	var arrEmps = GetEmpJSON(condition);

	//所选职员列表
	var $srcObj = $("#selEmpSrc");

	for(var i in arrEmps){
		$srcObj.append("<option value='" + arrEmps[i].id + "'>" + arrEmps[i].number + "-" + arrEmps[i].name + "</option>");
	}
}

function fCheckDept(){
	if($("#tr_DepartmentCode").children("td.DataTD").children("input").is(":checked")){
		$("#tr_DepartmentList").show();
	}
	else{
		$("#selDeptDesc>option").each(function(){
			$(this).remove();
		});

		$("#tr_DepartmentList").hide();
	}
}

function fCheckEmp(){
	if($("#tr_EmployeeCode").children("td.DataTD").children("input").is(":checked")){
		$("#tr_EmployeeList").show();
		$("#btnSearchEmployee").show();
	}
	else{
		$("#selEmpDesc>option").each(function(){
			$(this).remove();
		});

		$("#tr_EmployeeList").hide();
		$("#btnSearchEmployee").hide();
	}
}

function fGetFormData(){	
	var data = {EmployeeScheID:"",EmployeeController:"",DepartmentCode:"",DepartmentName:"",EmployeeCode:"",EmployeeName: ""};

	//时间表
	data.EmployeeScheID = $("#EmployeeScheID").val();

	//设备
	var strEmployeeController = $("input[name='ControllerSel']:checked").val();
	var strConvalues = "";//EmployeeController
	if(strEmployeeController == "1"){ //0 所有设备  1 部分设备
		for(i=0; i<$("#selConDesc option").length; i++){
			strConvalues = strConvalues + "," + document.getElementById("selConDesc").options[i].value;
		}
		if (strConvalues != ""){
			strConvalues = strConvalues.substr(1);
		}
		strEmployeeController = strConvalues;
	}

	data.EmployeeController = strEmployeeController;

	//选择部门
	if($("#tr_DepartmentCode").children("td.DataTD").children("input").is(":checked")){
		var deptIds = "", deptNames = "";
		$("#selDeptDesc").find("option").each(function(){
			deptIds += "," + $(this).val();
			deptNames += "," + $(this).text();
		});

		data.DepartmentCode = deptIds.substr(1);
		data.DepartmentName = deptNames.substr(1);
	}

	//选择职员
	if($("#tr_EmployeeCode").children("td.DataTD").children("input").is(":checked")){
		var empIds = "", empNames = "";
		$("#selEmpDesc").find("option").each(function(){
			empIds += "," + $(this).val();
			empNames += "," + $(this).text();
		});

		data.EmployeeCode = empIds.substr(1);
		data.EmployeeName = empNames.substr(1);
	}

	//只使用此条件
	data.OnlyByCondition = $("#tr_OnlyByCondition").children("td.DataTD").children("input").is(":checked") ? "1" : "0";
	return data; 
}

function RegController(){
	var rowids,i;
	var rowidArr = $("#DataGrid").jqGrid("getGridParam", "selarrrow");
	if(rowidArr == "" || rowidArr.length <= 0){
		//alert("请选择需要操作的数据行!");
		alert(getlbl("con.SelRowNull"));
		return;
	}
	rowids = "";
	for(i=0; i<rowidArr.length; i++){
		rowids=rowids+rowidArr[i]+",";
	}
	if(rowids != ""){
		rowids = rowids.substring(0,rowids.length-1);
	}
	
	var obj = {
		resizable: false,
		height:200,
		width:480,
		modal: true,
		buttons : {},
	};
	var confirmReg = getlbl("comm.Confirm");	//"确定注册"
	var cancelReg = getlbl("comm.Cancel"); 		//"取消注册"
	obj.buttons[confirmReg] = function(){
		$(this).dialog("close");	//"确定注册"
		RegCard(rowids);
	}
	obj.buttons[cancelReg] = function(){
		$(this).dialog("close");	//"取消注册"
	}

	$("#dialog-confirm").dialog(obj);	
};

function RegCard(templateId){
	$.ajax({
		type: 'Post',
		url: 'RegCardTemplateToControllerEdit.asp',
		data:{"TemplateId":templateId},
		success: function(data) {
			try  {
				var responseMsg = $.parseJSON(data);
				if(responseMsg.success == false){
					alert(responseMsg.message);
				}else if(responseMsg.success == true){
					//成功
					alert(responseMsg.message);
				}else{
					alert("Reg exception");
				}
			}
			catch(exception) {
				alert(exception+"," + data);
			}
		},
		error:function(XmlHttpRequest,textStatus, errorThrown){
			alert(textStatus+XmlHttpRequest.responseText);
		}
	});
}

$(function(){
	var iWidth = $(window).width()-40;
	if (iWidth <= 970)
		iWidth = 970;
	$("#DataGrid").setGridWidth(iWidth);　 
	$(window).resize(function(){　　
		$("#DataGrid").setGridWidth(iWidth);
	});　　
});
