var blnOperPermissions = false;
$(document).ready(function(){  
CheckLoginStatus();
InitForm();
//获取操作权限
var role = GetOperRole("users");
var iedit=false,iadd=false,idel=false,iview=false,irefresh=false,isearch=false,iexport=false;
try{
	iedit=role.edit;
	iadd=role.add;
	idel=role.del;
	iview=role.view;
	irefresh=role.refresh;
	isearch=role.search;
	iexport=role.exportdata;
}
catch(exception) {
	alert(exception);
}

function onSelDepartment1(){
	alert("test");
}
jQuery("#DataGrid").jqGrid({
		url:'UsersList.asp',
		editurl:"UsersEdit.asp",
		datatype: "json",
		//colNames:['UserId','登录名','密码','EmployeeId','姓名','OperPermissions','角色','访问部门','访问设备'],
		colNames:['UserId',getlbl("tool.LoginName"),getlbl("tool.Pwd"),'EmployeeId',getlbl("hr.Name"),'OperPermissions',getlbl("tool.Role"),getlbl("tool.VisitDept"),getlbl("tool.VisitCon")],
		colModel :[
			{name:'UserId',index:'UserId',width:10,hidden:true,viewable:false,editrules:{edithidden:true}},
			{name:'LoginName',index:'LoginName',editable:true,editrules:{required:true},width:220,
				stype:"text", searchoptions:{ sopt:["eq","ne",'cn','nc']},
				formoptions:{elmsuffix:"<font color=#FF0000>*</font>",rowpos:1,colpos:1}}, 
			{name:'UserPassword',index:'UserPassword',width:10,hidden:true,editrules:{required:true,edithidden:true},editable:true,edittype:'password',
				formoptions:{elmsuffix:"<font color=#FF0000>*</font>",rowpos:1,colpos:2}}, 
			{name:'Employeeid',index:'Employeeid',width:10,hidden:true,viewable:false,editrules:{edithidden:false}},
			{name:'Name',index:'Name',editable:true,editrules:{required:true},width:220,
				searchoptions:{sopt:["eq","ne",'cn','nc']},
				formoptions:{elmsuffix:"<font color=#FF0000>*</font>",rowpos:2,colpos:1}},
			{name:'OperPermissions',index:'OperPermissions',width:10,hidden:true,viewable:false,editrules:{edithidden:false}},
			{name:'OperPermDesc',index:'OperPermDesc',editable:true,editrules:{required:true,edithidden:true},search:false,width:220,
				edittype:'select', editoptions:{value:"2:"+getlbl("tool.OperPermDescVal2")+";1:"+getlbl("tool.OperPermDescVal1")},formoptions:{elmsuffix:"<span id='spanShowOperPermMsg' style='color:red'></span>",rowpos:2,colpos:2},//2:一般职员;1:系统管理员
				},
			{name:'RoleDept',index:'RoleDept',width:10,hidden:true,viewable:true,editrules:{edithidden:true},editable:true,formoptions:{rowpos:3,colpos:1}},
			{name:'RoleCon',index:'RoleCon',width:10,hidden:true,viewable:true,editrules:{edithidden:true},editable:true,formoptions:{rowpos:3,colpos:2}},
			], 
		caption:getlbl("tool.UserList"),//"用户列表",
		imgpath:'/images',
		multiselect: false,
		rowNum:irowNum,
		rowList:[10,16,20,30],
		prmNames: {search: "_search"},  
		postData:{
				  DepartmentId: function() { return GetDeptSelChildIds("selDept") /*$("#selDept").val()*/; },
		},
		//jsonReader: { repeatitems: false },
		pager: '#pager',
		//sortname: 'RecordID',
		multiselect: true,
        multiboxonly: true,
		viewrecords: true,
		sortorder: "asc",
		height: 'auto',
		width:'auto',
		forceFit:true, //调整列宽度不会改变表格的宽度
		hidegrid:false,//禁用控制表格显示、隐藏的按钮
		loadtext:strloadtext,
		toppager:true,
		loadComplete:function(data){ //完成服务器请求后，回调函数 
        if(data == null || data.records==0){ 
			jQuery("#DataGrid").jqGrid('clearGridData');
        }}
});

jQuery("#DataGrid").jqGrid('navGrid','#DataGrid_toppager', 
	{
		edit:iedit,add:iadd,del:idel,view:iview,refresh:irefresh,search:isearch,edittext:stredittext,addtext:straddtext,deltext:strdeltext,searchtext:strsearchtext,refreshtext:strrefreshtext,viewtext:strviewtext,
		alerttext : stralerttext ,
	}, 
	{
		top:0,width:920,
		reloadAfterSubmit :true,
		closeAfterEdit: true,
		jqModal:true, closeOnEscape:false,
		afterSubmit:getEditafterSubmit,
		afterShowForm:function(formid){
			var rowid = $("#DataGrid").jqGrid('getGridParam', 'selrow');
			if($("#LoginName").val().trim().toLowerCase() == "admin"){
				$("#OperPermDesc").attr("disabled", true);
				$("#LoginName").attr("disabled",true).css({ "color":"#ccc"});
				$("#tr_RoleDept").hide();
			}else{
				$("#OperPermDesc").attr("disabled",false);
				$("#LoginName").attr("disabled",false).css({ "color":"#222"});
				$("#tr_RoleDept").show();
			}
			//初始化窗体，加载对应的真实姓名的部门与人事信息
			InitEditForm("edit",rowid);
		},
		beforeSubmit:function(postdata, formid){
			//动态增加提交参数
			var Employeeid = $("#SelEmployees").children('option:selected').val();
			var OperPermissions = $("#OperPermDesc").children('option:selected').val();
			var OperPermDesc = $("#OperPermDesc").find("option:selected").text();
			postdata['Employeeid'] = Employeeid;   
			postdata['OperPermissions'] = OperPermissions;   
			postdata['OperPermDesc'] = OperPermDesc;  
			
			if(blnOperPermissions){
				//管理员， 非admin用户，返回部门权限ID及设备ID
				if($("#LoginName").val().trim().toLowerCase() != "admin"){
					postdata['RoleDeptId'] = GetRoleDeptIds();
					postdata['RoleConId'] = GetRoleConIds();
				}
			}
			return[true,'']; 
		},
		//selarrrow
	},  //  default settings for edit
	{
		top:0,width:920,
		reloadAfterSubmit :true,
		closeAfterEdit: true,
		afterSubmit:getAddafterSubmit,
		afterShowForm:function(formid){
			//初始化窗体，加载对应的真实姓名的部门与人事信息
			InitEditForm("add","0");
		},
		beforeSubmit:function(postdata, formid){
			//动态增加提交参数
			var Employeeid = $("#SelEmployees").children('option:selected').val();
			var OperPermissions = $("#OperPermDesc").children('option:selected').val();
			var OperPermDesc = $("#OperPermDesc").find("option:selected").text();
			postdata['Employeeid'] = Employeeid;   
			postdata['OperPermissions'] = OperPermissions;   
			postdata['OperPermDesc'] = OperPermDesc;  
			//非admin用户，返回部门权限ID及设备ID
			if($("#LoginName").val().trim().toLowerCase() != "admin"){
				postdata['RoleDeptId'] = GetRoleDeptIds();
				postdata['RoleConId'] = GetRoleConIds();
			}
			return[true,'']; 
		},
	},  //  default settings for add
	{
		top:0,
		reloadAfterSubmit :false,
		afterSubmit:getDelafterSubmit
	},  // delete instead that del:false we need this
	{multipleSearch:false, multipleGroup:false, showQuery: false,closeAfterSearch: true,caption:strsearchcaption,top:60} ,// search options
	{	top:0,width:880,viewPagerButtons:false,
		beforeShowForm:function(formid){
			  $('#v_UserPassword').html("<span>****</span>"); 
			  var rowid = $("#DataGrid").jqGrid('getGridParam', 'selrow'); //获取选择行ID
				setTimeout(function() {
					InitViewForm(rowid);
				},200);
		}
	}	//view parameters
	);

var topPagerDiv = $('#DataGrid_toppager')[0];         // "#list_toppager"
$("#DataGrid_toppager_center", topPagerDiv).remove(); // "#list_toppager_center"
$(".ui-paging-info", topPagerDiv).remove();
$("#DataGrid_toppager_right").css("width","30%");
$("#DataGrid_toppager_left").css("width","70%");
$('#table_DataGrid_top_right').appendTo('#DataGrid_toppager_right');

if(iexport){
	$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
		caption:getlbl("hr.Export"),	//"导出",
		buttonicon:"ui-icon-bookmark",
		title:getlbl("hr.ExportToLocal"),	//"导出至本地",
		id:"DataGrid_btnSubmit",
		onClickButton: ExportData,
		//position:"first"
	});
}

function InitForm(){
	 InitDepartments();
}

function GetDepartments(){
	var htmlObj = $.ajax({url:'../Common/GetDepartment.asp?nd='+getRandom()+'&selID=selDept&DeptId=',async:false});
		$("#tdDept").html(htmlObj.responseText);
		$("#selDept").css('width','140');
		$("#selDept").css('font-size','12px');
		$("#selDept").prepend("<option value='-1'>"+getlbl("rep.AllDept1")+"</option>"); 	//1 - 所有部门
		$("#selDept").prepend("<option value='0'>"+getlbl("rep.MyRecord0")+"</option>"); 	//0 - 我的记录
		$("#selDept").val(0);	//选择value为0的项
		$("#selDept").change(function(){
			gridReload();
		});
}

function gridReload(){
	$("#DataGrid").jqGrid('setGridParam',{url:"UsersList.asp",page:1,}).trigger("reloadGrid");
} 

});

//初使化部门
function InitDepartments(selId){
	var $tr = $("#tr_ParentDepartmentID"), 
		$label = $tr.children("td.CaptionTD"),
		$data = $tr.children("td.DataTD");

	var id, name, code, sBlank, len;
	var arrDepts = getDeptJSON();

	var deptListHtml = "";

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

	$("#selDept").html(deptListHtml);
	$("#selDept").css('width','140');
	$("#selDept").css('font-size','12px');
	$("#selDept").prepend("<option value='-1'>"+getlbl("rep.AllDept1")+"</option>"); 	//1 - 所有部门
	$("#selDept").prepend("<option value='0'>"+getlbl("rep.MyRecord0")+"</option>"); 	//0 - 我的记录
	$("#selDept").val(0);	//选择value为0的项
	$("#selDept").change(function(){
		gridReload();
	});
}

function InitEditForm(oper,userId){
	$("#tr_LoginName").children("td.CaptionTD").css("width", "10%"); //设置标签宽度
	$("#tr_LoginName").children("td.DataTD").css("width", "40%");
	var htmlObj,DepartmentId,EmployeeId;
	DepartmentId = "",EmployeeId="";
	if(oper == "edit"){
		$('#Act_Buttons').children().eq(0).html("<td class='navButton'></td>");  
	}  
	//一般职员仅可修改自己用户名与密码
	blnOperPermissions = GetOperPermissions();
	if(!blnOperPermissions){
		$("#tr_RoleDept").html("");
		$("#tr_Name").children("td.DataTD").eq(0).find('input').attr("disabled","disabled");
		$("#tr_Name").children("td.DataTD").eq(1).find('select').attr("disabled","disabled");
		return true;
	}
	//编辑时，根据用户ID，获取该用户部门ID，员工ID等信息
	if(oper == "edit"){
		if(userId != ""){
			htmlObj = $.ajax({url:"../Common/GetEmployeeByUserid.asp?strUserId="+userId,async:false});
			if(htmlObj.responseText != ""){
				var arr = htmlObj.responseText.split(",,");
				DepartmentId = arr[0];
				EmployeeId = arr[2];
			}
		}
	}
	//获取所有部门列表
	//htmlObj = $.ajax({url:"../Common/GetDepartmentForUser.asp",async:false});
	htmlObj = $.ajax({url:"../Common/GetDepartment.asp?selID=SelDepartment",async:false});
	$("#tr_Name").children().eq(1).html("&nbsp;"+htmlObj.responseText+"&nbsp;<select id = 'SelEmployees' class='FormElement ui-widget-content ui-corner-all' style='width:160px'></select><font color=#FF0000>*</font>");
	$("#SelDepartment").prepend("<option value=''></option>");
	$("#SelDepartment").val('');
	$("#SelDepartment").css('width','160');
	//绑定部门下拉框onChange事件
	$("#SelDepartment").change(function(){
		//var depId = $(this).children('option:selected').val();
		var depId = GetDeptSelChildIds("SelDepartment"); //获取部门下所有的子部门ID
		$("#SelEmployees").empty();
		//根据所选部门，获取该部门下的人事列表
		htmlObj = $.ajax({url:"../Common/GetEmployeesForUser.asp?strDepartmentId="+depId+"&strEmployeeId="+EmployeeId,async:false});
		if(htmlObj.responseText != ""){
			var arrEmp = htmlObj.responseText.split("||");
			for(var i=0; i<arrEmp.length; i++){
				var arrName = arrEmp[i].split(",,");
				$("<option value='"+arrName[0]+"'>"+arrName[1]+"</option>").appendTo("#SelEmployees");
			}
		}
	})
	//选择部门及人事
	if(oper == "edit"){
		$("#SelDepartment").val(DepartmentId);
		$("#SelDepartment").trigger("change");
		$("#SelEmployees").val(EmployeeId); 
	}
	
	if($("#LoginName").val().trim().toLowerCase() != "admin"){
		$("#tr_RoleDept").children("td.DataTD").eq(0).html("&nbsp;<iframe id='depframe' name='depframe' width='98%' height='270' frameborder='0'  align='center' src='GetUserEditDept.html?nd="+getRandom()+"&userId="+userId+"'></iframe>");
		$("#tr_RoleDept").children("td.DataTD").eq(1).html("&nbsp;<iframe id='conframe' name='conframe' width='98%' height='270' frameborder='0'  align='center' src='GetUserEditController.html?nd="+getRandom()+"&userId="+userId+"'></iframe>");
	}
	//$("#tr_RoleDept").children("td.DataTD").eq(0).load("GetUserEditDept.html");
	$("#OperPermDesc").change(function(){
		if($("#OperPermDesc").val() == "1"){
			$("#spanShowOperPermMsg").html(getlbl("tool.OperPermDescVal1Msg"));	//"[系统管理员]拥有增加、修改、删除等操作权限"
		}
		else if($("#OperPermDesc").val() == "2"){
			$("#spanShowOperPermMsg").html(getlbl("tool.OperPermDescVal2Msg"));	//"[一般职员]仅能查看数据，不能操作"
		}
	});
	//$("#spanShowOperPermMsg").html("aa");
}

function GetRoleDeptIds(){
	return $("#depframe")[0].contentWindow.GetCheckIDs();
}

function GetRoleConIds(){
	return $("#conframe")[0].contentWindow.GetCheckIDs();
}

function InitViewForm(userId){
	$("#trv_LoginName").children("td.CaptionTD").css("width", "10%"); //设置标签宽度
	$("#trv_LoginName").children("td.DataTD").css("width", "40%");
	$('#Act_Buttons').children().eq(0).html("<td class='navButton'></td>");  
	

	//if($("#LoginName").val().trim().toLowerCase() != "admin"){
		$("#trv_RoleDept").children("td.DataTD").eq(0).html("&nbsp;<iframe id='depframe' name='depframe' width='98%' height='270' frameborder='0'  align='center' src='GetUserEditDept.html?nd="+getRandom()+"&userId="+userId+"&view=1'></iframe>");
		$("#trv_RoleDept").children("td.DataTD").eq(1).html("&nbsp;<iframe id='conframe' name='conframe' width='98%' height='270' frameborder='0'  align='center' src='GetUserEditController.html?nd="+getRandom()+"&userId="+userId+"&view=1'></iframe>");
	//}
	
	//$("#tr_RoleDept").children("td.DataTD").eq(0).load("GetUserEditDept.html");
}

function ExportData(){
	$("#divExport").load("../Tools/ExportDataUI.asp?nd="+getRandom()+"&exportType=users");
	$("#divExport").show();
}	
