
$(document).ready(function(){  
	CheckLoginStatus();

jQuery("#DataGrid").jqGrid({
		url:'SetCodeList.asp',
		editurl:"SetCodeEdit.asp",
		datatype: "json",
		//colNames:['RecordID','名称'],
		colNames:['RecordID',getlbl("tool.CodeName")],
		colModel :[
			{name:'RecordID',index:'RecordID',width:10,hidden:true,editrules:{edithidden:false},search:false},
			{name:'Content',index:'Content',width:500,editable:true,editrules:{required:true},
				stype:"text", searchoptions:{ sopt:["eq","ne",'cn','nc']}},  
			], 
		caption:getlbl("tool.SetCode"),//"设置代码",
		imgpath:'/images',
		multiselect: false,
		rowNum:irowNum,
		rowList:[10,16,20,30],
		prmNames: {search: "_search"},  
		postData:{FieldId: function() { return $("#selCodeType").val(); },
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
        }},
});

//获取操作权限
var role = GetOperRole("SetCode");
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
		edit:iedit,add:iadd,del:idel,view:false,refresh:true,search:false,edittext:stredittext,addtext:straddtext,deltext:strdeltext,searchtext:strsearchtext,refreshtext:strrefreshtext,viewtext:strviewtext,
		alerttext : stralerttext ,
	}, 
	{
		closeAfterEdit: true,
		afterSubmit:getEditafterSubmit,
		beforeSubmit:function(postdata, formid){
			//动态增加提交参数
			var FieldId = $("#selCodeType").val();
			postdata['FieldId'] = FieldId;   
			return[true,'']; 
		},
	},  //  default settings for edit
	{
		closeAfterAdd: true,
		afterSubmit:getAddafterSubmit,
		beforeSubmit:function(postdata, formid){
			//动态增加提交参数
			var FieldId = $("#selCodeType").val();
			postdata['FieldId'] = FieldId;   
			return[true,'']; 
		},
	},  //  default settings for add
	{
		afterSubmit:getDelafterSubmit
	},  // delete instead that del:false we need this
	{multipleSearch:false, multipleGroup:false, showQuery: false,caption:strsearchcaption,top:60} ,// search options
	{top:0,}	//view parameters
	);

var topPagerDiv = $('#DataGrid_toppager')[0];         // "#list_toppager"
$("#DataGrid_toppager_center", topPagerDiv).remove(); // "#list_toppager_center"
$(".ui-paging-info", topPagerDiv).remove();
$("#DataGrid_toppager_right").css('width','50%');
$("#DataGrid_toppager_left").css("width","50%");

$('#table_DataGrid_top_right').appendTo('#DataGrid_toppager_right');

$("#selCodeType").change(function(){
	gridReload();
});
function gridReload(){
	$("#DataGrid").jqGrid('setGridParam',{url:"SetCodeList.asp",page:1,}).trigger("reloadGrid");
}

}); 

