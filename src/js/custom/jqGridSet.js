// JavaScript Document

var irowNum = 16;//显示默认行数

function getEditafterSubmit(response, postdata)
{
	try  {
		var responseMsg = $.parseJSON(response.responseText);
		//var e = eval('('+response.responseText+')');
		return [responseMsg.success,responseMsg.message];
	}
	catch(exception) {
		alert(exception);
	}
}

function getAddafterSubmit(response, postdata)
{
	try  {
		var responseMsg = $.parseJSON(response.responseText);
		//var e = eval('('+response.responseText+')');
		return [responseMsg.success,responseMsg.message];
	}
	catch(exception) {
		alert(exception);
	}
}

function getDelafterSubmit(response, postdata)
{
	try  {
		var responseMsg = $.parseJSON(response.responseText);
		//var e = eval('('+response.responseText+')');
		return [responseMsg.success,responseMsg.message];
	}
	catch(exception) {
		alert(exception);
	}
}

//根据刷卡属性，返回描述
function getBrushCardProDesc(cellvalue, options, rowObject)
{
	switch(cellvalue){
		case '0': return getlbl("rep.StatusShow0");break;	//"合法卡"
		case '1': return "<font color=#FF0000>"+getlbl("rep.StatusShow1")+"</font>";break;	//非法卡
		case '2': return "<font color=#872E00>"+getlbl("rep.StatusShow2")+"</font>";break;	//非法时段
		case '3': return "<font color=#531C00>"+getlbl("rep.StatusShow3")+"</font>";break;	//非法门
		case '4': return "<font color=#771A41>"+getlbl("rep.StatusShow4")+"</font>";break;	//防遣返
		case '5': return "<font color=#FF5800>"+getlbl("rep.StatusShow5")+"</font>";break;	//非法指纹
		case '6': return "<font color=#E37FA9>"+getlbl("rep.StatusShow6")+"</font>";break;	//密码错误
		case '7': return "<font color=#8A7D1D>"+getlbl("rep.StatusShow7")+"</font>";break;	//未采集指纹
		case '8': return "<font color=#453E0E>"+getlbl("rep.StatusShow8")+"</font>";break;	//验证方式错
		case '9': return "<font color=#453E81>"+getlbl("rep.StatusShow9")+"</font>";break;	//指纹模块故障
		default:  return " ";break;
	}
}

//根据刷卡属性，返回描述
function getBrushCardAttendProDesc(cellvalue, options, rowObject)
{
	switch(cellvalue){
		case '0': return getlbl("rep.StatusShow0");break;	//合法卡
		default:  return "<font color=#FF0000>"+getlbl("rep.StatusShow1")+"</font>";break;	//非法卡
	}
}

//格式化原始刷卡行转列的数据  ()表示为非法，转为红色显示
function FormatBrushCardAttendRowToCol(cellvalue, options, rowObject)
{
	if(cellvalue != undefined)
		return cellvalue.replace(/\(/g,"<font color=#FF0000>(").replace(/\)/g,")</font>");
}