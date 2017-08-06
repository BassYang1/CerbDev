$(document).ready(function () {
    //$("#progressbar").hide();
    CheckLoginStatus();

    function CardCheck(value, colname) {
        if (value < 0)
            return [false, getlbl("hr.CardNoLt0")];//"卡号不能小于0"
        else
            return [true, ""];
    }

    jQuery("#DataGrid").jqGrid({
        url: 'ShiftRulesList.asp',
        editurl: "ShiftRulesEdit.asp",
        datatype: "json",
        //colNames:['RuleId',员工说明','上班方式','详细规则','免打卡','DepartmentCode','EmployeeCode','Relationship','OtherCode',FirstWeekDate,Monday1,Tuesday1,Wednesday1,Thursday1,Friday1,Saturday1,Sunday1,Monday2,Tuesday2,Wednesday2,Thursday2,Friday2,Saturday2,Sunday2,day15,day16,day17,day18,day19,day20,day21,day22,day23,day24,day25,day26,day27,day28,day29,day30,day31,ChangeDate],
        colNames: ['RuleId', getlbl("hr.EmpDesc"), getlbl("hr.OnDutyMode"), getlbl("hr.RuleDetail"), getlbl("hr.NoBrushCard"), getlbl("hr.DeptList"), getlbl("hr.EmpList"), getlbl("hr.Relationship"),getlbl("hr.OtherCond"),getlbl("hr.FirstWeekDate"),'Monday1','Tuesday1','Wednesday1','Thursday1','Friday1','Saturday1','Sunday1','Monday2','Tuesday2','Wednesday2','Thursday2','Friday2','Saturday2','Sunday2','day15','day16','day17','day18','day19','day20','day21','day22','day23','day24','day25','day26','day27','day28','day29','day30','day31',getlbl("hr.ChangeDate")],
        colModel: [
            { name: 'RuleId', index: 'RuleId', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'EmployeeDesc', index: 'EmployeeDesc', width: 250, align: 'center', viewable: true, search: false },
            {
                name: 'OnDutyMode', index: 'OnDutyMode', align: 'center', editable: true, editrules: { required: false, edithidden: true },
                edittype: 'none',
                stype: 'select', searchoptions: { sopt: ["eq"], value: ":;1-" + getlbl("hr.SingleWeekCycle") + ":1-" + getlbl("hr.SingleWeekCycle") + ";2-" + getlbl("hr.DoubleWeekCycle") + ":2-" + getlbl("hr.DoubleWeekCycle") + ";3-" + getlbl("hr.CustomCycle") + ":3-" + getlbl("hr.CustomCycle") }, //"1-单周循环,2-双周循环,3-自定义循环"
                formatter: function (cellvalue, options, rowObject) { 
                    if (cellvalue && cellvalue.indexOf("-") >= 0) { 
                        return cellvalue.substr(cellvalue.indexOf("-") + 1); 
                    } 
                    else { 
                        return cellvalue; 
                    } 
                },
                formoptions: { rowpos: 5, colpos: 1 }
            },
            {
                name: 'RuleDetail', index: 'RuleDetail', align: 'center', hidden:true, width: 350, editable: true, editrules: { required: false, edithidden: true },
                edittype: 'none', 
                formatter: function (cellvalue, options, rowObject) {
                    cellvalue = "";
                    
                    for(var i in rowObject){
                        if(i >= 8 && i <= 38 && rowObject[i] && cellvalue.indexOf("-") >= 0){
                            cellvalue += "," + rowObject[i].substr(cellvalue.indexOf("-") + 1);
                        }
                    }

                    return cellvalue.substr(1);
                },
                formoptions: { rowpos: 7, colpos: 1 }
            },
            {
                name: 'NoBrushCard', index: 'NoBrushCard', align: 'center', editable: true, editrules: { required: false, edithidden: true },
                edittype: 'checkbox', editoptions: { value: getlbl("hr.Yes") + ":" + getlbl("hr.No") }, 
                stype: 'select', searchoptions: { sopt: ["eq"], value: ":;1:" + getlbl("hr.Yes") + ";" + "0:" + getlbl("hr.No") }, //"0-否:1-是"
                formatter: function (cellvalue, options, rowObject) { if (cellvalue == "True") { return getlbl("hr.Yes"); } else { return getlbl("hr.No"); } },
                formoptions: { rowpos: 8, colpos: 1 }
            },
            {
                name: 'DepartmentCode', index: 'DepartmentCode', align: 'center', width: 10, editable: true, edittype: 'select', hidden: true, editrules: { required: false, edithidden: true }, viewable: false, search: false,
                formoptions: { rowpos: 1, colpos: 1 },
                editoptions: { },
            },
            {
                name: 'EmployeeCode', index: 'EmployeeCode', align: 'center', width: 10, editable: false, edittype: 'select', hidden: true, editrules: { required: false, edithidden: true }, viewable: false, search: false,
                formoptions: { rowpos: 2, colpos: 1 },
                editoptions: { },
            },
            {
                name: 'Relationship', index: 'Relationship', width: 120, align: 'center', editable: true, sortable: false, search: false, hidden:true,
                editrules: { required: true, edithidden: true },
                edittype: 'select', editoptions: { value: 'and:' + getlbl("hr.RelaAnd") + ';or:' + getlbl("hr.RelaOr") },
                formoptions: { rowpos: 3, colpos: 1 }
            },
            {
                name: 'OtherCode', index: 'OtherCode', align: 'center', width: 10, editable: true, edittype: 'text', hidden: true, editrules: { required: false, edithidden: true }, viewable: false, search: false,
                formoptions: { rowpos: 4, colpos: 1, elmsuffix: "&nbsp;<a class='fm-button ui-state-default ui-corner-all fm-button-icon-left' id='btnSearch' onclick='Search()'>" + getlbl("hr.Search") + "<span class='ui-icon ui-icon-search'></span></a>"},
                editoptions: { disabled: true, code: ""},
            },
            {
                name: 'FirstWeekDate', index: 'FirstWeekDate', align: 'center', hidden: true, editable: true, editrules: { required: false, date: false, edithidden: true },
                width: 150, search: false, formatter: 'date', sorttype: 'date',
                formatoptions: { srcformat: 'Y-m-d', newformat: 'Y-m-d' }, datefmt: 'Y-m-d',                
                editoptions: {
                    size:20,maxlengh:20,
                    dataInit:function(element){
                        $(element).bind('focus', function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd'});});
                    }
                },
                formoptions: { rowpos: 6, colpos: 1 }
            },
            { name: 'Monday1', index: 'Monday1', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'Tuesday1', index: 'Tuesday1', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'Wednesday1', index: 'Wednesday1', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'Thursday1', index: 'Thursday1', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'Friday1', index: 'AoffDutyStart', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'Saturday1', index: 'AoffDutyEnd', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'Sunday1', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'Monday2', index: 'Monday1', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'Tuesday2', index: 'Tuesday1', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'Wednesday2', index: 'Wednesday1', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'Thursday2', index: 'Thursday1', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'Friday2', index: 'AoffDutyStart', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'Saturday2', index: 'AoffDutyEnd', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'Sunday2', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'day15', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'day16', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'day17', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'day18', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'day19', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'day20', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'day21', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'day22', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'day23', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'day24', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'day25', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'day26', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'day27', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'day28', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'day29', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'day30', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'day31', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'ChangeDate', index: 'ChangeDate', align: 'center', editable: true, editrules: { required: true, date: false, edithidden: true },
                width: 150, search: false, formatter: 'date', sorttype: 'date',
                formatoptions: { srcformat: 'Y-m-d', newformat: 'Y-m-d' }, datefmt: 'Y-m-d',
                editoptions: {
                    size:20,maxlengh:20,
                    dataInit:function(element){
                        $(element).bind('focus', function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd'});});
                    }
                },
                formoptions: { rowpos: 9, colpos: 1, elmsuffix:"<font color=#FF0000>*</font>" }
            },
        ],
        caption: getlbl("hr.ShiftRule"),//"上班规则"
        imgpath: '/images',
        multiselect: false,
        rowNum: irowNum,
        rowList: [10, 16, 20, 30],
        prmNames: { search: "_search" },
        //jsonReader: { repeatitems: false },
        pager: '#pager',
        //sortname: 'RecordID',
        multiselect: true,
        multiboxonly: true,
        viewrecords: true,
        sortorder: "desc",
        height: 'auto',
        width: 'auto',
        forceFit: true, //调整列宽度不会改变表格的宽度
        hidegrid: false,//禁用控制表格显示、隐藏的按钮
        loadtext: strloadtext,
        toppager: true,
        loadComplete: function (data) { //完成服务器请求后，回调函数 
            if (data == null || data.records == 0) {
                jQuery("#DataGrid").jqGrid('clearGridData');
            }
        },
    });

    //获取操作权限
    var role = GetOperRole("employees");
    var iedit = false, iadd = false, idel = false, iview = false, irefresh = false, isearch = false, iexport = false;
    try {
        iedit = role.edit;
        iadd = role.add;
        idel = role.del;
        iview = role.view;
        irefresh = role.refresh;
        isearch = role.search;
        iexport = role.exportdata;
    }
    catch (exception) {
        alert(exception);
    }

    jQuery("#DataGrid").jqGrid('navGrid', '#DataGrid_toppager',
        {
            edit: iedit, add: iadd, del: idel, view: iview, refresh: irefresh, search: isearch, edittext: stredittext, addtext: straddtext, deltext: strdeltext, searchtext: strsearchtext, refreshtext: strrefreshtext, viewtext: strviewtext,
            alerttext: stralerttext,
        },
        {
            top: 0, width: 850, labelswidth: '70px', height: "auto",
            dataheight: "auto",
            reloadAfterSubmit: true,
            closeAfterEdit: document.all ? false : true,    //IE下修改后，对话框不关闭。主要是上传照片Ajax无法同步执行
            jqModal: true,
            closeOnEscape: false,
            beforeInitData: function (formid) {},
            beforeShowForm: function (form) {
            },
            beforeSubmit: function (postdata, formid) {
                var rowid = $("#DataGrid").jqGrid('getGridParam', 'selrow'); //获取选择行ID
                return [true, ''];
            },
            afterSubmit: getEditafterSubmit,
            afterShowForm: function (formid) {
                var rowid = $("#DataGrid").jqGrid('getGridParam', 'selrow');
                var ret = $("#DataGrid").jqGrid('getRowData', rowid);

                $(".navButton").hide(); //隐藏按钮

                ShowLoading();
                initEditForm(ret); //绑定事件处理方法
                CloseLoadingByDept();
            },
            onclickSubmit: function (params) {
                return fGetFormData();
            },
            //selarrrow
        },  //  default settings for edit
        {
            top: 0, width: 850,
            dataheight: "auto",
            //url: addUrl,
            jqModal: true,
            reloadAfterSubmit: true,
            closeAfterAdd: document.all ? false : true, //IE下修改后，对话框不关闭。主要是上传照片Ajax无法同步执行
            //bottominfo : "<div class=&#39test'>有*号的为必填项  </div>",,
            afterSubmit: getAddafterSubmit,
            afterShowForm: function (formid) {
                ShowLoading();
                initEditForm(); //绑定事件处理方法
                CloseLoadingByDept();
            },
            onclickSubmit: function (params) {
                return fGetFormData();
            },
        },  //  default settings for add
        {
            top: 0,
            reloadAfterSubmit: true,
            afterSubmit: getDelafterSubmit
        },  // delete instead that del:false we need this
        { multipleSearch: false, multipleGroup: false, showQuery: false, closeAfterSearch: true, caption: strsearchcaption, top: 60 },// search options
        {
            top: 0, width: 850, labelswidth: '70px', height: "auto",
            beforeShowForm: function () {
                var rowid = $("#DataGrid").jqGrid('getGridParam', 'selrow');
                var ret = $("#DataGrid").jqGrid('getRowData', rowid);

                initRuleDetail4View(ret); //查看详细

                $(".navButton").hide(); //隐藏按钮  
            }
        }   //view parameters
        );

    var topPagerDiv = $('#DataGrid_toppager')[0];         // "#list_toppager"
    $("#DataGrid_toppager_center", topPagerDiv).remove(); // "#list_toppager_center"
    $(".ui-paging-info", topPagerDiv).remove();
    $("#DataGrid_toppager_right").css('width', '30%');
    $("#DataGrid_toppager_left").css("width", "70%");
    $('#table_DataGrid_top_right').appendTo('#DataGrid_toppager_right');

    //导出列表数据
    if (iexport) {
        $("#DataGrid").jqGrid('navGrid', "#DataGrid_toppager_left").jqGrid('navButtonAdd', "#DataGrid_toppager_left", {
            caption: getlbl("hr.Export"),//"导出"
            buttonicon: "ui-icon-bookmark",
            title: getlbl("hr.ExportToLocal"),//"导出至本地"
            id: "DataGrid_btnSubmit",
            onClickButton: ExportData,
            //position:"first"
        });
    }
});

function initEditForm(rowObject) {
    var id = rowObject && rowObject.RuleId ? rowObject.RuleId : "";

    //上班方式
    var htmlOnDutyMode = "&nbsp;";
    htmlOnDutyMode += "<input type='radio' checked value='1-" + getlbl("hr.SingleWeekCycle") + "' id='SingleWeekCycle' name='OnDutyMode' role='radio' class='FormElement' /><label for='SingleWeekCycle'>" + getlbl("hr.SingleWeekCycle") + "</label>&nbsp;";
    htmlOnDutyMode += "<input type='radio' value='2-" + getlbl("hr.DoubleWeekCycle") + "' id='DoubleWeekCycle' name='OnDutyMode' role='radio' class='FormElement' /><label for='DoubleWeekCycle'>" + getlbl("hr.DoubleWeekCycle") + "</label>&nbsp;";
    htmlOnDutyMode += "<input type='radio' value='3-" + getlbl("hr.CustomCycle") + "' id='CustomCycle' name='OnDutyMode' role='radio' class='FormElement' /><label for='CustomCycle'>" + getlbl("hr.CustomCycle") + "</label>";

    $("#tr_OnDutyMode").children("td.DataTD").html(htmlOnDutyMode);
    $("#tr_OnDutyMode").children("td.DataTD").children().css("vertical-align", "middle");
    $("#tr_OnDutyMode").children("td.DataTD").children("label").css("margin-left", "2px");
    
    $("#tr_OnDutyMode").children("td.DataTD").children("input").bind("click", function(){
        initRuleDetail4Form(rowObject, $(this).val().substr(0,1));
    });

    if(rowObject && rowObject.OnDutyMode){
        $("#tr_OnDutyMode").children("td.DataTD").children("input[value$='" + rowObject.OnDutyMode + "']").attr("checked", "checked");
    }

    if(rowObject && rowObject.OtherCode){ //其它条件
        var arrCode = rowObject.OtherCode.split("|,");

        if(arrCode.length >= 4){
            $("#OtherCode").val(arrCode[0]);
            $("#OtherCode").attr("code", arrCode[1] + "|," + arrCode[2] + "|," + arrCode[3]);
        }
    }

    //加载部门
    initDepartments(id); 
    //加载员工
    initEmployees(); 
    //初使化上班规则
    initRuleDetail4Form(rowObject);
}

//rowObject 规则详细数据
function initRuleDetail4Form(rowObject, mode) {
    if(mode == undefined && rowObject && rowObject.OnDutyMode){
        var modeValue = $("input[name='OnDutyMode'][value$='" + rowObject.OnDutyMode + "']").val();
        if (modeValue) {
            mode = modeValue.substr(0, 1)
        }
    }

    mode = mode ? mode : "1";
    rowObject = rowObject || {};

    var $tr = $("#tr_RuleDetail"), 
        $label = $tr.children("td.CaptionTD"),
        $data = $tr.children("td.DataTD");

    var html = "<table id='tbl_RuleDetail' class='FormElement' style='margin-left:13px;' width='90%' border='0' cellpadding='0' cellspacing='0'>";

    if(mode == "1" || mode == "2"){
        html = html + "<tbody>";
        html = html + "<tr class='FormData'>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder' style='width: 20%;'>" + getlbl("hr.FirstWeek") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Shift") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder' style='width: 20%;'>" + getlbl("hr.SecondWeek") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + getlbl("hr.Shift") + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Monday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.Monday1,"Monday1") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Monday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + getShiftList(rowObject.Monday2,"Monday2") + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Tuesday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.Tuesday1,"Tuesday1") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Tuesday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + getShiftList(rowObject.Tuesday2,"Tuesday2") + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Wednesday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.Wednesday1,"Wednesday1") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Wednesday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + getShiftList(rowObject.Wednesday2,"Wednesday2") + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Thursday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.Thursday1,"Thursday1") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Thursday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + getShiftList(rowObject.Thursday2,"Thursday2") + "</td>";
        html = html + "</tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Friday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.Friday1,"Friday1") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Friday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + getShiftList(rowObject.Friday2,"Friday2") + "</td>";
        html = html + "</tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Saturday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.Saturday1,"Saturday1") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Saturday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + getShiftList(rowObject.Saturday2,"Saturday2") + "</td>";
        html = html + "</tr>";  
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.Sunday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getShiftList(rowObject.Sunday1,"Sunday1") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.Sunday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB ui-border-R'>" + getShiftList(rowObject.Sunday2,"Sunday2") + "</td>";
        html = html + "</tr>";
    }
    else{
        html = html + "<tbody>";
        html = html + "<tr class='FormData'>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder' style='width: 10%;'>" + getlbl("hr.Date") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Shift") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder' style='width: 10%;'>" + getlbl("hr.Date") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Shift") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder' style='width: 10%;'>" + getlbl("hr.Date") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Shift") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder' style='width: 10%;'>" + getlbl("hr.Date") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + getlbl("hr.Shift") + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>1</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.Monday1,"Monday1",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>9</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.Tuesday2,"Tuesday2",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>17</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.day17,"day17",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>25</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + getShiftList(rowObject.day25,"day25",true) + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>2</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.Tuesday1,"Tuesday1",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>10</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.Wednesday2,"Wednesday2",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>18</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.day18,"day18",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>26</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + getShiftList(rowObject.day26,"day26",true) + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>3</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.Wednesday1,"Wednesday1",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>11</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.Thursday2,"Thursday2",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>19</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.day19,"day19",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>27</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + getShiftList(rowObject.day27,"day27",true) + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>4</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.Thursday1,"Thursday1",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>12</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.Friday2,"Friday2",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>20</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.day20,"day20",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>28</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + getShiftList(rowObject.day28,"day28",true) + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>5</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.Friday1,"Friday1",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>13</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.Saturday2,"Saturday2",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>21</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.day21,"day21",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>29</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + getShiftList(rowObject.day29,"day29",true) + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>6</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.Saturday1,"Saturday1",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>14</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.Sunday2,"Sunday2",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>22</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.day22,"day22",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>30</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + getShiftList(rowObject.day30,"day30",true) + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>7</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.Sunday1,"Sunday1",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>15</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.day15,"day15",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>23</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getShiftList(rowObject.day23,"day23",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>31</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + getShiftList(rowObject.day31,"day31",true) + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>8</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getShiftList(rowObject.Monday2,"Monday2",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>16</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getShiftList(rowObject.day16,"day16",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>24</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getShiftList(rowObject.day24,"day24",true) + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>&nbsp;</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB ui-border-R'>&nbsp;</td>";
        html = html + "</tr>";
    }

    html = html + "</tbody>";  
    html = html + "</table>";

    $data.html(html);
    if(mode == "1"){
        $("#Monday2,#Tuesday2,#Wednesday2,#Thursday2,#Friday2,#Saturday2,#Sunday2").attr("disabled", true);
        $("#Monday2,#Tuesday2,#Wednesday2,#Thursday2,#Friday2,#Saturday2,#Sunday2").removeClass("ui-widget-content");
    }  
}

//rowObject 规则详细数据
function initRuleDetail4View(rowObject) {
    var mode = "1";
    if (rowObject.OnDutyMode == getlbl("hr.DoubleWeekCycle")) {
        mode = "2"
    }
    else if (rowObject.OnDutyMode == getlbl("hr.CustomCycle")) {
        mode = "3"
    }

    rowObject = rowObject || {};

    var $tr = $("#trv_RuleDetail"), 
        $label = $tr.children("td.CaptionTD"),
        $data = $tr.children("td.DataTD");

    var html = "<table id='tbl_RuleDetail' class='FormElement' style='margin-left:13px;' width='90%' border='0' cellpadding='0' cellspacing='0'>";

    if(mode == "1" || mode == "2"){
        html = html + "<tbody>";
        html = html + "<tr class='FormData'>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder' style='width: 20%;'>" + getlbl("hr.FirstWeek") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Shift") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder' style='width: 20%;'>" + getlbl("hr.SecondWeek") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + getlbl("hr.Shift") + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Monday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.Monday1 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Monday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + rowObject.Monday2 + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Tuesday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.Tuesday1 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Tuesday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + rowObject.Tuesday2 + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Wednesday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.Wednesday1 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Wednesday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + rowObject.Wednesday2 + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Thursday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.Thursday1 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Thursday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + rowObject.Thursday2 + "</td>";
        html = html + "</tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Friday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.Friday1 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Friday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + rowObject.Friday2 + "</td>";
        html = html + "</tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Saturday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.Saturday1 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Saturday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + rowObject.Saturday2 + "</td>";
        html = html + "</tr>";  
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.Sunday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + rowObject.Sunday1 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.Sunday") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB ui-border-R'>" + rowObject.Sunday2 + "</td>";
        html = html + "</tr>";
    }
    else{
        html = html + "<tbody>";
        html = html + "<tr class='FormData'>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder' style='width: 10%;'>" + getlbl("hr.Date") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Shift") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder' style='width: 10%;'>" + getlbl("hr.Date") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Shift") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder' style='width: 10%;'>" + getlbl("hr.Date") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + getlbl("hr.Shift") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder' style='width: 10%;'>" + getlbl("hr.Date") + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + getlbl("hr.Shift") + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>1</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.Monday1 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>9</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.Tuesday2 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>17</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.day17 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>25</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + rowObject.day25 + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>2</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.Tuesday1 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>10</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.Wednesday2 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>18</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.day18 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>26</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + rowObject.day26 + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>3</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.Wednesday1 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>11</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.Thursday2 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>19</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.day19 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>27</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + rowObject.day27 + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>4</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.Thursday1 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>12</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.Friday2 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>20</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.day20 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>28</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + rowObject.day28 + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>5</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.Friday1 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>13</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.Saturday2 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>21</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.day21 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>29</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + rowObject.day29 + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>6</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.Saturday1 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>14</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.Sunday2 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>22</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.day22 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>30</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + rowObject.day30 + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>7</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.Sunday1 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>15</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.day15 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>23</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>" + rowObject.day23 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder'>31</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + rowObject.day31 + "</td>";
        html = html + "</tr>";
        html = html + "<tr>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>8</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + rowObject.Monday2 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>16</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + rowObject.day16 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>24</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + rowObject.day24 + "</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>&nbsp;</td>";
        html = html + "<td align='center' class='ui-border ui-NoneRightBorder ui-border-LB ui-border-R'>&nbsp;</td>";
        html = html + "</tr>";
    }

    html = html + "</tbody>";  
    html = html + "</table>";

    $data.html(html);
}

//获取班次列表
var arrShifts;
function getShiftList(shift, date, blankOption){
    if(blankOption == undefined){
        blankOption = false;
    }

    if(!(arrShifts)){
        var result = $.ajax({type:'post',url:'../Common/GetShiftJSON.asp?nd='+getRandom(),data:null,async:false});
        var data = result.responseText;
        arrShifts = data ? ($.parseJSON(data) || []) : [];
    }

    var html = "<select role='select' class='FormElement ui-widget-content' id='" + date + "' name='" + date + "'>";
    if(blankOption){
        html += "<option value=''></option>";
    }

    if(shift && shift.indexOf("0-" + getlbl("hr.Rest")) >= 0){
        html += "<option selected value='0-" + getlbl("hr.Rest") + "'>0-" + getlbl("hr.Rest") + "</option>";
    }
    else{
        html += "<option value='0-" + getlbl("hr.Rest") + "'>0-" + getlbl("hr.Rest") + "</option>";
    }

    for(var i in arrShifts){
        if(shift && shift.indexOf(arrShifts[i].id + "-") >= 0){
            html += "<option selected value='" + arrShifts[i].id + "-" + arrShifts[i].name + "'>" + arrShifts[i].name + "</option>";
        }
        else{
            html += "<option value='" + arrShifts[i].id + "-" + arrShifts[i].name + "'>" + arrShifts[i].name + "</option>";
        }
    }

    html += "</select>";
    return html;
}

//初使化部门
function initDepartments(ruleId) {
    var $tr = $("#tr_DepartmentCode"),
        $label = $tr.children("td.CaptionTD"),
        $data = $tr.children("td.DataTD");

    if (ruleId == undefined || ruleId == null || ruleId == "" || typeof ruleId != "string") {
        ruleId = "0";
    }

    var userId = getCookie(cookieUserId);
    $data.html("&nbsp;<iframe id='depframe' name='depframe' width='90%' height='180' marginheight='0' marginwidth='0' frameborder='0' align='center' src='../Tools/GetUserEditDept.html?nd=" + getRandom() + "&oper=shiftrules&id=" + ruleId + "&userId=" + userId + "'></iframe>");
}

//获取所选部门信息
function GetSelDepts() {
    if($("#depframe") && $("#depframe")[0] && $("#depframe")[0].contentWindow){
        return $("#depframe")[0].contentWindow.GetCheckDepts(); //{Ids: Ids, Names: Names}
    }

    return "";
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

    return true;
}

function fGetFormData() {
    var data = {};

    //员工条件
    data.OtherCond = $("#OtherCode").val();
    data.OtherCode = $("#OtherCode").attr("code");

    //上班方式
    data.OnDutyMode = $("#tr_OnDutyMode").find("input[name='OnDutyMode']").filter(":checked").val();

    //第一周开始日
    data.FirstWeekDate = $("#FirstWeekDate").val();

    //免打卡
    data.NoBrushCard = $("#NoBrushCard").is(":checked") ? "1" : "0";

    //更改日期
    data.ChangeDate = $("#ChangeDate").val();

    //选择部门
    var depts = GetSelDepts();
    if(depts && depts.Ids && depts.Names){
        data.DepartmentCode = depts.Ids;
        data.DepartmentName = depts.Names;
    }

    //选择职员
    var empIds = "", empNames = "";
    $("#selEmpDesc").find("option").each(function(){
        empIds += "," + $(this).val();
        empNames += "," + $(this).text();
    });

    data.EmployeeExpress = empIds.substr(1);
    data.EmployeeName = empNames.substr(1);

    //规则详细
    var rules = "";
    var $trs = $("#tbl_RuleDetail").find("tr:gt(0)");
    var loopCount = 0;
    $trs.find("td:eq(1)").find("select").each(function(){
        if($(this).val()){
            rules += "," + $(this).val();
            loopCount ++;
        }
    });
    $trs.find("td:eq(3)").find("select").each(function(){
        if($(this).val() && !$(this).is(":disabled")){
            rules += "," + $(this).val();
            loopCount ++;
        }
    });
    $trs.find("td:eq(5)").find("select").each(function(){
        if($(this).val() && !$(this).is(":disabled")){
            rules += "," + $(this).val();
            loopCount ++;
        }
    });
    $trs.find("td:eq(7)").find("select").each(function(){
        if($(this).val() && !$(this).is(":disabled")){
            rules += "," + $(this).val();
            loopCount ++;
        }
    });

    data.LoopCount = loopCount;
    data.RuleDetail = rules.substr(1);

    return data;
}

function gridReload() {
    $("#DataGrid").jqGrid('setGridParam', { url: "ShiftRulesList.asp", page: 1, }).trigger("reloadGrid");
}

function GetTime() {
    WdatePicker({ isShowClear: true, dateFmt: 'HH:mm', isShowToday: false, qsEnabled: false });
};

function ExportData() {
    $("#divExport").load("../Tools/ExportDataUI.asp?nd=" + getRandom() + "&exportType=shiftrules");
    $("#divExport").show();
}

function Search(){
    $("#divSearch").load("../Equipment/search.asp?submitfun=SearchSubmit()");
    $("#divSearch").show();
}

function SearchSubmit(){
    var strsearchField = $("#searRetColVal").html();
    var strsearchOper = $("#searRetOperVal").html();
    var strsearchString = $("#searRetDataVal").html();
    var code = strsearchField + "|," + strsearchOper + "|," + encodeURI(strsearchString);

    var searRetColText = $.trim($("#searRetColText").text());
    var searRetOperText = $.trim($("#searRetOperText").text());
    var searRetDataText = $.trim($("#searRetDataText").text());
    searRetDataText = searRetDataText.replace(/[\|\-]/g, '')

    if(code != ""){
        $("#OtherCode").val(searRetColText + " " + searRetOperText + " '" + searRetDataText + "'");
        $("#OtherCode").attr("code", code);
    }
}