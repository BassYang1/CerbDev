var language = 1 ;	//语言  1为简体中文 2为繁体中文 3为英文 4为自定义

function getCookie(name)
{
	try{
		var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
		if(arr=document.cookie.match(reg))
			return (arr[2]);
		else
			return "";
	}
	catch(exception) {
		return "";
	}
}

var LanTemp = getCookie("CerbLan");

if(LanTemp != ""){
	if(LanTemp == "1" || LanTemp == 1)
		language = 1;
	else if(LanTemp == "2" || LanTemp == 2)
		language = 2;
	else if(LanTemp == "3" || LanTemp == 3)
		language = 3;
	else if(LanTemp == "4" || LanTemp == 4)
		language = 4;
}

/*
if($.cookie('Cerb_lan') != null ){
	language = $.cookie('Cerb_lan');
}
*/
//获取jgrid语言文件  路径js\i18n
function getJgLan(){
	if(language == 1)
		return "grid.locale-cn.js" ;
	else if(language == 2)
		return "grid.locale-tw.js" ;
	else if(language == 3)
		return "grid.locale-en.js" ;
	else if(language == 4)
		return "grid.locale-custom.js" ;
	else 
		return "grid.locale-en.js" ;
}

//获取DatePicker语言文件  路径js\My97DatePicker\lang
function getDpLan(){
	if(language == 1)
		return "zh-cn-WdatePicker.js" ;
	else if(language == 2)
		return "zh-tw-WdatePicker.js" ;
	else if(language == 3)
		return "en-WdatePicker.js" ;
	else if(language == 4)
		return "custom-WdatePicker.js" ;
	else 
		return "en-WdatePicker.js" ;
}

//获取DatePicker语言文件  路径js\My97DatePicker\lang
function getLan(){
	if(language == 1)
		return "zh-cn.js?id=1" ;
	else if(language == 2)
		return "zh-tw.js" ;
	else if(language == 3)
		return "en.js" ;
	else if(language == 4)
		return "custom.js" ;
	else 
		return "en.js" ;
}

function getlbl(labelName){
	try{
		return eval(labelName);
	}
	catch(exception){
		return ""
	}
}

/*
if (language == 1)
	document.write("<script src='../js/lang/zh-cn.js'><\/script>");
else if(language == 2)
	document.write("<script src='zh-tw.js'><\/script>");
else if(language == 3)
	document.write("<script src='en.js'><\/script>");
else if(language == 4)
	document.write("<script src='custom.js'><\/script>");
else
	document.write("<script src='en.js'><\/script>");
*/	