﻿USE CerbDb
Go
/*
********************************2015-06-22升级*******************************************************************************************
*/

INSERT ControllerInout ([ControllerId],[InoutPoint],[InoutDesc],[Out1],[Out2],[Out3],[Out4],[Out5],status) 
SELECT ControllerId,14,'门-常开',0,0,0,0,0,0 from Controllers C
	WHERE NOT EXISTS(SELECT  1  FROM ControllerInout WHERE  ControllerId=C.ControllerId and InoutPoint=14)

INSERT ControllerInout ([ControllerId],[InoutPoint],[InoutDesc],[Out1],[Out2],[Out3],[Out4],[Out5],status) 
SELECT ControllerId,15,'门-常闭',0,0,0,0,0,0 from Controllers C
	WHERE NOT EXISTS(SELECT  1  FROM ControllerInout WHERE  ControllerId=C.ControllerId and InoutPoint=15)


INSERT ControllerTemplateInout ([TemplateId],[InoutPoint],[InoutDesc],[Out1],[Out2],[Out3],[Out4],[Out5]) 
SELECT TemplateId,14,'门-常开',0,0,0,0,0 from ControllerTemplates C
	WHERE C.TemplateType='3' AND NOT EXISTS(SELECT  1  FROM ControllerTemplateInout WHERE  TemplateId=C.TemplateId and InoutPoint=14)

INSERT ControllerTemplateInout ([TemplateId],[InoutPoint],[InoutDesc],[Out1],[Out2],[Out3],[Out4],[Out5]) 
SELECT TemplateId,15,'门-常闭',0,0,0,0,0 from ControllerTemplates C
	WHERE C.TemplateType='3' AND NOT EXISTS(SELECT  1  FROM ControllerTemplateInout WHERE  TemplateId=C.TemplateId and InoutPoint=15)
/*****************************************************************************************************************************************/	


/***************************************************20150728升级，三语言******************************************************************/
IF NOT EXISTS(SELECT 1 FROM sysobjects WHERE Name='LabelText' AND  type='U')	
BEGIN
	CREATE TABLE [dbo].[LabelText](
		[RecordId] [int] IDENTITY(1,1) NOT NULL,
		[PageFolder] [nvarchar](50) NULL,
		[PageName] [nvarchar](50) NULL,
		[LabelId] [nvarchar](50) NULL,
		[LabelZhcnText] [nvarchar](150) NULL,
		[LabelZhtwText] [nvarchar](150) NULL,
		[LabelEnText] [nvarchar](300) NULL,
		[LabelCustomText] [nvarchar](300) NULL,
		constraint PK_LabelText PRIMARY KEY  ([RecordId]))
END
GO

SET IDENTITY_INSERT [LabelText] ON

IF NOT EXISTS(SELECT 1 FROM LabelText WHERE RecordId = 437)	
BEGIN

INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 1,N'Cerb',N'CheckLogin.asp',N'EnterUserName',N'请输入用户名',N'請輸入用戶名',N'Please enter user name')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 2,N'Cerb',N'LoginSystem',N'登录系统',N'登錄系統',N'Login System')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 3,N'Cerb',N'Login',N'登录',N'登錄',N'Login')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 4,N'Cerb',N'UserName',N'用户名:',N'用戶名:',N'User Name:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 5,N'Cerb',N'LoginSuccess',N'登录成功',N'登錄成功',N'Login success')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 6,N'Cerb',N'UserOrPwdError',N'用户名或密码错误！',N'用戶名或密碼錯誤！',N'Wrong user name or password!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 7,N'Cerb',N'ReLoginSystem',N'重新登录系统',N'重新登錄系統',N'Re sign system')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 8,N'Cerb',N'LoginTimeOut',N'请先登录或登录已超时！',N'請先登錄或登錄已超時！',N'Please login or login has timed out!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 9,N'Cerb',N'NoRight',N'您无权操作！',N'您無權操作！',N'You are not allowed to operation!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 10,N'Employees',N'PartError',N'参数错误',N'參數錯誤',N'Parameter error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 11,N'Employees',N'NoRight',N'您无权操作！',N'您無權操作！',N'You are not allowed to operation!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 12,N'Employees',N'DeptNameUsed',N'部门名称已使用',N'部門名稱已使用',N'Department name already used')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 13,N'Employees',N'DeptMaxTenLevel',N'部门最大支持10级',N'部門最大支持10級',N'Maximum 10 of Department level')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 14,N'Employees',N'DeptNotDel',N'该部门或子部门下有人事资料，不能删除',N'該部門或子部門下有人事資料，不能刪除',N'The department or sub department under employees data and cannot be deleted')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 15,N'Employees',N'EmpData',N'人事资料',N'人事資料',N'Employees Data')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 16,N'Employees',N'Emp',N'人事',N'人事',N'HR')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 17,N'Employees',N'DeptList',N'部门列表',N'部門列表',N'Department List')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 18,N'Employees',N'Dept',N'部门',N'部門',N'Department')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 19,N'Employees',N'DeptName',N'部门名称',N'部門名稱',N'Department Name')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 20,N'Employees',N'EditName',N'修改后名称',N'修改後名稱',N'the Name')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 21,N'Employees',N'ExecSuccess',N'执行成功',N'執行成功',N'Execute success')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 22,N'Employees',N'Yes',N'是',N'是',N'Yes')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 23,N'Employees',N'No',N'否',N'否',N'No')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 24,N'Employees',N'CardUsed',N'卡号已使用',N'卡號已使用',N'Card already used')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 25,N'Employees',N'NumberUsed',N'工号已使用',N'工號已使用',N'Number already used')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 26,N'Employees',N'EmpList',N'人事列表',N'人事列表',N'Employees List')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 27,N'Employees',N'Num',N'工号',N'工號',N'Number')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 28,N'Employees',N'EmpID',N'员工ID',N'員工ID',N'Employee ID')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 29,N'Employees',N'EditNum',N'修改后工号',N'修改後工號',N'the number')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 30,N'Employees',N'AutoReg',N'自动注册',N'自動註冊',N'Auto registration')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 31,N'Employees',N'AutoRegMsgFail',N'注册卡号,模板自动注册到设备失败,员工工号:',N'註冊卡號,範本自動註冊到設備失敗,員工工號:',N'registration card number, the template automatically registered to the device failure, employee number:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 32,N'Employees',N'AutoRegMsg',N'注册卡号,模板自动注册到设备,员工工号:',N'註冊卡號,範本自動註冊到設備,員工工號:',N'registration card number, the template automatically registered to the device, employee number:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 33,N'Employees',N'PhotoBeyond10K',N'上传照片不能超过10K',N'上傳照片不能超過10K',N'Upload photos cannot be greater than 10K')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 34,N'Employees',N'DelPhotoFail',N'图片删除失败',N'圖片刪除失敗',N'Image delete failed')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 35,N'Employees',N'DelPhotoSuccess',N'图片删除成功',N'圖片刪除成功',N'Image delete success')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 36,N'Employees',N'UpPhotoFail',N'图片上传失败',N'圖片上傳失敗',N'Image upload failed')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 37,N'Employees',N'UpPhotoSuccess',N'图片上传成功',N'圖片上傳成功',N'Image upload success')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 38,N'Employees',N'Shifts',N'班次',N'班次',N'Shift')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 39,N'Employees',N'ShiftName',N'班次名称',N'班次名稱',N'Shift Name')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 40,N'Employees',N'ShiftTime',N'标准工时',N'標準工時',N'Working Hour')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 41,N'Employees',N'Night',N'过夜',N'過夜',N'Overnight')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 42,N'Employees',N'FirstOnDuty',N'第一次上班刷卡',N'第一次上班刷卡',N'First Clock In')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 43,N'Employees',N'Degree',N'时段数',N'時段數',N'Time Period')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 44,N'Employees',N'StretchShift',N'弹性班次',N'彈性班次',N'Flexible Shifts')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 45,N'Employees',N'Times',N'时段',N'時段',N'Time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 46,N'Employees',N'Duty',N'标准',N'標準',N'Standard')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 47,N'Employees',N'Start',N'开始',N'開始',N'Start')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 48,N'Employees',N'End',N'截止',N'截止',N'End')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 49,N'Employees',N'OnDuty',N'上班',N'上班',N'On Duty')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 50,N'Employees',N'OffDuty',N'下班',N'下班',N'Off Duty')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 51,N'Employees',N'Other',N'其它',N'其它',N'Other')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 52,N'Employees',N'AcalculateLate',N'允许迟到时间(分)',N'允許遲到時間(分)',N'Allow Late Time (min)')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 53,N'Employees',N'AcalculateEarly',N'允许早退时间(分)',N'允許早退時間(分)',N'Allow Early Leave Time (min)')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 54,N'Employees',N'ArestTime',N'中间休息(分)',N'中間休息(分)',N'Rest(min)')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 55,N'Employees',N'Edit',N'修改',N'修改',N'Edit')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 56,N'Employees',N'Submit',N'保存',N'保存',N'Save')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 57,N'Employees',N'Cancel',N'取消',N'取消',N'Cancel')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 58,N'Employees',N'Refresh',N'刷新',N'刷新',N'Refresh')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 59,N'Employees',N'LastDay',N'上日',N'上日',N'Previous Day')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 60,N'Employees',N'CurrentDay',N'当日',N'當日',N'Same Day')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 61,N'Employees',N'Hour',N'小时',N'小時',N'Hour')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 62,N'Employees',N'AcalculateLateDigital',N'[允许迟到]必须为数字',N'[允許遲到]必須為數位',N'[Allow late] must be numeric')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 63,N'Employees',N'AcalculateEarlyDigital',N'[允许早退]必须为数字',N'[允許早退]必須為數位',N'[Allow early leave] must be numeric')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 64,N'Employees',N'ArestTimeDigital',N'[中间休]息必须为数字',N'[中間休]息必須為數位',N'[rest] must be numeric')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 65,N'Employees',N'onDutyNull',N'[上班标准时间]不能为空！',N'[上班標準時間]不能為空！',N'[On duty standard time] can not be empty!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 66,N'Employees',N'onDutyStartNull',N'[上班开始时间]不能为空！',N'[上班開始時間]不能為空！',N'[On duty start time] can not be empty!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 67,N'Employees',N'onDutyEndNull',N'[上班截止时间]不能为空！',N'[上班截止時間]不能為空！',N'[On duty end time] can not be empty!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 68,N'Employees',N'onDutyIllegal',N'[上班标准时间]非法！',N'[上班標準時間]非法！',N'[On duty standard time] illegal!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 69,N'Employees',N'onDutyStartIllegal',N'[上班开始时间]非法！',N'[上班開始時間]非法！',N'[On duty start time] illegal!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 70,N'Employees',N'onDutyEndIllegal',N'[上班截止时间]非法！',N'[上班截止時間]非法！',N'[On duty end time] illegal!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 71,N'Employees',N'OnDutyLtonDutyStart',N'[上班标准时间]不能小于[上班开始时间]！',N'[上班標準時間]不能小於[上班開始時間]！',N'[On duty standard time]can not be less than[On duty start time]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 72,N'Employees',N'OnDutyEndLtOnDuty',N'[上班截止时间]不能小于[上班标准时间]！',N'[上班截止時間]不能小於[上班標準時間]！',N'[On duty end time]can not be less than[On duty standard time]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 73,N'Employees',N'offDutyNull',N'[下班标准时间]不能为空！',N'[下班標準時間]不能為空！',N'[Off duty standard time] can not be empty!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 74,N'Employees',N'offDutyStartNull',N'[下班开始时间]不能为空！',N'[下班開始時間]不能為空！',N'[Off duty start time] can not be empty!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 75,N'Employees',N'offDutyEndNull',N'[下班截止时间]不能为空！',N'[下班截止時間]不能為空！',N'[Off duty end time] can not be empty!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 76,N'Employees',N'offDutyIllegal',N'[下班标准时间]非法！',N'[下班標準時間]非法！',N'[Off duty standard time] illegal!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 77,N'Employees',N'offDutyStartIllegal',N'[下班开始时间]非法！',N'[下班開始時間]非法！',N'[Off duty start time] illegal!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 78,N'Employees',N'offDutyEndIllegal',N'[下班截止时间]非法！',N'[下班截止時間]非法！',N'[Off duty end time] illegal!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 79,N'Employees',N'offDutyLtoffDutyStart',N'[下班标准时间]不能小于[下班开始时间]！',N'[下班標準時間]不能小於[下班開始時間]！',N'[Off duty standard time]can not be less than[Off duty start time]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 80,N'Employees',N'offDutyEndLtoffDuty',N'[下班截止时间]不能小于[下班标准时间]！',N'[下班截止時間]不能小於[下班標準時間]！',N'[Off duty end time]can not be less than[Off duty standard time]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 81,N'Employees',N'FirstOffDutyLtOnDutyEnd',N'第一次[下班开始时间]不能小于[上班截止时间]！',N'第一次[下班開始時間]不能小於[上班截止時間]！',N'First [Off duty start time]can not be less than[On duty end time]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 82,N'Employees',N'SecondOffDutyLtOnDutyEnd',N'第二次[下班开始时间]不能小于[上班截止时间]！',N'第二次[下班開始時間]不能小於[上班截止時間]！',N'Second [Off duty start time]can not be less than[On duty end time]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 83,N'Employees',N'ThirdOffDutyLtOnDutyEnd',N'第三次[下班开始时间]不能小于[上班截止时间]！',N'第三次[下班開始時間]不能小於[上班截止時間]！',N'Third [Off duty start time]can not be less than[On duty end time]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 84,N'Employees',N'ShiftNameNull',N'[班次名称]不能为空',N'[班次名稱]不能為空',N'[Shift name] can not be empty!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 85,N'Employees',N'ShiftTimeNull',N'[标准工时]不能为空',N'[標準工時]不能為空',N'[Working hour] can not be empty!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 86,N'Employees',N'ShiftTimeDigital',N'[标准工时]必须为数字',N'[標準工時]必須為數位',N'[Working hour] must be numeric')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 87,N'Employees',N'DegreeNull',N'[时段数]不能为空',N'[時段數]不能為空',N'[Time Period] can not be empty!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 88,N'Employees',N'AOnDutyLtStartN',N'第一次上班开始时间必须早于上班标准时间或您没选择［过夜］！',N'第一次上班開始時間必須早於上班標準時間或您沒選擇［過夜］！',N'The first on duty start time must be earlier than the on duty standard time or you do not select [overnight]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 89,N'Employees',N'AOnDutyLtEndN',N'第一次上班标准时间必须早于上班截止时间或您没选择［过夜］！',N'第一次上班標準時間必須早于上班截止時間或您沒選擇［過夜］！',N'The first on duty standard time must be earlier than the on duty end time or you do not select [overnight]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 90,N'Employees',N'AOnDutyEndLtAoffDutyStartN',N'第一次上班截止时间必须早于下班开始时间或您没选择［过夜］！',N'第一次上班截止時間必須早于下班開始時間或您沒選擇［過夜］！',N'The first on duty end time must be earlier than the off duty start time or you do not select [overnight]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 91,N'Employees',N'AoffDutyLtStartN',N'第一次下班开始时间必须早于下班标准时间或您没选择［过夜］！',N'第一次下班開始時間必須早於下班標準時間或您沒選擇［過夜］！',N'The first off duty start time must be earlier than the off duty standard time or you do not select [overnight]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 92,N'Employees',N'AoffDutyEndLtoffDutyN',N'第一次下班标准时间必须早于下班截止时间或您没选择［过夜］！',N'第一次下班標準時間必須早于下班截止時間或您沒選擇［過夜］！',N'The first off duty standard time must be earlier than the off duty end time or you do not select [overnight]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 93,N'Employees',N'AonDutyEndLtAonDuty',N'第一次上班标准时间必须早于上班截止时间！',N'第一次上班標準時間必須早於上班截止時間！',N'The first on duty standard time must be earlier than the on duty end time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 94,N'Employees',N'AonDutyEndMtAonDutyStart',N'一个班次的时间段必须在二十四小时之内！',N'一個班次的時間段必須在二十四小時之內！',N'The time period of a shift must be within twenty-four hours!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 95,N'Employees',N'AoffDutyStartLtAonDutyEnd',N'第一次上班截止时间必须早于下班开始时间！',N'第一次上班截止時間必須早於下班開始時間！',N'The first on duty end time must be earlier than the off duty start time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 101,N'Employees',N'BonDutyStartLtAoffDutyEndN',N'第一次下班截止时间必须早于第二次上班开始时间或您没选择［过夜］！',N'第一次下班截止時間必須早於第二次上班開始時間或您沒選擇［過夜］！',N'The first off duty end time must be earlier than the second on duty start time or you do not select [overnight]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 97,N'Employees',N'AoffDutyLtAoffDutyStart',N'第一次下班开始时间必须早于下班标准时间！',N'第一次下班開始時間必須早於下班標準時間！',N'The first off duty start time must be earlier than the off duty standard time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 102,N'Employees',N'BOnDutyLtStartN',N'第二次上班开始时间必须早于上班标准时间或您没选择［过夜］！',N'第二次上班開始時間必須早於上班標準時間或您沒選擇［過夜］！',N'The second on duty start time must be earlier than the on duty standard time or you do not select [overnight]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 99,N'Employees',N'AoffDutyEndLtAoffDuty',N'第一次下班标准时间必须早于下班截止时间！',N'第一次下班標準時間必須早於下班截止時間！',N'The first off duty standard time must be earlier than the off duty end time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 103,N'Employees',N'BOnDutyLtEndN',N'第二次上班标准时间必须早于上班截止时间或您没选择［过夜］！',N'第二次上班標準時間必須早于上班截止時間或您沒選擇［過夜］！',N'The second on duty standard time must be earlier than the on duty end time or you do not select [overnight]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 104,N'Employees',N'BOnDutyEndLtBoffDutyStartN',N'第二次上班截止时间必须早于下班开始时间或您没选择［过夜］！',N'第二次上班截止時間必須早于下班開始時間或您沒選擇［過夜］！',N'The second on duty end time must be earlier than the off duty start time or you do not select [overnight]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 105,N'Employees',N'BoffDutyLtStartN',N'第二次下班开始时间必须早于下班标准时间或您没选择［过夜］！',N'第二次下班開始時間必須早於下班標準時間或您沒選擇［過夜］！',N'The second off duty start time must be earlier than the off duty standard time or you do not select [overnight]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 106,N'Employees',N'BoffDutyEndLtoffDutyN',N'第二次下班标准时间必须早于下班截止时间或您没选择［过夜］！',N'第二次下班標準時間必須早于下班截止時間或您沒選擇［過夜］！',N'The second off duty standard time must be earlier than the off duty end time or you do not select [overnight]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 107,N'Employees',N'BonDutyLtBonDutyStart',N'第二次上班开始时间必须早于上班标准时间！',N'第二次上班開始時間必須早於上班標準時間！',N'The second on duty start time must be earlier than the on duty standard time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 108,N'Employees',N'BonDutyEndLtBonDuty',N'第二次上班标准时间必须早于上班截止时间！',N'第二次上班標準時間必須早於上班截止時間！',N'The second on duty standard time must be earlier than the on duty end time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 109,N'Employees',N'BoffDutyStartLtBonDutyEnd',N'第二次上班截止时间必须早于下班开始时间！',N'第二次上班截止時間必須早於下班開始時間！',N'The second on duty end time must be earlier than the off duty start time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 110,N'Employees',N'BoffDutyLtBoffDutyStart',N'第二次下班开始时间必须早于下班标准时间！',N'第二次下班開始時間必須早於下班標準時間！',N'The second off duty start time must be earlier than the off duty standard time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 111,N'Employees',N'BoffDutyEndLtBoffDuty',N'第二次下班标准时间必须早于下班截止时间！',N'第二次下班標準時間必須早於下班截止時間！',N'The second off duty standard time must be earlier than the off duty end time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 112,N'Employees',N'BonDutyStartLtAoffDutyEnd',N'第一次下班截止时间必须早于第二次上班开始时间！',N'第一次下班截止時間必須早於第二次上班開始時間！',N'The first off duty end time must be earlier than the second on duty start time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 113,N'Employees',N'ConDutyStartLtBoffDutyEndN',N'第二次下班截止时间必须早于第三次上班开始时间或您没选择［过夜］！',N'第二次下班截止時間必須早於第三次上班開始時間或您沒選擇［過夜］！',N'The second off duty end time must be earlier than the third on duty start time or you do not select [overnight]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 114,N'Employees',N'ConDutyLtConDutyStartN',N'第三次上班开始时间必须早于上班标准时间或您没选择［过夜］！',N'第三次上班開始時間必須早於上班標準時間或您沒選擇［過夜］！',N'The third on duty start time must be earlier than the on duty standard time or you do not select [overnight]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 115,N'Employees',N'ConDutyEndLtConDutyN',N'第三次上班标准时间必须早于上班截止时间或您没选择［过夜］！',N'第三次上班標準時間必須早于上班截止時間或您沒選擇［過夜］！',N'The third on duty standard time must be earlier than the on duty end time or you do not select [overnight]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 116,N'Employees',N'CoffDutyStartLtConDutyEndN',N'第三次上班截止时间必须早于下班开始时间或您没选择［过夜］！',N'第三次上班截止時間必須早于下班開始時間或您沒選擇［過夜］！',N'The third on duty end time must be earlier than the off duty start time or you do not select [overnight]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 117,N'Employees',N'CoffDutyLtCoffDutyStartN',N'第三次下班开始时间必须早于下班标准时间或您没选择［过夜］！',N'第三次下班開始時間必須早於下班標準時間或您沒選擇［過夜］！',N'The third off duty start time must be earlier than the off duty standard time or you do not select [overnight]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 118,N'Employees',N'CoffDutyEndLtCoffDutyN',N'第三次下班标准时间必须早于下班截止时间或您没选择［过夜］！',N'第三次下班標準時間必須早于下班截止時間或您沒選擇［過夜］！',N'The third off duty standard time must be earlier than the off duty end time or you do not select [overnight]!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 119,N'Employees',N'ConDutyLtConDutyStart',N'第三次上班开始时间必须早于上班标准时间！',N'第三次上班開始時間必須早於上班標準時間！',N'The third on duty start time must be earlier than the on duty standard time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 120,N'Employees',N'ConDutyEndLtConDuty',N'第三次上班标准时间必须早于上班截止时间！',N'第三次上班標準時間必須早於上班截止時間！',N'The third on duty standard time must be earlier than the on duty end time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 121,N'Employees',N'CoffDutyStartLtConDutyEnd',N'第三次上班截止时间必须早于下班开始时间！',N'第三次上班截止時間必須早於下班開始時間！',N'The third on duty end time must be earlier than the off duty start time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 122,N'Employees',N'CoffDutyLtCoffDutyStart',N'第三次下班开始时间必须早于下班标准时间！',N'第三次下班開始時間必須早於下班標準時間！',N'The third off duty start time must be earlier than the off duty standard time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 123,N'Employees',N'CoffDutyEndLtCoffDuty',N'第三次下班标准时间必须早于下班截止时间！',N'第三次下班標準時間必須早於下班截止時間！',N'The third off duty standard time must be earlier than the off duty end time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 124,N'Employees',N'ConDutyStartLtBoffDutyEnd',N'第二次下班截止时间必须早于第三次上班开始时间！',N'第二次下班截止時間必須早於第三次上班開始時間！',N'The second off duty end time must be earlier than the third on duty start time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 125,N'Employees',N'StretchOnDutyLtOnDutyStart',N'弹性班上班开始时间必须早于上班标准时间！',N'彈性班上班開始時間必須早於上班標準時間！',N'Flexible shifts on duty start time must be earlier than the on duty standard time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 126,N'Employees',N'StretchOffDutyLtOnDuty',N'弹性班上班标准时间必须早于下班标准时间！',N'彈性班上班標準時間必須早於下班標準時間！',N'Flexible shifts on duty standard time must be earlier than the off duty standard time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 127,N'Employees',N'StretchOffDutyEndLtOffDuty',N'弹性班下班标准时间必须早于下班截止时间！',N'彈性班下班標準時間必須早於下班截止時間！',N'Flexible shifts off duty standard time must be earlier than the off duty end time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 128,N'Employees',N'StretchOnDutyLtOffDuty',N'弹性班下班标准时间必须早于上班标准时间！',N'彈性班下班標準時間必須早於上班標準時間！',N'Flexible shifts off duty standard time must be earlier than the on duty standard time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 129,N'Employees',N'DataIllegal',N'输入数据不符合过夜要求！',N'輸入資料不符合過夜要求！',N'Input data does not meet the requirements overnight!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 130,N'Employees',N'ShiftNameIllegal',N'班次名非法！',N'班次名非法！',N'[Shift Name] illegal!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 131,N'Employees',N'IllegalOperate',N'非法操作！',N'非法操作！',N'Illegal operation!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 132,N'Employees',N'EditFail',N'修改失败',N'修改失敗',N'Modification failed')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 133,N'Employees',N'Attend',N'考勤',N'考勤',N'Attendance')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 134,N'Equipment',N'SyncEd',N'已同步',N'已同步',N'Sync.')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 135,N'Equipment',N'UnSync',N'未同步',N'未同步',N'UnSync.')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 136,N'Equipment',N'BoardTypeAcs',N'0-门禁控制',N'0-門禁控制',N'0-Access Control')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 137,N'Equipment',N'ConNumUsed',N'设备编号已使用',N'設備編號已使用',N'Device Number already used')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 138,N'Equipment',N'ConNameUsed',N'设备名称已使用',N'設備名稱已使用',N'Device Name already used')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 139,N'Equipment',N'ConIPUsed',N'IP已使用',N'IP已使用',N'IP already used')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 140,N'Equipment',N'AddConError',N'增加设备出错',N'增加設備出錯',N'Add device error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 141,N'Equipment',N'AddHolidayError',N'增加假期表出错',N'增加假期表出錯',N'Add holiday table error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 142,N'Equipment',N'Schedule024',N'0 - 24H进出',N'0 - 24H進出',N'0 - 24H In & Out')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 143,N'Equipment',N'AddScheduleError',N'增加时间表出错',N'增加時間表出錯',N'Add schedule table error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 144,N'Equipment',N'RD1Valid',N'读卡器1-有效卡',N'讀卡器1-有效卡',N'Card Reader1-Valid Card')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 145,N'Equipment',N'RD1Illegal',N'读卡器1-非法卡',N'讀卡器1-非法卡',N'Card Reader1-Illegal Card')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 146,N'Equipment',N'RD1IllegalTime',N'读卡器1-非法时段',N'讀卡器1-非法時段',N'Card Reader1-Illegal Time Period')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 147,N'Equipment',N'RD1AntiPassBack',N'读卡器1-防遣返',N'讀卡器1-防遣返',N'Card Reader1-Anti Passback')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 148,N'Equipment',N'RD2Valid',N'读卡器2-有效卡',N'讀卡器2-有效卡',N'Card Reader2-Valid Card')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 149,N'Equipment',N'RD2Illegal',N'读卡器2-非法卡',N'讀卡器2-非法卡',N'Card Reader2-Illegal Card')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 150,N'Equipment',N'RD2IllegalTime',N'读卡器2-非法时段',N'讀卡器2-非法時段',N'Card Reader2-Illegal Time Period')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 151,N'Equipment',N'RD2AntiPassBack',N'读卡器2-防遣返',N'讀卡器2-防遣返',N'Card Reader2-Anti Passback')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 152,N'Equipment',N'DoorNO',N'门-常开',N'門-常開',N'Door-NO')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 153,N'Equipment',N'DoorNC',N'门-常闭',N'門-常閉',N'Door-NC')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 154,N'Equipment',N'AddInOutError',N'增加设备输入输出表出错',N'增加設備輸入輸出表出錯',N'Add controller input/output table error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 155,N'Equipment',N'AddDataSyncError',N'增加设备同步表数据出错',N'增加設備同步表資料出錯',N'Add controller sync table error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 156,N'Equipment',N'EditConError',N'修改设备出错',N'修改設備出錯',N'Modify controller error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 157,N'Equipment',N'DelConError',N'删除设备出错',N'刪除設備出錯',N'Delete controller error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 158,N'Equipment',N'ConID',N'设备ID',N'設備ID',N'Device ID')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 159,N'Equipment',N'WorkType2',N'2 - 上下班+进出入',N'2 - 上下班+進出入',N'2 - Clock in and out,Entrance & Exit')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 160,N'Equipment',N'ConHoliday',N'设备假期表',N'設備假期表',N'Holiday Table')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 161,N'Equipment',N'SN',N'序号',N'序號',N'SN')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 162,N'Equipment',N'HolidayName',N'假期名称',N'假期名稱',N'Holiday Name')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 163,N'Equipment',N'EditHolidayError',N'修改假期表出错',N'修改假期表出錯',N'Modified holiday table error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 164,N'Equipment',N'SyncHolidayError',N'同步假期表出错',N'同步假期表出錯',N'Synchronization holiday table error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 165,N'Equipment',N'ConManage',N'设备管理',N'設備管理',N'Controller')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 166,N'Equipment',N'BasicData',N'基本资料',N'基本資料',N'Basic Data')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 167,N'Equipment',N'Holiday',N'假期表',N'假期表',N'Holiday')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 168,N'Equipment',N'DeviceMode',N'设备方式',N'設備方式',N'Controller')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 169,N'Equipment',N'TempMode',N'模板方式',N'範本方式',N'Template')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 170,N'Equipment',N'HolidayName2',N'假期表名称',N'假期表名稱',N'Holiday Name')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 171,N'Equipment',N'HolidayTempDetail',N'假期表模板明细',N'假期表範本明細',N'Holiday Template Details')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 172,N'Equipment',N'TempNameUsed',N'名称已使用',N'名稱已使用',N'Name already used')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 173,N'Equipment',N'EditHolidayName2',N'修改后假期表名称',N'修改後假期表名稱',N'Holiday table name')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 174,N'Equipment',N'PhotoBeyond200K',N'上传图片不能超过200K',N'上傳圖片不能超過200K',N'Upload image cannot be greater than 200K')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 175,N'Equipment',N'SyncInoutError',N'同步输入输出表出错',N'同步輸入輸出表出錯',N'Sync input/output table error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 176,N'Equipment',N'Inout',N'输入输出表',N'輸入輸出表',N'Input&Output')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 177,N'Equipment',N'AddInoutTempError',N'增加输入输出模板出错',N'增加輸入輸出範本出錯',N'Add  input&output template error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 178,N'Equipment',N'AddInoutTempDetailError',N'增加输入输出模板明细出错',N'增加輸入輸出範本明細出錯',N'Add  input&output template details error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 179,N'Equipment',N'EditInoutTempError',N'修改输入输出模板出错',N'修改輸入輸出範本出錯',N'Modified input&output template error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 180,N'Equipment',N'DelInoutTempError',N'删除输入输出模板出错',N'刪除輸入輸出範本出錯',N'Delete input&output template error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 181,N'Equipment',N'InoutTemp',N'输入输出模板',N'輸入輸出範本',N'Input&Output Template')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 182,N'Equipment',N'InoutTempName',N'输入输出模板名称',N'輸入輸出範本名稱',N'Input&Output Template Name')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 183,N'Equipment',N'EditInoutTempName',N'修改后输入输出模板名称',N'修改後輸入輸出範本名稱',N'Input&output template name')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 184,N'Equipment',N'InoutTempDetail',N'输入输出模板明细',N'輸入輸出範本明細',N'Input&Output Template Details')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 185,N'Equipment',N'Template',N'模板',N'範本',N'Template')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 186,N'Equipment',N'RegCard.asp',N'RegMode',N'注册方式：',N'註冊方式：',N'Registration Mode：')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 187,N'Equipment',N'RegCard.asp',N'RegModeVal0',N'待注册',N'待註冊',N'Registration Pending')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 188,N'Equipment',N'RegCard.asp',N'RegModeVal1',N'部门',N'部門',N'Department')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 189,N'Equipment',N'RegCard.asp',N'RegModeVal2',N'模板',N'範本',N'Template')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 190,N'Equipment',N'RegCard.asp',N'RegModeVal3',N'条件',N'條件',N'Condition')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 191,N'Equipment',N'RegCard.asp',N'EmpList',N'职员列表：',N'職員列表：',N'Employees:')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 192,N'Equipment',N'RegCard.asp',N'ConList',N'设备列表：',N'設備列表：',N'Controllers:')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 193,N'Equipment',N'RegCard.asp',N'ValidateMode',N'验证方式：',N'驗證方式：',N'Verification:')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 194,N'Equipment',N'RegCard.asp',N'ValidateModeVal0',N'0 - 卡',N'0 - 卡',N'0 - Card')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 195,N'Equipment',N'RegCard.asp',N'ValidateModeVal1',N'1 - 指纹',N'1 - 指紋',N'1 - Fingerprint')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 196,N'Equipment',N'RegCard.asp',N'ValidateModeVal2',N'2 - 卡＋指纹',N'2 - 卡＋指紋',N'2 - Card＋Fingerprint')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 197,N'Equipment',N'RegCard.asp',N'ValidateModeVal3',N'3 - 卡＋密码',N'3 - 卡＋密碼',N'3 - Card＋Password')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 198,N'Equipment',N'RegCard.asp',N'Floor',N'楼层(信箱)：',N'樓層(信箱)：',N'Floor(Mailbox):')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 199,N'Equipment',N'RegCard.asp',N'Custom',N'自定义',N'自訂',N'Custom')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 200,N'Equipment',N'RegCard.asp',N'FloorMu',N'多层用,或.分开',N'多層用,或.分開',N'Multi-layer,or.separate')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 201,N'Equipment',N'RegCard.asp',N'InOutSchedule',N'进出时间表：',N'進出時間表：',N'Schedule:')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 202,N'Equipment',N'RegCard.asp',N'InOutDoor',N'进出门：',N'進出門：',N'Door:')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 203,N'Equipment',N'RegCard.asp',N'InOutDoorVal1',N'1 - 门1',N'1 - 門1',N'1 - Door1')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 204,N'Equipment',N'RegCard.asp',N'InOutDoorVal2',N'2 - 门2',N'2 - 門2',N'2 - Door2')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 205,N'Equipment',N'RegCard.asp',N'InOutDoorVal3',N'3 - 双门',N'3 - 雙門',N'3 - Double Doors')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 206,N'Equipment',N'RegCard.asp',N'DeptName',N'部门名称',N'部門名稱',N'Department Name')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 207,N'Equipment',N'RegCard.asp',N'TempName',N'模板名称',N'範本名稱',N'Template Name')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 208,N'Equipment',N'RegCard.asp',N'AllDept0',N'0 - 所有部门',N'0 - 所有部門',N'0 - All department')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 209,N'Equipment',N'RegCard.asp',N'NotSelEmp',N'没有选择职员！',N'沒有選擇職員！',N'Do not select employees!')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 210,N'Equipment',N'RegCard.asp',N'NotSelCon',N'没有选择设备！',N'沒有選擇設備！',N'Do not select controllers!')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 211,N'Equipment',N'RegCard.asp',N'NotSelValidate',N'没有选择验证方式！',N'沒有選擇驗證方式！',N'Do not select verification!')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 212,N'Equipment',N'RegCard.asp',N'CheckPwdMsg1',N'请先将',N'請先將',N'')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 213,N'Equipment',N'RegCard.asp',N'CheckPwdMsg2',N'用户的密码修改为[数字]型，然后再修改其验证方式为[卡+密码]！',N'使用者的密碼修改為[數位]型，然後再修改其驗證方式為[卡+密碼]！',N'user''s password is changed to [digital], and then modify the verification method for the [card + password]!')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 214,N'Equipment',N'RegCardEdit.asp',N'RegScheduleErr1',N'注册时间表到设备:',N'註冊時間表到設備:',N'Registration schedule to controller:')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 215,N'Equipment',N'RegCardEdit.asp',N'RegScheduleErr2',N'时出错！',N'時出錯！',N'error!')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 216,N'Equipment',N'RegCardEdit.asp',N'RegCardErr1',N'注册卡号到设备:',N'註冊卡號到設備:',N'Card registration to controller:')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 217,N'Equipment',N'RegCardEdit.asp',N'RegCardErr2',N'时出错！',N'時出錯！',N'error!')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 218,N'Equipment',N'RegCardEdit.asp',N'RegSyncToConErr1',N'同步到设备:',N'同步到設備:',N'Synchronized to the controller:')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 219,N'Equipment',N'RegCardEdit.asp',N'RegSyncToConErr2',N'时出错！',N'時出錯！',N'error!')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 220,N'Equipment',N'RegCardEdit.asp',N'DelRegErr1',N'删除注册卡号:',N'刪除註冊卡號:',N'Delete card')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 221,N'Equipment',N'RegCardEdit.asp',N'DelRegErr2',N'时出错！',N'時出錯！',N'error!')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 222,N'Equipment',N'RegCardEdit.asp',N'RegCard',N'注册卡号表',N'註冊卡號表',N'Card Registration')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 223,N'Equipment',N'RegCardEdit.asp',N'RegCard2',N'注册卡号',N'註冊卡號',N'Card Registration')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 230,N'Equipment',N'RegCardTemplateToControllerEdit.asp',N'RegConFail',N'注册到设备时失败！',N'註冊到設備時失敗！',N'Registration to controller failed!')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 231,N'Equipment',N'RegCardTemplateToControllerEdit.asp',N'TempRegCon',N'模板注册到设备',N'範本註冊到設備',N'Template to controller')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 232,N'Equipment',N'RegCardTemplateToControllerEdit.asp',N'AlreadyTempRegCon',N'已将所选模板注册到了相应的设备',N'已將所選範本註冊到了相應的設備',N'The selected template has been registered to the controllers.')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 233,N'Equipment',N'RegCardTemplateEdit.asp',N'AllCon0',N'0 - 所有设备',N'0 - 所有設備',N'0 - All Controllers')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 234,N'Equipment',N'RegCardTemplateEdit.asp',N'RegCardTemp',N'注册卡号模板',N'註冊卡號範本',N'Card Registration Template')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 235,N'Equipment',N'RegCardTemplateEdit.asp',N'EditRegTempName',N'修改后模板名称',N'修改後範本名稱',N'Template name')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 236,N'Equipment',N'ScheduleControllerEdit.asp',N'EditScheduleError',N'修改时间表出错',N'修改時間表出錯',N'Modified schedule error')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 237,N'Equipment',N'ScheduleControllerEdit.asp',N'SyncScheduleError',N'同步时间表出错',N'同步時間表出錯',N'Synchronized schedule error')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 238,N'Equipment',N'ScheduleControllerEdit.asp',N'Schedule',N'时间表',N'時間表',N'Schedule')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 239,N'Equipment',N'ScheduleControllerEdit.asp',N'ConSchedule',N'设备时间表',N'設備時間表',N'Schedule Table')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 240,N'Equipment',N'ScheduleTemplateEdit.asp',N'ScheduleDetail',N'时间表模板明细',N'時間表範本明細',N'Schedule Template Details')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 241,N'Equipment',N'ScheduleTemplateEdit.asp',N'AddScheduleTempError',N'增加时间模板出错',N'增加時間範本出錯',N'Add schedule template error')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 242,N'Equipment',N'ScheduleTemplateEdit.asp',N'AddScheduleTempDetailError',N'增加时间模板明细出错',N'增加時間範本明細出錯',N'Add schedule template details error')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 243,N'Equipment',N'ScheduleTemplateEdit.asp',N'EditScheduleTempError',N'修改时间模板出错',N'修改時間範本出錯',N'Modified schedule template error')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 244,N'Equipment',N'ScheduleTemplateEdit.asp',N'DelScheduleTempError',N'删除时间模板出错',N'刪除時間範本出錯',N'Delete schedule template error')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 245,N'Equipment',N'ScheduleTemplateEdit.asp',N'ScheduleName',N'时间表名称',N'時間表名稱',N'Schedule Name')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 246,N'Equipment',N'ScheduleTemplateEdit.asp',N'EditScheduleName',N'修改后时间表名称',N'修改後時間表名稱',N'Schedule name')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 247,N'Equipment',N'SyncData.asp',N'SyncBasicError',N'同步基本资料出错',N'同步基本資料出錯',N'Synchronized basic data error')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 248,N'Equipment',N'SyncData.asp',N'SyncHolidayError',N'同步假期表出错',N'同步假期表出錯',N'Synchronized holiday error')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 249,N'Equipment',N'SyncData.asp',N'SyncScheduleError',N'同步时间表出错',N'同步時間表出錯',N'Synchronized schedule error')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 250,N'Equipment',N'SyncData.asp',N'SyncInOutError',N'同步输入输出表出错',N'同步輸入輸出表出錯',N'Synchronized input&output error')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 251,N'Equipment',N'SyncData.asp',N'SyncRegcardError',N'同步注册卡号表出错',N'同步註冊卡號表出錯',N'Synchronized card Registration error')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 252,N'Equipment',N'SyncData.asp',N'SyncAll',N'同步所有数据',N'同步所有資料',N'Synchronized All Data')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 253,N'Equipment',N'SyncData.asp',N'SyncPart',N'同步部分数据',N'同步部分資料',N'Synchronized Partl Data')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 254,N'Equipment',N'SyncData.asp',N'SyncChange',N'同步变更数据',N'同步變更資料',N'Synchronized modify data')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 255,N'Equipment',N'search.asp',N'ConditionSelect',N'条件选择',N'條件選擇',N'Condition')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 256,N'Equipment',N'search.asp',N'Name',N'姓名',N'姓名',N'Name')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 257,N'Equipment',N'search.asp',N'Number',N'工号',N'工號',N'Card')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 258,N'Equipment',N'search.asp',N'Card',N'卡号',N'卡號',N'Number')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 259,N'Equipment',N'search.asp',N'Sex',N'性别',N'性別',N'Sex')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 260,N'Equipment',N'search.asp',N'Headship',N'职务',N'職務',N'Headship')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 261,N'Equipment',N'search.asp',N'Position',N'职位',N'職位',N'Position')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 262,N'Equipment',N'search.asp',N'Marry',N'婚否',N'婚否',N'Marry')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 263,N'Equipment',N'search.asp',N'Knowledge',N'学历',N'學歷',N'Knowledge')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 264,N'Equipment',N'search.asp',N'Country',N'国籍',N'國籍',N'Country')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 265,N'Equipment',N'search.asp',N'NativePlace',N'籍贯',N'籍貫',N'NativePlace')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 266,N'Equipment',N'search.asp',N'IncumbencyStatus',N'在职状态',N'在職狀態',N'Incumbency Status')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 267,N'Equipment',N'search.asp',N'eq',N'等于&nbsp;&nbsp;&nbsp;&nbsp;',N'等於&nbsp;&nbsp;&nbsp;&nbsp;',N'Equal')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 268,N'Equipment',N'search.asp',N'ne',N'不等&nbsp;&nbsp;&nbsp;&nbsp;',N'不等&nbsp;&nbsp;&nbsp;&nbsp;',N'Not equal')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 269,N'Equipment',N'search.asp',N'reset',N'重置',N'重置',N'Reset')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 270,N'Equipment',N'search.asp',N'search',N'查找',N'查找',N'Search')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 271,N'Equipment',N'search.asp',N'cn',N'包含&nbsp;&nbsp;&nbsp;&nbsp;',N'包含&nbsp;&nbsp;&nbsp;&nbsp;',N'Contain')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 272,N'Equipment',N'search.asp',N'nc',N'不包含',N'不包含',N'Not contain')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 273,N'Equipment',N'search.asp',N'lt',N'小于&nbsp;&nbsp;&nbsp;&nbsp;',N'小於&nbsp;&nbsp;&nbsp;&nbsp;',N'Less than')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 274,N'Equipment',N'search.asp',N'le',N'小于等于',N'小於等於',N'Less than or equal')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 275,N'Equipment',N'search.asp',N'gt',N'大于&nbsp;&nbsp;&nbsp;&nbsp;',N'大於&nbsp;&nbsp;&nbsp;&nbsp;',N'More than')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 276,N'Equipment',N'search.asp',N'ge',N'大于等于',N'大於等於',N'More than or equal')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 277,N'Equipment',N'search.asp',N'Male',N'男',N'男',N'Male')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 278,N'Equipment',N'search.asp',N'Female',N'女',N'女',N'Female')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 279,N'Equipment',N'search.asp',N'Married',N'已婚',N'已婚',N'Married')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 280,N'Equipment',N'search.asp',N'Unmarried',N'未婚',N'未婚',N'Unmarried')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 281,N'Equipment',N'search.asp',N'Knowledge1',N'小学',N'小學',N'Primary School')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 282,N'Equipment',N'search.asp',N'Knowledge2',N'初中',N'初中',N'Middle School')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 283,N'Equipment',N'search.asp',N'Knowledge3',N'中专',N'中專',N'Technical Secondary School')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 284,N'Equipment',N'search.asp',N'Knowledge4',N'高中',N'高中',N'Senior Middle School')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 285,N'Equipment',N'search.asp',N'Knowledge5',N'大专',N'大專',N'Junior College')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 286,N'Equipment',N'search.asp',N'Knowledge6',N'本科',N'本科',N'Undergraduate Course')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 287,N'Equipment',N'search.asp',N'Knowledge7',N'硕士',N'碩士',N'Master')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 288,N'Equipment',N'search.asp',N'Knowledge8',N'博士',N'博士',N'Doctor')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 289,N'Equipment',N'search.asp',N'IncumbencyStatus0',N'0-在职',N'0-在職',N'0 - Incumbent')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 290,N'Equipment',N'search.asp',N'IncumbencyStatus1',N'1-离职',N'1-離職',N'1 - Dimission')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 291,N'Report',N'AttendOriginalCardDetailList.asp',N'FreeCard',N'免卡',N'免卡',N'Card Exempted')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 292,N'Report',N'AttendOriginalCardTotal.asp',N'WorkDay0',N'出勤天数:',N'出勤天數:',N'Attendance Days:')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 293,N'Report',N'AttendOriginalCardTotal.asp',N'WorkTime0',N'总工时(H):',N'總工時(H):',N'Total Work Hours(H):')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 294,N'Report',N'AttendOriginalCardTotal.asp',N'LateTime0',N'退到时间(M):',N'退到時間(M):',N'Late Time(M):')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 295,N'Report',N'AttendOriginalCardTotal.asp',N'LeaveEarlyTime0',N'早退时间(M):',N'早退時間(M):',N'Leave Early Time(M):')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 296,N'Report',N'AttendTotalList.asp',N'Hour',N'小时',N'小時',N'Hour')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 297,N'Report',N'AttendTotalList.asp',N'Minute',N'分',N'分',N'Minute')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 298,N'Report',N'ExportData.asp',N'ExportFail',N'导出失败',N'匯出失敗',N'Export failed')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 299,N'Tool',N'ExportDataExec.asp',N'ConBasicData',N'设备基本资料',N'設備基本資料',N'Controller Basic Data')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 300,N'Tool',N'ExportDataExec.asp',N'ConInout',N'设备输入输出表',N'設備輸入輸出表',N'Input&Output')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 301,N'Tool',N'ExportDataExec.asp',N'ConRegCard',N'设备注册卡号表',N'設備註冊卡號表',N'Card Registration')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 302,N'Tool',N'ExportDataExec.asp',N'ConRegCardDetail',N'设备注册卡号明细',N'設備註冊卡號明細',N'Card Registration Details')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 303,N'Tool',N'ExportDataExec.asp',N'attend',N'考勤原始刷卡',N'考勤原始刷卡',N'Attendance Original Card')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 304,N'Tool',N'ExportDataExec.asp',N'attenddetail',N'考勤明细',N'考勤明細',N'Attendance Details')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 305,N'Tool',N'ExportDataExec.asp',N'attendcard',N'考勤卡',N'考勤卡',N'Attendance')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 306,N'Tool',N'ExportDataExec.asp',N'attendtotal',N'考勤汇总',N'考勤匯總',N'Attendance Total')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 307,N'Tool',N'ExportDataExec.asp',N'acsdetail',N'进出明细',N'進出明細',N'Entrance/Exit Details')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 308,N'Tool',N'ExportDataExec.asp',N'acsillegal',N'非法进出',N'非法進出',N'Illegal Entrance/Exit')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 309,N'Tool',N'ExportDataExec.asp',N'acsbuttonreport',N'按钮事件明细',N'按鈕事件明細',N'Event')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 310,N'Tool',N'ExportDataExec.asp',N'users',N'用户列表',N'用戶列表',N'Users List')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 311,N'Tool',N'ExportDataExec.asp',N'logevent',N'日志',N'日誌',N'Log')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 312,N'Tool',N'ExportDataExec.asp',N'ExportComplete',N'导出完成！',N'匯出完成！',N'Export done!')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 313,N'Tool',N'ExportDataExec.asp',N'ExportFail',N'导出失败',N'匯出失敗',N'Export failed!')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 314,N'Tool',N'ExportDataExec.asp',N'ExportFailMsg',N'\n请尝试：工具 -> Internet 选项 -> 安全 -> \n自定义安全级别 -> ActiveX 控件与插件 ->\n对未标记为可安全执行脚本的ActiveX 控件初始化并执行\n设置为[启用]',N'\n請嘗試：工具 -> Internet 選項 -> 安全 -> \n自訂安全級別 -> ActiveX 控制項與外掛程式 ->\n對未標記為可安全執行腳本的ActiveX 控制項初始化並執行\n設置為[啟用]',N'\n Try: Tools -> Internet Options -> Security -> \n Custom Security Level -> ActiveX controls and plug-ins -> \n unlabeled Initialize and safe for Script ActiveX controls \n is set to [enable]')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 315,N'Tool',N'ExportDataUI.asp',N'Exporting',N'正在导出',N'正在匯出',N'Exporting')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 316,N'Tool',N'ExportDataUI.asp',N'SelExportFormat',N'选择导出格式',N'選擇匯出格式',N'Select export')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 317,N'Tool',N'ExportDataUI.asp',N'Path',N'&nbsp;路径&nbsp;',N'&nbsp;路徑&nbsp;',N'&nbsp;Path &nbsp;')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 318,N'Tool',N'ExportDataUI.asp',N'SelPath',N'选择路径',N'選擇路徑',N'Select path')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 319,N'Tool',N'ExportDataUI.asp',N'ExportCSV',N'导出CSV',N'匯出CSV',N'Export CSV')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 320,N'Tool',N'ExportDataUI.asp',N'ExportExcel',N'导出Excel',N'匯出Excel',N'Export Excel')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 321,N'Tool',N'ExportDataUI.asp',N'ExportAlertMsg',N'提示：CSV导出性能、速度优于Excel.<br />数据量较大时(约大于2万)，建议使用IE导出',N'提示：CSV匯出性能、速度優於Excel.<br />資料量較大時(約大於2萬)，建議使用IE匯出',N'Tip: CSV export performance, is faster than Excel. <br /> amount of data is large (greater than about 20,000), it is recommended to use IE to export.')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 322,N'Tool',N'ExportDataUI.asp',N'ExportAlertMsg2',N'提示：CSV导出性能、速度优于Excel.',N'提示：CSV匯出性能、速度優於Excel.',N'Tip: CSV export performance, is faster than Excel.')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 323,N'Tool',N'ExportDataUI.asp',N'FileNameNull',N'请输入文件名',N'請輸入檔案名',N'Enter a file name')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 324,N'Tool',N'ExportEmployeesTitle',N'部门,姓名,工号,卡号,身份证,性别,职务,职位,电话,Email,出生日期,入职日期,婚否,学历,国籍,籍贯,通信地址,在职状态,含指纹,含照片',N'部門,姓名,工號,卡號,身份證,性別,職務,職位,電話,Email,出生日期,入職日期,婚否,學歷,國籍,籍貫,通信地址,在職狀態,含指紋,含照片',N'Department,Name,Card,Number,ID,Sex,Headship,Position,Telephone,Email,BirthDate,Joindate,Marry,Knowledge,Country,NativePlace,Address,Incumbency Status,Fingerprints,Photos')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 325,N'Tool',N'ExportDepartmentsTitle',N'部门ID,部门名称,部门代码',N'部門ID,部門名稱,部門代碼',N'Department ID,Department Name,Department Code')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 326,N'Tool',N'ExportControllersTitle',N'设备ID,设备编号,设备名称,位置,设备IP,工作类型,服务器,同步状态',N'設備ID,設備編號,設備名稱,位置,設備IP,工作類型,伺服器,同步狀態',N'Controller ID,Number,Name,Location,IP,Work Type,Server,Sync status')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 327,N'Tool',N'ExportRegisterdetailTitle',N'设备编号,部门,姓名,工号,卡号,验证方式,时间表,进出门,有照片,有指纹,同步状态',N'設備編號,部門,姓名,工號,卡號,驗證方式,時間表,進出門,有照片,有指紋,同步狀態',N'Controller Number,Department,Name,Number,Card,Verification,Schedule,Door,Photos,Fingerprints,Sync status')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 328,N'Tool',N'ExportUsersTitle',N'登录名,姓名,角色',N'登錄名,姓名,角色',N'Login,Name,Role')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 329,N'Tool',N'ExportLogeventTitle',N'用户名,登录机器,日期,模块,操作方式,对象',N'用戶名,登錄機器,日期,模組,操作方式,對象',N'User name,Login machine,date,Module,Operation,Target')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 330,N'Tool',N'ExportAttendtotalTitle',N'部门,姓名,工号,月份,出勤天数,总工时,迟到次数,迟到时间,早退次数,早退时间,异常次数',N'部門,姓名,工號,月份,出勤天數,總工時,遲到次數,遲到時間,早退次數,早退時間,異常次數',N'Department,Name,Number,Month,Attendance Days,Total Work Hours,Late Times,Late Time,Leave Early Times,Leave Early Time,Abnormal times')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 331,N'Tool',N'ExportAcsbuttonreportTitle',N'设备,输入,日期,时间',N'設備,輸入,日期,時間',N'Controller,Input,Date,Time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 332,N'Tool',N'ExportattendTitle',N'部门,姓名,工号,卡号,刷卡日期,刷卡时间',N'部門,姓名,工號,卡號,刷卡日期,刷卡時間',N'Department,Name,Number,Card,Date,Time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 333,N'Tool',N'ExportAttenddetailTitle',N'部门,姓名,工号,卡号,设备编号,位置,刷卡日期,刷卡时间,状态(0:合法;1:非法)',N'部門,姓名,工號,卡號,設備編號,位置,刷卡日期,刷卡時間,狀態(0:合法;1:非法)',N'Department,Name,Number,Card,Controller Number,Location,Date,Time,Status(0:Valid;1:Illegal)')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 334,N'Tool',N'ExportAcsdetailTitle',N'部门,姓名,工号,卡号,设备编号,位置,刷卡日期,刷卡时间,状态(0:合法)',N'部門,姓名,工號,卡號,設備編號,位置,刷卡日期,刷卡時間,狀態(0:合法)',N'Department,Name,Number,Card,Controller Number,Location,Date,Time,Status(0:Validl)')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 335,N'Tool',N'ExportAttendcardTitle',N'日期,上班（一）,下班（一）,上班（二）,下班（二）,上班（三）,下班（三）,工时（M）,迟到（M）,早退（M）',N'日期,上班（一）,下班（一）,上班（二）,下班（二）,上班（三）,下班（三）,工時（M）,遲到（M）,早退（M）',N'Date,On Duty(One),Off Duty(One),On Duty(Two),Off Duty(Two),On Duty(Three),Off Duty(Three), Work Hours(M), Late(M), Leave Early(M)')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 336,N'Tool',N'ExportDept',N'部门：',N'部門：',N'Department:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 337,N'Tool',N'ExportNumber',N'工号：',N'工號：',N'Number:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 338,N'Tool',N'ExportName',N'姓名：',N'姓名：',N'Name:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 339,N'Tool',N'Tool',N'工具',N'工具',N'Tool')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 340,N'Tool',N'Import.asp',N'ImportAlertMsg',N'请启用ActiveX控件设置！\n请尝试：工具 -> Internet 选项 -> 安全 -> \n自定义安全级别 -> ActiveX 控件与插件 ->\n对未标记为可安全执行脚本的ActiveX 控件初始化并执行\n设置为[启用]',N'請啟用ActiveX控制項設置！\n請嘗試：工具 -> Internet 選項 -> 安全 -> \n自訂安全級別 -> ActiveX 控制項與外掛程式 ->\n對未標記為可安全執行腳本的ActiveX 控制項初始化並執行\n設置為[啟用]',N'Please enable ActiveX controls! \n Try: Tools -> Internet Options -> Security -> \n Custom Security Level -> ActiveX controls and plug-ins -> \n unlabeled Initialize and safe for Script ActiveX controls \n is set to [enable]')
INSERT [LabelText] ([RecordId],[PageFolder],[PageName],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 341,N'Tool',N'Import.asp',N'PleaseSelect',N'====请选择====',N'====請選擇====',N'====Select====')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 342,N'Tool',N'PleaseSelectExcelFile',N'请选择要上传的Excel文件！',N'請選擇要上傳的Excel檔！',N'Please select the Excel file to upload!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 343,N'Tool',N'PleaseSelectExcelTable',N'请选择要导入的Excel表！',N'請選擇要導入的Excel表！',N'Please select to import Excel table!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 344,N'Tool',N'DeptNull',N'部门不能为空！',N'部門不能為空！',N'Department cannot be empty!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 345,N'Tool',N'NameNull',N'姓名不能为空！',N'姓名不能為空！',N'Name cannot be empty!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 346,N'Tool',N'NumberNull',N'工号不能为空！',N'工號不能為空！',N'Number cannot be empty!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 347,N'Tool',N'HeadshipNull',N'职务不能为空！',N'職務不能為空！',N'Headship cannot be empty!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 348,N'Tool',N'JoinDateNull',N'请选择入职日期！',N'請選擇入職日期！',N'Please select join date!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 349,N'Tool',N'EditByNumber',N'请选择员工工号，修改人事以员工工号为索引关联人事资料！',N'請選擇員工工號，修改人事以員工工號為索引關聯人事資料！',N'Please select the employees number, modify the employeesto the employees number is the index associated employees data!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 350,N'Tool',N'SelectOptions',N'请选择要修改的项！',N'請選擇要修改的項！',N'Please select the item you want to modify!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 351,N'Tool',N'SaveDataEx',N'保存数据异常',N'保存資料異常',N'Save data exception')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 352,N'Tool',N'prompt',N'提示',N'提示',N'Prompt')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 353,N'Tool',N'OnlyIEUsed',N'该功能请在IE下使用',N'該功能請在IE下使用',N'Please use this feature in IE')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 354,N'Tool',N'EmpImport',N'人事导入',N'人事導入',N'Employees Import')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 355,N'Tool',N'FileName',N'文件名：',N'檔案名：',N'File Name:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 356,N'Tool',N'Browse',N'浏览...',N'流覽...',N'Browse...')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 357,N'Tool',N'AddEmp',N'新增人事',N'新增人事',N'Add Employees')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 358,N'Tool',N'EditEmp',N'修改人事',N'修改人事',N'Edit Employees')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 359,N'Tool',N'TableName',N'表名：',N'表名：',N'Table:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 360,N'Tool',N'FiledName',N'字段对应：',N'欄位對應：',N'Field:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 361,N'Tool',N'Dept',N'部门：',N'部門：',N'Department:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 362,N'Tool',N'Name1',N'姓名：',N'姓名：',N'Name:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 363,N'Tool',N'Number',N'工号：',N'工號：',N'Number:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 364,N'Tool',N'Card',N'卡号：',N'卡號：',N'Card:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 365,N'Tool',N'Ident',N'身份证号：',N'身份證號：',N'ID:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 366,N'Tool',N'Sex',N'性别：',N'性別：',N'Sex:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 367,N'Tool',N'Headship',N'职务：',N'職務：',N'Headship:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 368,N'Tool',N'Position',N'职位：',N'職位：',N'Position:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 369,N'Tool',N'Tel',N'电话：',N'電話：',N'Telephone:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 370,N'Tool',N'Email',N'Email：',N'Email：',N'Email:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 371,N'Tool',N'BirthDate',N'出生日期：',N'出生日期：',N'BirthDate:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 372,N'Tool',N'JoinDate',N'入职日期：',N'入職日期：',N'JoinDate:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 373,N'Tool',N'Marry',N'婚否：',N'婚否：',N'Marry')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 374,N'Tool',N'Knowledge',N'学历：',N'學歷：',N'Knowledge:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 375,N'Tool',N'Country',N'国籍：',N'國籍：',N'Country:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 376,N'Tool',N'NativePlace',N'籍贯：',N'籍貫：',N'NativePlace:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 377,N'Tool',N'Address',N'通信地址：',N'通信地址：',N'Address:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 378,N'Tool',N'CardDigital',N'卡号只能是数字',N'卡號只能是數字',N'Card can only be numeric')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 379,N'Tool',N'CardMt10',N'卡号不能大于10位',N'卡號不能大於10位',N'Card cannot be greater than 10-bit')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 380,N'Tool',N'JoinDateFormatError',N'入职时间格式不对，应为（YYYY-MM-DD）',N'入職時間格式不對，應為（YYYY-MM-DD）',N'Join date format is wrong, should be (YYYY-MM-DD)')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 381,N'Tool',N'Married2',N'婚',N'婚',N'Married')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 382,N'Tool',N'Unmarried2',N'否',N'否',N'No')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 383,N'Tool',N'BirthDateFormatError',N'出生日期格式不对，应为（YYYY-MM-DD）',N'出生日期格式不對，應為（YYYY-MM-DD）',N'Birth date format is wrong, should be (YYYY-MM-DD)')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 384,N'Tool',N'EditFailMsg1',N'修改第',N'修改第',N'Modify the')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 385,N'Tool',N'EditFailMsg2',N'条人事资料出错！',N'條人事資料出錯！',N'employees error!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 386,N'Tool',N'ImportEdit',N'导入修改',N'導入修改',N'Import the modified')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 387,N'Tool',N'Records',N'记录数:',N'記錄數:',N'Records')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 388,N'Tool',N'EditSuccessMsg1',N'修改',N'修改',N'Modify')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 389,N'Tool',N'EditSuccessMsg2',N'条人事资料成功！',N'條人事資料成功！',N'employees success!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 390,N'Tool',N'AddFailMsg1',N'导入第',N'導入第',N'Import the')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 391,N'Tool',N'AddFailMsg2',N'条人事资料出错！',N'條人事資料出錯！',N'employees error!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 392,N'Tool',N'ImportAdd',N'导入新增',N'導入新增',N'Import add')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 393,N'Tool',N'AutoRegFail',N'注册卡号,模板自动注册到设备失败',N'註冊卡號,範本自動註冊到設備失敗',N'Card registration, the template automatically registered to the controller fails')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 394,N'Tool',N'AutoRegSuccess',N'注册卡号,模板自动注册到设备',N'註冊卡號,範本自動註冊到設備',N'Card registration, the template automatically registered to the controller')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 395,N'Tool',N'AddImportSuccMsg1',N'导入',N'導入',N'Import')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 396,N'Tool',N'AddImportSuccMsg2',N'条人事资料成功！',N'條人事資料成功！',N'employees success!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 397,N'Tool',N'FollowingNum',N'以下工号重复：',N'以下工號重複：',N'Following number repeated:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 398,N'Tool',N'NameUsed',N'名称已使用',N'名稱已使用',N'Name already used')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 399,N'Tool',N'SetCode',N'设置代码',N'設置代碼',N'Set code')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 400,N'Tool',N'Code',N'代码',N'代碼',N'Code')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 401,N'Tool',N'Name',N'名称',N'名稱',N'Name')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 402,N'Tool',N'EditLastName',N'修改后的名称',N'修改後的名稱',N'The name')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 403,N'Tool',N'Totaling',N'正在统计中，请稍后...',N'正在統計中，請稍後...',N'Counting,please wait...')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 404,N'Tool',N'AttendTotal',N'考勤统计',N'考勤統計',N'Attendance Count')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 405,N'Tool',N'Total',N'统计',N'統計',N'Count')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 406,N'Tool',N'CancelTotal',N'取消统计',N'取消統計',N'Cancel Count')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 407,N'Tool',N'CancelSuccess',N'取消成功',N'取消成功',N'Cancel success')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 408,N'Tool',N'DataEx',N'数据异常！',N'數據異常！',N'Data exception')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 409,N'Tool',N'OtherUserTotal',N'可能有其他的用户正在统计,统计不能继续！',N'可能有其他的用戶正在統計,統計不能繼續！',N'There may be other users are counting, count can not continue!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 410,N'Tool',N'ThisMonth',N'本月',N'本月',N'This Month')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 411,N'Tool',N'TotalCycleError',N'统计周期设置有误！无法统计！',N'統計週期設置有誤！無法統計！',N'Count cycle setting is wrong! Unable to compile count!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 412,N'Tool',N'EndDateLtStartDate',N'统计截止日期小于开始日期！无法统计！',N'統計截止日期小於開始日期！無法統計！',N'Count end date is less than the start date! Unable to count!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 413,N'Tool',N'datDateLtStartDate',N'不能统计将来的数据！',N'不能統計將來的資料！',N'No count data in the future!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 414,N'Tool',N'TotalDeleteMonth',N'不能统计已删除月份之前的数据！',N'不能統計已刪除月份之前的資料！',N'No count data that has been deleted before the month!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 415,N'Tool',N'ExecEx',N'执行异常！',N'執行異常！',N'Execution exception!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 416,N'Tool',N'ImmediatelyTotal',N'立即统计',N'立即統計',N'Immediate Count')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 417,N'Tool',N'TotalDimission',N'仅统计离职:',N'僅統計離職:',N'Count only the dimission:')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 418,N'Tool',N'TotalComplete',N'统计完成！',N'統計完成！',N'Count done!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 419,N'Tool',N'ServiceTotal',N'服务执行统计',N'服務執行統計',N'Count by Service')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 420,N'Tool',N'ExecIng',N'正在执行',N'正在執行',N'Counting')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 421,N'Tool',N'EditSelfInfo',N'您仅能修改自己信息！',N'您僅能修改自己資訊！',N'You can only modify your own information!')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 422,N'Tool',N'LoginUsed',N'登录名已使用',N'登錄名已使用',N'Login name already used')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 423,N'Tool',N'EmpUsed',N'该职员已对应另一个用户',N'該職員已對應另一個用戶',N'The employee had another user')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 424,N'Tool',N'AddUserError',N'增加用户出错',N'增加用戶出錯',N'Add user error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 425,N'Tool',N'AddUserRoleError',N'增加用户权限出错',N'增加用戶許可權出錯',N'Add user permissions error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 426,N'Tool',N'EditUserError',N'修改用户出错',N'修改用戶出錯',N'Modify user error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 427,N'Tool',N'EditUserRoleError',N'修改用户权限出错',N'修改用戶許可權出錯',N'Modify user permissions error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 428,N'Tool',N'DelUserError',N'删除用户出错',N'刪除用戶出錯',N'Delete user error')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 429,N'Tool',N'UserSet',N'用户设置',N'用戶設置',N'User Set')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 430,N'Tool',N'User2',N'用户',N'用戶',N'User')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 431,N'Tool',N'UserName2',N'用户名',N'用戶名',N'User Name')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 432,N'Tool',N'UserID',N'用户ID',N'用戶ID',N'User ID')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 433,N'Tool',N'EditLastUser',N'修改后用户名',N'修改後用戶名',N'The user name')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 434,N'Cerb',N'strLogAdd',N'增加',N'增加',N'Add')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 435,N'Cerb',N'strLogEdit',N'修改',N'修改',N'Edit')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 436,N'Cerb',N'strLogDel',N'删除',N'刪除',N'Delete')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 437,N'Cerb',N'strLogSync',N'同步',N'同步',N'Sync')

END  

SET IDENTITY_INSERT [LabelText] OFF

GO
--20160702升级 增加实时监控
IF NOT EXISTS(SELECT 1 FROM LabelText WHERE RecordId = 443)	
BEGIN
SET IDENTITY_INSERT [LabelText] ON
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 438,N'Monitor',N'strMonitor',N'实时监控',N'即時監控',N'Monitor')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 439,N'Monitor',N'DoorStatus',N'监控门状态',N'監控門狀態',N'Monitor Door')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 440,N'Monitor',N'OpenDoor',N'远程开门',N'遠程開門',N'Open Door')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 441,N'Monitor',N'SyncData',N'立即同步',N'立即同步',N'Sync Data')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 442,N'Monitor',N'SyncTime',N'立即校时',N'立即校時',N'Calibration Time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 443,N'Monitor',N'Controller',N'设备',N'設備',N'Controller')
SET IDENTITY_INSERT [LabelText] OFF
END
GO

INSERT ControllerDataSync ([ControllerId],[SyncType]) 
SELECT ControllerId,'online' from Controllers C
	WHERE NOT EXISTS(SELECT  1  FROM ControllerDataSync WHERE  ControllerId=C.ControllerId and [SyncType]='online')
Go
	
/******************************修改注册模板 更新***************************************************************************************************/
GO

--增加新字段ControllerTemplates
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'ControllerTemplates') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'ControllerTemplates') AND name = N'DepartmentCode')
	ALTER TABLE ControllerTemplates ADD DepartmentCode NTEXT NULL --保存部门列表条件	


IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'ControllerTemplates') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'ControllerTemplates') AND name = N'EmployeeCode')
	ALTER TABLE ControllerTemplates ADD EmployeeCode NTEXT NULL --保存职员列表条件	

	
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'ControllerTemplates') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'ControllerTemplates') AND name = N'OtherCode')
	ALTER TABLE ControllerTemplates ADD OtherCode NTEXT NULL --预留,后续可能再增加的条件	


IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'ControllerTemplates') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'ControllerTemplates') AND name = N'OnlyByCondition')
	ALTER TABLE ControllerTemplates ADD OnlyByCondition BIT NOT NULL DEFAULT(0) --仅按此条件, 1为界面勾选了,0或null 表示没勾选


--添加LabelText
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Equipment', NULL, 'Yes', '是', '是', 'Yes', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Equipment' AND LabelId = 'Yes');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Equipment', NULL, 'No', '否', '否', 'No', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Equipment' AND LabelId = 'No');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Equipment', NULL, 'RegEmpCondition', '未设置注册员工条件', '未設置註冊員工條件', 'Not set the staff conditions', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Equipment' AND LabelId = 'RegEmpCondition');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'AllDept', '所有部门', '所有部門', ' All Departments', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'AllDept');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'AllEmp', '所有职员', '所有職員', ' All Employees', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'AllDept');


--按单个模板注册到设备
if exists (select name from sysObjects where name = 'pRegCardTemplateRegister' and type = 'p')
	drop Procedure pRegCardTemplateRegister
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[pRegCardTemplateRegister]
( --模板Id
  @TemplateId VARCHAR(50),
  --注册方式，0为追加注册（不会产生重复数据，已注册的卡号，不做任何修改）
  --1为覆盖注册（即先全部清空原注册卡号，再注册（注意：清空仅清空服务器设备数据，不清空硬件上的数据））
  @RegMode		bit = 0,  
  --在模板的条件中筛选注册人员条件；为空表示按模板的条件全部注册. 格式：EmployeeID值. 如：select EmployeeId from Employes where Employeeid In (1,2,3)
  @WhereEmployee VARCHAR(2000) = '',     
 --在模板的条件中筛选设备；为空表示按模板的条件全部注册	. 格式：同上
  @WhereControllerid VARCHAR(2000) = ''
)
AS
BEGIN	
	--DECLARE @TemplateId VARCHAR(50) = 51,	DECLARE @TemplateId VARCHAR(50) = 73,
			--@RegMode		bit = 1,  
			--@WhereEmployee VARCHAR(2000) = 'Select Employeeid from Employees where DepartmentID in (select DepartmentID from RoleDepartment where UserId in (5) and Permission=1) and Left(IncumbencyStatus,1)<>''1''',     
			--@WhereControllerid VARCHAR(2000) = 'select ControllerID from RoleController where UserId in (5) and Permission=1'

	DECLARE @strSQL nvarchar(max)
	DECLARE @strEmController VARCHAR(1000)
	DECLARE @strEmCode VARCHAR(4000) --员工Id
	DECLARE @strDeptCode VARCHAR(4000) --部门Id
	DECLARE @strOtherCode VARCHAR(4000) --其它条件
	DECLARE @strEmployeeScheID VARCHAR(100)
	DECLARE @strEmployeeDoor VARCHAR(100)
	DECLARE @strValidateMode VARCHAR(100)
	DECLARE @OnlyByCondition bit

	SET NOCOUNT ON
	--从模板表获取相关字段
	SELECT @strEmCode=EmployeeCode,@strDeptCode=DepartmentCode,@strOtherCode=OtherCode,@strEmController=ISNULL(EmployeeController,''),
			@strEmployeeScheID=ISNULL(EmployeeScheID,''),@strEmployeeDoor=ISNULL(EmployeeDoor,''),@strValidateMode=ValidateMode,@OnlyByCondition=isnull(OnlyByCondition,0)
			FROM ControllerTemplates where TemplateType=4 and TemplateId=+@TemplateId
				
	if ISNULL(@strEmCode,'') != '' and left(replace(@strEmCode,' ',''), 2) <> '0-'
	begin
		Set @strEmCode = '( EmployeeId in ('+ @strEmCode + '))'

		if ISNULL(@strDeptCode,'') != '' and left(replace(@strDeptCode,' ',''), 2) <> '0-'
			Set @strEmCode = '(' + @strEmCode + ' or (Departmentid In(' + @strDeptCode + ')))'	
	end
	else
	begin
		if ISNULL(@strDeptCode,'') != '' and left(replace(@strDeptCode,' ',''), 2) <> '0-'
			Set @strEmCode = '(Departmentid In(' + @strDeptCode + '))'	
	end		
	
	if ISNULL(@strEmCode,'') != '' 
		Set @strEmCode = 'select EmployeeId from Employees where Left(IncumbencyStatus,1) != ''1'' and '+ @strEmCode
	else 
	Begin
		Set @strEmCode = 'select EmployeeId from Employees where Left(IncumbencyStatus,1) != ''1'''		
	End
	
	--WhereEmployee 条件不能直接并入到strEmCode中，因为如果选择【仅按此条件注册】要删除非条件中的人员。  WhereEmployee一般用于接口同步时，传入有变动的人员信息
	--IF @WhereEmployee <> '' 
	--	Set @strEmCode = @strEmCode + ' and EmployeeId IN (' + @WhereEmployee+')'	
		
	--获取需要注册的设备，并将设备ID保存于#TempConId中
	IF object_id('tempdb.dbo.#TempConId') IS not null
		DROP TABLE #TempConId

	Create Table #TempConId(ControllerId int null)
	Set @strSQL = 'INSERT #TempConId SELECT ControllerId  From Controllers '
	IF left(@strEmController,1)='0'
		 Set @strSQL = @strSQL + ' where ControllerId > 0 '
	Else if rtrim(ltrim(@strEmController))=''
		Set @strSQL = @strSQL + ' where ControllerId < 0 '
	Else
		Set @strSQL = @strSQL + ' where ControllerId in ('+@strEmController+') '

	--@WhereControllerid 条件不能直接并入到@strEmController中，同@WhereEmployee
	--IF @WhereControllerid <> '' 
	--	Set @strSQL = @strSQL + ' and ControllerId in ('+@WhereControllerid+') '

	Exec(@strSQL)

	----注册时间表。当前时间表ID没在设备时间表中，则找一个ScheduleCode最小且没有未注册的时间表的记录来保存当前时间表ID
	IF @strEmployeeScheID <> ''
	BEGIN
		Set @strSQL = 'update CS set TemplateId='+@strEmployeeScheID+',TemplateName=(select top 1 TemplateName from ControllerTemplates where TemplateId='+@strEmployeeScheID+' ),Status=0 
						From ControllerSchedule CS 
						where CS.ScheduleCode=(select MIN(ScheduleCode) From ControllerSchedule CS2 
									where CS.Controllerid=CS2.Controllerid and (ISNULL(CS2.TemplateId,0)=0 or ISNULL(CS2.TemplateId,'''')='''')  ) 
							and CS.Controllerid in (Select Controllerid from #TempConId ) 
							and CS.ControllerId NOT IN(select Controllerid from ControllerSchedule where TemplateId='+@strEmployeeScheID+' ) ' 
	End
	EXEC(@strSQL)

	--set @RegMode = 0
	
	if @RegMode=1 
	Begin
		--覆盖注册，先删除，再注册
		Set @strSQL = 'delete from ControllerEmployee where ControllerId in (select ControllerId from #TempConId) 
						and EmployeeId in (select EmployeeId from ('+@strEmCode+') A ); ' --删除后重新注册
						
		Set @strSQL = @strSQL+'insert into ControllerEmployee(ControllerId,Employeeid,UserPassword,ScheduleCode,EmployeeDoor,DeleteFlag,Status, ValidateMode) 
						select C.ControllerId, Emp.Employeeid, U.Userpassword,'''+@strEmployeeScheID+''','''+@strEmployeeDoor+''',0,0, '''+@strValidateMode+''' 
						from Controllers C,Employees Emp left join Users U on  Emp.Employeeid=U.Employeeid 
						where  Emp.EmployeeId in (select EmployeeId from ('+@strEmCode+') A ) and Left(Emp.IncumbencyStatus,1)!=''1'' and Emp.Card>0 
						and C.ControllerID in (select ControllerId from #TempConId) 
						and NOT EXISTS(SELECT 1 FROM ControllerEmployee AS CE 
							WHERE CE.Employeeid=Emp.Employeeid and CE.Controllerid = C.Controllerid 
							and CE.ControllerID in (select ControllerId from #TempConId) 
							and ISNULL(CE.deleteflag, 0) = 0 ) '
		Exec(@strSQL)	
	End
	Else
	Begin
		Set @strSQL = @strSQL+'insert into ControllerEmployee(ControllerId,Employeeid,UserPassword,ScheduleCode,EmployeeDoor,DeleteFlag,Status, ValidateMode) 
						select C.ControllerId, Emp.Employeeid, U.Userpassword,'''+@strEmployeeScheID+''','''+@strEmployeeDoor+''',0,0, '''+@strValidateMode+''' 
						from Controllers C,Employees Emp left join Users U on  Emp.Employeeid=U.Employeeid 
						where  Emp.EmployeeId in (select EmployeeId from ('+@strEmCode+') A ) '
		IF @WhereEmployee <> '' 
			Set @strSQL = @strSQL+' and Emp.EmployeeId IN (' + @WhereEmployee+')'
			
		Set @strSQL = @strSQL+'and Left(Emp.IncumbencyStatus,1)!=''1'' and Emp.Card>0 
						and C.ControllerID in (select ControllerId from #TempConId) '
		IF @WhereControllerid <> '' 
			Set @strSQL = @strSQL+' and C.ControllerID IN (' + @WhereControllerid+')'
			
		Set @strSQL = @strSQL+' and NOT EXISTS(SELECT 1 FROM ControllerEmployee AS CE 
							WHERE CE.Employeeid=Emp.Employeeid and CE.Controllerid = C.Controllerid 
							and CE.ControllerID in (select ControllerId from #TempConId) 
							and ISNULL(CE.deleteflag, 0) = 0 ) '
		--仅按此条件注册。删除非条件中的数据
		if	@OnlyByCondition = 1
		begin
			set @strSQL = @strSQL+';update ControllerEmployee set deleteflag = 1, status = 0 where ControllerId in (select ControllerId from #TempConId) 
							and EmployeeId not in (select EmployeeId from ('+@strEmCode+') A ); ' --软件删除当前未注册在该设备上的员工卡号
		end
		
		Exec(@strSQL)	
	End	
	
	
	
	UPDATE ControllerDataSync set SyncStatus=0 where Controllerid in (select ControllerId from #TempConId) and SyncType='register'
		
	IF object_id('tempdb.dbo.#TempConId') IS not null
		DROP TABLE #TempConId

	SET NOCOUNT OFF
END
GO



--所有模板注册到设备
if exists (select name from sysObjects where name = 'pRegCardTemplateRegisterAll' and type = 'p')
	drop Procedure pRegCardTemplateRegisterAll
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROC [dbo].[pRegCardTemplateRegisterAll]
( 
 /*注意：执行注册时，模板ID从大到小排序，即先注册最大ID模板　*/

  --注册方式，0为追加注册（不会产生重复数据，已注册的卡号，不做任何修改）
  --1为覆盖注册（即先全部清空原注册卡号，再注册（注意：清空仅清空服务器设备数据，不清空硬件上的数据））
  @RegMode		bit = 0,  
  --在模板的条件中筛选注册人员条件；为空表示按模板的条件全部注册. 格式：EmployeeID值. 如：select EmployeeId from Employes where Employeeid In (1,2,3)
  @WhereEmployee VARCHAR(2000) = '',     
 --在模板的条件中筛选设备；为空表示按模板的条件全部注册	. 格式：同上
  @WhereControllerid VARCHAR(2000) = ''
)
AS
BEGIN	
	--DECLARE @RegMode		bit = 0,  
	--		@WhereEmployee VARCHAR(2000) = '',     
	--		@WhereControllerid VARCHAR(2000) = ''

	DECLARE @StrSQL NVARCHAR(2000)
	DECLARE @TemplateId VARCHAR(50)

	SET NOCOUNT ON

		if exists( select * from master.dbo.syscursors where cursor_name='RegCursor')
			DEALLOCATE  RegCursor 
	     
		set @strSQL='declare RegCursor cursor for select TemplateId from ControllerTemplates where TemplateType=4 order by TemplateId Desc '
		exec sp_executesql  @strSQL
	   
		OPEN RegCursor; --打开游标
		FETCH NEXT FROM RegCursor INTO @TemplateId; --读取第一行数据,并将值保存于变量中
		WHILE @@FETCH_STATUS = 0
			BEGIN
				exec pRegCardTemplateRegister @TemplateId,@RegMode,@WhereEmployee,@WhereControllerid

				FETCH NEXT FROM RegCursor INTO @TemplateId; --读取下一行数据
			END
		CLOSE RegCursor; --关闭游标
		DEALLOCATE RegCursor; --释放游标
	
	SET NOCOUNT OFF
END

GO

/**************20170525 增加人脸设备更新********************************************************************************************************/
delete from TableFieldCode where FieldId=7


INSERT INTO TableFieldCode(FieldId,Content) SELECT '7',N'0 - 指纹机' 
	WHERE NOT EXISTS(SELECT 1 FROM TableFieldCode WHERE FieldId = '7' AND Left(Content,1) = '0');
INSERT INTO TableFieldCode(FieldId,Content) SELECT '7',N'1 - 刷卡机' 
	WHERE NOT EXISTS(SELECT 1 FROM TableFieldCode WHERE FieldId = '7' AND Left(Content,1) = '1');
INSERT INTO TableFieldCode(FieldId,Content) SELECT '7',N'2 - 人脸机' 
	WHERE NOT EXISTS(SELECT 1 FROM TableFieldCode WHERE FieldId = '7' AND Left(Content,1) = '2');

if not exists(select name from syscolumns where id=object_id('Controllers')and name='ControllerType')
	alter table Controllers add ControllerType  nvarchar(100)--保存设备类型
go
if not exists(select name from syscolumns where id=object_id('Controllers')and name='ControllerSerail')
	alter table Controllers add ControllerSerail  nvarchar(50)--保存设备序列号
go 
if not exists(select name from syscolumns where id=object_id('Employees')and name='isHaveFaceLib')
	alter table Employees add isHaveFaceLib bit				--保存人脸模板是否已采集
go 	

update Controllers set ControllerType=(SELECT Content FROM TableFieldCode WHERE FieldId = '7' AND Left(Content,1) = '0') where IsFingerprint=1
update Controllers set ControllerType=(SELECT Content FROM TableFieldCode WHERE FieldId = '7' AND Left(Content,1) = '1') where IsFingerprint=0

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Equipment', NULL, 'ValidateModeVal5', '5 - 人脸', '5 - 人臉', '5 - Face', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Equipment' AND LabelId = 'ValidateModeVal5');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Equipment', NULL, 'ValidateModeVal6', '6 - 卡+人脸', '6 - 卡+人臉', '6 - Card+Face', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Equipment' AND LabelId = 'ValidateModeVal6');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Equipment', NULL, 'ConSerailUsed', '设备序列号已使用', '設備序號已使用', 'Serail already used', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Equipment' AND LabelId = 'ConSerailUsed')
	
	