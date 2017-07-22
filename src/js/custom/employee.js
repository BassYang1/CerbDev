// JavaScript Document

//初使化部门
function initDepartments(orderId) {
    var $tr = $("#tr_DepartmentCode"),
        $label = $tr.children("td.CaptionTD"),
        $data = $tr.children("td.DataTD");

    if (orderId == undefined || orderId == null || orderId == "" || typeof orderId != "string") {
        orderId = "0";
    }

    if(orderId != "0"){
        $tr.hide();
        return;
    }

    var userId = getCookie(cookieUserId);
    $data.html("&nbsp;<iframe id='depframe' name='depframe' width='90%' height='180' marginheight='0' marginwidth='0' frameborder='0' align='center' src='../Tools/GetUserEditDept.html?nd=" + getRandom() + "&oper=askforleave&id=" + orderId + "&userId=" + userId + "'></iframe>");
}

//获取所选部门信息
function GetSelDepts() {
    return $("#depframe")[0].contentWindow.GetCheckDepts(); //{Ids: Ids, Names: Names}
}

//初使化员工
function initEmployees() {
    var $tr = $("#tr_EmployeeCode"),
        $label = $tr.children("td.CaptionTD"),
        $data = $tr.children("td.DataTD");

    var empListHtml = "<div>&nbsp;<a class='fm-button ui-state-default ui-corner-all fm-button-icon-left' id='btnSearchEmployee' onclick='fSearchEmployee()'>" + getlbl("hr.Search") + "<span class='ui-icon ui-icon-search'></span></a></div>" +
            "<TABLE width='100%' border='0' cellPadding=0 cellSpacing=0>" +
            "<TBODY><TR>" +
            "<TD width='30%' valign='top'><div onDblClick='fInsertEmp()' style='padding-left:1em;' class='ui-jqdialog-content ui-widget-content'>" +
            "<select id='selEmpSrc' name='selEmpSrc' class='FormElement ui-widget-content ui-corner-all' size=8 multiple style='WIDTH: 270px'>";

    empListHtml += "</select></div></TD>" +
            "<TD width='18%'align=middle valign='middle'>" +
            "<div align='center'>" +
            "<a class='fm-button ui-state-default ui-corner-all fm-button-icon-left ' id='empadd' onclick='fInsertEmp()'>" +
            "<span class='ui-icon ui-icon-carat-1-e ' style='position:relative;left: -13px;top: 8px;'></span>" +
            "<span class='ui-icon ui-icon-carat-1-e ' style='position:relative;left: -8px;top: 0px;'></span>" +
            "</a><p>" +
            "<a class='fm-button ui-state-default ui-corner-all fm-button-icon-left' id='empdel' onclick='fDelEmp()'>" +
            "<span class='ui-icon ui-icon-carat-1-w ' style='position:relative;left: -13px;top: 8px;'></span>" +
            "<span class='ui-icon ui-icon-carat-1-w ' style='position:relative;left: -8px;top: 0px;'></span>" +
            "</a></div></TD>" +
            "<TD width='52%' valign='top'><div onDblClick='fDelEmp()' class='ui-jqdialog-content ui-widget-content'>" +
            "<select id='selEmpDesc' name='selEmpDesc' class='FormElement ui-widget-content ui-corner-all' style='WIDTH: 270px' multiple size=8 >" +
            "</select></div></TD></TR></TBODY></TABLE>";

    $data.html(empListHtml);
}

function fInsertEmp() {
    //职员列表
    var srcValue, srcText;
    var $srcObj = $("#selEmpSrc");
    var $selOptions = $srcObj.find("option:selected"); //选中职员
    var $selOption, $allOptions; //包括子部门

    //所选职员列表
    var $selObj = $("#selEmpDesc");

    //是否选择所有职员
    if ($selObj.find("option[value='0']").length <= 0) { //未选择所有员工，则继续添加
        if ($selOptions.filter("option[value='0']").length > 0) {
            $selObj.empty();
            $selObj.append("<option value='0'>" + getlbl("con.AllEmp") + "</option>");
        }
        else {
            $selOptions.each(function (i) {
                $selOption = $(this);
                srcValue = $selOption.val();
                srcText = $selOption.text();

                if ($selObj.find("option[value='" + srcValue + "']").length <= 0) {
                    $selObj.append("<option value='" + srcValue + "'>" + srcText + "</option>");
                }
            });
        }
    }
}

function fDelEmp() {
    //所选职员列表
    var $selObj = $("#selEmpDesc");
    var $selOptions = $selObj.find("option:selected"); //待移出的选项

    $selOptions.each(function (i) {
        $(this).remove();
    });
}

function fSearchEmployee() {
    $("#divSearch").load("../Equipment/search.asp?submitfun=fSearchEmployeeSubmit()");
    $("#divSearch").show();
}

function fSearchEmployeeSubmit() {
    var strsearchField = $("#searRetColVal").html();
    var strsearchOper = $("#searRetOperVal").html();
    var strsearchString = $("#searRetDataVal").html();

    condition = strsearchField + "|," + strsearchOper + "|," + encodeURI(strsearchString);

    var arrEmps = getEmpJSON(condition);

    //所选职员列表
    var $srcObj = $("#selEmpSrc");
    $srcObj.empty();

    for (var i in arrEmps) {
        $srcObj.append("<option value='" + arrEmps[i].id + "'>" + arrEmps[i].number + "-" + arrEmps[i].name + "</option>");
    }
}

function LoadSelEmp(empIds){
    if(empIds == undefined || typeof empIds != "string" || empIds == "" || empIds.search(/[a-zA-Z]+/g) >= 0){
        return false;
    }

    var arrEmps = getEmpJSON(null, empIds); //获取员工JSON数据

    //所选职员列表
    var $selObj = $("#selEmpDesc");

    for(var i in arrEmps){
        $selObj.append("<option value='" + arrEmps[i].id + "'>" + arrEmps[i].number + "-" + arrEmps[i].name + "</option>");
    }

    $("#selEmpDesc").attr("disabled", true);
    $("#srcEmpDesc").attr("disabled", true);
    $("#empadd").attr("disabled", true);
    $("#empdel").attr("disabled", true);

    return true;
}
