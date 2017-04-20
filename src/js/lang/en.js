var strloadtext= "Loading, please wait...";
var stredittext = "Edit";
var straddtext = "Add";
var strviewtext = "View";
var strdeltext = "Delete";
var strsearchtext="Search";
var strrefreshtext="Refresh";
var stralerttext = "Please select the data rows need to operate!";
var strsearchcaption ="Search";

var login={
	Title : "Cerberus iSCS user login",
	LoginUserName : "User: ",
	LoginPwd : "Password: ",
	BrowseMsg1 : "&nbsp;&nbsp;&nbsp;&nbsp;Your browser version is too low, it is recommended to use <a href='http://www.firefox.com.cn/download/'>Firefox</a>、<a href='https://www.google.com.hk/chrome/'>Google Chrome</a>、IE9 or more",
	BrowseMsg2 : "&nbsp;&nbsp;&nbsp;&nbsp;Your browser is IE, it can also be used<a href='http://www.firefox.com.cn/download/'>Firefox</a> or <a href='https://www.google.com.hk/chrome/'>Google Chrome</a> ",
	EnterUserName : "Please enter your user name",
	PwdIllegal : "Password contains illegal characters",
	LoginEx : "Login exception",
	UserTopImg : "url(Images/user_top_e.gif)",
	SubmitImg : "url(Images/submit_e.png)",
	imgBottom : "images/user_bottom3_e.gif",
	logopic : "images/logo_e.gif",
	photo : "images/photo_e.gif",
	picture : "images/picture_e.gif",
	Hello : "Hello:",
	Employees : "&nbsp;HR&nbsp;",
	Equipment : "Controller",
	Report : "Report",
	Tool : "Tool",
	LogOut : "Logout",
	Help : "Help",
	Monitor : "Monitor"
};

var hr={
	CardNoLt0 : "Card cannot be less than 0",
	SuperiorDept : "Parent Department",
	DeptName : "Department Name",
	DeptLevel : "Department Level",
	DeptList : "Department List",
	DelByOnlyOne : "Delete department can only delete one by one.",
	DelAllDept : "When you delete a parent department,the Department of all sub departments will be deleted.",
	Export : "Export",
	ExportToLocal : "Export to local",
	Refresh: "Refresh",
	View : "View",
	Search : "Search",
	Del : "Delete",
	DeptMaxLevel : "Department maximum support 10, can not choose the 10th departments when the parent department",
	Dept : "Department",
	Name : "Name",
	Num : "Number",
	Card : "Card",
	IdentityCard : "ID",
	Sex : "Sex",
	Position : "Position",
	Headship : "Headship",
	Telephone : "Telephone",
	BirthDate : "BirthDate",
	JoinDate : "JoinDate",
	Marry : "Marry",
	Knowledge : "Knowledge",
	Country : "Country",
	NativePlace : "NativePlace",
	Address : "Address",
	IncumbencyStatus : "Incumbency Status",
	CollectFP : "Collect FP",
	DimissionDate : "Dimission Date",
	DimissionReason : "Dimission Reason",
	Male : "Male",
	Female : "Female",
	Married : "Married",
	Unmarried : "Unmarried",
	Incumbent0 : "0 - Incumbent",
	Incumbent1 : "1 - Dimission",
	PersonnelList : "Employees list",
	UpPhotoFail : "Photo upload failed",
	AllDept : "All Department",
	MyRecord : "My Records",
	Browse : "Browse...",
	Delete : "Delete",
	SupportPhotoFormat : "Only supports the PNG | JPG | jpeg | GIF| BMP format images! ",//仅支持png|jpg|jpeg|gif|bmp格式图片！
	UpPhotoEx : "Photo upload exception",
	UpPhotoFail : "Upload photos failure, may cause: photos of more than 10k. error message: ",
	divEmp : "Employees",
	spanNavEmp : "Employees Data",
	hrefDept : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Department List",
	hrefEmp : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Employees List",
	spanNavAtt : "Attendance",
	hrefAttShift : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Shift"
}


var con={
	ControllerId : 'Controller ID',
	ControllerIdNum : 'Controller No.',
	ControllerIdName : 'Controller Name',
	Location : 'Location',
	IP : 'IP',
	MASK : 'MASK',
	GateWay : 'Gateway',
	DNS : 'DNS',
	DNS2 : 'DNS2',
	DHCP : 'DHCP',
	AntiPassBackType : 'AntiPass Back',
	WorkType : 'Work Type',
	ServerIP : 'Server',
	ServerIP2 : 'Server(Domain Name)',
	StorageMode : 'Storage Mode',
	IsFingerprint : 'Fingerprint Module ',
	DoorType : 'Door Type',
	CardReader1 : 'Card Reader 1(the machine)',
	CardReader2 : 'Card Reader 2',
	SystemPassword : 'Controller Password',
	DataUpdateTime : 'Data Upload Interval',
	WaitTime : 'Screen Wait Time',
	CloseLightTime : 'Screen Close Time',
	DownPhoto : 'Down Photo',
	DownFingerprint : 'Down Fingerprint',
	Sound : 'Volume',
	ScreenFile1 : 'Screen File 1',
	ScreenFile2 : 'Screen File 2',
	SyncStatus : 'Sync Status',
	WorkType0 : '0 - Clock In and Out',//0 - 上下班
	WorkType1 : '1 - Entrance & Exit',//1 - 进出入
	WorkType2 : '2 - Clock In and Out,Entrance & Exit',//2 - 上下班+进出入
	StorageMode0 : '0 - All Brushing Card',
	StorageMode1 : '1 - Registered Card Only',//1 - 仅注册卡
	DoorType0 : '0 - single Door',
	DoorType1 : '1 - Double Door',
	CardReaderVal0 : '0 - In',//0 - 进
	CardReaderVal1 : '1 - Out',//1 - 出
	Minute : 'Minute',
	Second : 'Second',
	SoundVal : ' ',//档
	ConBasicData : 'Controller Basic Data',
	IPNull : 'IP: This field is required  ',
	MASKNull : 'Mask: This field is required  ',
	IPIllegal : 'IP illegal',
	MASKIllegal : 'Mask illegal',
	GateWayIllegal : 'Gateway illegal',
	DNSIllegal : 'DNS illegal',
	DNS2Illegal : 'DNS2 illegal',
	Yes : 'Yes',
	No : 'No',
	Have : 'Have',
	NotHave : 'No',
	SyncToCon : 'Sync',//同步到设备
	SyncTitle : 'All data (basic data, schedule, holiday, input&output and Card Registration) synchronized to the controllers',
	DHCPMsg : 'Enable DHCP, you may not know the controller IP', 
	ConHoliday : "Holiday",
	ConSchedule : "Schedule ",
	SelRowNull : 'Please select the data rows need to operate!',
	SyncEx : 'Synchronized exception',
	Edit : "Edit",
	EditTitle : "Modify the cell, the color change of the cell is editable, click to enter edit mode",
	Submit : "Save",
	SubmitTitle : "Save data, and automatically sync to the controller",
	Cancel : "Cancel",
	CancelTitle : "Cancel save",
	SaveEx : "Save data exception",//保存数据异常
	SyncHolidayTitle : "The holiday data synchronized to the controller",//将假期表数据同步到设备
	HolidayName : "Holiday Name",
	HolidayTemp : "Holiday Template",
	SN : "SN",
	HoliName : "Holiday Name",
	HolidayDate : "Date",
	Del : "Delete",
	DelTitle : "Delete the selected record(s)",//删除所选记录
	Add : "Add",
	AddTitle : "Add new record",//添加新记录
	DateNull : "Date is empty",//日期为空
	UpScreenFail : "Upload photos failure, may cause: photos of more than 200k. error message: ",
	OutputMin : "Output can not be less than 0",
	OutputMax : "Output can not be greater than 99999999 milliseconds",//输出值不能大于99999999毫秒
	ConInout : "Input&Output",//设备输入输出表
	Explain : "Description",//说明
	ScheduleName : "Schedule Name",//时间表名称
	ScheduleTemp : "Schedule Template",//时间表模板
	Ouput1 : "One",//一
	Ouput2 : "Two",
	Ouput3 : "Three",
	Ouput4 : "Four",
	Ouput5 : "Five",
	SelTemp : "Select Template",
	InputFont : "Input",
	OutputFont : "Output(milliseconds)",
	MustSelSchedule : "Must select schedule ",//必须选择时间表
	SyncInoutTitle : "The input&output data synchronized to the controller",//将输入输出表数据同步到设备
	SyncScheduleTitle : "The schedule data synchronized to the controller",//将时间表数据同步到设备
	InoutName : "Input&Output Name",
	InoutTemp : "Input&Output Template",
	SaveData : "Save data",
	ConManager : "Controller",//设备管理
	spanNavBasicData : "Basic Data",//基本资料
	aBasicData : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Basic Data",
	spanNavHoliday : "Holiday",
	spanNavSchedule : "Schedule",
	spanNavInOut : "Input&Output",
	spanNavRegCard : "Card Registration",
	aHolidayController : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Controller",
	aHolidayTemplate : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Template",
	RegCardTitle : "Card Registration",
	SyncDataTitle : "Sync Data",
	spanLoad : "Loading, please wait...",
	SyncButtonExplain : "<B>[Sync change]</B> only Sync change data, <br /><B>[Sync all]</B> Sync all the data  ",
	SyncedUnsync : "Sync/UnSync",//已同步/未同步
	Synced : "Sync.",
	Unsync : "UnSync.",
	ClickDetail : "Click to view the details ",//点击查看明细
	ViewTitle : "View card registration details ",//查看设备注册卡号明细
	Reg : "Add",////注册
	RegTitle : "Add card registration ", //
	SyncRegCardTitle : "Card registration data synchronized to the controller",//将注册卡号数据同步到设备
	Moment : "Please wait...",//请稍后...
	SyncChange : "Sync Change",//同步变更
	SyncAll : "Sync All",//同步所有
	spanDelAll : "Delete the selected record(s)? ",
	ValidateMode : "Verification",//验证方式
	Schedule : "Schedule",
	InOutDoor : "Door",//进出门
	HavePhoto : "Have Photo",//有照片
	HaveFP : "Have Fingerprint",//有指纹
	RegCardDetail : "Card registration details",//注册卡号明细
	TempRegToCon : "Template to controller",//模板注册到设备
	RegTempExplan : "<B> [Covering Registration] </B> template data overwrite the original card registration , which is to clear all the original card registration, and new add (Note: Empty server controller data only, not empty hardware data );<br />&nbsp;&nbsp;&nbsp;<B> [Additional Registration] </B> templates that will append data to the controller (note: on't make duplicate data, the cards has been registered, without any modification)",
	TempID : "Template ID",//模板ID
	TempName : "Template Name",//模板名称
	Emp : "Employees",//职员
	Controller : "Controllers",//设备
	SelController : "Select controllers",//选择设备
	Sel : "Select",//选择
	InOutDoorVal1 : "1 - Door1",
	InOutDoorVal2 : "2 - Door2",
	InOutDoorVal3 : "3 - Double Doors",
	ValidateModeVal0 : "0 - Card",	//0 - 卡
	ValidateModeVal1 : "1 - Fingerprint",	//1 - 指纹
	ValidateModeVal2 : "2 - Card＋Fingerprint",	//2 - 卡＋指纹
	ValidateModeVal3 : "3 - Card＋Password",	//3 - 卡＋密码
	RegCardTemp : "Card Registration Template",//注册卡号模板
	AllEmp0 : "0 - All Employees",//0 - 所有职员
	RegToCon : "Registration to controller",//注册到设备
	RegToConTitle : "Template to controller",//将模板注册到设备	
	AllEmp : "All Employees",
	AllDept : "All Departments",
	AllCon : "All Controllers",//所有设备
	PartCon : "Part Controllers",//部分设备
	CoverReg : "Covering Registration",//覆盖注册
	AdditionalReg : "Additional Registration",//追加注册
	Week : "Week",//星期
	Start : "Start",//开始
	End : "End",//截止
	Monday : "Monday",
	Tuesday : "Tuesday",
	Wednesday : "Wednesday",
	Thursday : "Thursday",
	Friday : "Friday",
	Saturday : "Saturday",
	Sunday : "Sunday",
	NotHoliSchedule : "No Holiday Schedule",//无假期时间表
	HoliSchedule : "Holiday Schedule",//无假期时间表
	Times1 : "Time 1",//时段1
	Times2 : "Time 2",//时段2
	Times3 : "Time 3",//时段3
	Times4 : "Time 4",
	Times5 : "Time 5",
	StartTimeNull : "[Start time] can not be empty!",//[开始时间]不能为空！
	StartTimeIllegal : "[Start time] illegal!",//[开始时间]非法！
	EndTimeNull : "[End time] can not be empty!",
	EndTimeIllegal : "[End time] illegal!",
	EndTimeLtStartTime : "[End time] can not be less than [Start time]!",//[截止时间]不能小于等于[开始时间]！
	Schedule024 : "0 - 24H In & Out",
	ConnStatus : 'Conn Status',	//连接状态
	IN_button : '0-Button',
	IN_MenCi : '1-Magnetic Contact',
	ByDept: '按部門',
	DeptList: '部門列表',
	ByEmp: '按職員',
	EmpList: '職員列表',
	OnlyByCond:'仅按此条件', 
	OnlyByCondDesc:'勾选后设备只注册上述条件人员，不符合上述条件的人员将删除；否则追注册' 
}

var rep={
	selstartTime : "Select start date",//选择起始日期
	selendTime : "Select end date",
	Input : "Input",//输入
	BCDate : "Date",//
	BCTime : "Time",
	BCTime2 : "Time",
	ButtonReport : "Event Records Report",//按钮事件报表
	ConfirmStr : "Confirm",//确定
	ConfirmSearch : "Confirm Search",//确定查找
	AllCon0 : "0 - All Controllers",//0 - 所有设备
	AllDept1 : "1 - All Departments", //所有部门
	MyRecord0 : "0 - My Records",//
	Status : "Status",//状态
	AcsDetailRport : "Entrance/Exit Details Report",//进出明细报表
	StatusVal99 : "99 - All Status",//99 - 所有状态
	StatusVal0 : "0 - Valid",//0 - 合法卡
	StatusVal1 : "1 - Illegal",//1 - 非法卡
	StatusVal2 : "2 - Illegal Time Period",//2 - 非法时段
	StatusVal3 : "3 - Illegal Door",//3 - 非法门
	StatusVal4 : "4 - Anti Passback",//4 - 防遣返
	StatusVal5 : "5 - Illegal Fingerprint",//5 - 非法指纹
	StatusVal6 : "6 - Wrong Pssword",//6 - 密码错误
	StatusVal7 : "7 - Not Collect Fingerprint",//7 - 未采集指纹
	StatusVal8 : "8 - Wrong Verification Mode",//8 - 验证方式错
	StatusVal9 : "9 - Fingerprint Module Fault",//9 - 指纹模块故障
	StatusShow0 : "Valid",
	StatusShow1 : "Illegal",
	StatusShow2 : "Illegal Time Period",
	StatusShow3 : "Illegal Door",
	StatusShow4 : "Anti Passback",
	StatusShow5 : "Illegal Fingerprint",
	StatusShow6 : "Wrong Pssword",
	StatusShow7 : "Not Collect Fingerprint",
	StatusShow8 : "Wrong Verification Mode",
	StatusShow9 : "Fingerprint Module Fault",
	AcsIllegalReport : "Illegal Entrance/Exit Report",//非法进出报表
	StatusValAllIllegal : "0 - All Illegal",//所有非法状态
	AttendDetailReport : "Attendance Brushing Card Details Report",//考勤明细报表
	selMonth : "Select month",//选择月份
	AttendOriginalCard : "Attendance Card Report",//考勤刷卡报表
	Shift : "Shift",
	OnDuty : "On Duty",
	OffDuty : "Off Duty",//
	WorkTime : "Work Hours(M)",//工时(M)
	LateTime : "Late(M)",//迟到(M)
	LeaveEarly : "Leave Early(M)",//早退(M)
	First : "First",//第一次
	Second : "Second",//第二次
	Third : "Third",//第三次
	selshowAllRowVal0 : "0 - Show only have card data rows",//仅显示有刷卡数据的行
	selshowAllRowVal1 : "1 - Show all rows",//显示日期范围内所有行
	AttendOriginalReport : "Attendance Original Report",//考勤原始刷卡报表
	RedColor : " Note: <font color=#FF0000> (red) </font>illegal ",//注：<font color=#FF0000>(红色)</font>表示非法卡
	Month : "Month",//月份
	WorkDay_0 : "Attendance Days",//出勤天数
	WorkTime_0 : "Total Work Hours",//总工时
	LateCount_0 : "Late Times",//迟到次数
	LateTime_0 : "Late Time",//迟到时间
	LeaveEarlyCount_0 : "Leave Early Times",//早退次数
	LeaveEarlyTime_0 : "Leave Early Time",//早退时间
	AbnormityCount_0 : "Abnormal Times",//异常次数
	AttendTotalReport : "Attendance Total Report",//考勤汇总报表
	Report : "Report",//报表
	spanNavAttend : "Attendance",//考勤
	aAttendTotal : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Attendance Total",//考勤汇总
	aAttendOriginalCard : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Attendance Card",//考勤卡
	aAttendOriginalReport : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Attendance Original",//原始刷卡
	aAttendDetailReport : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Brushing Card",//刷卡明细
	spanNavACS : "Access Control",//门禁
	aAcsDetailReport : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Entrance/Exit Details",//进出明细
	aAcsIllegalReport : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Illegal Entrance/Exit",//非法进出
	aAcsButtonReport : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Event Records"//按钮事件
}

var tool={
	SelectAll : "All",	//全选
	LoginName : "User Name",//用户名
	LoginIP : "Login IP",//登录机器
	OperateTime : "Date",//
	Modules : "Module",//
	Actions : "Actions",//操作方式
	Objects : "Objects",//对象
	LogEvent : "Log",//
	tool : "Tool",
	spanNavUser : "Users",
	aUsers : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Users",
	spanNavImport : "Import Employees",//导入人事
	aImport : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Import Employees",
	spanNavLogEvent : "Log",
	aLogEvent : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Log",
	spanNavSetCode : "Set Code",
	aSetCode : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Set Code",
	spanNavTotal : "Attendance Count",
	aTotal : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Count",
	selCodeTypeVal1 : "1 - Country",
	selCodeTypeVal2 : "2 - NativePlace",
	selCodeTypeVal3 : "3 - Headship",
	selCodeTypeVal4 : "4 - Position",
	CodeName : "Name",
	SetCode : "Set code",
	TotalMonth : "Month",//统计月份
	TotalDimission : "Count only dimission",//仅统计离职人员
	TotalDialogPrompt : "<B>[Immediate count]</B> Immediate count, cannot leave the page, applicable to the small amount of data, count can finish in a short period of time (about 2 minutes);<br />&nbsp;&nbsp;&nbsp;&nbsp;<B>[Count by service]</B> Count by service, can leave the page, suitable for large amount of data or need to spend more time.",
	ExecTotal : "Count",//执行统计
	CancelTotal : "Cancel count",//取消统计
	ImmediatelyTotal : "Immediate count",//立即执行统计
	ServiceTotal : "Count by service",//服务执行统计
	TotalingNotLeave : "Counting,please wait......Please don't leave the page",//正在统计，请稍后......请不要离开页面
	Totaling : "Counting,please wait...",//正在统计，请稍后...
	LoginName : "Login Name",//登录名
	Pwd : "Password",
	Role : "Role",
	VisitDept : "Visit Department",//访问部门
	VisitCon : "Visit Controller",//访问设备
	OperPermDescVal1 : "System Administrator",//系统管理员
	OperPermDescVal2 : "General Employees",//一般职员
	UserList : "Users List",//用户列表
	OperPermDescVal1Msg : "[System Administrator] have to add, modify, and delete permissions",//[系统管理员]拥有增加、修改、删除等操作权限
	OperPermDescVal2Msg : "[General Employees] can only view the data, you can not operate"//[一般职员]仅能查看数据，不能操作
}

var mon={
	AllCon : "Controller",
	MonitorTitle : "Monitor",
	Name : "Name",
	Card : "Card",
	Num : "Number",
	Dept : "Dept.",
	Time : "Time",
	Controller : "Con.",
	Property : "Pro.",
	Monitor : "Monitor",
	MonitorAll : "Monitor All",
	StopMonitor : "Stop Monitor",
	FullScreen : "Full Screen",
	PSelectCon : "Please select controller",
	MonitorIsEmpty : "Monitoring address is empty, please try to log in again!",
	MonitorPartIng : "Monitoring:",
	MonitorAllIng : "Monitoring all controller...",
	StopMonitored : "Has stopped monitoring",
	ExitFullScreen : "Exit Full Screen",
	OpenDoor : "Open Door",//远程开门
	SyncData : "Sync Data",//立即同步
	SyncTime : "Calibration Time",//立即校时
	ConfirmOpenDoor : "Confirm open door?",//确定远程开门?
	SelectOutput : "Select Output",//选择输出点
	OutputMsg : "Output",//输出点
	PleSelCon : "Please select the controller!",//请先选择设备！
	ExecSuccess : "Exec success",//执行成功
	MonitorBrushCard : "Monitor Entrance/Exit",//监控进出明细
	MonitorDoorStatus : "Monitor Door",//监控门状态
	DoorConnSta : "Connected to the network, but the door state is unknown",
	DoorDisConnSta : "Disconnected",
	DoorCloseSta : "Door is closed",
	DoorOpenSta : "Door is open",
	DoorAlarmSta : "Illegal opening"
}