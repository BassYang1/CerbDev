// JavaScript Document

var cookieUserId = "Cerb%5FUserId"; // 用户Id Cookie : Cerb_UserId

//去除字符串首尾空格
String.prototype.trim = function()
{
    return this.replace(/(^\s*)|(\s*$)/g, "");
}

function GetEquipmentType()
{
	htmlObj = $.ajax({url:"../Common/GetEquipmentType.asp",async:false});
	//return htmlObj.responseText;
	return false;
	if(htmlObj.responseText == "0"){
		return false;
	}else{
		return true;
	}
}

//获取用户模块的操作权限
function GetOperRole(module)
{
	var retVal = "";
	$.ajax({
		url: '../Common/GetOperRoleForHtml.asp?nd='+getRandom()+'&module=' + module,
		async:false,
		data:{},
		success: function(data) {
			try  {
				retVal = $.parseJSON(data);
			}
			catch(exception) {
				alert(exception);
			}
		}
	});	
	return retVal;
}
function GetOperPermissions()
{
	htmlObj = $.ajax({url:"../Common/GetOperPermissions.asp?nd="+getRandom(),async:false});
	if(htmlObj.responseText == "1"){
		return true; //系统管理员
	}else{
		return false;
	}
}

function CheckLoginStatus()
{
	$.ajax({
		url: '../CheckLoginStatusForHtml.asp?nd='+getRandom(),
		async:false,
		data:{},
		success: function(data) {
			try  {
				var responseMsg = $.parseJSON(data);
				if(responseMsg.success == false){
					alert(responseMsg.message);
					parent.location.href='../Login.html';
				}else if(responseMsg.success == true){
		
				}else{
					alert("Save data exception");
				}
			}
			catch(exception) {
				alert(exception);
			}
		}
	});
}

function CheckLoginStatusForRoot()
{
	$.ajax({
		url: 'CheckLoginStatusForHtml.asp?nd='+getRandom(),
		async:false,
		data:{},
		success: function(data) {
			try  {
				var responseMsg = $.parseJSON(data);
				if(responseMsg.success == false){
					alert(responseMsg.message);
					parent.location.href='Login.html';
				}else if(responseMsg.success == true){
		
				}else{
					alert("Save data exception");
				}
			}
			catch(exception) {
				alert(exception);
			}
		}
	});
}

//获取员工JSON数据
function getEmpJSON(){
	var condition = "";
	if(arguments.length > 0){
		condition = arguments[0]; //id|,eq|,100
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
function getUserDeptJSON(){
	var condition = "";
	if(arguments.length > 0){
		condition = arguments[0]; //id|,eq|,100
	}

	var deptIds = "";
	if(arguments.length > 1){
		deptIds = arguments[1];
	}

	var userId = getCookie(cookieUserId); 
	var result = $.ajax({type:"post",url:'../Common/GetDepartmentJSON.asp?nd='+getRandom() + "&userId=" + userId,data:{deptIds: deptIds, oper:"filter"},async:false});
	var data = result.responseText;
	var arrDepts = data ? ($.parseJSON(data) || []) : [];

	return arrDepts;
}

//获取HTML地址栏参数
function Request(strUrl,strName){  
	//var strUrl = location.href;  
	var intPos = strUrl.indexOf("?");  
	var strRight = strUrl.substr(intPos + 1);  
	var arrTmp = strRight.split("&");  
	for(var i = 0; i < arrTmp.length; i++) {  
		var arrTemp = arrTmp[i].split("=");  
		if(arrTemp[0].toUpperCase() == strName.toUpperCase()) 
			return arrTemp[1];  
	}  
	return "";  
}  

//读取cookie
function getCookie(name){
	if(!(document.cookie || navigator.cookieEnabled)){
		console.log("Browser Cookie is not enabled, please open!");
		return "";
	}

	if(name == undefined || name == null || name == "" || typeof name != "string"){
		return "";
	}

	try{
		var reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
		var arr = document.cookie.match(reg);

		if(arr){
			return unescape(arr[2]);
		}
		else{
			return "";
		}
	}
	catch(exception) {
		console.log(exception);
		return "";
	}
}

function getRandom()
{
	return Math.round(Math.random(0)*100000);
}

//获取当前所选部门下拉框所有的子部门ID（包括当前所选的部门的ID）
function GetDeptSelChildIds(selID){
	var selDeptIds = $("#"+selID).val();
	try{
		var cIndex = $("#"+selID).get(0).selectedIndex; //获取select选择的索引值
		var maxIndex = $("#"+selID+" option:last").index(); //获取最大索引值
		
		//var NodeText = $("#depID").find("option:selected").text();
		var NodeText = $("#"+selID+" option:selected")[0].innerHTML;
			NodeText = NodeText.substring(0,NodeText.indexOf("|-"));
			NodeText = NodeText.replace("&nbsp;","|");// 非一级部门前面有两个&nbsp;
		var NodeTextSpace =  NodeText.match(/\|&nbsp;/g);
		var parentSpaceLen = 0;
		if(NodeTextSpace != null){
			parentSpaceLen = NodeTextSpace.length;//计算当前选择的节点的空格数
		}
		
		//查找当前节点以下的节点，找出|-前空格数大于当前节点空格数的。
		for(var i = cIndex+1; i <= maxIndex; i++){
			NodeText =$("#"+selID).get(0).options[i].innerHTML;
			NodeText = NodeText.substring(0,NodeText.indexOf("|-"));
			NodeText = NodeText.replace("&nbsp;","|");// 非一级部门前面有两个&nbsp;
			NodeTextSpace =  NodeText.match(/\|&nbsp;/g);
			var childNodeSpaceLen = 0;
			if(NodeTextSpace != null){
				childNodeSpaceLen = NodeTextSpace.length;
			}
	
			if(childNodeSpaceLen > parentSpaceLen){
				selDeptIds = selDeptIds+"," + $("#"+selID).get(0).options[i].value;
			}
			else{
				break;
			}
		}
	}
	catch(exception) {
		alert(exception);
	}
	return selDeptIds;
}

//判断是否为IE，是IE返回true,否则false
function isIE(){
	if(!!window.ActiveXObject || "ActiveXObject" in window){
		return true;
	}
	return false;
}

var IEVersion = (function(){
    var v = 3, div = document.createElement('div'), all = div.getElementsByTagName('i');
    while (
        div.innerHTML = '<!--[if gt IE ' + (++v) + ']><i></i><![endif]-->',
        all[0]
    );
    return v > 4 ? v : false ;
}());