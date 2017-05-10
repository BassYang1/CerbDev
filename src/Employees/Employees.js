$(document).ready(function(){  
	//$("#progressbar").hide();
CheckLoginStatus();

function CardCheck(value, colname) {
	if (value < 0) 
	   return [false,getlbl("hr.CardNoLt0")];//"卡号不能小于0"
	else 
	   return [true,""];
}
InitDepartments();

jQuery("#DataGrid").jqGrid({
		url:'EmployeesList.asp',
		editurl:"EmployeesEdit.asp",
		datatype: "json",
		//colNames:['Employeeid','部门','姓名','photo1','工号','卡号','身份证','性别','职务','职位','电话','Email','出生日期','入职日期', '婚否','学历','国籍','籍贯','通信地址','在职状态','采集指纹','离职日期','离职原因','photo','DeptID'],
		colNames:['Employeeid',getlbl("hr.Dept"),getlbl("hr.Name"),'photo1',getlbl("hr.Num"),getlbl("hr.Card"),getlbl("hr.IdentityCard"),getlbl("hr.Sex"),getlbl("hr.Position"),getlbl("hr.Headship"),getlbl("hr.Telephone"),'Email',getlbl("hr.BirthDate"),getlbl("hr.JoinDate"), getlbl("hr.Marry"),getlbl("hr.Knowledge"),getlbl("hr.Country"),getlbl("hr.NativePlace"),getlbl("hr.Address"),getlbl("hr.IncumbencyStatus"),getlbl("hr.CollectFP"),getlbl("hr.DimissionDate"),getlbl("hr.DimissionReason"),'photo','DeptID'],
		colModel :[
			{name:'Employeeid',index:'Employeeid',align:'center',width:10,hidden:true,viewable:false,editrules:{edithidden:false},search:false},
			{name:'DepartmentID',index:'DepartmentID',align:'center',editable:true,editrules:{required:true},
				edittype:'select', editoptions:{dataUrl:"../Common/GetDepartment.asp",
												dataInit: function (elem) {$(elem).css("width", "160"); }},
				stype:"select", searchoptions:{ dataUrl:"../Common/GetDepartment.asp",sopt:["eq","ne"],},
				formoptions:{rowpos:1,colpos:1}},  
			{name:'Name',index:'Name',align:'center',editable:true,editoptions:{maxlength:50},editrules:{required:true},
				searchoptions:{sopt:["eq","ne",'cn','nc']},
				formoptions:{rowpos:1,colpos:2,elmsuffix:"<font color=#FF0000>*</font>"}},
			{name:'photo1',index:'photo1',align:'center',hidden:true,editable:true,editrules:{edithidden:true},label:'photo1',
				formoptions:{rowpos:1,colpos:3,}},
			{name:'Number',index:'Number',align:'center',editable:true,editoptions:{size:20,maxlength:20},editrules:{required:true,edithidden:true},
				formoptions:{rowpos:2,colpos:1,elmsuffix:"<font color=#FF0000>*</font>"},
				searchoptions:{sopt:["eq","ne",'cn','nc']}},
			{name:'Card',index:'Card',align:'center',editable:true,width:120,
				editrules:{required:true,integer:true,maxValue:4294967294,custom:true, custom_func:CardCheck},
				searchoptions:{sopt:["eq","ne",'lt','le','gt','ge']},
				formoptions:{rowpos:2,colpos:2,elmsuffix:"<font color=#FF0000>*</font>"}}, 
			{name:'IdentityCard',index:'IdentityCard',align:'center',editable:true,editoptions:{size:20,maxlength:20},editrules:{required:false,edithidden:true},hidden:true,
				searchoptions:{sopt:["eq","ne",'cn','nc']},
				formoptions:{rowpos:3,colpos:1}},
			{name:'Sex',index:'Sex',align:'center',editable:true,editrules:{required:false,edithidden:true},width:80,
				edittype:'select', editoptions:{maxlengh:20,value:" : ;"+getlbl("hr.Male")+":"+getlbl("hr.Male")+";"+getlbl("hr.Female")+":"+getlbl("hr.Female")},
				stype:'select',searchoptions:{value:" : ;"+getlbl("hr.Male")+":"+getlbl("hr.Male")+";"+getlbl("hr.Female")+":"+getlbl("hr.Female"),sopt:["eq","ne"]},//" : ;男:男;女:女",
				formoptions:{rowpos:3,colpos:2}},
			{name:'Headship',index:'Headship',align:'center',editable:true,editrules:{required:false},
				edittype:'select', editoptions:{dataUrl:"../Common/GetTableFieldCode.asp?type=headship"},
				stype:"select", searchoptions:{ dataUrl:"../Common/GetTableFieldCode.asp?type=headship",sopt:["eq","ne"]},
				formoptions:{rowpos:4,colpos:1}},  
			{name:'Position',index:'Position',editable:true,editrules:{required:false},hidden:true,
				edittype:'select', editoptions:{dataUrl:"../Common/GetTableFieldCode.asp?type=position"},
				stype:"select", searchoptions:{ dataUrl:"../Common/GetTableFieldCode.asp?type=position",sopt:["eq","ne"],searchhidden:true},
				formoptions:{rowpos:4,colpos:2}},  
			{name:'Telephone',index:'Telephone',editable:true,editrules:{required:false,edithidden:true},editoptions:{size:20,maxlength:20},
				search:false,hidden:true,
				formoptions:{rowpos:5,colpos:1}}, 
			{name:'Email',index:'Email',editable:true,editrules:{required:false,edithidden:true,email:true},editoptions:{size:20,maxlength:50},
				search:false,hidden:true,
				formoptions:{rowpos:5,colpos:2}}, 
			{name:'BirthDate',index:'BirthDate',editable:true,editrules:{required:false,date:false,edithidden:true},
				search:false,hidden:true,
				formatter:'date',sorttype:'date',
				formatoptions: {srcformat:'Y-m-d',newformat:'Y-m-d'},datefmt:'Y-m-d', 
				editoptions:{size:20,maxlengh:20,dataInit:function(element){$(element).bind('focus',
					function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd'})})}},
				formoptions:{rowpos:6,colpos:1}},
			{name:'JoinDate',index:'JoinDate',align:'center',editable:true,editrules:{required:false,date:false,edithidden:true},width:120
				,search:false,
				formatter:'date',sorttype:'date',
				formatoptions: {srcformat:'Y-m-d',newformat:'Y-m-d'},datefmt:'Y-m-d', 
				editoptions:{size:20,maxlengh:20,dataInit:function(element){$(element).bind('focus',
					function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd'})})}},
				formoptions:{rowpos:6,colpos:2}},
			{name:'Marry',index:'Marry',editable:true,editrules:{required:false,edithidden:true},hidden:true,
				edittype:'select', editoptions:{value:" : ;"+getlbl("hr.Married")+":"+getlbl("hr.Married")+";"+getlbl("hr.Unmarried")+":"+getlbl("hr.Unmarried")},//" : ;已婚:已婚;未婚:未婚"
				stype:'select',searchoptions:{value:" : ;"+getlbl("hr.Married")+":"+getlbl("hr.Married")+";"+getlbl("hr.Unmarried")+":"+getlbl("hr.Unmarried"),sopt:["eq","ne"],searchhidden:true},
				formoptions:{rowpos:7,colpos:1}},
			{name:'Knowledge',index:'Knowledge',editable:true,editrules:{required:false,edithidden:true},hidden:true,
				edittype:'select', editoptions:{dataUrl:"../Common/GetTableFieldCode.asp?type=knowledge"},
				stype:'select',searchoptions:{dataUrl:"../Common/GetTableFieldCode.asp?type=knowledge",sopt:["eq","ne"],searchhidden:true},
				formoptions:{rowpos:7,colpos:2}},
			{name:'Country',index:'Country',editable:true,editrules:{required:false,edithidden:true},hidden:true,
				edittype:'select', editoptions:{dataUrl:"../Common/GetTableFieldCode.asp?type=country"},
				stype:'select',searchoptions:{dataUrl:"../Common/GetTableFieldCode.asp?type=country",sopt:["eq","ne"],searchhidden:true},
				formoptions:{rowpos:8,colpos:1}},
			{name:'NativePlace',index:'NativePlace',editable:true,editrules:{required:false,edithidden:true},hidden:true,
				edittype:'select', editoptions:{dataUrl:"../Common/GetTableFieldCode.asp?type=nativeplace"},
				stype:'select',searchoptions:{dataUrl:"../Common/GetTableFieldCode.asp?type=nativeplace",sopt:["eq","ne"],searchhidden:true},
				formoptions:{rowpos:8,colpos:2}},
			{name:'Address',index:'Address',editable:true,editrules:{required:false,edithidden:true,size:60,maxlengh:100},
				search:false,hidden:true,
				formoptions:{rowpos:9,colpos:1}}, 
			{name:'IncumbencyStatus',index:'IncumbencyStatus',editable:true,editrules:{required:false,edithidden:true},hidden:true,
				edittype:'select', editoptions:{value:getlbl("hr.Incumbent0")+":"+getlbl("hr.Incumbent0")+";"+getlbl("hr.Incumbent1")+":"+getlbl("hr.Incumbent1")},//"0-在职:0-在职;1-离职:1-离职"
				stype:'select',searchoptions:{value:getlbl("hr.Incumbent0")+":"+getlbl("hr.Incumbent0")+";"+getlbl("hr.Incumbent1")+":"+getlbl("hr.Incumbent1"),sopt:["eq","ne"],searchhidden:true},
				formoptions:{rowpos:10,colpos:1}},
			{name:'isFingerPrint',index:'isFingerPrint',editable:false,editrules:{required:false,edithidden:true},search:false,hidden:true,
				formoptions:{rowpos:10,colpos:2}}, 
			{name:'DimissionDate',index:'DimissionDate',align:'center',editable:true,editrules:{required:false,date:false,},width:120
				,search:false,hidden:true,
				formatter:'date',sorttype:'date',
				formatoptions: {srcformat:'Y-m-d',newformat:'Y-m-d'},datefmt:'Y-m-d', 
				editoptions:{size:20,maxlengh:20,dataInit:function(element){$(element).bind('focus',
					function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd'})})}},
				formoptions:{rowpos:11,colpos:1}},
			{name:'DimissionReason',index:'DimissionReason',editable:true,editrules:{required:false,},search:false,hidden:true,
				formoptions:{rowpos:11,colpos:2}}, 
			{name:'photo',index:'photo',editable:true,editrules:{required:false},search:false,hidden:true,}, 
			{name:'DeptID',index:'DeptID',hidden:true,viewable:false,editrules:{edithidden:false},search:false},
			], 
		caption:getlbl("hr.PersonnelList"),//"人事列表"
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
		sortorder: "desc",
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

//获取操作权限
var role = GetOperRole("employees");
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

jQuery("#DataGrid").jqGrid('navGrid','#DataGrid_toppager', 
	{
		edit:iedit,add:iadd,del:idel,view:iview,refresh:irefresh,search:false,edittext:stredittext,addtext:straddtext,deltext:strdeltext,searchtext:strsearchtext,refreshtext:strrefreshtext,viewtext:strviewtext,
		alerttext : stralerttext ,
	}, 
	{
		top:0,width:850,labelswidth:'70px',
		reloadAfterSubmit :true,
		closeAfterEdit: document.all ? false:true,	//IE下修改后，对话框不关闭。主要是上传照片Ajax无法同步执行
		jqModal:true,
		closeOnEscape:false,
		beforeInitData:function(formid){
			var rowid = $("#DataGrid").jqGrid('getGridParam', 'selrow'); //获取选择行ID
			if(rowid != null){
				var ret = $("#DataGrid").jqGrid("getRowData", rowid);//根据ID，获取行数据
			  	//修改人事资料时，选择当前部门;
				$("#DataGrid").jqGrid('setColProp', 'DepartmentID', {editoptions:{dataUrl: '../Common/GetDepartment.asp?selectId='+ret.DeptID}, }); 
			}
		}, 
		beforeShowForm:function(form){
		},
		beforeSubmit:function(postdata, formid){
			var rowid = $("#DataGrid").jqGrid('getGridParam', 'selrow'); //获取选择行ID
			return[true,'']; 
		},
		afterSubmit:function(response, postdata){
			try{
				var responseMsg = $.parseJSON(response.responseText);
				var $infoTr = $("#TblGrid_" + $.jgrid.jqID(this.id) + ">tbody>tr.tinfo"),
				     $infoTd = $infoTr.children("td.topinfo");//信息栏
				//var e = eval('('+response.responseText+')');
				if(responseMsg.id != ""){
					var retVal = $("#iMage")[0].contentWindow.fSubmit(responseMsg.id);
					if(retVal){
						if (responseMsg.success) {
							var myInfo = '<div class="ui-state-highlight ui-corner-all">' + '<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>' + responseMsg.message + '</div>'
							$infoTd.html(myInfo);
							$infoTr.show();
							return [responseMsg.success,responseMsg.message];
						} else {
							//错误信息是在id为FormError的单元格显示
							$infoTr.hide();//隐藏信息栏以免同时显示info和FormError
							return [responseMsg.success,responseMsg.message];
						}						
					}
					else
						return [false,getlbl("hr.UpPhotoFail")];//"照片上传失败"
				}
				else{
					return [responseMsg.success,responseMsg.message];
				}
			}
			catch(exception) {
				alert(exception);
			}
		},
		afterShowForm:function(formid){
			var rowid = $("#DataGrid").jqGrid('getGridParam', 'selrow'); //获取选择行ID
			InitForm("edit",rowid);
			$("#pData").hide();
			$("#nData").hide();
		},
		//selarrrow
	},  //  default settings for edit
	{
		top:0,width: 850,labelswidth:'70px',
		//url: addUrl,
		jqModal : true,  
		reloadAfterSubmit :true,
		closeAfterAdd:  document.all ? false:true,	//IE下修改后，对话框不关闭。主要是上传照片Ajax无法同步执行
		//bottominfo : "<div class=&#39test'>有*号的为必填项  </div>",
		afterSubmit:function(response, postdata){
			try{
				var responseMsg = $.parseJSON(response.responseText);
				var $infoTr = $("#TblGrid_" + $.jgrid.jqID(this.id) + ">tbody>tr.tinfo"),
				     $infoTd = $infoTr.children("td.topinfo");//信息栏
				//var e = eval('('+response.responseText+')');
				if(responseMsg.id != ""){
					var retVal = $("#iMage")[0].contentWindow.fSubmit(responseMsg.id);
					if(retVal){
						if (responseMsg.success) {
							var myInfo = '<div class="ui-state-highlight ui-corner-all">' + '<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>' + responseMsg.message + '</div>'
							$infoTd.html(myInfo);
							$infoTr.show();
							InitForm("add","0");
							return [responseMsg.success,responseMsg.message];
						} else {
							//错误信息是在id为FormError的单元格显示
							$infoTr.hide();//隐藏信息栏以免同时显示info和FormError
							return [responseMsg.success,responseMsg.message];
						}						
					}
					else
						return [false,getlbl("hr.UpPhotoFail")];//"照片上传失败"
				}
				else{
					return [responseMsg.success,responseMsg.message];
				}
			}
			catch(exception) {
				alert(exception);
			}
		},
		afterShowForm:function(formid){	
			InitForm("add","0");
        }
	},  //  default settings for add
	{
		top:0,
		reloadAfterSubmit :true,
		afterSubmit:getDelafterSubmit
	},  // delete instead that del:false we need this
	{	
		top:60,
		multipleSearch:false, multipleGroup:false, showQuery: false,caption:strsearchcaption,
	} ,// search options
	{	
		top:0,width:850,
		beforeShowForm: function () {			
			var rowid = $("#DataGrid").jqGrid('getGridParam', 'selrow'); //获取选择行ID
			setTimeout(function() {
				InitForm("view",rowid);
				$("#pData").hide();
				$("#nData").hide();
    		},100);
			
        },
	}	//view parameters
	);

var topPagerDiv = $('#DataGrid_toppager')[0];         // "#list_toppager"
$("#DataGrid_toppager_center", topPagerDiv).remove(); // "#list_toppager_center"
$(".ui-paging-info", topPagerDiv).remove();
$("#DataGrid_toppager_right").css('width','30%');
$("#DataGrid_toppager_left").css("width","70%");
$('#table_DataGrid_top_right').appendTo('#DataGrid_toppager_right');
if(isearch){
	$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
		caption:getlbl("hr.Search"),//"查找"
		buttonicon:"ui-icon-search",
		title:getlbl("hr.Search"),//"查找"
		id:"DataGrid_btnSearch",
		onClickButton: Search,
		position:"last"
	});
}
if(iexport){
	$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
		caption:getlbl("hr.Export"),//"导出"
		buttonicon:"ui-icon-bookmark",
		title:getlbl("hr.ExportToLocal"),//"导出至本地"
		id:"DataGrid_btnSubmit",
		onClickButton: ExportData,
		//position:"first"
	});
}

function GetDepartments(){
	var htmlObj = $.ajax({url:'../Common/GetDepartment.asp?nd='+getRandom()+'&selID=selDept&DeptId=',async:false});
		$("#tdDept").html(htmlObj.responseText);
		$("#selDept").css('width','140');
		$("#selDept").css('font-size','12px');
		$("#selDept").prepend("<option value='-1'>1 - "+getlbl("hr.AllDept")+"</option>"); //所有部门
		$("#selDept").prepend("<option value='0'>0 - "+getlbl("hr.MyRecord")+"</option>"); //我的记录
		$("#selDept").val(0);	//选择value为0的项
		$("#selDept").change(function(){
			gridReload();
		});
}

//初使化部门
function InitDepartments(selId){
	var id, name, code, sBlank, len;
	var arrDepts = getUserDeptJSON();

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

function gridReload(){
	$("#DataGrid").jqGrid('setGridParam',{url:"EmployeesList.asp",page:1,}).trigger("reloadGrid");
}

function InitForm(oper,rowid)
{
	var $tr;
	if(oper == "view")
		$tr = $("#trv_DepartmentID"); 
	else
		$tr = $("#tr_DepartmentID"); 
	
	if(oper == "view"){
		$tr.children().eq(0).css("width", "15%");
		$tr.children().eq(2).css("width", "15%");
		$tr.children().eq(1).css("width", "25%");
		$tr.children().eq(3).css("width", "25%");
	}else{
		$tr.children().eq(0).css("width", "12%");
		$tr.children().eq(2).css("width", "12%");
		$tr.children().eq(1).css("width", "30%");
		$tr.children().eq(3).css("width", "30%");
	}	
	$tr.children().eq(4).attr("colspan", "2");
	$tr.children().eq(4).attr("rowspan", "7");
	$tr.children().eq(4).css("width", "12%");
	$tr.children().eq(5).remove();
	if(oper == "view")
		$tr.children().eq(4).html("<iframe name='iMage' id='iMage' style='position:absolute;top:30px;' src='ImageBrowse.asp?nd="+getRandom()+"&id="+rowid+"' width='140' height='170' scrolling='no' frameborder=0></iframe>");
	else
		$tr.children().eq(4).html("<iframe name='iMage' id='iMage' src='Image.asp?nd="+getRandom()+"&id="+rowid+"' width='140' height='170' scrolling='no' frameborder=0></iframe>");

	if(oper == "view")
		$tr = $("#trv_Address"); 
	else
		$tr = $("#tr_Address"); //地址栏跨四列
	var	$label = $tr.children("td.CaptionTD");
	var	$data = $tr.children("td.DataTD");
	$tr.children().eq(1).attr("colspan", "3");
	$tr.children().eq(2).remove();
	$tr.children().eq(3).remove();
		$data.children("input").css("width", "70%");
		
	$("#IncumbencyStatus").change(function(){
		//根据在职状态，显示或隐藏离职日期及离职原因
		if($("#IncumbencyStatus").val().length > 0 && $("#IncumbencyStatus").val().substring(0,1) == "1"){
			$("#tr_DimissionDate").show();
		}
		else{
			$("#tr_DimissionDate").hide();
		}
	});
	$("#IncumbencyStatus").change();
}

});
 
function ExportData(){
	$("#divExport").load("../Tools/ExportDataUI.asp?nd="+getRandom()+"&exportType=employees");
	$("#divExport").show();
}
function Search(){
	$("#divSearch").load("../Equipment/search.asp?submitfun=SearchSubmit()");
	$("#divSearch").show();
}

function SearchSubmit(){
	var strsearchField=$("#searRetColVal").html();
	var strsearchOper=$("#searRetOperVal").html();
	var strsearchString=$("#searRetDataVal").html();

	$("#DataGrid").jqGrid('setGridParam',{url:"EmployeesList.asp?search=true&searchField="+strsearchField+"&searchOper="+strsearchOper+"&searchString="+encodeURI(strsearchString),page:1 }).trigger("reloadGrid");

}
