$(function(){
	initEditForm();

	var role = GetOperRole("options"); //权限
	if(!(role && role.add)){
		$("#sData").hide();
		$("input,textarea,select").attr("disabled", true);
		//$("#depframe").find("input,textarea,select").attr("disabled", true);
	}
});

//初使化
function initEditForm(){
	var userId = getCookie(cookieUserId); 
	var strUrl = "LeaveOptionList.asp?nd=" + getRandom() + "&userId=" + userId;
	var optObj = null;
	$.ajax({
				type: "get", 
				url: strUrl,
				async: false, 		
				success: function(data) {
					optObj = $.parseJSON(data);
				},
				error:function(XmlHttpRequest,textStatus, errorThrown){
					alert(errorThrown);
				}
			});

	var html = "";
	$("#frm_Caption").text(getlbl("tool.LeaveOption"));

	//可休年假职员
	var deptHtml = "<iframe id='depframe' name='depframe' width='90%' height='180' marginheight='0' marginwidth='0' frameborder='0' align='center' src='../Tools/GetUserEditDept.html?nd=" + getRandom() + "&oper=annaloption&id=strAnnalDeptEmps&userId=" + userId + "'></iframe>";
	html = getlbl("tool.StrAnnalEmpDetail");
	html = html.replace(/{{dropdownlist}}/, deptHtml);
	$("#tr_StrAnnalEmp").children(".CaptionTD").text(getlbl("tool.StrAnnalEmp"));
	$("#tr_StrAnnalEmp").children(".DataTD").html(html);

	//可休年假 intIncreasePerYear
	var basicDay = getOptionValue("intBasicDay", optObj);
	var vacationType = getOptionValue("strVacationType", optObj);
	vacationType = vacationType ? vacationType : "0";

	//年假递增方式1
	var arrType;
	var increaseYear, increaseDay
	var increasePerYear = getOptionValue("intIncreasePerYear", optObj);
	
	arrType = (increasePerYear ? increasePerYear : "").split(",");
	increaseYear = arrType.length > 0 ? arrType[0] : "";
	increaseDay = arrType.length > 1 ? arrType[1] : "";

	//年假递增方式2
	var increaseType1 = getOptionValue("strIncreaseType1", optObj);
	var increaseYear1, increaseDay1;

	arrType = (increaseType1 ? increaseType1 : "").split(",");
	increaseYear1 = arrType.length > 0 ? arrType[0] : "";
	increaseDay1 = arrType.length > 1 ? arrType[1] : "";

	var increaseType2 = getOptionValue("strIncreaseType2", optObj);
	var increaseYear2, increaseDay2

	arrType = (increaseType2 ? increaseType2 : "").split(",");
	increaseYear2 = arrType.length > 0 ? arrType[0] : "";
	increaseDay2 = arrType.length > 1 ? arrType[1] : "";

	//是否可延续到下一年，最大可休年假
	var maxVacation = getOptionValue("intMaxVacation", optObj);
	var continueNext = getOptionValue("blnContinueNext", optObj);

	html = getlbl("tool.StrAnnalDetail");
	html = html.replace(/{{textbox}}/, "<input type='text' id='BasicAnnualDay' name='BasicAnnualDay' value='" + (basicDay && !isNaN(basicDay) ? basicDay : "") + "' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	html = html.replace(/{{radiobox}}/, "<input type='radio'  id='VacationType1' name='VacationType' value='0'" + (vacationType == "0" ? "checked" : "") + " role='radiobox' class='FormElement'>");
	html = html.replace(/{{textbox}}/, "<input type='text' id='IncreaseYear' value='" + (increaseYear && !isNaN(increaseYear) ? increaseYear : "") + "' name='IncreaseYear' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	html = html.replace(/{{textbox}}/, "<input type='text' id='IncreaseDay' value='" + (increaseDay && !isNaN(increaseDay) ? increaseDay : "") + "' name='IncreaseDay' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	html = html.replace(/{{radiobox}}/, "<input type='radio' id='VacationType2'  name='VacationType' value='1' " + (vacationType == "1" ? "checked" : "") + " role='radiobox' class='FormElement'>");
	html = html.replace(/{{textbox}}/, "<input type='text' id='IncreaseYear1' value='" + (increaseYear1 && !isNaN(increaseYear1) ? increaseYear1 : "") + "' name='IncreaseYear1' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	html = html.replace(/{{textbox}}/, "<input type='text' id='IncreaseDay1' value='" + (increaseDay1 && !isNaN(increaseDay1) ? increaseDay1 : "") + "' name='IncreaseDay1' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	html = html.replace(/{{textbox}}/, "<input type='text' id='IncreaseYear2' value='" + (increaseYear2 && !isNaN(increaseYear2) ? increaseYear2 : "") + "' name='IncreaseYear2' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	html = html.replace(/{{textbox}}/, "<input type='text' id='IncreaseDay2' value='" + (increaseDay2 && !isNaN(increaseDay2) ? increaseDay2 : "") + "' name='IncreaseDay2' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='ContinueNext' name='ContinueNext' " + (continueNext == "1" ? "checked" : "") + "' role='checkbox' class='FormElement' checked='checked'>");
	html = html.replace(/{{textbox}}/, "<input type='text' id='MaxVacation' name='MaxVacation' value='" + (maxVacation && !isNaN(maxVacation) ? maxVacation : "") + "' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	$("#tr_StrAnnal").children(".CaptionTD").text(getlbl("tool.StrAnnal"));
	$("#tr_StrAnnal").children(".DataTD").html(html);

	$("#VacationType1").change(function(){
		if($(this).is(":checked")){
			$("#IncreaseYear1, #IncreaseDay1, #IncreaseYear2, #IncreaseDay2").attr("disabled",true).val("");
			$("#IncreaseYear, #IncreaseDay").removeAttr("disabled");
		}
	});

	$("#VacationType2").change(function(){
		if($(this).is(":checked")){
			$("#IncreaseYear, #IncreaseDay").attr("disabled",true).val("");
			$("#IncreaseYear1, #IncreaseDay1, #IncreaseYear2, #IncreaseDay2").removeAttr("disabled");
		}
	});

	if(vacationType == "0"){
		$("#VacationType1").change();
	}
	else{
		$("#VacationType2").change();
	}

	//假期类型
	var skipHoliday = getOptionValue("strSkipHoliday", optObj);
	var workTime = getOptionValue("intWorkTime", optObj);
	skipHoliday = skipHoliday ? skipHoliday : "";
	skipHoliday = skipHoliday.replace(/[a-z|A-Z]/g, "");

	var arrHoliday = skipHoliday.split(",");
	html = getlbl("tool.StrSkipHolidayDetail");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsPrivate' name='IsPrivate' " + (arrHoliday.length > 0 && arrHoliday[0] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsSick' name='IsSick' " + (arrHoliday.length > 1 && arrHoliday[1] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsCompensatory' name='IsCompensatory' " + (arrHoliday.length > 2 && arrHoliday[2] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsMaternity' name='IsMaternity' " + (arrHoliday.length > 3 && arrHoliday[3] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsMatrimony' name='IsMatrimony' " + (arrHoliday.length > 4 && arrHoliday[4] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsLactation' name='IsLactation' " + (arrHoliday.length > 5 && arrHoliday[5] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsOther' name='IsOther' " + (arrHoliday.length > 6 && arrHoliday[6] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsTrip' name='IsTrip' " + (arrHoliday.length > 7 && arrHoliday[7] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsAnnual' name='IsAnnual' " + (arrHoliday.length > 8 && arrHoliday[8] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsHolidy' name='IsHolidy' " + (arrHoliday.length > 9 && arrHoliday[9] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsInjury' name='IsInjury' " + (arrHoliday.length > 10 && arrHoliday[10] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsFuneral' name='IsFuneral' " + (arrHoliday.length > 11 && arrHoliday[11] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsVisit' name='IsVisit' " + (arrHoliday.length > 12 && arrHoliday[12] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{textbox}}/, "<input type='text' id='WorkTime' name='WorkTime' value='" + (workTime && !isNaN(workTime) ? workTime : "") + "' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	$("#tr_StrLeaveType").children(".CaptionTD").html(getlbl("tool.StrSkipHoliday"));
	$("#tr_StrLeaveType").children(".DataTD").html(html);

	$("#sData").html(getlbl("comm.Save") + "<span class='ui-icon ui-icon-disk'>");
	$("#sData").click(function(){		
		var strUrl = "LeaveOptionEdit.asp?nd=" + getRandom() + "&userId=" + userId;
		var data = fGetFormData();
		var htmlObj = $.ajax({
				type: "post", 
				url: strUrl, 
				data: data, 
				async: false, 		
				success: function(data) {
					var responseMsg = $.parseJSON(data);

					if(responseMsg && responseMsg.message){
						alert(responseMsg.message);
					}
				},
				error:function(XmlHttpRequest,textStatus, errorThrown){
					alert(errorThrown);
				}
			});
	});

	$(".DataTD").find("div").css({"line-height": "20px"});
	$(".DataTD").css({"margin": "5px 0px"});
	$(".DataTD").find("input:checkbox").css({"vertical-align": "-3px"});
	$(".DataTD").find("input:radio").css({"vertical-align": "-3px"});
}

//获取数据
function fGetFormData(){
	var data = {};

	//可休年假职员
	data.AnnalDeptEmps = GetSelDepts().Ids;

	//年假规则
	data.BasicAnnualDay = $("#BasicAnnualDay").val();
	data.VacationType = $("#VacationType2").is(":checked") ? "1" : "0";

	data.IncreaseYear = $("#IncreaseYear").val();
	data.IncreaseDay = $("#IncreaseDay").val();

	data.IncreaseYear1 = $("#IncreaseYear1").val();
	data.IncreaseDay1 = $("#IncreaseDay1").val();
	data.IncreaseYear2 = $("#IncreaseYear2").val();
	data.IncreaseDay2 = $("#IncreaseDay2").val();
	data.ContinueNext = $("#ContinueNext").is(":checked") ? "1" : "0";
	data.MaxVacation = $("#MaxVacation").val();

	//请假期间的[休息日、法定假]仍计为[休息日、法定假]
	data.IsPrivate = $("#IsPrivate").is(":checked") ? "1" : "0";
	data.IsSick = $("#IsSick").is(":checked") ? "1" : "0";
	data.IsCompensatory = $("#IsCompensatory").is(":checked") ? "1" : "0";
	data.IsMaternity = $("#IsMaternity").is(":checked") ? "1" : "0";
	data.IsMatrimony = $("#IsMatrimony").is(":checked") ? "1" : "0";
	data.IsLactation = $("#IsLactation").is(":checked") ? "1" : "0";
	data.IsOther = $("#IsOther").is(":checked") ? "1" : "0";
	data.IsTrip = $("#IsTrip").is(":checked") ? "1" : "0";
	data.IsAnnual = $("#IsAnnual").is(":checked") ? "1" : "0";
	data.IsHolidy = $("#IsHolidy").is(":checked") ? "1" : "0";
	data.IsInjury = $("#IsInjury").is(":checked") ? "1" : "0";
	data.IsFuneral = $("#IsFuneral").is(":checked") ? "1" : "0";
	data.IsVisit = $("#IsVisit").is(":checked") ? "1" : "0";
	data.WorkTime = $("#WorkTime").val();

	return data;
}

function GetSelDepts() {
    return $("#depframe")[0].contentWindow.GetCheckDepts(); //{Ids: Ids, Names: Names}
}

function getOptionValue(name, options){
	if(options == undefined || options == null || name == "" || name == undefined){
		return null;
	}

	for(var i in options){
		if(options[i].name == name){
			return options[i].value;
		}
	}

	return null;
}
