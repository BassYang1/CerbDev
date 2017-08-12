﻿var strloadtext= "正在获取，请稍后...";
var strapplytext = "申请";
var strrevoketext = "撤销";
var strrevokemsg = "撤销所选记录？";
var strchecktext = "审核";
var strapprovetext = "批准";
var strrefusetext = "拒绝";
var stredittext = "修改";
var straddtext = "增加";
var strviewtext = "查看";
var strdeltext = "删除";
var strdelmsg = "删除所选记录？";
var strsearchtext="查找";
var strrefreshtext="刷新";
var stralerttext = "请选择需要操作的数据行!";
var strsearchcaption ="查找";

var comm = {
	Save: "保存",
	Confirm: "确定",
	Cancel: "取消"
}

var login={
	Title : "Cerberus iSCS 用户登录",
	LoginUserName : "用户名： ",
	LoginPwd : "密 码： ",
	BrowseMsg1 : "&nbsp;&nbsp;&nbsp;&nbsp;您的浏览器版本过低，建议使用<a href='http://www.firefox.com.cn/download/'>Firefox</a>、<a href='https://www.google.com.hk/chrome/'>Google Chrome</a>、IE９或以上",
	BrowseMsg2 : "&nbsp;&nbsp;&nbsp;&nbsp;您的浏览器为IE，也可使用<a href='http://www.firefox.com.cn/download/'>Firefox</a>或<a href='https://www.google.com.hk/chrome/'>Google Chrome</a> ",
	EnterUserName : "请输入用户名",
	PwdIllegal : "密码中含有非法字符",
	LoginEx : "登录异常",
	UserTopImg : "url(Images/user_top.gif)",
	SubmitImg : "url(Images/submit.png)",
	imgBottom : "images/user_bottom3.gif",
	logopic : "images/logo.gif",
	photo : "images/photo.gif",
	picture : "images/picture.gif",
	Hello : "您好：",
	Employees : "人&nbsp;&nbsp;事",
	Equipment : "设备管理",
	Report : "报&nbsp;&nbsp;表",
	Tool : "工&nbsp;&nbsp;具",
	LogOut : "注&nbsp;&nbsp;销",
	Help : "帮&nbsp;&nbsp;助",
	Monitor : "实时监控",
}

var hr={
	CardNoLt0 : "卡号不能小于0",
	SuperiorDept : "上级部门",
	DeptName : "部门名称",
	DeptLevel : "部门级别",
	DeptList : "部门列表",
	DelByOnlyOne : "删除部门仅能逐条删除.",
	DelAllDept : "删除父部门时，该部门下所有子部门将全部删除.",
	Export : "导出",
	ExportToLocal : "导出至本地",
	Refresh: "刷新",
	View : "查看",
	Search : "查找",
	Del : "删除",
	DeptMaxLevel : "部门最大支持10级，不能选择第10级部门当上级部门",
	Dept : "部门",
	Name : "姓名",
	Num : "工号",
	Card : "卡号",
	IdentityCard : "身份证",
	Sex : "性别",
	Position : "职务",
	Headship : "职位",
	Telephone : "电话",
	BirthDate : "出生日期",
	JoinDate : "入职日期",
	Marry : "婚否",
	Knowledge : "学历",
	Country : "国籍",
	NativePlace : "籍贯",
	Address : "通信地址",
	IncumbencyStatus : "在职状态",
	CollectFP : "采集指纹",
	DimissionDate : "离职日期",
	DimissionReason : "离职原因",
	Male : "男",
	Female : "女",
	Married : "已婚",
	Unmarried : "未婚",
	Incumbent0 : "0-在职",
	Incumbent1 : "1-离职",
	PersonnelList : "人事列表",
	UpPhotoFail : "照片上传失败",
	AllDept : "所有部门",
	MyRecord : "我的记录",
	Browse : "浏览...",
	Delete : "删除",
	SupportPhotoFormat : "仅支持png|jpg|jpeg|gif|bmp格式图片！",
	UpPhotoEx : "上传照片异常",
	UpPhotoFail : "上传照片失败，可能原因：照片超过10K. 错误信息：",
	divEmp : "人事",
	spanNavEmp : "人事资料",
	hrefDept : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;部门列表",
	hrefEmp : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;人事列表",
	spanNavAtt : "考勤",
	hrefAttShift : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;班次",
	ShiftName: "班次名",
	StretchShift: "弹性班次",
	ShiftTime: "基本工时",
	Degree: "上班次数",
	Night: "是否过夜",
	Yes : '是',
	No : '否',
	ShiftList : "班次列表",
	OnThatDay : "0 - 当日",
	OnPriorDay : "1 - 上日",
	FirstOnDuty: "第一次上班刷卡",
	TimePeriod: "时段",
	Clockin: "上班",
	Clockout: "下班",
	Other: "其它",
	CanLateIn: "允许迟到时间(分)",
	CanEarlyOut: "允许早退时间(分)",
	CanRest: "中间休息(分)",
	TheFirstClockin: "1",
	Standard: "标准",
	Start: "开始",
	End: "截止",
	hrefAdjustShift : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;班次调整",
	hrefShiftRules : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;上班规则",
	AdjustShift: "调整后的班次名",
	AdjustDate: "调整日期",
	Description: "调整说明",
	DeptList: '部门列表',
	EmpList: '职员列表',
	EmpDesc: '员工说明',
	OnDutyMode: '上班方式',
	RuleDetail: '详细规则',
	NoBrushCard: '免打卡',
	SingleWeekCycle: '单周循环',
	DoubleWeekCycle: '双周循环',
	CustomCycle: '自定义循环',
	FirstWeekDate: '第一周开始日',
	ChangeDate: '生效日期',
	ShiftAdjust: '班次调整',
	ShiftRule: '上班规则',
	FirstWeek: '第一周',
	SecondWeek: '第二周',
	Shift : '班次',
	Monday : "周一",
	Tuesday : "周二",
	Wednesday : "周三",
	Thursday : "周四",
	Friday : "周五",
	Saturday : "周六",
	Sunday : "周日",
	Rest: "休息",
	Date: "日期",
	hrefHolidy : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;法定假日",
	Holiday: "法定假日",
	HolidayDate: "假期日期",
	TransposalDate: "调换日期",
	HolidayDesc: "假期说明",
	ChooseTemp: "请选择模板...",
	hrefLeave : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请假",
	LeaveList: "请假",
	LeaveType: "请假类型",
	StartTime: "开始时间",
	EndTime: "结束时间",
	Status : "状态",
	LeaveStatus : "休假状态",
	Note : "说明",
	ApproveDesc: "批注",
	Private : "事假",
	Sick : "病假",
	Annual : "年假",
	Compensatory : "补假",
	Maternity : "产假",
	Matrimony : "婚假",
	Visit : "探亲假",
	Lactation : "哺乳假",
	Funeral : "丧假",
	OtherLeave : "其它",
	Minute: "分",
	Hour: "时",
	Day: "天",
	Year: "年",
	Month: "月",
	IsAllDay: "是否整天",
	FlowData_My: "我的资料",
	FlowData_Processing: "待办资料",
	FlowData_Processed: "已办资料",
	FlowStatus_All_A: "全部",
	FlowStatus_Applied_0: "申请",
	FlowStatus_Reviewing_1: "待审",
	FlowStatus_Reviewed_1: "已审",
	FlowStatus_Approving_2: "待批",
	FlowStatus_Approved_2: "已批",
	FlowStatus_Refused_3: "拒絕",
	FlowStatus_Reviewing_With_Revoke_4: "待撤审",
	FlowStatus_Approving_With_Revode_5: "待撤批",
	FlowStatus_Ceased_C: "中止",
	YearLeave: "全年应休日数",
	AppliedLeave: "已休日数",
	ApplingLeave: "本次申请",
	RemainLeave: "剩余年假",
	hrefTrip: "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;出差",
	TripList: "出差",
	TripDes: "出差地点",
	TripThing: "拟办事项",
	hrefSign: "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;补卡",
	BrushTime: "时间",
	SingReason: "原因",
	SignList: "补卡", 
	hrefOvertime: "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;加班",
	OvertimeList: "加班",
	OTReason: "原因",
	Late: "迟到",
	Trip: "出差",
	Abnormity: "旷工",
}

var con={
	ControllerId : '设备ID',
	ControllerIdNum : '设备编号',
	ControllerIdName : '设备名称',
	Location : '位置',
	IP : '设备IP',
	MASK : '子网掩码',
	GateWay : '网关',
	DNS : 'DNS',
	DNS2 : 'DNS2',
	DHCP : '启用DHCP',
	AntiPassBackType : '防遣返',
	WorkType : '工作类型',
	ServerIP : '服务器',
	ServerIP2 : '服务器(域名)',
	StorageMode : '存储方式',
	IsFingerprint : '指纹模块',
	DoorType : '门类型',
	CardReader1 : '读卡器1（彩屏机）',
	CardReader2 : '读卡器2',
	SystemPassword : '设备密码',
	DataUpdateTime : '数据上传间隔',
	WaitTime : '屏保等待时间',
	CloseLightTime : '屏幕关闭时间',
	DownPhoto : '下载相片',
	DownFingerprint : '下载指纹',
	Sound : '音量',
	ScreenFile1 : '屏保图片1',
	ScreenFile2 : '屏保图片2',
	SyncStatus : '同步状态',
	WorkType0 : '0 - 上下班',
	WorkType1 : '1 - 进出入',
	WorkType2 : '2 - 上下班+进出入',
	StorageMode0 : '0 - 所有刷卡',
	StorageMode1 : '1 - 仅注册卡',
	DoorType0 : '0 - 单门',
	DoorType1 : '1 - 双门',
	CardReaderVal0 : '0 - 进',
	CardReaderVal1 : '1 - 出',
	Minute : '分钟',
	Second : '秒',
	SoundVal : '档',
	ConBasicData : '设备基本资料',
	IPNull : '设备IP: 此字段必需',
	MASKNull : '子网掩码: 此字段必需',
	IPIllegal : 'IP地址非法',
	MASKIllegal : '子网掩码非法',
	GateWayIllegal : '网关非法',
	DNSIllegal : 'DNS非法',
	DNS2Illegal : 'DNS2非法',
	Yes : '是',
	No : '否',
	Have : '有',
	NotHave : '无',
	SyncToCon : '同步到设备',
	SyncTitle : '将全部数据(基本资料、时间表、假期表、输入输出表及注册卡号)同步到设备',
	DHCPMsg : '启用DHCP，您可能无法得知设备IP', 
	ConHoliday : "设备假期表",
	ConSchedule : "设备时间表",
	SelRowNull : '请选择需要操作的数据行!',
	SyncEx : '同步异常',
	Edit : "修改",
	EditTitle : "修改单元格，颜色改变的单元格为可编辑，点击可进入编辑状态",
	Submit : "保存",
	SubmitTitle : "保存数据，且自动同步到设备",
	Cancel : "取消",
	CancelTitle : "取消保存",
	SaveEx : "保存数据异常",
	SyncHolidayTitle : "将假期表数据同步到设备",
	HolidayName : "假期表名称",
	HolidayTemp : "假期表模板",
	SN : "序号",
	HoliName : "假期名称",
	HolidayDate : "日期",
	Del : "删除",
	DelTitle : "删除所选记录",
	Add : "增加",
	AddTitle : "添加新记录",
	DateNull : "日期为空",
	UpScreenFail : "上传照片失败，可能原因：图片超过200K. 错误信息：",
	OutputMin : "输出值不能小于0",
	OutputMax : "输出值不能大于99999999毫秒",
	ConInout : "设备输入输出表",
	Explain : "说明",
	ScheduleName : "时间表名称",
	ScheduleTemp : "时间表模板",
	Ouput1 : "一",
	Ouput2 : "二",
	Ouput3 : "三",
	Ouput4 : "四",
	Ouput5 : "五",
	SelTemp : "选择模板",
	InputFont : "输入",
	OutputFont : "输出(毫秒)",
	MustSelSchedule : "必须选择时间表",
	SyncInoutTitle : "将输入输出表数据同步到设备",
	SyncScheduleTitle : "将时间表数据同步到设备",
	InoutName : "输入/输出表名称",
	InoutTemp : "输入/输出表模板",
	SaveData : "保存数据",
	ConManager : "设备管理",
	spanNavBasicData : "基本资料",
	aBasicData : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;基本资料",
	spanNavHoliday : "假期表",
	spanNavSchedule : "时间表",
	spanNavInOut : "输入输出表",
	spanNavRegCard : "注册卡号表",
	aHolidayController : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;设备方式",
	aHolidayTemplate : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;模板方式",
	RegCardTitle : "注册卡号",
	SyncDataTitle : "同步数据",
	spanLoad : "正在加载，请稍后...",
	SyncButtonExplain : "<B>[同步变更]</B>表示仅同步变更的数据,<br /><br /><B>[同步所有]</B>表示同步所有的数据  ",
	SyncedUnsync : "已同步/未同步",
	Synced : "已同步",
	Unsync : "未同步",
	ClickDetail : "点击查看明细",
	ViewTitle : "查看设备注册卡号明细",
	Reg : "注册",
	RegTitle : "注册人员",
	SyncRegCardTitle : "将注册卡号数据同步到设备",
	Moment : "请稍后...",
	SyncChange : "同步变更",
	SyncAll : "同步所有",
	spanDelAll : "删除所选记录？",
	ValidateMode : "验证方式",
	Schedule : "时间表",
	InOutDoor : "进出门",
	HavePhoto : "有照片",
	HaveFP : "有指纹(人脸)",
	RegCardDetail : "注册卡号明细",
	TempRegToCon : "模板注册到设备",
	RegTempExplan : "<br/><B>[覆盖注册]</B>表示用模板数据覆盖原注册卡号，即先全部清空原注册卡号，再注册（注意：清空仅清空服务器设备数据，不清空硬件上的数据）；<br /><br />&nbsp;&nbsp;&nbsp;<B>[追加注册]</B>表示将模板数据追加到设备上（注意：不会产生重复数据，已注册的卡号，不做任何修改）",
	RegNotice : "<br/>如果模板勾选<B>[仅按此条件]</B>，则只注册上述条件人员，不符合上述条件的人员将删除；否则追加注册",
	TempID : "模板ID",
	TempName : "模板名称",
	Emp : "职员",
	Controller : "设备",
	SelController : "选择设备",
	Sel : "选择",
	InOutDoorVal1 : "1 - 门1",
	InOutDoorVal2 : "2 - 门2",
	InOutDoorVal3 : "3 - 双门",
	ValidateModeVal0 : "0 - 卡",
	ValidateModeVal1 : "1 - 指纹",
	ValidateModeVal2 : "2 - 卡＋指纹",
	ValidateModeVal3 : "3 - 卡＋密码",
	ValidateModeVal5 : "5 - 人脸",
	ValidateModeVal6 : "6 - 卡+人脸",
	RegCardTemp : "注册卡号模板",
	AllEmp0 : "0 - 所有职员",
	RegToCon : "注册到设备",
	RegToConTitle : "将模板注册到设备",	
	AllEmp : "所有职员",
	AllDept : "所有部门",
	AllCon : "所有设备",
	PartCon : "部分设备",
	CoverReg : "覆盖注册",
	AdditionalReg : "追加注册",
	Week : "星期",
	Start : "开始",
	End : "截止",
	Monday : "周一",
	Tuesday : "周二",
	Wednesday : "周三",
	Thursday : "周四",
	Friday : "周五",
	Saturday : "周六",
	Sunday : "周日",
	NotHoliSchedule : "无假期时间表",
	HoliSchedule : "假期时间表",
	Times1 : "时段1",
	Times2 : "时段2",
	Times3 : "时段3",
	Times4 : "时段4",
	Times5 : "时段5",
	StartTimeNull : "[开始时间]不能为空！",
	StartTimeIllegal : "[开始时间]非法！",
	EndTimeNull : "[截止时间]不能为空！",
	EndTimeIllegal : "[截止时间]非法！",
	EndTimeLtStartTime : "[截止时间]不能小于等于[开始时间]！",
	Schedule024 : "0 - 24H进出",
	ConnStatus : '连接状态',
	IN_button : '0-按钮',
	IN_MenCi : '1-门磁',
	ByDept: '按部门',
	DeptList: '部门列表',
	ByEmp: '按职员',
	EmpList: '职员列表',
	OnlyByCond:'仅按此条件', 
	OnlyByCondDesc:'勾选后设备只注册上述条件人员，不符合上述条件的人员将删除；否则追加注册',
	TempNotice: '部门列表或职员列表为“或”的关系',
	ControllerIdType:'设备类型',
	ControllerIdSerail:'设备序列号',
	SerailIllegal:'序列号非法'
}

var rep={
	selstartTime : "选择起始日期",
	selendTime : "选择截止日期",
	Input : "输入",
	BCDate : "日期",
	BCTime : "时间",
	BCTime2 : "刷卡时间",
	ButtonReport : "按钮事件报表",
	ConfirmStr : "确定",
	ConfirmSearch : "确定查找",
	AllCon0 : "0 - 所有设备",
	AllDept1 : "1 - 所有部门",
	MyRecord0 : "0 - 我的记录",
	Status : "状态",
	AcsDetailRport : "进出明细报表",
	StatusVal99 : "99 - 所有状态",
	StatusVal0 : "0 - 合法卡",
	StatusVal1 : "1 - 非法卡",
	StatusVal2 : "2 - 非法时段",
	StatusVal3 : "3 - 非法门",
	StatusVal4 : "4 - 防遣返",
	StatusVal5 : "5 - 非法指纹",
	StatusVal6 : "6 - 密码错误",
	StatusVal7 : "7 - 未采集指纹",
	StatusVal8 : "8 - 验证方式错",
	StatusVal9 : "9 - 指纹模块故障",
	StatusShow0 : "合法卡",
	StatusShow1 : "非法卡",
	StatusShow2 : "非法时段",
	StatusShow3 : "非法门",
	StatusShow4 : "防遣返",
	StatusShow5 : "非法指纹",
	StatusShow6 : "密码错误",
	StatusShow7 : "未采集指纹",
	StatusShow8 : "验证方式错",
	StatusShow9 : "指纹模块故障",
	AcsIllegalReport : "非法进出报表",
	StatusValAllIllegal : "0 - 所有非法状态",
	AttendDetailReport : "考勤明细报表",
	selMonth : "选择月份",
	AttendOriginalCard : "考勤刷卡报表",
	Shift : "班次",
	OnDuty : "上班",
	OffDuty : "下班",
	WorkTime : "工时(M)",
	LateTime : "迟到(M)",
	LeaveEarly : "早退(M)",
	First : "第一次",
	Second : "第二次",
	Third : "第三次",
	selshowAllRowVal0 : "0 - 仅显示有刷卡数据的行",
	selshowAllRowVal1 : "1 - 显示日期范围内所有行",
	AttendOriginalReport : "考勤原始刷卡报表",
	RedColor : " 注：<font color=#FF0000>(红色)</font>表示非法卡",
	Month : "月份",
	WorkDay_0 : "出勤天数",
	WorkDay_1 : "应到天数",
	WorkTime_0 : "总工时",
	LateCount_0 : "迟到次数",
	LateTime_0 : "迟到时间",
	LeaveEarlyCount_0 : "早退次数",
	LeaveEarlyTime_0 : "早退时间",
	AbnormityCount_0 : "异常次数",
	AttendTotalReport : "考勤汇总报表",
	Report : "报表",
	spanNavAttend : "考勤",
	aAttendTotal : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;考勤汇总",
	aAttendOriginalCard : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;考勤卡",
	aAttendOriginalReport : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;原始刷卡",
	aAttendDetailReport : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;刷卡明细",
	spanNavACS : "门禁",
	aAcsDetailReport : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;进出明细",
	aAcsIllegalReport : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;非法进出",
	aAcsButtonReport : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;按钮事件",
	Monday: "一",
	Tuesday: "二",
	Wednesday: "三",
	Thursday: "四",
	Friday: "五",
	Saturday: "六",
	Sunday: "日",
	Remark: "备注",
	aAttendOtTotal: "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;加班汇总",
	AttendOtTotalReport : "加班汇总报表",
	AttendOTTime: "超时加班(M)",
	AttendOTCount: "加班次数",
	AttendRestday: "休息日加班(M)",
	AttendHoliday: "节假日加班(M)",
	AttendTotal: "总计",
	aAttendTodayOnduty: "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;今日上班",
	AttendTodayOndutyReport : "今日上班汇总报表",
	EmpCount: "编制人数",
	EmpTodayCount: "本日实到",
	Name: "姓名", 
	Sex: "性别", 
	Number: "编号", 
	CardNo: "卡号", 
	Headship: "职务", 
	FirstBrush: "第一次刷卡时间",
	JoinDate: "入职日期",
	LeaveType: "假别",
	RegEmp:"实际上班人员",
	LeaveEmp:"请假人员",
	AbsEmp:"未上班人员",
	LateEmp:"迟到人员",
	aAttendMonthTotal: "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;每月出勤",
	AttendMonthTotal: "月份出勤报表",
	Io: "进,出",
	IoDesc: "上下班",
	AttendMonthMsg: "月份出勤不支持导出CSV格式",
}

var tool={
	SelectAll : "全选",
	LoginName : "用户名",
	LoginIP : "登录机器",
	OperateTime : "日期",
	Modules : "模块",
	Actions : "操作方式",
	Objects : "对象",
	LogEvent : "日志浏览",
	tool : "工具",
	spanNavUser : "用户",
	aUsers : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用户",
	spanNavImport : "导入人事",
	aImport : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;导入人事",
	spanNavLogEvent : "日志",
	aLogEvent : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日志",
	spanNavSetCode : "设置代码",
	aSetCode : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;设置代码",
	spanNavTotal : "考勤统计",
	aTotal : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;统计",
	selCodeTypeVal1 : "1 - 国籍",
	selCodeTypeVal2 : "2 - 籍贯",
	selCodeTypeVal3 : "3 - 职务",
	selCodeTypeVal4 : "4 - 职位",
	CodeName : "名称",
	SetCode : "设置代码",
	TotalMonth : "统计月份",
	TotalDimission : "仅统计离职人员",
	TotalDialogPrompt : "<B>[立即执行统计]</B>立即执行统计，执行过程中不能离开页面，适用于数据量较小、统计能在短时间内完成（约2分钟内）；<br /><br />&nbsp;&nbsp;&nbsp;&nbsp;<B>[服务执行统计]</B>通过服务执行统计，执行过程中可以离开页面，适用于数据量较大或需花较多时间完成统计。",
	ExecTotal : "执行统计",
	CancelTotal : "取消统计",
	ImmediatelyTotal : "立即执行统计",
	ServiceTotal : "服务执行统计",
	TotalingNotLeave : "正在统计，请稍后......请不要离开页面",
	Totaling : "正在统计，请稍后...",
	LoginName : "登录名",
	Pwd : "密码",
	Role : "角色",
	VisitDept : "访问部门",
	VisitCon : "访问设备",
	OperPermDescVal1 : "系统管理员",
	OperPermDescVal2 : "一般职员",
	UserList : "用户列表",
	OperPermDescVal1Msg : "[系统管理员]拥有增加、修改、删除等操作权限",
	OperPermDescVal2Msg : "[一般职员]仅能查看数据，不能操作",
	spanNavOption: "选项配置",
	hrefAttendOption: "考勤",
	hrefLeaveOption: "休假",
	AttendOption: "考勤选项",
	StrLate: "迟到规则",
	StrLateDetail: "<div>&nbsp;大于{{textbox}}分，则视为迟到</div><div>&nbsp;{{checkbox}}计算迟到时包含此段时间</div>",
	StrEarly: "早退规则",
	StrEarlyDetail: "<div>&nbsp;小于{{textbox}}分，则视为早退</div><div>&nbsp;{{checkbox}}计算早退时包含此段时间</div>",
	StrLeaveOT: "请假超时",
	StrLeaveOTDetail: "<div>&nbsp;{{checkbox}}当天请假超过{{textbox}}分未返，则发短信</div>",
	StrAbsent: "超时未上班",
	StrAbsentDetail: "<div>&nbsp;{{checkbox}}没有请假或出差的情况下，超过{{textbox}}分未上班，则发送短</div>",
	StrAbnormity: "异常处理",
	StrAbnormityDetail: "<div>&nbsp;{{checkbox}}视为旷工</div>",
	StrOtApply: "申请加班",
	StrOtApplyDetail: "<div>&nbsp;{{checkbox}}刷上班卡&nbsp;&nbsp;{{checkbox}}刷下班卡</div>",
	StrOtOver: "超时加班",
	StrOtOverDetail: "<div>&nbsp;{{checkbox}}提前上班属于加班&nbsp;&nbsp;{{checkbox}}延时下班属于加班</div><div>&nbsp;{{radiobox}}按提前或延后的所有工时计为加班&nbsp;&nbsp;{{radiobox}}按整数倍方式计为加班，基数：{{textbox}}分",
	StrAnalyseOffDuty: "分析下班刷卡",
	StrAnalyseOffDutyDetail: "<div>&nbsp;{{radiobox}}第一次刷卡&nbsp;&nbsp;{{radiobox}}最后一次刷卡",
	StrWorkDay: "出勤天数",
	StrWorkDayDetail: "<div>&nbsp;{{radiobox}}实际出勤&nbsp;&nbsp;{{radiobox}}实际工时",
	StrWorkflow: "流程审批",
	StrWorkflowDetail: "<div>&nbsp;{{checkbox}}使用流程审批</div><div>&nbsp;{{radiobox}}指定审批人工号{{textbox}}&nbsp;{{radiobox}}管理员审批</div>",
	StrAutoTotal: "自动统计",
	StrAutoTotalDetail: "<div>&nbsp;{{checkbox}}自动统计的时间：{{textbox}}:{{textbox}}&nbsp;＊ HH:MM",
	StrTotalCycle: "结算周期",
	StrTotalCycleDetail: "<div>&nbsp;{{dropdownlist}}{{dropdownlist}}&nbsp;到&nbsp;{{dropdownlist}}{{dropdownlist}}",
	CurrentMonth: "本月",
	LastMonth: "上月",
	LeaveOption: "休假选项",
	StrAnnalEmp: "可休年假职员",
	StrAnnalEmpDetail: "<div>&nbsp;{{dropdownlist}}</div>",
	StrAnnal: "年假规则",
	StrAnnalDetail: "<div>&nbsp;可休年假的天数：{{textbox}}</div><div>&nbsp;{{radiobox}}入职{{textbox}}年后每年递增：{{textbox}}天&nbsp;&nbsp;{{radiobox}}入职{{textbox}}年后{{textbox}}天，{{textbox}}年后{{textbox}}天</div><div>&nbsp;{{checkbox}}可延续到下一年度</div><div>&nbsp;最多不超过：{{textbox}}天</div>",
	StrSkipHoliday: "请假期间的[休息日、法定假]<br />仍计为[休息日、法定假]",
	StrSkipHolidayDetail: "<div>&nbsp;{{checkbox}}事假&nbsp;{{checkbox}}病假&nbsp;{{checkbox}}补假&nbsp;{{checkbox}}产假&nbsp;{{checkbox}}婚假&nbsp;{{checkbox}}哺乳假&nbsp;{{checkbox}}其他</div><div>&nbsp;{{checkbox}}出差&nbsp;{{checkbox}}年假&nbsp;{{checkbox}}法定假&nbsp;{{checkbox}}工伤&nbsp;{{checkbox}}丧假&nbsp;{{checkbox}}探亲假</div><div>&nbsp;如果请假期间的［休息日］仍计为相应的假别,则休息日按{{textbox}}工时计为一个工作</div>",
	
}

var mon={
	AllCon : "所有设备",
	MonitorTitle : "实时监控",
	Name : "姓名",
	Card : "卡号",
	Num : "工号",
	Dept : "部门",
	Time : "时间",
	Controller : "设备",
	Property : "属性",
	Monitor : "监控",
	MonitorAll : "监控所有设备",
	StopMonitor : "停止监控",
	FullScreen : "全屏显示",
	PSelectCon : "请先选择设备",
	MonitorIsEmpty : "监控地址为空，请重新登录再试！",
	MonitorPartIng : "正在监控部分设备:",
	MonitorAllIng : "正在监控所有设备...",
	StopMonitored : "已停止监控",
	ExitFullScreen : "退出全屏",
	OpenDoor : "远程开门",
	SyncData : "立即同步",
	SyncTime : "立即校时",
	ConfirmOpenDoor : "确定远程开门?",
	SelectOutput : "选择输出点",
	OutputMsg : "输出点",
	PleSelCon : "请先选择设备！",
	ExecSuccess : "执行成功",
	MonitorBrushCard : "监控进出明细",
	MonitorDoorStatus : "监控门状态",
	DoorConnSta : "已连接网络，但门状态未知",
	DoorDisConnSta : "已断开",
	DoorCloseSta : "门已关闭",
	DoorOpenSta : "门已打开",
	DoorAlarmSta : "非法开门"
}