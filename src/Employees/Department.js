CheckLoginStatus();
function CardCheck(value, colname) {
        if (value < 0) 
           return [false,getlbl("hr.CardNoLt0")];//"卡号不能小于0"
        else 
           return [true,""];
        }
var lastSel;
jQuery("#DataGrid").jqGrid({
		url:'DepartmentList.asp',
		editurl:"DepartmentEdit.asp",
		datatype: "json",
		colNames:['DepartmentID','',getlbl("hr.SuperiorDept"),getlbl("hr.DeptName"),getlbl("hr.DeptLevel")],
		colModel :[
			{name:'DepartmentID',index:'DepartmentID',width:10,hidden:true,editrules:{edithidden:false},search:false},
			{name:'DepartmentCode',index:'DepartmentCode',width:60,align:'center',hidden:false,editrules:{edithidden:false},search:false,label:'',sortable:false,
			formatter: function (cellvalue, options, rowObject) {
				return "<input type='checkbox' class='itmchk' id='itmchk_"+options.rowId+"' value='"+options.rowId+"' >";
			}
			},  
			{name:'ParentDepartmentID',index:'ParentDepartmentID',width:80,edittype:'none',editable:true,hidden:true,editrules:{edithidden:true,required:false},sortable:false,},
			{name:'DepartmentName',index:'DepartmentName',width:500,editable:true,editrules:{required:true},sortable:false,
				searchoptions:{sopt:["eq","ne",'cn']},
				formoptions:{elmsuffix:"<font color=#FF0000>*</font>"}},
			{name:'DepartmentLevel',index:'DepartmentLevel',width:120,align:'center',editable:false,sortable:false,search:false},
			], 
		caption:getlbl("hr.DeptList"),//"部门列表"
		imgpath:'/images',
		multiselect: false,
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
		width:'auto',
		forceFit:true, //调整列宽度不会改变表格的宽度
		hidegrid:false,//禁用控制表格显示、隐藏的按钮
		loadtext:strloadtext,
		toppager:true,
		
		treeGrid: true,//启用树型Grid功能
		treeGridModel: 'adjacency',//表示返回数据的读取类型，分为两种：和adjacency
		ExpandColumn: 'DepartmentName',//树型结构在哪列显示
		treeIcons: {plus:'ui-icon-plus',minus:'ui-icon-minus',leaf:'ui-icon-document'},

		loadComplete:function(data){ //完成服务器请求后，回调函数 
			if(data == null || data.records==0){ 
				jQuery("#DataGrid").jqGrid('clearGridData');
			}
			var iCol = getColumnIndexByName($(this), 'DepartmentCode'), rows = this.rows, i, c = rows.length;
			for (i = 0; i < c; i += 1) {
				$(rows[i].cells[iCol]).click(function (e) {
					var id = $(e.target).closest('tr')[0].id, isChecked = $(e.target).is(':checked');
					//alert("checked:" + isChecked);
					if(!isChecked){
						$("#DataGrid").resetSelection();
					}
					else{
						$("#DataGrid").jqGrid('setSelection',id);   
					}
				});
			}
		},
		onSelectRow: function(id){ 
			if(id && id!==lastSel){ 
				//jQuery(this).restoreRow(lastSel); 
				lastSel=id; 
			} 
		},
		beforeSelectRow: function (rowid, e) {
			var isLeftClick = false;
			var clickType = e.which;
			if (clickType == 1) {
				isLeftClick = true;
			}
			//如果单击TD，也就是单击的非复选框，则先取消选择所有行，取消所有打勾的复选框，再将当前行的复选框打勾。
			if(e && e.target.nodeName.toUpperCase() == "TD"){
				$("#DataGrid").resetSelection();
				$("input[type=checkbox][class=itmchk]").each(function(){    
                    $(this).attr("checked", false);    
                });   
				$("#itmchk_"+rowid).click(); 
			}
			return isLeftClick;
		},
});
getColumnIndexByName = function (grid, columnName) {
	var cm = grid.jqGrid('getGridParam', 'colModel'), i, l;
	for (i = 0, l = cm.length; i < l; i += 1) {
		if (cm[i].name === columnName) {
			return i; // return the index
		}
	}
	return -1;
};
	
//获取操作权限
var role = GetOperRole("Department");
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
		edit:iedit,add:iadd,del:idel,view:false,refresh:irefresh,search:isearch,edittext:stredittext,addtext:straddtext,deltext:strdeltext,searchtext:strsearchtext,refreshtext:strrefreshtext,viewtext:strviewtext,
		alerttext : stralerttext ,
	}, 
	{
		top:0,width:450,
		reloadAfterSubmit :true,
		closeAfterEdit: true,
		afterSubmit:getEditafterSubmit,
		afterShowForm:function(formid){
			var rowid = $("#DataGrid").jqGrid('getGridParam', 'selrow');
			var ret = $("#DataGrid").jqGrid('getRowData',rowid);
			var parentId = ret.ParentDepartmentID;

			//初始化窗体
			InitEditForm("edit", parentId);
		},
		beforeSubmit:function(postdata, formid){
			//动态增加提交参数
			var parentDepartmentId = $("#ParentDepartmentID").val();
			if(parentDepartmentId == ""){
				parentDepartmentId = "0";
			}
			postdata['ParentDepartmentID'] = parentDepartmentId;   
			return[true,'']; 
		},
		//selarrrow
	},  //  default settings for edit
	{
		top:0,width:450,
		reloadAfterSubmit :true,
		afterSubmit:getAddafterSubmit,
		afterShowForm:function(formid){
			//初始化窗体
			InitEditForm("add");
		},
		beforeSubmit:function(postdata, formid){
			//动态增加提交参数
			var parentDepartmentId = $("#ParentDepartmentID").val();
			if(parentDepartmentId == ""){
				parentDepartmentId = "0";
			}
			postdata['ParentDepartmentID'] = parentDepartmentId;   
			return[true,'']; 
		},
	},  //  default settings for add
	{
		top:0,
		reloadAfterSubmit :false,
		afterSubmit:getDelafterSubmit,
		afterShowForm:function(formid){
			var i = 0;
			var strIds = "";
			var isParentDept = false;
			//获取多选时，所有打勾的复选框的值 
			$("input[type=checkbox][class=itmchk]:checked").each(function() {
				i = i + 1;
				strIds = strIds + this.value + ",";
				var rowData = $("#DataGrid").jqGrid("getRowData",this.value);
				if(!isParentDept && rowData.isLeaf == "false")
					isParentDept = true;//获取是否有选择父部门
			});
			if(strIds != ""){
				strIds = strIds.substring(0,strIds.length-1);
			}
			
			$('#DelError').children().eq(0).html("");  
			if(i > 1){
				 // 部门删除一次只能删除一条
				$('#DelError').show();
				$('#DelError').children().eq(0).html(getlbl("hr.DelByOnlyOne"));  //"删除部门仅能逐条删除."
			}
			if(isParentDept == true){
				$('#DelError').show();
				$('#DelError').children().eq(0).html($('#DelError').children().eq(0).html()+"\n\r"+getlbl("hr.DelAllDept"));  //删除父部门时，该部门下所有子部门将全部删除.
			}
		},
	},  // delete instead that del:false we need this
	{multipleSearch:false, multipleGroup:false, showQuery: false,closeAfterSearch: true,caption:strsearchcaption,top:60} ,// search options
	{top:0,}	//view parameters
	);

var topPagerDiv = $('#DataGrid_toppager')[0];         // "#list_toppager"
$("#DataGrid_toppager_center", topPagerDiv).remove(); // "#list_toppager_center"
$(".ui-paging-info", topPagerDiv).remove();
$("#DataGrid_toppager_right").css("width","1%");
$("#DataGrid_toppager_left").css("width","99%");
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

function InitEditForm(oper, selId)
{
	$("#tr_ParentDepartmentID").children("td.CaptionTD").css("width", "10%"); //设置标签宽度
	$("#tr_ParentDepartmentID").children("td.DataTD").css("width", "40%");
	var DepartmentId,EmployeeId;
	if(oper == "edit"){
		$('#Act_Buttons').children().eq(0).html("<td class='navButton'></td>");  
	}

	//获取所有部门列表
	InitDepartments(selId);

	var parentDeptId = $("#ParentDepartmentID").val();
	if(parentDeptId == ""){
		parentDeptId = "0";
	}

	$("#DepartmentName").css('width','250');
	//绑定部门下拉框onChange事件
	$("#ParentDepartmentID").change(function(){
		var NodeText = $("#ParentDepartmentID option:selected")[0].innerHTML;
			NodeText = NodeText.substring(0,NodeText.indexOf("|-"));
		var NodeTextSpace =  NodeText.match(/\&nbsp;/g);
		var parentSpaceLen = 0;
		if(NodeTextSpace != null){
			parentSpaceLen = NodeTextSpace.length;//计算当前选择的节点的空格数
		}
		if(parentSpaceLen >= 18){
			$('#FormError').show();
			$('#FormError').children().eq(0).html("<td class='ui-state-highlight' colspan='2'>"+getlbl("hr.DeptMaxLevel")+"</td>");  //部门最大支持10级，不能选择第10级部门当上级部门
			$("#ParentDepartmentID").val('');
		}
	})
	if(oper == "edit"){
		//修改记录时，上级部门下拉框选择该记录的上级部门
		if(parentDeptId == "0"){
			$("#ParentDepartmentID").trigger("change");
		}
		else{
			$("#ParentDepartmentID").trigger("change");
		}
		//修改记录时，上级部门不可修改。主要考虑涉及其它表使用了部门ID
		$("#ParentDepartmentID").attr("disabled",true).css({ "color":"#ccc"});
	}
	else{
		//增加记录时，上级部门下拉框选择表格打勾的行
		var id=$("#DataGrid").jqGrid("getGridParam","selrow");
		if(id){
			$("#ParentDepartmentID").val(id);
			$("#ParentDepartmentID").trigger("change");
		}
		else{
			$("#ParentDepartmentID").val('');
			$("#ParentDepartmentID").trigger("change");
		}
		$("#ParentDepartmentID").attr("disabled",false).css({ "color":"#222"});
	}	
}

//初使化部门
function InitDepartments(selId){
	var $tr = $("#tr_ParentDepartmentID"), 
		$label = $tr.children("td.CaptionTD"),
		$data = $tr.children("td.DataTD");

	var id, name, code, sBlank, len;
	var arrDepts = getUserDeptJSON();

	var deptListHtml = "&nbsp;<select id='ParentDepartmentID' name='ParentDepartmentID' style='width:260px' class='FormElement ui-widget-content ui-corner-all'>";
	deptListHtml += "<option value=''></option>";

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

	$data.html(deptListHtml);

	if(selId){
		$("#ParentDepartmentID>option[value='" + selId + "']").attr("selected", true);
	}
}

function ExportData(){
	$("#divExport").load("../Tools/ExportDataUI.asp?nd="+getRandom()+"&exportType=departments");
	$("#divExport").show();
}

