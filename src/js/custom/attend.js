// JavaScript Document
 
//初使化列表
function initListPage(iapprove){
    var html = "<option value='0'>0 - " + getlbl("hr.FlowData_My") + "</option>";

    //iapprove = false;

    if(iapprove){
        html += "<option value='1'>1 - " + getlbl("hr.FlowData_Processing") + "</option>";
        html += "<option value='2'>2 - " + getlbl("hr.FlowData_Processed") + "</option>";
    }

    $("#selHead").html(html);

    initDate();
    initStatus();
    initListDepartments();
    $("#selDept").attr("disabled", true);

    $("#selHead").change("change", function(){
        var ihead = $(this).val()
        initStatus(ihead);
        changeNavEx();

        if(ihead != "0"){
            $("#selDept").removeAttr("disabled");
        }
        else{
            $("#selDept").attr("disabled", true);
        }

        gridReload();
    });
}

function initStatus(ihead){
    var html = "";

    if(ihead == undefined || ihead == "0"){        
        html = "<option value='A'>A - " + getlbl("hr.FlowStatus_All_A") + "</option>";
        html += "<option value='0'>1 - " + getlbl("hr.FlowStatus_Applied_0") + "</option>";
        //html += "<option value='1'>" + getlbl("hr.FlowStatus_Reviewed_1") + "</option>";
        html += "<option value='2'>2 - " + getlbl("hr.FlowStatus_Approved_2") + "</option>";
        html += "<option value='3'>3 - " + getlbl("hr.FlowStatus_Refused_3") + "</option>";
        //html += "<option value='4'>" + getlbl("hr.FlowStatus_Review_With_Pend_4") + "</option>";
        //html += "<option value='5'>" + getlbl("hr.FlowStatus_Approve_With_Pend_5") + "</option>";
        html += "<option value='C'>C - " + getlbl("hr.FlowStatus_Ceased_C") + "</option>";
    }
    else if(ihead == "1"){
        html = "<option value='A'>A - " + getlbl("hr.FlowStatus_All_A") + "</option>";
        html += "<option value='1'>1 - " + getlbl("hr.FlowStatus_Approving_2") + "</option>";
    }
    else if(ihead == "2"){
        html = "<option value='A'>A - " + getlbl("hr.FlowStatus_All_A") + "</option>";
        html += "<option value='2'>1 - " + getlbl("hr.FlowStatus_Approved_2") + "</option>";
        html += "<option value='3'>2 - " + getlbl("hr.FlowStatus_Refused_3") + "</option>";
    }

    $("#selStatus").html(html);

    $("#selStatus").change("change", function(){
        gridReload();
    });
}

//获取申请时长
function getDuration(){
    var timeHtml = "";
    var startTime, endTime;
    var vluStart = $("#StartTime").val(), vluEnd = $("#EndTime").val();
    var diffTime = 0, days = 0, hours = 0;
    
    try{
        if(vluStart != "" &&  vluEnd != ""){
            startTime = new Date(vluStart);
            endTime = new Date(vluEnd);
            diffTime = endTime.getTime() - startTime.getTime();
        }
    }
    catch(ex){          
    }
            
    if($("#AllDay").is(":checked") == true){
        days = Math.ceil((diffTime + 1)/ (3600000 * 24));
        timeHtml = days + getlbl("hr.Day");
    }
    else {          
        diffTime = Math.ceil(diffTime / 60000);  //1h = 60m * 1000ms
        timeHtml = parseInt(diffTime / 60) + getlbl("hr.Hour") + (diffTime % 60) + getlbl("hr.Minute");
    }

    if(vluStart != "" &&  vluEnd != ""){
        $("#tr_Status").children("td.DataTD").find("#leaveNum").html(timeHtml);
    }
    else{
        $("#tr_Status").children("td.DataTD").find("#leaveNum").html("");
    }
}

//初使化日期年月
function initDate(){
    //年
    var nowYear = parseInt((new Date()).getFullYear());
    var html = "<option value=''>" + getlbl("hr.Year") + "</option>";

    for(var i = 0; i < 20; i ++){
        html += "<option value='" + (nowYear - i) + "'>" + (nowYear - i) + "</option>";
    }

    $("#selYear").html(html);
    $("#selYear option:eq(0)").attr("selected", true);

    //月
    html = "<option value='' selected>" + getlbl("hr.Month") + "</option>";

    for(var i = 1; i <= 12; i ++){
        html += "<option value='" + (i < 10 ? "0" : "") + i + "'>" + i + "</option>";
    }

    $("#selMonth").html(html);
    $("#selMonth option:eq(0)").attr("selected", true);

    $("#selYear").change("change", function(){
        if($(this).val() == ""){
            $("#selMonth option:eq(0)").attr("selected", true);
            $("#selMonth").attr("disabled", true);
        }
        else{
            $("#selMonth").attr("disabled", false);
        }

        gridReload();
    });

    $("#selMonth").change("change", function(){
        gridReload();
    });
}

//初使化部门
function initListDepartments(){
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
            for(var i = 1; i < len; i ++){
                if(i==1)
                    sBlank += "&nbsp;&nbsp;";
                else
                    sBlank += "|&nbsp;";
            }

            deptListHtml += "<option value='" + id + "' code='" + code + "'>" + sBlank + "|-" + name + "</option>";
        }
    }

    $("#selDept").html(deptListHtml);
    $("#selDept").css('width','140');
    $("#selDept").css('font-size','12px');
    $("#selDept").prepend("<option value='0'>A - "+getlbl("hr.AllDept")+"</option>");    //1 - 所有部门
    $("#selDept").val(0);   //选择value为0的项
    $("#selDept").change(function(){
        gridReload();
    });
}

//导航条扩展
function changeNavEx(){   
    var ihead = $("#selHead").val();
    ihead = ihead ? ihead : "0";

    //显示审批按钮
    if(ihead == "0"){ //我的资料            
        $("#add_DataGrid_top, #del_DataGrid_top").show();
        $("#edit_DataGrid_top").hide();
    }
    else if(ihead == "1"){ //审批资料
        $("#add_DataGrid_top, #del_DataGrid_top").hide();
        $("#edit_DataGrid_top").show();
    }
    else { //已审资料
        $("#edit_DataGrid_top, #add_DataGrid_top, #del_DataGrid_top").hide();
    }
}