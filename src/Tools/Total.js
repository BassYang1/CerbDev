var timer1;
$(document).ready(function(){  
	CheckLoginStatus();
	//获取操作权限
	var role = GetOperRole("total");
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
	
	$("#startTime").click(function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM',minDate:'%y-{%M-11}',maxDate:'%y-{%M+1}'})});
	var d,strMonth,strDay,time1;
	d = new Date();
	d.setDate(d.getDate()-1);
	
	strMonth = d.getMonth() + 1;
	strDay = d.getDate();
	if (strMonth <= 9)  strMonth = "0" + strMonth;
	if (strDay <= 9)    strDay = "0" + strDay;
	$("#startTime").val(d.getFullYear() + "-" + strMonth);

if(iedit){
	//$("#trOper").append("<td class='ui-pg-button ui-corner-all' id='DataGrid_btnSubmit' title='执行统计'><div class='ui-pg-div'><span class='ui-icon ui-icon-calculator'></span><a>执行统计</a></div></td>");
	$("#trOper").append("<td class='ui-pg-button ui-corner-all' id='DataGrid_btnSubmit' title='"+getlbl("tool.ExecTotal")+"'><div class='ui-pg-div'><span class='ui-icon ui-icon-calculator'></span><a>"+getlbl("tool.ExecTotal")+"</a></div></td>");
}
if(iedit){
	//$("#trOper").append("<td class='ui-pg-button ui-corner-all' id='DataGrid_btnCancel' title='取消统计'><div class='ui-pg-div'><span class='ui-icon ui-icon-cancel'></span><a>取消</a></div></td>");
	$("#trOper").append("<td class='ui-pg-button ui-corner-all' id='DataGrid_btnCancel' title='"+getlbl("tool.CancelTotal")+"'><div class='ui-pg-div'><span class='ui-icon ui-icon-cancel'></span><a>"+getlbl("con.Cancel")+"</a></div></td>");
}
if(irefresh){
	$("#trOper").append("<td class='ui-pg-button ui-corner-all' id='DataGrid_btnRefresh' title='"+getlbl("hr.Refresh")+"'><div class='ui-pg-div'><span class='ui-icon ui-icon-refresh'></span><a>"+getlbl("hr.Refresh")+"</a></div></td>");
}
Init();

function Init(){
	$("#DataGrid_btnSubmit").click(function(){
		 if (!$(this).hasClass('ui-state-disabled')) {
			btnbtnSubmit();      
		}
		return false;
	}).hover(
		function () {
			if (!$(this).hasClass('ui-state-disabled')) {
				$(this).addClass("ui-state-hover");
			}
		},
		function() {$(this).removeClass("ui-state-hover");}
	);
	$("#DataGrid_btnCancel").click(function(){
		 if (!$(this).hasClass('ui-state-disabled')) {
			btnCancel();      
		}
		return false;
	}).hover(
		function () {
			if (!$(this).hasClass('ui-state-disabled')) {
				$(this).addClass("ui-state-hover");
			}
		},
		function() {$(this).removeClass("ui-state-hover");}
	);
	$("#DataGrid_btnRefresh").click(function(){
		 if (!$(this).hasClass('ui-state-disabled')) {
			btnRefresh();      
		}
		return false;
	}).hover(
		function () {
			if (!$(this).hasClass('ui-state-disabled')) {
				$(this).addClass("ui-state-hover");
			}
		},
		function() {$(this).removeClass("ui-state-hover");}
	);
	//默认进入系统时，获取一次状态
	GetTotalStatus();
}


$("#selCodeType").change(function(){
	gridReload();
});
function gridReload(){
	$("#DataGrid").jqGrid('setGridParam',{url:"TotalList.asp",page:1,}).trigger("reloadGrid");
}


function btnbtnSubmit(){
	var obj = {
		resizable: false,
		height:230,
		width:450,
		modal: true,
		position: [300, 70],
		buttons : {},
	};
	var ImmediatelyTotal = getlbl("tool.ImmediatelyTotal");	//立即执行统计
	var ServiceTotal = getlbl("tool.ServiceTotal");	//服务执行统计
	obj.buttons[ImmediatelyTotal] = function(){
		$( this ).dialog( "close" );
		TotalByPage();
	}
	obj.buttons[ServiceTotal] = function(){
		$( this ).dialog( "close" );
		TotalByServices();
	}
	$( "#dialog-confirm" ).dialog(obj);

}
//由页面执行统计
function TotalByPage(){
	if(timer1 != undefined)
		clearInterval(timer1);
	 $.ajax({
			type: "POST",
			dataType: "html",
			async:true,
			url: 'TotalEdit.asp?oper=total&by=page',
			data: $('#FrmGrid_DataGrid').serialize(),
			 success: function(data) {
			  try  {
					var responseMsg = $.parseJSON(data);
					if(responseMsg.success == false){
						//alert(responseMsg.message);
						TotalEd();
						showMsg(responseMsg.message);
					}else if(responseMsg.success == true){
						//成功
						TotalEd();
						showMsgSuccess(responseMsg.message);
						//$("#DataGrid").trigger("reloadGrid");
					}else{
						//alert("保存异常");
						alert(getlbl("con.SaveEx"));
					}
				}
				catch(exception) {
					alert(exception+"," + data);
				}
			},
			error:function(XmlHttpRequest,textStatus, errorThrown){
				alert(textStatus+":TotalEdit.asp,"+XmlHttpRequest.responseText);
			}

	});
	TotalIng(getlbl("tool.TotalingNotLeave"));	//"正在统计，请稍后......请不要离开页面"
}

//由服务调用 执行统计
function TotalByServices(){
	 $.ajax({
			type: "POST",
			dataType: "html",
			async:false,
			url: 'TotalEdit.asp?oper=total&by=services',
			data: $('#FrmGrid_DataGrid').serialize(),
			 success: function(data) {
			  try  {
					var responseMsg = $.parseJSON(data);
					if(responseMsg.success == false){
						//alert(responseMsg.message);
						TotalEd();
						showMsg(responseMsg.message);
					}else if(responseMsg.success == true){
						//成功
						//TotalEd();
						//showMsgSuccess(responseMsg.message);
						//$("#DataGrid").trigger("reloadGrid");
					}else{
						alert(getlbl("con.SaveEx"));
					}
				}
				catch(exception) {
					alert(exception+"," + data);
				}
			},
			error:function(XmlHttpRequest,textStatus, errorThrown){
				alert(textStatus+":TotalEdit.asp,"+XmlHttpRequest.responseText);
			}

	});
	TotalIng(getlbl("tool.Totaling"));	//"正在统计，请稍后..."
}


function btnCancel(){
	$.ajax({
		type: "POST",
		dataType: "html",
		async:false,
		url: 'TotalEdit.asp?oper=cancel',
		 success: function(data) {
		  try  {
				var responseMsg = $.parseJSON(data);
				if(responseMsg.success == false){
					//alert(responseMsg.message);
					showMsg(responseMsg.message);
				}else if(responseMsg.success == true){
					//成功
					TotalEd();
					showMsgSuccess(responseMsg.message);
				}else{
					alert("exception");
				}
			}
			catch(exception) {
				alert(exception+"," + data);
			}
		},
		error:function(XmlHttpRequest,textStatus, errorThrown){
			alert(textStatus+":TotalEdit.asp,"+XmlHttpRequest.responseText);
		}
	});	
}

function btnRefresh(){
	GetTotalStatus();
}

timer1 = setInterval("GetTotalStatus();",1000);//自动刷新状态

}); 

function showMsg(strMsg){
	$("#FormSuccess").hide();
	$("#FormError").show();
	$("#FormError").children("td:eq(0)").html(strMsg);
}

function showMsgSuccess(strMsg){
	$("#FormError").hide();
	$("#FormSuccess").show();
	$("#FormSuccess").children("td:eq(0)").html("<div class='ui-state-highlight ui-corner-all'><span style='float: left; margin-right: .3em;' class='ui-icon ui-icon-info'></span>"+strMsg+"</div>");
}

//存在统计中
function TotalIng(strMsg){
	showMsg(strMsg);
	$("#DataGrid_btnSubmit").attr("disabled","disabled"); 
	$("#DataGrid_btnSubmit").addClass("ui-state-disabled");
	$("#startTime").attr("disabled","disabled"); 
	$("#blnTotalDimission").attr("disabled","disabled"); 
	$("#DataGrid_btnCancel").removeAttr("disabled");  
	$("#DataGrid_btnCancel").removeClass("ui-state-disabled");
}

//统计完成
function TotalEd(){
	$("#FormError").hide();
	$("#DataGrid_btnSubmit").removeAttr("disabled");  
	$("#DataGrid_btnSubmit").removeClass("ui-state-disabled");
	$("#startTime").removeAttr("disabled");  
	$("#blnTotalDimission").removeAttr("disabled");  
	$("#DataGrid_btnCancel").attr("disabled","disabled"); 
	$("#DataGrid_btnCancel").addClass("ui-state-disabled");		
}

function GetTotalStatus(){
	$.ajax({
		type: 'Post',
		url: 'TotalList.asp',
		success: function(data) {
			try  {
				var responseMsg = $.parseJSON(data);
				if(responseMsg.success == false){
					//未统计或统计完成
					TotalEd();
					
				}else if(responseMsg.success == true){
					//正在统计中
					//TotalIng("正在统计，请稍后...");	
					TotalIng(getlbl("tool.Totaling"));	//"正在统计，请稍后..."
				}else{
					//alert("保存异常");
				}
			}
			catch(exception) {
				//alert(exception+"," + data);
			}
		},
		error:function(XmlHttpRequest,textStatus, errorThrown){
			//alert(textStatus+":ExportData.asp,"+XmlHttpRequest.responseText);
		}
	});		
}
