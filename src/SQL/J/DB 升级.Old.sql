USE CerbDb
Go
/*
********************************升级2015-04-10*******************************************************************************************
*/


/*==============================================================*/
/* Table: AttendanceShifts                                  
 StretchShift 是否弹性班次
 Degree 上班次数
 ShiftTime 标准工时
 Night 是否过夜
 FirstOnDuty 第一次刷卡  0 当日  1上日
    */
/*==============================================================*/
create table AttendanceShifts (
  ShiftId              int                  identity,
  ShiftName            nvarchar(50)          null,
  StretchShift         bit                  null,
  Degree               int             not null,
  Night                bit                  not null,
  FirstOnDuty          nchar(1)              null,
  ShiftTime            numeric(5,2)         null,
   AonDuty              datetime             not null,
   AonDutyStart         datetime             not null,
   AonDutyEnd           datetime             null,
   AoffDuty             datetime             not null,
   AoffDutyStart        datetime             null,
   AoffDutyEnd          datetime             null,
   AcalculateLate       smallint             null,
   AcalculateEarly      smallint             null,
   ArestTime            smallint             null,
   BonDuty              datetime             null,
   BonDutyStart         datetime             null,
   BonDutyEnd           datetime             null,
   BoffDuty             datetime             null,
   BoffDutyStart        datetime             null,
   BoffDutyEnd          datetime             null,
   BcalculateLate       smallint             null,
   BcalculateEarly      smallint             null,
   BrestTime            smallint             null,
   ConDuty              datetime             null,
   ConDutyStart         datetime             null,
   ConDutyEnd           datetime             null,
   CoffDuty             datetime             null,
   CoffDutyStart        datetime             null,
   CoffDutyEnd          datetime             null,
   CcalculateLate       smallint             null,
   CcalculateEarly      smallint             null,
   CrestTime            smallint             null,
	Overtime             int                  null,
   constraint PK_ATTENDANCESHIFTS primary key nonclustered (ShiftID)
)
go

/*==============================================================*/
/* Table: AttendanceDetail                                      */
/*==============================================================*/
create table AttendanceDetail (
EmployeeId           int                  not null,
OnDutyDate           datetime        not null,
NoBrushCard          bit             null,
ShiftName            nvarchar(50)          null,
OnDutyType           nvarchar(50)          null,
OnDuty1              datetime              null,
OffDuty1             datetime              null,
OnDuty2              datetime              null,
OffDuty2             datetime              null,
OnDuty3              datetime              null,
OffDuty3             datetime              null,
Result1              nvarchar(30)          null,
Result2              nvarchar(30)          null,
Result3              nvarchar(30)          null,
Result4              nvarchar(30)          null,
Result5              nvarchar(30)          null,
Result6              nvarchar(30)          null,
SignInFlag           nchar(6)             null default '000000',
LateTime1            numeric(18, 0)       null,
LateTime2            numeric(18, 2)       null,
LateTime3            numeric(18, 2)       null,
LeaveEarlyTime1      numeric(18, 2)       null,
LeaveEarlyTime2      numeric(18, 2)       null,
LeaveEarlyTime3      numeric(18, 2)       null,
WorkTime1            numeric(18, 0)       null,
WorkTime2            numeric(18, 0)       null,
WorkTime3            numeric(18, 0)       null,
WorkTime             numeric(18, 2)       null,
OtTime               numeric(18, 2)       null,
WorkDay              numeric(18, 2)       null,
Absent               numeric(18, 2)       null,
AnnualVacation       numeric(18, 2)       null,
PersonalLeave        numeric(18, 2)       null,
SickLeave            numeric(18, 2)       null,
InjuryLeave          numeric(18, 2)       null,
WeddingLeave         numeric(18, 2)       null,
MaternityLeave       numeric(18, 2)       null,
OnTrip               numeric(18, 2)       null,
FuneralLeave         numeric(18, 2)       null,
CompensatoryLeave    numeric(18, 2)       null,
PublicHoliday        numeric(18, 2)       null,
OtherLeave           numeric(18, 2)       null,
LactationLeave       numeric(18, 2)       null,
VisitLeave           numeric(18, 2)       null,
constraint PK_AttendanceDetail primary key nonclustered (EmployeeId, OnDutyDate)
      on [PRIMARY]
)
ON [PRIMARY]
go


/*==============================================================*/
/* Index: Index_1                                               */
/*==============================================================*/
create   index Index_1 on dbo.AttendanceDetail (
EmployeeId,
OnDutyDate
)
go


/*==============================================================*/
/* Table: AttendanceTotal                                       */
/*==============================================================*/
create table dbo.AttendanceTotal (
EmployeeId           int                  not null,
AttendMonth          nvarchar(7)           null,
LateCount_0          numeric(18, 2)       null,
LateTime_0           numeric(18, 2)       null,
LeaveEarlyCount_0    numeric(18, 2)       null,
LeaveEarlyTime_0     numeric(18, 2)       null,
AbnormityCount_0     numeric(18, 2)       null,
WorkTime_0           numeric(18, 2)       null,
OtTime_0             numeric(18, 2)       null,
WorkDay_0            numeric(18, 2)       null,
WorkTime_1           numeric(18, 2)       null,
WorkTime_2           numeric(18, 2)       null,
Absent               numeric(18, 2)       null,
AnnualVacation       numeric(18, 2)       null,
PersonalLeave        numeric(18, 2)       null,
SickLeave            numeric(18, 2)       null,
InjuryLeave          numeric(18, 2)       null,
WeddingLeave         numeric(18, 2)       null,
MaternityLeave       numeric(18, 2)       null,
OnTrip               numeric(18, 2)       null,
FuneralLeave         numeric(18, 2)       null,
CompensatoryLeave    numeric(18, 2)       null,
OtherLeave           numeric(18, 2)       null,
LactationLeave       numeric(18, 2)       null,
VisitLeave           numeric(18, 2)       null,
AnnualVacationRemanent  numeric(18, 2)       null,
PublicHoliday        numeric(18, 2)       null
)
ON [PRIMARY]
go


/*==============================================================*/
/* Index: Index_2                                               */
/*==============================================================*/
create   index Index_2 on dbo.AttendanceTotal (
AttendMonth
)
go


/*==============================================================*/
/* Table: AttendanceTotalYear                                   */
/*==============================================================*/
create table dbo.AttendanceTotalYear (
EmployeeId           int                  not null,
AttendMonth          nvarchar(7)           null,
LateCount_0          numeric(18, 2)       null,
LateTime_0           numeric(18, 2)       null,
LeaveEarlyCount_0    numeric(18, 2)       null,
LeaveEarlyTime_0     numeric(18, 2)       null,
AbnormityCount_0     numeric(18, 2)       null,
WorkTime_0           numeric(18, 2)       null,
OtTime_0             numeric(18, 2)       null,
WorkDay_0            numeric(18, 2)       null,
WorkTime_1           numeric(18, 2)       null,
WorkTime_2           numeric(18, 2)       null,
Absent               numeric(18, 2)       null,
AnnualVacationYear   numeric(18, 2)       null,
AnnualVacationRemanent  numeric(18, 2)       null,
AnnualVacation       numeric(18, 2)       null,
PersonalLeave        numeric(18, 2)       null,
SickLeave            numeric(18, 2)       null,
InjuryLeave          numeric(18, 2)       null,
WeddingLeave         numeric(18, 2)       null,
MaternityLeave       numeric(18, 2)       null,
OnTrip               numeric(18, 2)       null,
FuneralLeave         numeric(18, 2)       null,
CompensatoryLeave    numeric(18, 2)       null,
OtherLeave           numeric(18, 2)       null,
LactationLeave       numeric(18, 2)       null,
VisitLeave           numeric(18, 2)       null,
PublicHoliday        numeric(18, 2)       null
)
ON [PRIMARY]
go



/*==============================================================*/
/* Table: AttendanceAskForLeave                                 */
/*==============================================================*/
create table dbo.AttendanceAskForLeave (
AskForLeaveId        int                  identity,
EmployeeId           int                  null,
StartTime            datetime             null,
EndTime              datetime             null,
AllDay               bit                  null,
TransactThing        nvarchar(100)        null,
AskForLeaveType      nvarchar(50)         null,
SumTotal             nvarchar(8)          null,
Note                 nvarchar(100)        null,
Status               nvarchar(50)         null,
WorkFlowId           int                  null,
WorkFlowName         nvarchar(50)         null,
OldStepId            int                  null,
OldTransactorId      int                  null,
NowStep              int                  null,
NextStep             nvarchar(50)         null,
TransactorDesc       nvarchar(50)         null,
TransactorId         int                  null,
TransactorName       nvarchar(50)         null,
DeputizeId           int                  null,
DeputizeName         nvarchar(50)         null,
constraint PK_ATTENDANCEASKFORLEAVE primary key nonclustered (AskForLeaveId)
      on [PRIMARY]
)
ON [PRIMARY]
go
/*==============================================================*/
/* Index: Index_1                                               */
/*==============================================================*/
create   index Index_1 on dbo.AttendanceAskForLeave (
EmployeeId,
AskForLeaveId
)
go


/*==============================================================*/
/* Table: AttendanceHoliday                                     */
/*==============================================================*/
create table dbo.AttendanceHoliday (
HolidayId            int             identity,
HolidayDate          datetime        null,
TransposalDate       datetime        null,
HolidayName          nvarchar(50)    null,
TempLateId           int             null,
constraint PK_AttendanceHoliday primary key nonclustered (HolidayId)
      on [PRIMARY]
)
ON [PRIMARY]
go
/*==============================================================*/
/* Index: Index_1                                               */
/*==============================================================*/
create   index Index_1 on dbo.AttendanceHoliday (
HolidayId
)
go

/*==============================================================*/
/* Table: AttendanceOT                                          */
/*==============================================================*/
create table dbo.AttendanceOT (
OTId                 int                  identity,
EmployeeId           int                  null,
StartTime            datetime             null,
EndTime              datetime             null,
AllDay               bit                  null, 
SumTotal             nvarchar(8)          null,
Note                 nvarchar(100)         null,
Status               nvarchar(50)          null,
WorkFlowId           int                  null,
WorkFlowName         nvarchar(50)         null,
OldStepId            int                  null,
OldTransactorId      int                  null,
NowStep              int                  null,
NextStep             nvarchar(50)         null,
TransactorDesc       nvarchar(50)         null,
TransactorId         int                  null,
TransactorName       nvarchar(50)         null,
constraint PK_ATTENDANCEOT primary key nonclustered (OTId)
      on [PRIMARY]
)
ON [PRIMARY]
go

/*==============================================================*/
/* Table: AttendanceSignIn                                      */
/*==============================================================*/
create table dbo.AttendanceSignIn (
SignId               int                  identity,
EmployeeId           int                  not null,
BrushTime            datetime             null,
Remark               nvarchar(50)          null,
Status               nvarchar(50)          null,
WorkFlowId           int                  null,
WorkFlowName         nvarchar(50)         null,
OldStepId            int                  null,
OldTransactorId      int                  null,
NowStep              int                  null,
NextStep             nvarchar(50)         null,
TransactorDesc       nvarchar(50)         null,
TransactorId         int                  null,
TransactorName       nvarchar(50)         null,
constraint PK_ATTENDANCESIGNIN primary key  (SignId)
)
ON [PRIMARY]
go
/*==============================================================*/
/* Index: Index_1                                               */
/*==============================================================*/
create   index Index_1 on dbo.AttendanceSignIn (
EmployeeId,
BrushTime
)
go


/*==============================================================*/
/* Table: Options                                               */
/*==============================================================*/
create table dbo.Options (
VariableId           int                  identity,
VariableName         nvarchar(50)          null,
VariableDesc         nvarchar(100)          null,
VariableType         nvarchar(50)          null,
VariableValue        nvarchar(500)          null,
constraint PK_Options primary key nonclustered (VariableId)
      on [PRIMARY]
)
ON [PRIMARY]
go
/*==============================================================*/
/* Index: Index_1                                               */
/*==============================================================*/
create   index Index_1 on dbo.Options (
VariableId
)
go

/*==============================================================*/
/* Table: TotalMonth                                            */
/*==============================================================*/
create table TotalMonth (
PostMonth            nvarchar(10)         null,
StartDate            datetime             null,
EndDate              datetime             null
)
go


/*==============================================================*/
/* Table: AttendanceOnDutyRuleChange                            */
/*==============================================================*/
create table AttendanceOnDutyRuleChange (
ChangeId             int                  identity,
ChangeDate           datetime        null,
RuleId               int             not null,
EmployeeDesc         ntext          null,
EmployeeCode         ntext                 null,
OnDutyMode           nvarchar(20)          null,
NoBrushCard	     bit	           null,
FirstWeekDate        datetime        null,
LoopCount		smallint			null,
Monday1              nvarchar(50)          null,
Tuesday1             nvarchar(50)          null,
Wednesday1           nvarchar(50)          null,
Thursday1            nvarchar(50)          null,
Friday1              nvarchar(50)          null,
Saturday1            nvarchar(50)          null,
Sunday1              nvarchar(50)          null,
Monday2              nvarchar(50)          null,
Tuesday2             nvarchar(50)          null,
Wednesday2           nvarchar(50)          null,
Thursday2            nvarchar(50)          null,
Friday2              nvarchar(50)          null,
Saturday2            nvarchar(50)          null,
Sunday2              nvarchar(50)          null,
day15             nvarchar(50)          null,
day16            nvarchar(50)          null,
day17          nvarchar(50)          null,
day18           nvarchar(50)          null,
day19             nvarchar(50)          null,
day20           nvarchar(50)          null,
day21             nvarchar(50)          null,
day22             nvarchar(50)          null,
day23            nvarchar(50)          null,
day24           nvarchar(50)          null,
day25            nvarchar(50)          null,
day26              nvarchar(50)          null,
day27            nvarchar(50)          null,
day28              nvarchar(50)          null,
day29            nvarchar(50)          null,
day30              nvarchar(50)          null,
day31            nvarchar(50)          null)
go


/*==============================================================*/
/* Table: AttendanceOndutyRule                                  */
/*==============================================================*/
create table AttendanceOndutyRule (
RuleId               int             identity,
EmployeeDesc         ntext          null,
EmployeeCode         ntext                 null,
OnDutyMode           nvarchar(20)          null,
NoBrushCard	     bit	           null,
FirstWeekDate        datetime        null,
LoopCount		smallint			null,
Monday1              nvarchar(50)          null,
Tuesday1             nvarchar(50)          null,
Wednesday1           nvarchar(50)          null,
Thursday1            nvarchar(50)          null,
Friday1              nvarchar(50)          null,
Saturday1            nvarchar(50)          null,
Sunday1              nvarchar(50)          null,
Monday2              nvarchar(50)          null,
Tuesday2             nvarchar(50)          null,
Wednesday2           nvarchar(50)          null,
Thursday2            nvarchar(50)          null,
Friday2              nvarchar(50)          null,
Saturday2            nvarchar(50)          null,
Sunday2              nvarchar(50)          null,
day15             nvarchar(50)          null,
day16            nvarchar(50)          null,
day17          nvarchar(50)          null,
day18           nvarchar(50)          null,
day19             nvarchar(50)          null,
day20           nvarchar(50)          null,
day21             nvarchar(50)          null,
day22             nvarchar(50)          null,
day23            nvarchar(50)          null,
day24           nvarchar(50)          null,
day25            nvarchar(50)          null,
day26              nvarchar(50)          null,
day27            nvarchar(50)          null,
day28              nvarchar(50)          null,
day29            nvarchar(50)          null,
day30              nvarchar(50)          null,
day31            nvarchar(50)          null,

constraint PK_ATTENDANCEONDUTYRULE primary key nonclustered (RuleId)
      on [PRIMARY]
)
go

/*==============================================================*/
/* Table: TempShifts                                            */
/*==============================================================*/
create table dbo.TempShifts (
TempShiftID          int             identity,
ShiftType            nchar(1)              null,
AdjustDate           datetime        null,
EmployeeExpress      ntext           null,
EmployeeDesc         ntext           null,
ShiftId              int                  not null,
ShiftName            nvarchar(50)          null,
StretchShift         bit                  null,
Degree               int             not null,
Night                bit                  not null,
FirstOnDuty          nvarchar(20)          null,
ShiftTime            numeric(5,2)         null,
AonDuty              datetime             not null,
AonDutyStart         datetime             not null,
AonDutyEnd           datetime             null,
AoffDuty             datetime             not null,
AoffDutyStart        datetime             null,
AoffDutyEnd          datetime             null,
AcalculateLate       smallint             null,
AcalculateEarly      smallint             null,
ArestTime            int             null,
BonDuty              datetime             null,
BonDutyStart         datetime             null,
BonDutyEnd           datetime             null,
BoffDuty             datetime             null,
BoffDutyStart        datetime             null,
BoffDutyEnd          datetime             null,
BcalculateLate       smallint             null,
BcalculateEarly      smallint             null,
BrestTime            int             null,
ConDuty              datetime             null,
ConDutyStart         datetime             null,
ConDutyEnd           datetime             null,
CoffDuty             datetime             null,
CoffDutyStart        datetime             null,
CoffDutyEnd          datetime             null,
CcalculateLate       smallint             null,
CcalculateEarly      smallint             null,
CrestTime            int                  null,
Description          nvarchar(200)        null,
Overtime             int                  null,
)
go
/*==============================================================*/
/* Index: Index_1                                               */
/*==============================================================*/
create   index Index_1 on dbo.TempShifts (
AdjustDate
)
go



/*==============================================================*/
/* Table: TableStructure                                        */
/*==============================================================*/
create table dbo.TableStructure (
FieldId              int                  identity,
TableId              int             null,
TableName			 nvarchar(50)          null,
FieldName            nvarchar(50)          not null,
FieldProperty1       nvarchar(50)          null,
FieldProperty2       nvarchar(50)          null,
FieldDesc            nvarchar(50)          null,
FieldType            nvarchar(50)          not null,
AllowView            bit                  null,
ViewOrder            int             not null,
constraint PK_TableStructure primary key nonclustered (FieldId)
      on [PRIMARY]
)
ON [PRIMARY]
go


/*==============================================================*/
/* Index: Index_1                                               */
/*==============================================================*/
create   index Index_1 on dbo.TableStructure (
FieldId
)
go


/*==============================================================*/
/* Table: Tables                                                */
/*==============================================================*/
create table dbo.Tables (
TableId              int             identity,
TableName            nvarchar(30)          not null,
TableDesc            nvarchar(40)          null,
constraint PK_Tables primary key nonclustered (TableId)
      on [PRIMARY]
)
ON [PRIMARY]
go


alter table dbo.TableStructure
   add constraint FK_TABLESTR_REFERENCE_TABLES foreign key (TableId)
      references dbo.Tables (TableId)
go

SET IDENTITY_INSERT options ON
--------------------------------------------------------------------------------------- ----------- ---- ---------------------------------------------------- ---- ---------------------------------------------------- ---- ---------------------------------------------------- ---- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---- 
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 1 , 'strLate',    '迟到(第2位为1,计算迟到包括允许迟到时间)'    , '1,1,1' , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 2 , 'strLeaveEarly'  , '早退(第2位为1,计算早退包括允许早退时间)'  , '1,1,1'  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 3 , 'strAbnormity'   , '异常(1为异常视旷工)'  , '0'  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 4 , 'strVacationDesc', '休假说明', NULL  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 5 , 'strVacationCondition', '休假条件', NULL  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 6 , 'intBasicDay'    , '基本年假', '7'  , 'int'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 7 , 'strVacationType', '递增方式', NULL  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 8 , 'intIncreasePerYear'  , '递增天数', NULL  , 'int'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 9 , 'strIncreaseType1',    '递增方式1',    NULL  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 10 , 'strIncreaseType2',    '递增方式2',    NULL  , 'int'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 11, 'intMaxVacation' , '最大年假', '12'  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 12, 'blnContinueNext', '可延续' , '0'  , 'bln'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 13, 'strWeekendPrompt',    '周末提示', '0, '  , 'bln'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 14, 'strAskForLeaveOT',    '请假超时', '1,30'  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 15, 'strOTType', '超时加班(提前属于加班,延后属于加班,所有工时计加班,整数倍计为加班,整数)',    '0,0,1,0,30'  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 16, 'strTotalCycle'  , '汇总周期','0 – 本月,1,0 – 本月,31',    'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 17, 'strAbsent', '超时未上班',    '1,30'  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 18, 'strAnalyseOffDuty'   , '分析下班(0第一次刷卡,1最后一次刷卡)', '1'  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 19, 'strSkipHoliday' , '休假时跨过法定假'  , 'PersonalLeave1,SickLeave1,CompensatoryLeave1,MaternityLeave,WeddingLeave,LactationLeave,OtherLeave,OnTrip,AnnualVacation,PublicHoliday,InjuryLeave,FuneralLeave,VisitLeave',  'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 20, 'blnAnalyseWorkDay'   , '[出勤]计算方式(0实际出勤,1实际工时)', '0'  , 'bln'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 21, 'blnautoTotal'   , '自动统计', '1'  , NULL               )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 22, 'datAutotime',    '自动统计的时间' , '10:00'  , NULL               )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 23, 'blnTotalDimission',    '仅统计离职员工' , '0'  , 'bln'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 24, 'intWorkTime',    '休息日默认工时' , '8'  , 'str'  )
Insert into options (VariableId,variablename,variabledesc, variabletype, variablevalue) values (31,'strOnduty','申请加班','str','0,1')
insert into options(VariableId,VariableName,VariableDesc,VariableType,VariableValue) values(32,'strTotal','统计(2,1,1,2015-04-1,2015-4-12)',null,null)
insert into options(VariableId,VariableName,VariableDesc,VariableType,VariableValue) values(33,'strEmail','电子邮件','str','1')
SET IDENTITY_INSERT options OFF
GO


SET IDENTITY_INSERT [Tables] ON

INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 1,'AttendanceShifts','正常班次')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 2,'Tables','表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 6,'TableStructure','表结构')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 7,'AttendanceSignIn','补卡')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 10,'AttendanceHoliday','法定假期')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 11,'Company','机构')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 12,'Employees','职员')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 13,'Departments','部门')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 14,'RoleDepartment','用户部门权限')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 15,'RoleController','用户设备权限')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 16,'BrushCardAcs','进出刷卡表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 17,'AttendanceTotal','考勤汇总表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 18,'AttendanceDetail','考勤明细表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 19,'BrushCardAttend','考勤刷卡表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 20,'ControllerDataSync','控制器同步')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 21,'Controllers','设备')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 22,'ControllerHoliday','设备假期表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 24,'ControllerTemplateHoliday','设备假期模板')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 25,'ControllerTemplates','设备模板')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 26,'ControllerSchedule','设备时间表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 28,'ControllerTemplateSchedule','设备时间表模板')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 29,'ControllerInout','设备输入/输出表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 30,'ControllerTemplateInout','设备输入/输出模板')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 31,'ControllerEmployee','设备注册卡号')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 32,'TempShifts','班次调整')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 33,'AttendanceAskForLeave','请假')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 34,'LogEvent','日志')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 35,'AttendanceOndutyRule','上班规则')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 36,'AttendanceOnDutyRuleChange','上班规则变动')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 37,'EventRecord','按钮事件记录表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 38,'Options','选项')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 39,'Users','用户表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 40,'AttendanceTotalYear','删历史数时的考勤年汇总')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 41,'AttendanceOT','加班')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 42,'TotalMonth','统计月份')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 43,'CombinationDoor','组合开门')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 45,'TableFieldCode','字段代码')

SET IDENTITY_INSERT [Tables] OFF
Go

SET IDENTITY_INSERT [TableStructure] ON

INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 1,1,'AttendanceShifts','ShiftName','班次名','nvarchar(50)',1,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 2,1,'AttendanceShifts','StretchShift','弹性班次','bit',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 3,1,'AttendanceShifts','ShiftTime','基本工时','numeric(5,2)',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 4,1,'AttendanceShifts','Degree','上班次数','int',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 5,1,'AttendanceShifts','Night','过夜','bit',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 6,1,'AttendanceShifts','AonDuty','上班标准1','datetime',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 7,1,'AttendanceShifts','AonDutyStart','上班开始1','datetime',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 8,1,'AttendanceShifts','AonDutyEnd','上班截止1','datetime',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 9,1,'AttendanceShifts','AoffDuty','下班标准1','datetime',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 10,1,'AttendanceShifts','AoffDutyStart','下班开始1','datetime',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 11,1,'AttendanceShifts','ArestTime','中间休息1','int',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 12,1,'AttendanceShifts','AcalculateLate','允许迟到1','int',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 13,1,'AttendanceShifts','AcalculateEarly','允许早退1','int',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 14,1,'AttendanceShifts','BonDuty','上班标准2','datetime',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 15,1,'AttendanceShifts','BonDutyEnd','上班截止2','datetime',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 16,1,'AttendanceShifts','BoffDuty','下班标准2','datetime',0,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 17,1,'AttendanceShifts','BoffDutyEnd','下班截止2','datetime',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 18,1,'AttendanceShifts','BrestTime','中间休息2','int',0,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 19,1,'AttendanceShifts','BcalculateLate','允许迟到2','int',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 20,1,'AttendanceShifts','BcalculateEarly','允许早退2','int',0,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 21,1,'AttendanceShifts','ConDuty','上班标准3','datetime',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 22,1,'AttendanceShifts','ConDutyEnd','上班截止3','datetime',0,22)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 23,1,'AttendanceShifts','CoffDuty','下班标准3','datetime',0,23)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 24,1,'AttendanceShifts','CrestTime','中间休息3','int',0,24)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 25,1,'AttendanceShifts','CcalculateLate','允许迟到3','int',0,25)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 26,1,'AttendanceShifts','CcalculateEarly','允许早退3','int',0,26)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 27,1,'AttendanceShifts','FirstOnDuty','第一次上下班','nchar(1)',0,27)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 28,1,'AttendanceShifts','AoffDutyEnd','下班截止1','datetime',0,28)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 29,1,'AttendanceShifts','BonDutyStart','上班开始2','datetime',0,29)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 30,1,'AttendanceShifts','BoffDutyStart','下班开始2','datetime',0,30)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 31,1,'AttendanceShifts','ConDutyStart','上班开始3','datetime',0,31)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 32,1,'AttendanceShifts','CoffDutyStart','下班开始3','datetime',0,32)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 33,1,'AttendanceShifts','CoffDutyEnd','下班截止3','datetime',0,33)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 34,1,'AttendanceShifts','ShiftId','班次ID','int',0,34)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 35,2,'Tables','TableName','表名','nvarchar(30)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 36,2,'Tables','TableDesc','说明','nvarchar(40)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 37,2,'Tables','TableId','表ID','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 38,6,'TableStructure','FieldDesc','字段说明','nvarchar(50)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 39,6,'TableStructure','FieldId','字段ID','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 40,6,'TableStructure','FieldType','字段类型','nvarchar(50)',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 41,6,'TableStructure','TableId','表ID','int',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 42,6,'TableStructure','ViewOrder','显示顺序','int',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 43,6,'TableStructure','FieldName','字段名','nvarchar(50)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 44,6,'TableStructure','AllowView','允许显示','bit',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 45,6,'TableStructure','FieldProperty1','字段属性1','nvarchar(50)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 46,6,'TableStructure','FieldProperty2','字段属性2','nvarchar(50)',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 47,7,'AttendanceSignIn','SignId','补卡ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 48,7,'AttendanceSignIn','BrushTime','时间','datetime',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 49,7,'AttendanceSignIn','EmployeeId','职员ID','int',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 50,7,'AttendanceSignIn','Status','状态','nvarchar(50)',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 51,7,'AttendanceSignIn','Remark','原因','nvarchar(50)',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 52,7,'AttendanceSignIn','WorkFlowId','工作流ID','int',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 53,7,'AttendanceSignIn','WorkFlowName','工作流名称','nvarchar(50)',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 54,7,'AttendanceSignIn','OldStepId','撤消时的步骤ID','int',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 55,7,'AttendanceSignIn','OldTransactorId','撤消时的下步经办人ID','int',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 56,7,'AttendanceSignIn','NowStep','当前步骤','int',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 57,7,'AttendanceSignIn','NextStep','下一步','nvarchar(50)',1,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 58,7,'AttendanceSignIn','TransactorDesc','经办人说明','nvarchar(50)',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 59,7,'AttendanceSignIn','TransactorId','经办人ID','int',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 60,7,'AttendanceSignIn','TransactorName','经办人姓名','nvarchar(50)',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 61,10,'AttendanceHoliday','HolidayId','ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 62,10,'AttendanceHoliday','HolidayName','说明','nvarchar(50)',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 63,10,'AttendanceHoliday','HolidayDate','日期','datetime',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 64,10,'AttendanceHoliday','TransposalDate','调换日期','datetime',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 65,11,'Company','Tel','联系电话','nvarchar(50)',1,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 66,11,'Company','CompDesc','简介','nvarchar(500)',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 67,11,'Company','Linkman','联系人','nvarchar(50)',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 68,11,'Company','Address','地址','nvarchar(100)',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 69,11,'Company','CompName','公司名称','nvarchar(100)',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 70,11,'Company','ChiefId','负责人ID','int',1,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 71,12,'Employees','EmployeeId','职员ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 72,12,'Employees','DepartmentID','部门ID','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 73,12,'Employees','Name','姓名','nvarchar(50)',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 74,12,'Employees','Sex','性别','nvarchar(20)',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 75,12,'Employees','Card','卡号','bigint',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 76,12,'Employees','Number','编号','nvarchar(20)',1,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 77,12,'Employees','Marry','婚否','nvarchar(20)',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 78,12,'Employees','Knowledge','学历','nvarchar(20)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 79,12,'Employees','Position','职位','nvarchar(50)',1,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 80,12,'Employees','Headship','职务','nvarchar(50)',1,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 81,12,'Employees','JoinDate','入职日期','datetime',1,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 82,12,'Employees','IdentityCard','身份证','nvarchar(20)',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 83,12,'Employees','BirthDate','出生日期','datetime',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 84,12,'Employees','Country','国籍','nvarchar(20)',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 85,12,'Employees','NativePlace','籍贯','nvarchar(50)',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 86,12,'Employees','Address','地址','nvarchar(100)',0,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 87,12,'Employees','Telephone','电话','nvarchar(20)',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 88,12,'Employees','IncumbencyStatus','在职类型','nvarchar(20)',0,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 89,12,'Employees','Photo','照片','image',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 90,12,'Employees','FingerPrint1','指纹1','image',0,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 91,12,'Employees','FingerPrint2','指纹2','image',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 92,12,'Employees','Email','Email','nvarchar(50)',0,22)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 93,12,'Employees','DimissionDate','离职日期','datetime',0,23)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 94,12,'Employees','DimissionReason','离职说明','nvarchar(100)',0,24)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 95,12,'Employees','FieldVal1','保留字段1值','nvarchar(50)',0,25)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 96,12,'Employees','FieldDesc1','保留字段1说明','nvarchar(50)',0,26)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 97,12,'Employees','FieldVal2','保留字段2值','nvarchar(50)',0,27)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 98,12,'Employees','FieldDesc2','保留字段2说明','nvarchar(50)',0,28)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 99,12,'Employees','FieldVal3','保留字段1值','int',0,29)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 100,12,'Employees','FieldDesc3','保留字段1说明','nvarchar(50)',0,30)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 101,13,'Departments','DepartmentID','部门ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 102,13,'Departments','DepartmentCode','部门编码','nvarchar(50)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 103,13,'Departments','DepartmentName','部门名称','nvarchar(100)',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 104,13,'Departments','ChiefId','部门主管','nvarchar(50)',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 105,13,'Departments','LeadId','分管领导','nvarchar(50)',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 106,13,'Departments','ParentDepartmentID','父部门ID','int',1,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 107,13,'Departments','Remark','备注','nvarchar(100)',1,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 108,14,'RoleDepartment','DepartmentID','部门ID','nvarchar(20)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 109,14,'RoleDepartment','Permission','访问','bit',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 110,14,'RoleDepartment','UserId','角色ID','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 111,15,'RoleController','ControllerID','部门ID','nvarchar(20)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 112,15,'RoleController','Permission','访问','bit',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 113,15,'RoleController','UserId','角色ID','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 114,16,'BrushCardAcs','RecordID','记录ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 115,16,'BrushCardAcs','Property','属性','nvarchar(2)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 116,16,'BrushCardAcs','EmployeeId','职员ID','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 117,16,'BrushCardAcs','ControllerId','控制器ID','int',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 118,16,'BrushCardAcs','BrushTime','刷卡时间','datetime',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 119,16,'BrushCardAcs','Door','进出门','nvarchar(2)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 120,16,'BrushCardAcs','Card','卡号','bigint',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 121,17,'AttendanceTotal','EmployeeId','职员ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 122,17,'AttendanceTotal','AttendMonth','月份','nvarchar(7)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 123,17,'AttendanceTotal','LateCount_0','迟到次数(平)','numeric(18, 2)',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 124,17,'AttendanceTotal','LateTime_0','迟到时间(平)','numeric(18, 2)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 125,17,'AttendanceTotal','LeaveEarlyCount_0','早退次数(平)','numeric(18, 2)',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 126,17,'AttendanceTotal','LeaveEarlyTime_0','早退时间(平)','numeric(18, 2)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 127,17,'AttendanceTotal','AbnormityCount_0','异常次数(平)','numeric(18, 2)',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 128,17,'AttendanceTotal','WorkTime_0','工作时间(平)','numeric(18, 2)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 129,17,'AttendanceTotal','OtTime_0','超时加班(平)','numeric(18, 2)',1,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 130,17,'AttendanceTotal','WorkDay_0','出勤(平)','numeric(18, 2)',1,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 131,17,'AttendanceTotal','WorkTime_1','工作时间(休)','numeric(18, 2)',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 132,17,'AttendanceTotal','WorkTime_2','工作时间(假)','numeric(18, 2)',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 133,17,'AttendanceTotal','Absent','旷工','numeric(18, 2)',1,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 134,17,'AttendanceTotal','AnnualVacation','Holiday','年假','numeric(18, 2)',1,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 135,17,'AttendanceTotal','PersonalLeave','Holiday','事假','numeric(18, 2)',1,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 136,17,'AttendanceTotal','SickLeave','Holiday','病假','numeric(18, 2)',1,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 137,17,'AttendanceTotal','InjuryLeave','Holiday','工伤','numeric(18, 2)',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 138,17,'AttendanceTotal','WeddingLeave','Holiday','婚假','numeric(18, 2)',0,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 139,17,'AttendanceTotal','MaternityLeave','Holiday','产假','numeric(18, 2)',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 140,17,'AttendanceTotal','OnTrip','Holiday','出差','numeric(18, 2)',1,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 141,17,'AttendanceTotal','FuneralLeave','Holiday','丧假','numeric(18, 2)',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 142,17,'AttendanceTotal','CompensatoryLeave','Holiday','补假','numeric(18, 2)',1,22)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 143,17,'AttendanceTotal','OtherLeave','Holiday','其他假','numeric(18, 2)',0,23)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 144,17,'AttendanceTotal','LactationLeave','Holiday','哺乳假','numeric(18, 2)',0,24)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 145,17,'AttendanceTotal','VisitLeave','Holiday','探亲假','numeric(18, 2)',0,25)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 146,17,'AttendanceTotal','PublicHoliday','Holiday','法定假','numeric(18, 2)',1,26)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 147,17,'AttendanceTotal','AnnualVacationRemanent','上年剩余年假','numeric(18, 2)',0,27)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 148,18,'AttendanceDetail','EmployeeId','职员ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 149,18,'AttendanceDetail','OnDutyDate','上班日期','datetime',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 150,18,'AttendanceDetail','NoBrushCard','免打卡','bit',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 151,18,'AttendanceDetail','ShiftName','班次名','nvarchar(50)',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 152,18,'AttendanceDetail','OnDutyType','上班类型','nvarchar(50)',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 153,18,'AttendanceDetail','OnDuty1','上班刷卡1','datetime',1,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 154,18,'AttendanceDetail','OffDuty1','下班刷卡1','datetime',1,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 155,18,'AttendanceDetail','OnDuty2','上班刷卡2','datetime',1,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 156,18,'AttendanceDetail','OffDuty2','下班刷卡2','datetime',1,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 157,18,'AttendanceDetail','OnDuty3','上班刷卡3','datetime',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 158,18,'AttendanceDetail','OffDuty3','下班刷卡3','datetime',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 159,18,'AttendanceDetail','Result1','刷卡性质1','nvarchar(30)',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 160,18,'AttendanceDetail','Result2','刷卡性质2','nvarchar(30)',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 161,18,'AttendanceDetail','Result3','刷卡性质3','nvarchar(30)',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 162,18,'AttendanceDetail','Result4','刷卡性质4','nvarchar(30)',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 163,18,'AttendanceDetail','Result5','刷卡性质5','nvarchar(30)',0,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 164,18,'AttendanceDetail','Result6','刷卡性质6','nvarchar(30)',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 165,18,'AttendanceDetail','SignInFlag','补卡标志','char(6)',0,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 166,18,'AttendanceDetail','LateTime1','迟到时间1','numeric(18, 0)',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 167,18,'AttendanceDetail','LateTime2','迟到时间2','numeric(18, 2)',0,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 168,18,'AttendanceDetail','LateTime3','迟到时间3','numeric(18, 2)',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 169,18,'AttendanceDetail','LeaveEarlyTime1','早退时间1','numeric(18, 2)',0,22)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 170,18,'AttendanceDetail','LeaveEarlyTime2','早退时间2','numeric(18, 2)',0,23)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 171,18,'AttendanceDetail','LeaveEarlyTime3','早退时间3','numeric(18, 2)',0,24)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 172,18,'AttendanceDetail','WorkTime1','工作时间1','numeric(18, 0)',0,25)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 173,18,'AttendanceDetail','WorkTime2','工作时间2','numeric(18, 0)',0,26)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 174,18,'AttendanceDetail','WorkTime3','工作时间3','numeric(18, 0)',0,27)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 175,18,'AttendanceDetail','WorkTime','总工作时间','numeric(18, 2)',0,28)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 176,18,'AttendanceDetail','OtTime','总超时加班','numeric(18, 2)',0,29)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 177,18,'AttendanceDetail','Absent','旷工','numeric(18, 2)',0,30)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 178,18,'AttendanceDetail','WorkDay','出勤','numeric(18, 2)',0,31)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 179,18,'AttendanceDetail','AnnualVacation','Holiday','年假','numeric(18, 2)',0,32)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 180,18,'AttendanceDetail','PersonalLeave','Holiday','事假','numeric(18, 2)',0,33)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 181,18,'AttendanceDetail','SickLeave','Holiday','病假','numeric(18, 2)',0,34)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 182,18,'AttendanceDetail','InjuryLeave','Holiday','工伤','numeric(18, 2)',0,35)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 183,18,'AttendanceDetail','WeddingLeave','Holiday','婚假','numeric(18, 2)',0,36)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 184,18,'AttendanceDetail','MaternityLeave','Holiday','产假','numeric(18, 2)',0,37)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 185,18,'AttendanceDetail','OnTrip','出差','numeric(18, 2)',0,38)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 186,18,'AttendanceDetail','FuneralLeave','Holiday','丧假','numeric(18, 2)',0,39)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 187,18,'AttendanceDetail','CompensatoryLeave','Holiday','补假','numeric(18, 2)',0,40)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 188,18,'AttendanceDetail','PublicHoliday','Holiday','法定假','numeric(18, 2)',0,41)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 189,18,'AttendanceDetail','OtherLeave','Holiday','其他假','numeric(18, 2)',0,42)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 190,18,'AttendanceDetail','VisitLeave','Holiday','探亲假','numeric(18, 2)',0,43)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 191,18,'AttendanceDetail','LactationLeave','Holiday','哺乳假','numeric(18, 2)',0,44)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 192,19,'BrushCardAttend','Card','卡号','bigint',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 193,19,'BrushCardAttend','ControllerId','控制器ID','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 194,19,'BrushCardAttend','RecordID','记录ID','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 195,19,'BrushCardAttend','EmployeeId','职员ID','int',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 196,19,'BrushCardAttend','BrushTime','刷卡时间','datetime',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 197,19,'BrushCardAttend','Door','进出门','nvarchar(2)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 198,19,'BrushCardAttend','property','属性','smallint',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 199,20,'ControllerDataSync','ID','ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 200,20,'ControllerDataSync','ControllerId','控制器ID','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 201,20,'ControllerDataSync','OperateUser','操作用户','nvarchar(20)',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 202,20,'ControllerDataSync','SyncType','同步类型','nvarchar(20)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 203,20,'ControllerDataSync','SyncStatus','是否同步','smallint',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 204,20,'ControllerDataSync','SyncTime','同步时间','datetime',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 205,20,'ControllerDataSync','TrueTimeInfo','监控信息','nvarchar(60)',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 206,21,'Controllers','ConnectMode','连接方式','nvarchar(50)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 207,21,'Controllers','WorkType','工作目的','nvarchar(50)',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 208,21,'Controllers','ControllerNumber','设备编号','nvarchar(10)',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 209,21,'Controllers','ControllerName','设备名称','nvarchar(10)',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 210,21,'Controllers','Location','位置','nvarchar(20)',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 211,21,'Controllers','StorageMode','存储方式','nvarchar(50)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 212,21,'Controllers','IsFingerprint','含指纹模块','bit',1,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 213,21,'Controllers','ServerIP','服务器地址','nvarchar(50)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 214,21,'Controllers','DNS','DNS','nvarchar(20)',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 215,21,'Controllers','DoorType','门','nvarchar(20)',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 216,21,'Controllers','CardReader1','读卡器1','nvarchar(10)',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 217,21,'Controllers','CardReader2','读卡器2','nvarchar(10)',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 218,21,'Controllers','DoorLocation1','门位置1','nvarchar(50)',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 219,21,'Controllers','DoorLocation2','门位置2','nvarchar(50)',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 220,21,'Controllers','Sound','语音音量','int',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 221,21,'Controllers','IP','IP','nvarchar(30)',1,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 222,21,'Controllers','AntiPassBackType','防遣返方式','bit',1,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 223,21,'Controllers','SystemPassword','设备设置密码','nvarchar(20)',0,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 224,21,'Controllers','DownPhoto','下载照片','bit',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 225,21,'Controllers','WaitTime','等待时间','int',0,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 226,21,'Controllers','ControllerId','控制器ID','int',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 227,21,'Controllers','ScreenFile1','屏保文件1','image',0,22)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 228,21,'Controllers','ScreenFile2','屏保文件2','image',0,23)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 229,21,'Controllers','MASK','MASK','nvarchar(20)',0,24)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 230,21,'Controllers','GateWay','网关','nvarchar(20)',0,25)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 231,21,'Controllers','DataUpdateTime','数据上传下载间隔','int',0,26)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 232,21,'Controllers','DownFingerprint','下载指纹','bit',0,27)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 233,21,'Controllers','EnableDHCP','启用IP','bit',0,28)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 234,21,'Controllers','DNS2','备用DNS','nvarchar(20)',0,29)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 235,21,'Controllers','CloseLightTime','关闭背光时间','smallint',0,30)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 236,21,'Controllers','BoardType','控制板类型','nvarchar(50)',0,31)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 237,21,'Controllers','FieldVal1','保留字段1值','nvarchar(50)',0,32)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 238,21,'Controllers','FieldDesc1','保留字段1说明','nvarchar(50)',0,33)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 239,21,'Controllers','FieldVal2','保留字段2值','nvarchar(50)',0,34)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 240,21,'Controllers','FieldDesc2','保留字段2说明','nvarchar(50)',0,35)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 241,21,'Controllers','FieldVal3','保留字段3值','nvarchar(50)',0,36)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 242,21,'Controllers','FieldDesc3','保留字段3说明','nvarchar(50)',0,37)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 243,21,'Controllers','FieldVal4','保留字段4值','nvarchar(50)',0,38)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 244,21,'Controllers','FieldDesc4','保留字段4说明','nvarchar(50)',0,39)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 245,21,'Controllers','FieldVal5','保留字段5值','nvarchar(50)',0,40)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 246,21,'Controllers','FieldDesc5','保留字段5说明','nvarchar(50)',0,41)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 247,22,'ControllerHoliday','TemplateId','假期模板ID','int',1,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 248,22,'ControllerHoliday','TemplateName','假期模板名称','nvarchar(50)',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 249,22,'ControllerHoliday','ControllerId','控制器ID','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 250,22,'ControllerHoliday','Status','同步状态','bit',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 251,22,'ControllerHoliday','RecordID','RecordID','int',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 252,22,'ControllerHoliday','HolidayCode','假期表编码','int',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 253,24,'ControllerTemplateHoliday','HolidayNumber','假期编码','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 254,24,'ControllerTemplateHoliday','HolidayDate','日期','nvarchar(5)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 255,24,'ControllerTemplateHoliday','HolidayName','假期名','nvarchar(50)',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 256,24,'ControllerTemplateHoliday','TemplateId','模板ID','int',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 257,24,'ControllerTemplateHoliday','RecordID','RecordID','int',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 258,25,'ControllerTemplates','TemplateId','模板ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 259,25,'ControllerTemplates','TemplateType','模板类型','nchar(1)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 260,25,'ControllerTemplates','TemplateName','模板名称','nvarchar(50)',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 261,25,'ControllerTemplates','EmployeeDesc','进出职员','ntext',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 262,25,'ControllerTemplates','EmployeeCode','进出职员条件','ntext',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 263,25,'ControllerTemplates','EmployeeController','进出设备','nvarchar(20)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 264,25,'ControllerTemplates','EmployeeScheID','进出时间表','smallint',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 265,25,'ControllerTemplates','EmployeeDoor','进出门','nvarchar(20)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 266,26,'ControllerSchedule','ScheduleCode','时间表编号','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 267,26,'ControllerSchedule','ControllerId','控制器Id','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 268,26,'ControllerSchedule','Status','同步状态','bit',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 269,26,'ControllerSchedule','TemplateName','时间模板名称','nvarchar(50)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 270,26,'ControllerSchedule','TemplateId','时间模板ID','int',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 271,26,'ControllerSchedule','RecordID','RecordID','int',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 272,28,'ControllerTemplateSchedule','EndTime5','截止时间5','nvarchar(5)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 273,28,'ControllerTemplateSchedule','StartTime3','开始时间3','nvarchar(5)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 274,28,'ControllerTemplateSchedule','StartTime5','开始时间5','nvarchar(5)',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 275,28,'ControllerTemplateSchedule','WeekDay','星期','nvarchar(50)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 276,28,'ControllerTemplateSchedule','HolidayTemplateId','假期表模板ID','smallint',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 277,28,'ControllerTemplateSchedule','EndTime2','截止时间2','nvarchar(5)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 278,28,'ControllerTemplateSchedule','EndTime3','截止时间3','nvarchar(5)',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 279,28,'ControllerTemplateSchedule','StartTime2','开始时间2','nvarchar(5)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 280,28,'ControllerTemplateSchedule','StartTime4','开始时间4','nvarchar(5)',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 281,28,'ControllerTemplateSchedule','EndTime1','截止时间1','nvarchar(5)',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 282,28,'ControllerTemplateSchedule','EndTime4','截止时间4','nvarchar(5)',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 283,28,'ControllerTemplateSchedule','TemplateId','模板ID','int',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 284,28,'ControllerTemplateSchedule','StartTime1','开始时间1','nvarchar(5)',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 285,29,'ControllerInout','RecordID','记录ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 286,29,'ControllerInout','Out4','输出4','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 287,29,'ControllerInout','Out3','输出3','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 288,29,'ControllerInout','ScheduleName','时间表','nvarchar(50)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 289,29,'ControllerInout','Out5','输出5','int',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 290,29,'ControllerInout','Out1','输出1','int',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 291,29,'ControllerInout','InoutDesc','输入说明','nvarchar(50)',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 292,29,'ControllerInout','InoutPoint','输入','int',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 293,29,'ControllerInout','ControllerId','控制器Id','int',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 294,29,'ControllerInout','ScheduleID','时间表ID','int',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 295,29,'ControllerInout','Out2','输出2','int',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 296,29,'ControllerInout','Status','同步状态','bit',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 297,30,'ControllerTemplateInout','InoutDesc','输入说明','nvarchar(50)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 298,30,'ControllerTemplateInout','InoutPoint','输入','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 299,30,'ControllerTemplateInout','Out1','输出1','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 300,30,'ControllerTemplateInout','Out2','输出2','int',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 301,30,'ControllerTemplateInout','Out5','输出5','int',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 302,30,'ControllerTemplateInout','TemplateId','模板ID','int',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 303,30,'ControllerTemplateInout','Out4','输出4','int',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 304,30,'ControllerTemplateInout','ScheduleName','时间表','nvarchar(50)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 305,30,'ControllerTemplateInout','Out3','输出3','int',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 306,30,'ControllerTemplateInout','ScheduleId','时间表ID','int',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 307,31,'ControllerEmployee','RecordID','记录ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 308,31,'ControllerEmployee','ControllerId','设备ID','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 309,31,'ControllerEmployee','EmployeeId','员工ID','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 310,31,'ControllerEmployee','ScheduleCode','时间表','int',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 311,31,'ControllerEmployee','EmployeeDoor','进出门','nvarchar(20)',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 312,31,'ControllerEmployee','UserPassword','用户密码','nvarchar(20)',1,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 313,31,'ControllerEmployee','PassBackFlag','防遣返','bit',1,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 314,31,'ControllerEmployee','Status','同步状态','bit',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 315,31,'ControllerEmployee','DeleteFlag','删除标志','bit',1,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 316,31,'ControllerEmployee','ValidateMode','验证方式','nvarchar(20)',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 317,31,'ControllerEmployee','Floor','电梯楼层权限','nvarchar(700)',1,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 318,31,'ControllerEmployee','CombinationID','开门分组IDs','int',1,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 319,32,'TempShifts','AdjustDate','日期','datetime',1,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 320,32,'TempShifts','ShiftName','调整后班次','nvarchar(50)',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 321,32,'TempShifts','StretchShift','弹性班次','bit',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 322,32,'TempShifts','ShiftTime','基本工时','numeric(5,2)',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 323,32,'TempShifts','Degree','上班次数','int',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 324,32,'TempShifts','Night','过夜','bit',1,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 325,32,'TempShifts','ArestTime','中间休息1','int',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 326,32,'TempShifts','AcalculateLate','允许迟到1','int',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 327,32,'TempShifts','AcalculateEarly','允许早退1','int',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 328,32,'TempShifts','ShiftId','班次ID','int',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 329,32,'TempShifts','AoffDutyEnd','下班截止1','datetime',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 330,32,'TempShifts','TempShiftID','临时班次ID','int',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 331,32,'TempShifts','EmployeeExpress','职员条件','ntext',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 332,32,'TempShifts','EmployeeDesc','职员说明','ntext',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 333,32,'TempShifts','CrestTime','中间休息3','int',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 334,32,'TempShifts','CcalculateLate','允许迟到3','int',0,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 335,32,'TempShifts','CcalculateEarly','允许早退3','int',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 336,32,'TempShifts','BonDuty','上班标准2','datetime',0,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 337,32,'TempShifts','AoffDutyStart','下班开始1','datetime',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 338,32,'TempShifts','CoffDuty','下班标准3','datetime',0,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 339,32,'TempShifts','AoffDuty','下班标准1','datetime',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 340,32,'TempShifts','CoffDutyEnd','下班截止3','datetime',0,22)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 341,32,'TempShifts','BoffDutyEnd','下班截止2','datetime',0,23)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 342,32,'TempShifts','ShiftType','班次类型','nchar(1)',0,24)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 343,32,'TempShifts','BonDutyEnd','上班截止2','datetime',0,25)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 344,32,'TempShifts','BoffDuty','下班标准2','datetime',0,26)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 345,32,'TempShifts','ConDutyEnd','上班截止3','datetime',0,27)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 346,32,'TempShifts','CoffDutyStart','下班开始3','datetime',0,28)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 347,32,'TempShifts','FirstOnDuty','第一次上下班','nvarchar(20)',0,29)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 348,32,'TempShifts','BonDutyStart','上班开始2','datetime',0,30)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 349,32,'TempShifts','AonDutyEnd','上班截止1','datetime',0,31)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 350,32,'TempShifts','ConDutyStart','上班开始3','datetime',0,32)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 351,32,'TempShifts','AonDutyStart','上班开始1','datetime',0,33)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 352,32,'TempShifts','BoffDutyStart','下班开始2','datetime',0,34)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 353,32,'TempShifts','AonDuty','上班标准1','datetime',0,35)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 354,32,'TempShifts','BrestTime','中间休息2','int',0,36)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 355,32,'TempShifts','BcalculateLate','允许迟到2','int',0,37)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 356,32,'TempShifts','BcalculateEarly','允许早退2','int',0,38)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 357,32,'TempShifts','ConDuty','上班标准3','datetime',0,39)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 358,32,'TempShifts','Description','调整说明','nvarchar(200)',0,40)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 359,33,'AttendanceAskForLeave','Status','状态','nvarchar(50)',1,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 360,33,'AttendanceAskForLeave','AskForLeaveType','假别','nvarchar(50)',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 361,33,'AttendanceAskForLeave','TransactThing','拟办事项','nvarchar(100)',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 362,33,'AttendanceAskForLeave','Note','说明','nvarchar(100)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 363,33,'AttendanceAskForLeave','AskForLeaveId','请假ID','int',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 364,33,'AttendanceAskForLeave','EmployeeId','职员ID','int',1,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 365,33,'AttendanceAskForLeave','SumTotal','合计','nvarchar(8)',1,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 366,33,'AttendanceAskForLeave','StartTime','开始时间','datetime',1,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 367,33,'AttendanceAskForLeave','EndTime','截止时间','datetime',1,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 368,33,'AttendanceAskForLeave','AllDay','整日','bit',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 369,33,'AttendanceAskForLeave','WorkFlowId','工作流ID','int',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 370,33,'AttendanceAskForLeave','WorkFlowName','工作流名称','nvarchar(50)',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 371,33,'AttendanceAskForLeave','OldStepId','撤消时的步骤ID','int',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 372,33,'AttendanceAskForLeave','OldTransactorId','撤消时的下步经办人ID','int',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 373,33,'AttendanceAskForLeave','NowStep','当前步骤','int',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 374,33,'AttendanceAskForLeave','NextStep','下一步','nvarchar(50)',1,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 375,33,'AttendanceAskForLeave','TransactorDesc','经办人说明','nvarchar(50)',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 376,33,'AttendanceAskForLeave','TransactorId','经办人ID','int',0,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 377,33,'AttendanceAskForLeave','TransactorName','经办人姓名','nvarchar(50)',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 378,33,'AttendanceAskForLeave','DeputizeId','代理人ID','int',0,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 379,33,'AttendanceAskForLeave','DeputizeName','代理人姓名','nvarchar(50)',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 380,34,'LogEvent','EventID','日志ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 381,34,'LogEvent','Actions','操作','nvarchar(50)',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 382,34,'LogEvent','LoginMachine','登录机器','nvarchar(50)',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 383,34,'LogEvent','Modules','模块','nvarchar(200)',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 384,34,'LogEvent','LoginName','用户名','nvarchar(50)',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 385,34,'LogEvent','Objects','对象','nvarchar(200)',1,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 386,34,'LogEvent','LoginDate','时间','datetime',1,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 387,34,'LogEvent','UserName','用户名','nvarchar(50)',1,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 388,35,'AttendanceOndutyRule','EmployeeDesc','员工说明','ntext',1,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 389,35,'AttendanceOndutyRule','OnDutyMode','上班方式','nvarchar(20)',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 390,35,'AttendanceOndutyRule','Friday1','周五(1)','nvarchar(50)',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 391,35,'AttendanceOndutyRule','Wednesday1','周三(1)','nvarchar(50)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 392,35,'AttendanceOndutyRule','Thursday1','周四(1)','nvarchar(50)',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 393,35,'AttendanceOndutyRule','Saturday1','周六(1)','nvarchar(50)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 394,35,'AttendanceOndutyRule','Tuesday1','周二(1)','nvarchar(50)',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 395,35,'AttendanceOndutyRule','Wednesday2','周三(2)','nvarchar(50)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 396,35,'AttendanceOndutyRule','EmployeeCode','职员代码','ntext',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 397,35,'AttendanceOndutyRule','Thursday2','周四(2)','nvarchar(50)',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 398,35,'AttendanceOndutyRule','Friday2','周五(2)','nvarchar(50)',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 399,35,'AttendanceOndutyRule','FirstWeekDate','第一周开始日','datetime',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 400,35,'AttendanceOndutyRule','Tuesday2','周二(2)','nvarchar(50)',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 401,35,'AttendanceOndutyRule','Monday1','周一(1)','nvarchar(50)',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 402,35,'AttendanceOndutyRule','Sunday1','周日(1)','nvarchar(50)',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 403,35,'AttendanceOndutyRule','Sunday2','周日(2)','nvarchar(50)',0,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 404,35,'AttendanceOndutyRule','RuleId','规则ID','int',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 405,35,'AttendanceOndutyRule','NoBrushCard','免打卡','bit',1,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 406,35,'AttendanceOndutyRule','Saturday2','周六(2)','nvarchar(50)',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 407,35,'AttendanceOndutyRule','Monday2','周一(2)','nvarchar(50)',0,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 408,36,'AttendanceOnDutyRuleChange','ChangeId','变动ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 409,36,'AttendanceOnDutyRuleChange','Monday1','周一(1)','nvarchar(50)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 410,36,'AttendanceOnDutyRuleChange','FirstWeekDate','第一周开始日','datetime',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 411,36,'AttendanceOnDutyRuleChange','Saturday2','周六(2)','nvarchar(50)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 412,36,'AttendanceOnDutyRuleChange','OnDutyMode','上班方式','nvarchar(20)',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 413,36,'AttendanceOnDutyRuleChange','NoBrushCard','免打卡','bit',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 414,36,'AttendanceOnDutyRuleChange','Sunday2','周日(2)','nvarchar(50)',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 415,36,'AttendanceOnDutyRuleChange','Sunday1','周日(1)','nvarchar(50)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 416,36,'AttendanceOnDutyRuleChange','EmployeeDesc','职员说明','ntext',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 417,36,'AttendanceOnDutyRuleChange','Saturday1','周六(1)','nvarchar(50)',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 418,36,'AttendanceOnDutyRuleChange','Friday2','周五(2)','nvarchar(50)',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 419,36,'AttendanceOnDutyRuleChange','Thursday1','周四(1)','nvarchar(50)',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 420,36,'AttendanceOnDutyRuleChange','EmployeeCode','职员代码','ntext',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 421,36,'AttendanceOnDutyRuleChange','Friday1','周五(1)','nvarchar(50)',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 422,36,'AttendanceOnDutyRuleChange','Wednesday1','周三(1)','nvarchar(50)',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 423,36,'AttendanceOnDutyRuleChange','RuleId','规则ID','int',0,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 424,36,'AttendanceOnDutyRuleChange','ChangeDate','变动日期','datetime',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 425,36,'AttendanceOnDutyRuleChange','Wednesday2','周三(2)','nvarchar(50)',0,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 426,36,'AttendanceOnDutyRuleChange','Thursday2','周四(2)','nvarchar(50)',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 427,36,'AttendanceOnDutyRuleChange','Monday2','周一(2)','nvarchar(50)',0,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 428,36,'AttendanceOnDutyRuleChange','Tuesday2','周二(2)','nvarchar(50)',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 429,36,'AttendanceOnDutyRuleChange','Tuesday1','周二(1)','nvarchar(50)',0,22)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 430,37,'EventRecord','RecordID','记录ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 431,37,'EventRecord','ControllerID','控制器编号','nvarchar(10)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 432,37,'EventRecord','InputPoint','输入点','nvarchar(2)',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 433,37,'EventRecord','OccurTime','发生时间','datetime',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 434,38,'Options','VariableType','类型','nvarchar(50)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 435,38,'Options','VariableId','变量ID','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 436,38,'Options','VariableDesc','说明','nvarchar(50)',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 437,38,'Options','VariableValue','值','nvarchar(500)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 438,38,'Options','VariableName','变量名','nvarchar(50)',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 439,39,'Users','LoginName','登录名','nvarchar(50)',1,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 440,39,'Users','UserId','用户ID','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 441,39,'Users','EmployeeId','职员ID','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 442,39,'Users','Name','职员姓名','nvarchar(50)',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 443,39,'Users','PrivateUser','私用帐号','bit',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 444,39,'Users','UserPassword','用户密码','nvarchar(20)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 445,39,'Users','OperableEmployees','可操作职员','bit',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 446,39,'Users','OperableExpress','职员表达式','nvarchar(20)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 447,39,'Users','VisitTimeLeave','访问请假时间','nvarchar(19)',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 448,39,'Users','VisitTimeOntrip','访问出差时间','nvarchar(19)',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 449,39,'Users','VisitTimeSignIn','访问补卡时间','nvarchar(19)',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 450,39,'Users','VisitTimeOT','访问加班时间','nvarchar(19)',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 451,39,'Users','VisitProbation','访问转正模块时间','nvarchar(19)',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 452,39,'Users','VisitDimission','访问离职模块时间','nvarchar(19)',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 453,40,'AttendanceTotalYear','LateTime_0','迟到时间(平)','numeric(18, 2)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 454,40,'AttendanceTotalYear','InjuryLeave','Holiday','工伤','numeric(18, 2)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 455,40,'AttendanceTotalYear','WeddingLeave','Holiday','婚假','numeric(18, 2)',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 456,40,'AttendanceTotalYear','OtherLeave','Holiday','女性假','numeric(18, 2)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 457,40,'AttendanceTotalYear','LactationLeave','Holiday','哺乳假','numeric(18, 2)',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 458,40,'AttendanceTotalYear','VisitLeave','Holiday','探亲假','numeric(18, 2)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 459,40,'AttendanceTotalYear','OnTrip','Holiday','出差','numeric(18, 2)',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 460,40,'AttendanceTotalYear','CompensatoryLeave','Holiday','补假','numeric(18, 2)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 461,40,'AttendanceTotalYear','AbnormityCount_0','异常次数(平)','numeric(18, 2)',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 462,40,'AttendanceTotalYear','FuneralLeave','Holiday','丧假','numeric(18, 2)',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 463,40,'AttendanceTotalYear','PersonalLeave','Holiday','事假','numeric(18, 2)',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 464,40,'AttendanceTotalYear','OtTime_0','超时加班(平)','numeric(18, 2)',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 465,40,'AttendanceTotalYear','Absent','旷工','numeric(18, 2)',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 466,40,'AttendanceTotalYear','WorkTime_0','工作时间(平)','numeric(18, 2)',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 467,40,'AttendanceTotalYear','AttendMonth','月份','nvarchar(7)',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 468,40,'AttendanceTotalYear','MaternityLeave','Holiday','产假','numeric(18, 2)',0,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 469,40,'AttendanceTotalYear','LateCount_0','迟到次数(平)','numeric(18, 2)',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 470,40,'AttendanceTotalYear','EmployeeId','职员ID','int',0,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 471,40,'AttendanceTotalYear','WorkTime_1','工作时间(休)','numeric(18, 2)',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 472,40,'AttendanceTotalYear','LeaveEarlyCount_0','早退次数(平)','numeric(18, 2)',0,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 473,40,'AttendanceTotalYear','SickLeave','Holiday','病假','numeric(18, 2)',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 474,40,'AttendanceTotalYear','LeaveEarlyTime_0','早退时间(平)','numeric(18, 2)',0,22)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 475,40,'AttendanceTotalYear','PublicHoliday','Holiday','法定假','numeric(18, 2)',0,23)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 476,40,'AttendanceTotalYear','AnnualVacation','Holiday','年假','numeric(18, 2)',0,24)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 477,40,'AttendanceTotalYear','WorkTime_2','工作时间(假)','numeric(18, 2)',0,25)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 478,40,'AttendanceTotalYear','WorkDay_0','出勤(平)','numeric(18, 2)',0,26)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 479,40,'AttendanceTotalYear','AnnualVacationRemanent','上年度剩余年假','numeric(18, 2)',0,27)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 480,40,'AttendanceTotalYear','AnnualVacationYear','应休年假','numeric(18, 2)',0,28)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 481,41,'AttendanceOT','Status','状态','nvarchar(50)',1,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 482,41,'AttendanceOT','Note','事由','nvarchar(100)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 483,41,'AttendanceOT','OTId','请假ID','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 484,41,'AttendanceOT','EmployeeId','职员ID','int',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 485,41,'AttendanceOT','SumTotal','合计','nvarchar(8)',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 486,41,'AttendanceOT','StartTime','开始时间','datetime',1,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 487,41,'AttendanceOT','EndTime','截止时间','datetime',1,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 488,41,'AttendanceOT','AllDay','整天','bit',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 489,41,'AttendanceOT','WorkFlowId','工作流ID','int',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 490,41,'AttendanceOT','WorkFlowName','工作流名称','nvarchar(50)',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 491,41,'AttendanceOT','OldStepId','撤消时的步骤ID','int',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 492,41,'AttendanceOT','OldTransactorId','撤消时的下步经办ID','int',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 493,41,'AttendanceOT','NowStep','当前步骤','int',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 494,41,'AttendanceOT','NextStep','下一步','nvarchar(50)',1,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 495,41,'AttendanceOT','TransactorDesc','经办人说明','nvarchar(50)',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 496,41,'AttendanceOT','TransactorId','经办人ID','int',0,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 497,41,'AttendanceOT','TransactorName','经办人姓名','nvarchar(50)',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 498,42,'TotalMonth','TotalMonth','统计月份','nvarchar(10)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 499,42,'TotalMonth','StartDate','开始日期','datetime',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 500,42,'TotalMonth','EndDate','截止日期','datetime',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 501,43,'CombinationDoor','RecordID','RecordID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 502,43,'CombinationDoor','CombinationID','组ID','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 503,43,'CombinationDoor','EmployeeId','EmployeeId','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 504,43,'CombinationDoor','OpenOrder','开门顺序','int',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 505,45,'TableFieldCode','FieldId','字段ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 506,45,'TableFieldCode','Content','内容','nvarchar(50)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 507,35,'AttendanceOndutyRule','LoopCount','循环天数','bit',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 508,35,'AttendanceOndutyRule','day15','循环(15)','nvarchar(50)',0,22)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 509,35,'AttendanceOndutyRule','day16','循环(16)','nvarchar(50)',0,23)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 510,35,'AttendanceOndutyRule','day17','循环(17)','nvarchar(50)',0,24)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 511,35,'AttendanceOndutyRule','day18','循环(18)','nvarchar(50)',0,25)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 512,35,'AttendanceOndutyRule','day19','循环(19)','nvarchar(50)',0,26)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 513,35,'AttendanceOndutyRule','day20','循环(20)','nvarchar(50)',0,27)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 514,35,'AttendanceOndutyRule','day21','循环(21)','nvarchar(50)',0,28)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 515,35,'AttendanceOndutyRule','day22','循环(22)','nvarchar(50)',0,29)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 516,35,'AttendanceOndutyRule','day23','循环(23)','nvarchar(50)',0,30)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 517,35,'AttendanceOndutyRule','day24','循环(24)','nvarchar(50)',0,31)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 518,35,'AttendanceOndutyRule','day25','循环(25)','nvarchar(50)',0,32)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 519,35,'AttendanceOndutyRule','day26','循环(26)','nvarchar(50)',0,33)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 520,35,'AttendanceOndutyRule','day27','循环(27)','nvarchar(50)',0,34)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 521,35,'AttendanceOndutyRule','day28','循环(28)','nvarchar(50)',0,35)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 522,35,'AttendanceOndutyRule','day28','循环(29)','nvarchar(50)',0,36)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 523,35,'AttendanceOndutyRule','day30','循环(30)','nvarchar(50)',0,37)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 524,35,'AttendanceOndutyRule','day31','循环(31)','nvarchar(50)',0,38)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 525,36,'AttendanceOnDutyRuleChange','LoopCount','循环天数','bit',0,23)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 526,36,'AttendanceOnDutyRuleChange','day15','循环(15)','nvarchar(50)',0,24)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 527,36,'AttendanceOnDutyRuleChange','day16','循环(16)','nvarchar(50)',0,25)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 528,36,'AttendanceOnDutyRuleChange','day17','循环(17)','nvarchar(50)',0,26)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 529,36,'AttendanceOnDutyRuleChange','day18','循环(18)','nvarchar(50)',0,27)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 530,36,'AttendanceOnDutyRuleChange','day19','循环(19)','nvarchar(50)',0,28)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 531,36,'AttendanceOnDutyRuleChange','day20','循环(20)','nvarchar(50)',0,29)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 532,36,'AttendanceOnDutyRuleChange','day21','循环(21)','nvarchar(50)',0,30)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 533,36,'AttendanceOnDutyRuleChange','day22','循环(22)','nvarchar(50)',0,31)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 534,36,'AttendanceOnDutyRuleChange','day23','循环(23)','nvarchar(50)',0,32)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 535,36,'AttendanceOnDutyRuleChange','day24','循环(24)','nvarchar(50)',0,33)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 536,36,'AttendanceOnDutyRuleChange','day25','循环(25)','nvarchar(50)',0,34)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 537,36,'AttendanceOnDutyRuleChange','day26','循环(26)','nvarchar(50)',0,35)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 538,36,'AttendanceOnDutyRuleChange','day27','循环(27)','nvarchar(50)',0,36)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 539,36,'AttendanceOnDutyRuleChange','day28','循环(28)','nvarchar(50)',0,37)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 540,36,'AttendanceOnDutyRuleChange','day28','循环(29)','nvarchar(50)',0,38)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 541,36,'AttendanceOnDutyRuleChange','day30','循环(30)','nvarchar(50)',0,39)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 542,36,'AttendanceOnDutyRuleChange','day31','循环(31)','nvarchar(50)',0,40)

INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 543,1,'AttendanceShifts','Overtime','超时休息','int',0,35)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 544,32,'TempShifts','Overtime','超时休息','int',0,41)
SET IDENTITY_INSERT [TableStructure] OFF
GO

--------------------------插入默认班次----------------------------------------
SET IDENTITY_INSERT [AttendanceOndutyRule] ON
INSERT [AttendanceOndutyRule] ([RuleId],[EmployeeDesc],[EmployeeCode],[OnDutyMode],[NoBrushCard],[Monday1],[Tuesday1],[Wednesday1],[Thursday1],[Friday1],[Saturday1],[Sunday1]) VALUES ( 1,'在职类型不等于离职','((left(IncumbencyStatus,1) not in(''1'')))','1-单周循环',0,'1-正常班','1-正常班','1-正常班','1-正常班','1-正常班','1-正常班','1-正常班')
SET IDENTITY_INSERT [AttendanceOndutyRule] OFF

SET IDENTITY_INSERT [AttendanceOnDutyRuleChange] ON
INSERT [AttendanceOnDutyRuleChange] ([ChangeId],[ChangeDate],[RuleId],[EmployeeDesc],[EmployeeCode],[OnDutyMode],[NoBrushCard],[Monday1],[Tuesday1],[Wednesday1],[Thursday1],[Friday1],[Saturday1],[Sunday1]) VALUES ( 1,'2011-05-01 0:00:00',1,'在职类型不等于离职','((left(IncumbencyStatus,1) not in(''1'')))','1-单周循环',0,'1-正常班','1-正常班','1-正常班','1-正常班','1-正常班','1-正常班','1-正常班')
SET IDENTITY_INSERT [AttendanceOnDutyRuleChange] OFF

SET IDENTITY_INSERT [AttendanceShifts] ON
INSERT [AttendanceShifts] ([ShiftId],[ShiftName],[StretchShift],[Degree],[Night],[FirstOnDuty],[ShiftTime],[AonDuty],[AonDutyStart],[AonDutyEnd],[AoffDuty],[AoffDutyStart],[AoffDutyEnd],[ArestTime],[AcalculateLate],[AcalculateEarly],[Overtime]) VALUES ( 1,'正常班',0,1,1,'0',8.00,'1900-01-01 9:00:00','1900-01-01 6:00:00','1900-01-01 13:29:59','1900-01-01 18:00:00','1900-01-01 13:30:00','1900-01-02 5:59:59',60,5,0,0)
SET IDENTITY_INSERT [AttendanceShifts] OFF

SET IDENTITY_INSERT [TempShifts] ON
INSERT [TempShifts] ([TempShiftID],[ShiftType],[ShiftId],[ShiftName],[StretchShift],[Degree],[Night],[FirstOnDuty],[ShiftTime],[AonDuty],[AonDutyStart],[AonDutyEnd],[AoffDuty],[AoffDutyStart],[AoffDutyEnd],[ArestTime],[Overtime]) VALUES ( 1,'0',1,'正常班',0,1,1,'0',8.00,'1900-01-01 9:00:00','1900-01-01 6:00:00','1900-01-01 13:29:59','1900-01-01 18:00:00','1900-01-01 13:30:00','1900-01-02 5:59:59',60,0)
SET IDENTITY_INSERT [TempShifts] OFF

--------------------------插入默认班次  结束----------------------------------------



---------------------按钮事件进出明细 ---------------------
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysObjects where name = 'V_EventRecord'
			and type = 'v')
	drop View V_EventRecord
GO

Create View [V_EventRecord]
As
Select B.RecordID,B.Controllerid,B.InputPoint,B.OccurTime,
	CONVERT(CHAR(10),B.OccurTime,108) as OccurTime2
	From  EventRecord B
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
--------------------End 按钮事件进出明细--------------------------------

------------导出考勤卡存储过程
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

if exists (select name from sysObjects where name = 'pExportAttendCard' and type = 'p')
	drop Procedure pExportAttendCard
GO


CREATE   PROCEDURE [pExportAttendCard]
	--日期 格式:'2015-04-01' and '2015-04-30'  
    @strDate		varchar(100),
	--统计月份  格式:'2015-04'      
    @strAttendMonth		varchar(50), 
  
	--查询的条件(加where)  如： where Employeeid = 1 or card=123         
    @strWhere    nvarchar(max) = ''
AS
DECLARE @strSQL  nvarchar(max)
DECLARE @EmployeeId int        
DECLARE @DepartmentName nvarchar(100)
DECLARE @Name nvarchar(50)
DECLARE @Number nvarchar(50)
DECLARE @Card bigint  
DECLARE @strTemp nvarchar(2000)

IF object_id('tempdb.dbo.#tempAttendCard') IS not null
	DROP TABLE #tempAttendCard

create table #tempAttendCard (
RecordID			int				identity,
DepartmentName      nvarchar(100)   null,
Name				nvarchar(50)	null,
Number				nvarchar(50)	null,
DataType			bit	null,
OnDutyDate          nvarchar(100)    null,
NoBrushCard          nvarchar(50)             null,
ShiftName            nvarchar(50)          null,
OnDuty1              nvarchar(50)              null,
OffDuty1             nvarchar(50)              null,
OnDuty2              nvarchar(50)              null,
OffDuty2             nvarchar(50)              null,
OnDuty3              nvarchar(50)              null,
OffDuty3             nvarchar(50)              null,
WorkTime             numeric(18, 2)       null,
LateTime            numeric(18, 2)       null,
LeaveEarlyTime      numeric(18, 2)       null,
OtTime               numeric(18, 2)       null
)

if exists( select * from master.dbo.syscursors where cursor_name='My_Cursor_Card')
	DEALLOCATE  My_Cursor_Card 

set @strSQL='declare My_Cursor_Card cursor for select E.EmployeeID,D.DepartmentName,E.Name,E.Number,E.Card from Employees E left join Departments D on E.DepartmentID = D.DepartmentID '
if @strWhere <> '' 
begin
	set @strSQL = @strSQL + ' ' + @strWhere
end 
exec sp_executesql  @strSQL
   
OPEN My_Cursor_Card; --打开游标
FETCH NEXT FROM My_Cursor_Card INTO @EmployeeId,@DepartmentName,@Name,@Number,@Card; --读取第一行数据,并将值保存于变量中
WHILE @@FETCH_STATUS = 0
    BEGIN
    
		Insert INTO #tempAttendCard(DepartmentName,Name,Number,DataType,OnDutyDate) Select @DepartmentName,@Name,@Number,1,@EmployeeId

		set @strTemp = 'Insert INTO #tempAttendCard(DataType,OnDutyDate,NoBrushCard,ShiftName,OnDuty1,OffDuty1,OnDuty2,OffDuty2,OnDuty3,OffDuty3,WorkTime,LateTime,LeaveEarlyTime,OtTime) 
		select 0,convert(varchar(10),OnDutyDate, 121) as OnDutyDate1,(case Nobrushcard when 1 then (case Substring(OnDutyType, 1, 1) when ''0'' then ''(免卡)'' else '''' end)  else '''' end) as 
		Nobrushcard,ShiftName,convert(nvarchar(20),OnDuty1,120) as OnDuty1,convert(nvarchar(20),OffDuty1,120) as OffDuty1,convert(nvarchar(20),OnDuty2,120) as OnDuty2,convert(nvarchar(20),OffDuty2,120) as 
		OffDuty2,convert(nvarchar(20),OnDuty3,120) as OnDuty3,convert(nvarchar(20),OffDuty3,120) as OffDuty3,isnull(worktime,0) as 
		worktime,(isnull(LateTime1,0)+isnull(LateTime2,0)+isnull(LateTime3,0)) as 
		LateTime,(isnull(LeaveEarlyTime1,0)+isnull(LeaveEarlyTime2,0)+isnull(LeaveEarlyTime3,0)) as LeaveEarlyTime,isnull(OTtime,0) as OTtime from 
		AttendanceDetail where convert(varchar(10),OnDutyDate, 121) between '+@strDate+'  and Employeeid in ('''+convert(nvarchar(10),@EmployeeId)+''') order by OnDutyDate '
		
		exec( @strTemp)

		Exec('Insert INTO #tempAttendCard(DataType) select 0 ')

        FETCH NEXT FROM My_Cursor_Card INTO @EmployeeId,@DepartmentName,@Name,@Number,@Card; --读取下一行数据
    END
CLOSE My_Cursor_Card; --关闭游标
DEALLOCATE My_Cursor_Card; --释放游标

Exec ('select * from #tempAttendCard order by RecordID ')

IF object_id('tempdb.dbo.#tempAttendCard') IS not null
	DROP TABLE #tempAttendCard


SET QUOTED_IDENTIFIER OFF  




--------------------考勤统计------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if exists (select name from sysObjects where name = 'pAutoShifts' and type = 'p')
	drop Procedure pAutoShifts
GO


Create  Procedure [pAutoShifts](@StartDate datetime,@EndDate datetime)
As
--处理班次规则
--按最新的处理方式处理班次规则。班次规则的处理将直接以attendanceondutyrulechange表的先后来处理。
Declare 
	@Ruleid int,
	@Nobrushcard bit,
	@Employeecode nvarchar(4000),
	@ChangeDate datetime
Declare @strSqlSet nvarchar(4000),
	@strSql nvarchar(4000)

Declare @SourceRuleid int
Declare @RuleCount int
Declare @Trulecount int 
Declare @Fchangedate datetime
Declare @Echangedate datetime
Declare @RuleSql nvarchar(4000)
Declare @Tchangedate datetime

Declare Csourerule cursor fast_forward
	for select Ruleid from attendanceondutyrule order by ruleid
open Csourerule
fetch Csourerule into @SourceRuleid
While @@fetch_status=0
	begin
		select @echangedate='1900-01-01',@tchangedate='1900-01-01',@fchangedate='1900-01-01'
		/*
		set @trulecount=0
		select @RuleCount=count(*) from AttendanceOndutyRulechange where ruleid=@Sourceruleid and changedate<=@enddate
		select @Trulecount=count(*) from attendanceondutyrulechange where ruleid=@sourceruleid and changedate>=@startdate and Changedate<=@enddate
		if  @RuleCount > @Trulecount 
			select @Trulecount=@Trulecount+1 
		--要用全局的临时表代替下面语句中的子查询
--		select @fchagedate=min(t.changedate) from (select top @trulecount * from AttendanceOndutyRulechange where ruleid=@Sourceruleid and changedate<=@enddate order by changedate desc) t

		If OBJECT_ID('Tempdb..##TempRule') is not null drop table ##TempRule
		set @RuleSql='select top '+ cast(@trulecount as varchar(20)) +' * into ##temprule from AttendanceOndutyRulechange where ruleid='+cast(@Sourceruleid as varchar(20)) +' and convert(char,changedate,120)<='''+ convert(char,@enddate,120) +''' order by changedate desc'
		exec (@RuleSql)
		select @fchangedate=min(changedate) from ##temprule
		If OBJECT_ID('Tempdb..##Temprule') is not null drop table ##Temprule
		*/
		--修改因全局临时表，在多用户统计时，相互删除的问题。
		select top 1 @fchangedate=changedate from  attendanceondutyrulechange where ruleid=@sourceruleid and changedate<=@startdate order by changedate desc
		if @fchangedate='1900-01-01' Set @fchangedate=@startdate

		Declare Crule Cursor fast_forward
			for Select changeid,Nobrushcard,Cast(Employeecode as nvarchar(4000)),Changedate from AttendanceOndutyRulechange where ruleid=@Sourceruleid and changedate>=@fchangedate and changedate<=@enddate order by changedate desc,changeid
		Open Crule
		Fetch Crule into @ruleid,@Nobrushcard,@Employeecode,@ChangeDate
		While @@Fetch_Status=0		
			Begin
				if @Echangedate='1900-01-01' 
					set @Echangedate=dateadd(dd,1,@enddate)

				if  @Echangedate=@changedate				
					set @Echangedate=@Tchangedate
				if @employeecode is  null or @employeecode ='' 
					begin
						if @changedate is not null
							set @strSql ='Update #AttendanceDetail set Ruleid='+Cast(@Ruleid as varchar(20))+',noBrushcard=' +cast(@Nobrushcard as varchar(1))+' where convert(char,ondutydate,120)>=''' +convert(char,@changedate,120) +''' and convert(char,ondutydate,120)<'''+convert(char,@echangedate,120) +''''
					end
				else
					begin
						if @changedate is not null						
							set @strSql ='Update #AttendanceDetail set Ruleid='+Cast(@Ruleid as varchar(20))+',noBrushcard=' +cast(@Nobrushcard as varchar(1))+'  where convert(char,ondutydate,120)>=''' +convert(char,@changedate,120)  +''' and convert(char,ondutydate,120)<'''+convert(char,@echangedate,120)+''' and employeeid in (select employeeid from employees where ' +cast(@Employeecode as varchar(4000))+')'
					end
		
		--		set @strSql ='Update #AttendanceDetail set Ruleid='+Cast(@Ruleid as varchar(20))+',noBrushcard=' +cast(@Nobrushcard as varchar(1))+'  where employeeid in (select employeeid from employees where ' +cast(@Employeecode as varchar(4000))+')'
		--		print @strsql
				exec (@strsql)
				select @Tchangedate=@echangedate
				select @echangedate=@changedate
				Fetch Crule into @ruleid,@Nobrushcard,@Employeecode,@ChangeDate
			End
		Close Crule
		Deallocate Crule

		fetch Csourerule into @SourceRuleid
	end
Close Csourerule
deallocate Csourerule

--select * from #attendancedetail where employeeid=594
Update #AttendanceDetail set shiftid=  case  
         when datepart(dw,ondutydate)=1 then left(b.sunday1,patindex('%-%',b.sunday1)-1) 
         when datepart(dw,ondutydate)=2 then left(b.monday1,patindex('%-%',b.monday1)-1) 
         when datepart(dw,ondutydate)=3 then left(b.tuesday1,patindex('%-%',b.tuesday1)-1) 
         when datepart(dw,ondutydate)=4 then left(b.wednesday1,patindex('%-%',b.wednesday1)-1) 
         when datepart(dw,ondutydate)=5 then left(b.thursday1,patindex('%-%',b.thursday1)-1) 
         when datepart(dw,ondutydate)=6 then left(b.friday1,patindex('%-%',b.friday1)-1) 
         else  left(b.saturday1,patindex('%-%',b.saturday1)-1)  
         end  
         from #AttendanceDetail a,attendanceondutyrulechange b where a.Ruleid = b.changeid  and left(b.ondutymode,1)='1'

Update #AttendanceDetail set shiftid= 
         case 
         when (datediff(dd,b.firstweekdate,a.ondutydate) +datepart(dw,b.firstweekdate)) %14=1 then left(b.sunday1,patindex('%-%',b.sunday1)-1)
         when (datediff(dd,b.firstweekdate,a.ondutydate) +datepart(dw,b.firstweekdate)) %14=2 then left(b.monday1,patindex('%-%',b.monday1)-1)
         when (datediff(dd,b.firstweekdate,a.ondutydate) +datepart(dw,b.firstweekdate)) %14=3 then left(b.tuesday1,patindex('%-%',b.tuesday1)-1)
         when (datediff(dd,b.firstweekdate,a.ondutydate) +datepart(dw,b.firstweekdate)) %14=4 then left(b.wednesday1,patindex('%-%',b.wednesday1)-1)
         when (datediff(dd,b.firstweekdate,a.ondutydate) +datepart(dw,b.firstweekdate)) %14=5 then left(b.thursday1,patindex('%-%',b.thursday1)-1)
         when (datediff(dd,b.firstweekdate,a.ondutydate) +datepart(dw,b.firstweekdate)) %14=6 then left(b.friday1,patindex('%-%',b.friday1)-1)
         when (datediff(dd,b.firstweekdate,a.ondutydate) +datepart(dw,b.firstweekdate)) %14=7 then left(b.saturday1,patindex('%-%',b.saturday1)-1)
         when (datediff(dd,b.firstweekdate,a.ondutydate) +datepart(dw,b.firstweekdate)) %14=8 then left(b.sunday2,patindex('%-%',b.sunday2)-1)
         when (datediff(dd,b.firstweekdate,a.ondutydate) +datepart(dw,b.firstweekdate)) %14=9 then left(b.monday2,patindex('%-%',b.monday2)-1)
         when (datediff(dd,b.firstweekdate,a.ondutydate) % 14+datepart(dw,b.firstweekdate)) %14=10 then left(b.tuesday2,patindex('%-%',b.tuesday2)-1)
         when (datediff(dd,b.firstweekdate,a.ondutydate) % 14+datepart(dw,b.firstweekdate)) %14=11 then left(b.wednesday2,patindex('%-%',b.wednesday2)-1)
         when (datediff(dd,b.firstweekdate,a.ondutydate) % 14+datepart(dw,b.firstweekdate)) %14=12 then left(b.thursday2,patindex('%-%',b.thursday2)-1)
         when (datediff(dd,b.firstweekdate,a.ondutydate) % 14+datepart(dw,b.firstweekdate)) %14=13 then left(b.friday2,patindex('%-%',b.friday2)-1)
         else  left(b.saturday2,patindex('%-%',b.saturday2)-1)
         end
         from #AttendanceDetail a,attendanceondutyrulechange b where a.ruleid=b.changeid and left(b.ondutymode,1)='2'
If OBJECT_ID('Tempdb..#TempRules') is not null drop table #TempRules
select 1 as daynum,monday1 as value,changeid,changedate,loopcount into #TempRules  from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 2 as daynum,tuesday1 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 3 as daynum,wednesday1 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 4 as daynum,thursday1 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 5 as daynum,friday1 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 6 as daynum,saturday1 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 7 as daynum,sunday1 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 8 as daynum,monday2 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 9 as daynum,tuesday2 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 10 as daynum,wednesday2 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 11 as daynum,thursday2 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 12 as daynum,friday2 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 13 as daynum,saturday2 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 14 as daynum,sunday2 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 15 as daynum,day15 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 16 as daynum,day16 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 17 as daynum,day17 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 18 as daynum,day18 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 19 as daynum,day19 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 20 as daynum,day20 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 21 as daynum,day21 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 22 as daynum,day22 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 23 as daynum,day23 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 24 as daynum,day24 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 25 as daynum,day25 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 26 as daynum,day26 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 27 as daynum,day27 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 28 as daynum,day28 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 29 as daynum,day29 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 30 as daynum,day30 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
	union all select 31 as daynum,day31 as value,changeid,changedate,loopcount from attendanceondutyrulechange where left(ondutymode,1)='3'
Delete #TempRules where value is null or value=''
Update #TempRules set value=left(value,patindex('%-%',value)-1)
Update #AttendanceDetail set shiftid= t.value
	from #TempRules t
	where t.loopcount=31 and #attendancedetail.ruleid=t.changeid
	      and #attendancedetail.ondutydate>=t.changedate and day(#attendancedetail.ondutydate)=t.daynum
Declare @LoopCountchar varchar(8000),
	@LoopValues int,
	@CompareChar varchar(12)
Select @LoopCountChar=',',@LoopValues=1
select @loopCountchar=@LoopCountChar+cast(LoopCount as varchar(10))+',' from (select distinct LoopCount from #TempRules )t
While @loopValues<31
	begin
		Set @CompareChar=','+cast(@LoopValues as varchar(10))+','

		if  charindex(@Comparechar,@LoopCountChar,1)>0
			begin
				Update #attendancedetail set  shiftid=t.value
					from (select * from #temprules where loopcount=@loopvalues) t
					where   #attendancedetail.ruleid=t.changeid
						and #attendancedetail.ondutydate>=t.changedate 
						and datediff(dd,t.changedate,#attendancedetail.ondutydate)%@loopvalues+1=t.daynum
			end
		Set @loopValues=@loopValues+1
	end
drop table #TempRules
-- declare @strsqlset  varchar(8000)
-- declare @strsql varchar(8000)
Set @strSqlSet=''

Select @strSqlset = @strSqlset + fieldname+'=T.'+fieldname+','  from tablestructure where tableid in (select tableid from tables where tablename='attendanceshifts') and fieldname<>'shiftid'
--print @strsqlset
if right(@strsqlset,1)=',' set @strsqlset=substring(@strsqlset,1,len(@strsqlset)-1)
set @strSql='UPdate #AttendanceDetail set '+ @StrSqlSet + ' from #AttendanceDetail Emp ,attendanceshifts t where Emp.shiftid=t.shiftid'
exec (@strsql)

--select * from #attendancedetail where employeeid=594
--print @strsql

--处理班次变动
set @strsql=''
declare @TCount int,
	@Shiftid int,
	@SCount int,
	@SShiftid int 
declare @adjustdate datetime
--修改。因全局临时表在多用户同时统计时存在相互删除的问题
Declare CTemp Cursor fast_forward
for Select Distinct shiftid from tempshifts where shifttype=0 order by shiftid 
open Ctemp
Fetch Ctemp into @Shiftid
While @@Fetch_status=0
	begin 
		set @adjustdate='1900-01-01'
		select top 1 @adjustdate=adjustdate from tempshifts where shiftid=@shiftid and adjustdate<=@startdate order by adjustdate desc
		if @adjustdate='1900-01-01' or @adjustdate is null
			set @adjustdate=@startdate
		select tempshiftid into #tempshifts from tempshifts where shiftid=@shiftid and adjustdate>=@adjustdate and adjustdate<=@enddate order by adjustdate desc
		Declare STempshift Cursor Fast_forward
			for select tempshiftid from #tempshifts
		Open StempShift
		Fetch Stempshift into @Sshiftid
		While @@Fetch_Status=0
			Begin
				set @strsql='UPdate #AttendanceDetail set ' + @StrSqlSet + ' from  (select  * from tempshifts where tempshiftid =' +cast(@Sshiftid as varchar(20))+ ')t,#AttendanceDetail a where a.shiftid=t.shiftid and a.ondutydate = t.adjustdate'
				exec (@strsql)
				Fetch StempShift into @Sshiftid
			end
		Close Stempshift
		Deallocate Stempshift
		drop table #tempshifts
 		Fetch Ctemp into @Shiftid
	end 
Close Ctemp
Deallocate Ctemp





/*
Declare CTemp Cursor fast_forward
for Select count(*) as TheCount,shiftid from tempshifts where shifttype=0 and adjustdate between' ' +@StartDate +' 'and' '+ @EndDate +' ' group by shiftid order by shiftid 
open Ctemp
Fetch Ctemp into @Tcount,@Shiftid
While @@Fetch_status=0
	begin 
		set @scount=0
		select @Scount=count(*) from tempshifts where shiftid=@shiftid 
		if @Scount>@tcount 
			set @tcount=@tcount+1
		If OBJECT_ID('Tempdb..##TempShifts1') is not null drop table ##TempShifts1	
		set @Strsql='select top '+cast(@tcount as varchar(20))+' tempshiftid into ##TempShifts1 from tempshifts where shifttype=0  And shiftid='+cast(@shiftid as varchar(20))+' and adjustdate<'''+ cast(@EndDate as varchar(20))+''' order by adjustdate desc'
		exec (@strsql)
		If OBJECT_ID('Tempdb..#TempShifts') is not null drop table #TempShifts
		select tempshiftid into #tempshifts from ##tempshifts1 order by tempshiftid
		Declare STempshift Cursor Fast_forward
			for select tempshiftid from #tempshifts
		Open StempShift
		Fetch Stempshift into @Sshiftid
		While @@Fetch_Status=0
			Begin
				set @strsql='UPdate #AttendanceDetail set ' + @StrSqlSet + ' from  (select  * from tempshifts where tempshiftid =' +cast(@Sshiftid as varchar(20))+ ')t,#AttendanceDetail a where a.shiftid=t.shiftid and a.ondutydate >= t.adjustdate'
				exec (@strsql)
				Fetch StempShift into @Sshiftid
			end
		Close Stempshift
		Deallocate Stempshift
		drop table #tempshifts
 		Fetch Ctemp into @Tcount,@Shiftid
	end 
Close Ctemp
Deallocate Ctemp
*/
--处理临时班次（注：如同班次同一天有多条临时班次，以后面的盖掉前面的。）
--候改内容:按临时班次表里设定的条件，满足条件的员工的当天的班次，改为临时表里的班次。
--	   但如果是节假日的话。在调整完后，将用节假日再复盖掉原来的班次。

Declare @TempShiftid int
select @Tcount=0,@strSql='',@Sshiftid=0,@EmployeeCode=''
--Select @Tcount=count(*) from tempshifts where shifttype=1 and adjustdate between @StartDate  and @EndDate
--if @Tcount>0 
Declare Ctemp Cursor fast_forward
	for select Tempshiftid,cast(isnull(EmployeeExpress,'') as varchar(8000)) from TempShifts where employeedesc is not null and shifttype=1 and adjustdate between @StartDate  and @EndDate
Open Ctemp
Fetch Ctemp into @TempShiftid,@employeecode
While @@Fetch_status=0
	Begin
		if @employeecode=''
			set @strsql= ('UPdate #AttendanceDetail set ' + @StrSqlSet + ' from  (select  * from tempshifts where tempshiftid =' +cast(@TempShiftid as varchar(20))+ ')t,#AttendanceDetail a 
				where  a.ondutydate=t.adjustdate and a.employeeid in (select employeeid from employees)')
		else
			set @strsql= ('UPdate #AttendanceDetail set ' + @StrSqlSet + ' from  (select  * from tempshifts where tempshiftid =' +cast(@TempShiftid as varchar(20))+ ')t,#AttendanceDetail a 
				where  a.ondutydate=t.adjustdate and a.employeeid in (select employeeid from employees where ' +@employeecode+')')
		--print @strsql
		exec (@strsql)
		Fetch Ctemp into @TempShiftid,@employeecode
	end
Close Ctemp
DealLocate Ctemp
-- update #attendancedetail set standardtime =case when degree=1 then datediff(mi,aonduty,aoffduty)-isnull(aresttime,0) 
-- 					when degree=2 then datediff(mi,aonduty,aoffduty)-isnull(aresttime,0) +datediff(mi,bonduty,boffduty)-isnull(bresttime,0)
-- 					when degree=3 then datediff(mi,aonduty,aoffduty)-isnull(aresttime,0) +datediff(mi,bonduty,boffduty)-isnull(bresttime,0)+datediff(mi,conduty,coffduty)-isnull(cresttime,0) end
--处理新入职员工的排班。
delete attendancedetail from employees a where a.employeeid=attendancedetail.employeeid and attendancedetail.ondutydate <a.joindate
delete #attendancedetail from employees a where a.employeeid=#attendancedetail.employeeid and #attendancedetail.ondutydate <a.joindate
--处理离职员工的排班问题。
set @strsqlset=''

Select @strSqlset = @strSqlset + fieldname+'=Null,'  from tablestructure where tableid in (select tableid from tables where tablename='attendanceshifts') and fieldname<>'shiftid'
if len(@strsqlset)>1 set @strsqlset=substring(@strsqlset,1,len(@strsqlset)-1)

---20150412 by mike 处理离职员工,从Employees表判断
--exec ('update #attendancedetail set '+@strsqlset + ' from EmployeeDimission a where a.employeeid=#attendancedetail.employeeid and ondutydate>a.dimissiondate and (left(a. status,1)=''2'' or left(a.status,1)=''7'') and left(a.nextstep,1)=''E''')
exec ('update #attendancedetail set '+@strsqlset + ' from Employees a where a.employeeid=#attendancedetail.employeeid and left(a.IncumbencyStatus,1)=''1'' and (ondutydate>a.dimissiondate) ')

update #AttendanceDetail set ondutytype='0-平常' where shiftid is not null
update #AttendanceDetail set ondutytype='0-平常' where shiftid=0 and shiftname is not null--规则中排了0-休息的初始班次名为'休息。'
update #AttendanceDetail set ondutytype='1-休息' where shiftid=0 and shiftname is null--规则中排了0-休息的初始班次名为'休息。'

update #AttendanceDetail set ondutytype='0-平常' from attendanceholiday b where #AttendanceDetail.ondutydate=b.transposaldate  and #AttendanceDetail.templateid=b.templateid
update #AttendanceDetail set ondutytype='2-假日' from attendanceholiday b where #AttendanceDetail.ondutydate=b.HolidayDate and left(#AttendanceDetail.ondutytype,1)<>'1' and #AttendanceDetail.templateid=b.templateid
update #attendancedetail set ShiftId=null,ShiftName=null,StretchShift=null,ShiftTime=null,Degree=null,Night=null,AonDuty=null,AonDutyStart=null,AonDutyEnd=null,AoffDuty=null,AoffDutyStart=null,ArestTime=null,BonDuty=null,BonDutyEnd=null,BoffDuty=null,BoffDutyEnd=null,BrestTime=null,ConDuty=null,ConDutyEnd=null,CoffDuty=null,CrestTime=null,FirstOnDuty=null,AoffDutyEnd=null,BonDutyStart=null,BoffDutyStart=null,ConDutyStart=null,CoffDutyStart=null,CoffDutyEnd=null  where left(ondutytype,1)='2'
update #attendancedetail set ShiftName=null,StretchShift=null,ShiftTime=null,Degree=null,Night=null,AonDuty=null,AonDutyStart=null,AonDutyEnd=null,AoffDuty=null,AoffDutyStart=null,ArestTime=null,BonDuty=null,BonDutyEnd=null,BoffDuty=null,BoffDutyEnd=null,BrestTime=null,ConDuty=null,ConDutyEnd=null,CoffDuty=null,CrestTime=null,FirstOnDuty=null,AoffDutyEnd=null,BonDutyStart=null,BoffDutyStart=null,ConDutyStart=null,CoffDutyStart=null,CoffDutyEnd=null where left(ondutytype,1)='1'

update #AttendanceDetail set shiftname='休息' where shiftid=0 and shiftname is null--规则中排了0-休息的初始班次名为'休息。'
update #AttendanceDetail set shiftname=b.holidayname from attendanceholiday b where #AttendanceDetail.shiftid is  null and #AttendanceDetail.ondutydate=b.HolidayDate and left(#AttendanceDetail.ondutytype,1)='2' and #AttendanceDetail.templateid=b.templateid





-------------------------------------------------------------------------------------------------------------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if exists (select name from sysObjects where name = 'pAnalyseBrushAndSign' and type = 'p')
	drop Procedure pAnalyseBrushAndSign
GO


Create Procedure [pAnalyseBrushAndSign](@StartDate datetime,@EndDate datetime)
As

Declare @strOptionOffduty char
Declare @NowDate datetime
Declare @SmallDate datetime,
	@LargeDate datetime
Declare @Recordnum int
Declare @strOnduty varchar(10)
Declare @blnOnduty bit
Declare @blnOffduty bit

select @stronduty=variablevalue from options where variablename='strOnduty'
set @stronduty=isnull(@stronduty,'0,0')
set @blnonduty=cast(left(@stronduty,1) as bit)
set @blnOffduty=stuff(@stronduty,1,charindex(',',@stronduty),'')

select @strOptionOffduty= case when variablevalue is null or variablevalue='' then '1' else variablevalue end  from options where variablename='stranalyseoffduty'
Set @strOptionOffduty=isnull(@strOptionOffduty,'1')

--如果brushcardattend\brushcardacs表中的employeeid为0时，则从employees表中找回ID
Update brushcardattend set employeeid =employees.employeeid from employees where brushcardattend.employeeid=0 and brushcardattend.card=employees.card and employees.IncumbencyStatus<>'1'
Update brushcardacs set employeeid =employees.employeeid from employees where brushcardacs.employeeid=0 and brushcardacs.card=employees.card and employees.IncumbencyStatus<>'1'

Update #attendancedetail set signinflag ='000000'--初始化补卡标志

IF OBJECT_ID('tempdb..#TBrush') IS NOT NULL DROP TABLE #Tbrush
CREATE TABLE #Tbrush (EmployeeID INT,BrushTime DATETIME)

Set @NowDate=@Startdate
While @NowDate<=@EndDate
	Begin
		Select @SmallDate=Dateadd(ss,-86399,@NowDate),@LargeDate=Dateadd(ss,86399,@NowDate)
		IF OBJECT_ID('tempdb..#BrushCardAttend') IS NOT NULL DROP TABLE #BrushCardAttend
		SELECT EmployeeID,BrushTime INTO #BrushCardAttend FROM BrushcardAttend WHERE  property=0 and EmployeeID IN(SELECT DISTINCT EmployeeID FROM #AttendanceDetail) AND BrushTime BETWEEN @SmallDate  AND dateadd(dd,1,@LargeDate)
		if  @blnonduty=0
			begin
				insert into #brushcardattend (employeeid,brushtime)
					select a.employeeid,b.ondutydate+b.aOnduty from attendanceot a ,#AttendanceDetail b 
					where a.allday=1 and left(a.status,1)='2' and left(a.nextstep,1)='E' and @nowdate between a.starttime and a.endtime 
						 and DATEDIFF(d,b.OnDutyDate,@NowDate)=0 and a.employeeid=b.employeeid and b.degree>=1
				insert into #brushcardattend (employeeid,brushtime)
					select a.employeeid,b.ondutydate+b.BOnduty from attendanceot a ,#AttendanceDetail b 
					where a.allday=1 and left(a.status,1)='2' and left(a.nextstep,1)='E' and @nowdate between a.starttime and a.endtime 
						 and DATEDIFF(d,b.OnDutyDate,@NowDate)=0 and a.employeeid=b.employeeid and b.degree>=2
				insert into #brushcardattend (employeeid,brushtime)
					select a.employeeid,b.ondutydate+b.COnduty from attendanceot a ,#AttendanceDetail b 
					where a.allday=1 and left(a.status,1)='2' and left(a.nextstep,1)='E' and @nowdate between a.starttime and a.endtime 
						 and DATEDIFF(d,b.OnDutyDate,@NowDate)=0 and a.employeeid=b.employeeid and b.degree>=3
			end
		if  @blnoffduty=0
			begin
				insert into #brushcardattend (employeeid,brushtime)
					select a.employeeid,b.ondutydate+b.aOffduty from attendanceot a ,#AttendanceDetail b 
					where a.allday=1 and left(a.status,1)='2' and left(a.nextstep,1)='E' and @nowdate between a.starttime and a.endtime 
						 and DATEDIFF(d,b.OnDutyDate,@NowDate)=0 and a.employeeid=b.employeeid and b.degree>=1
				insert into #brushcardattend (employeeid,brushtime)
					select a.employeeid,b.ondutydate+b.BOffduty from attendanceot a ,#AttendanceDetail b 
					where a.allday=1 and left(a.status,1)='2' and left(a.nextstep,1)='E' and @nowdate between a.starttime and a.endtime 
						 and DATEDIFF(d,b.OnDutyDate,@NowDate)=0 and a.employeeid=b.employeeid and b.degree>=2
				insert into #brushcardattend (employeeid,brushtime)
					select a.employeeid,b.ondutydate+b.COffduty from attendanceot a ,#AttendanceDetail b 
					where a.allday=1 and left(a.status,1)='2' and left(a.nextstep,1)='E' and @nowdate between a.starttime and a.endtime 
						 and DATEDIFF(d,b.OnDutyDate,@NowDate)=0 and a.employeeid=b.employeeid and b.degree>=3
			end

		CREATE CLUSTERED INDEX BrushTime_ind ON #BrushCardAttend(EmployeeID,BrushTime)
		--分析非弹性班次刷卡
		--分析上班卡
--select dateadd(d,-DATEDIFF(d,0,getdate()),getdate()),getdate(),dateadd(d,-datediff(dd,'1900-01-01',getdate()),getdate())
		INSERT INTO #Tbrush
	            	 SELECT b.EmployeeID,MIN(BrushTime) AS BrushTime
	                             FROM #AttendanceDetail a,#BrushCardAttend b
	                             WHERE a.stretchshift=0 AND a.Degree>=1 AND DATEDIFF(d,a.OnDutyDate,@NowDate)=0  AND a.EmployeeID=b.EmployeeID 
	                             AND DATEADD(dd,-DATEDIFF(d,0,a.OnDutyDate),b.BrushTime) BETWEEN a.AOndutyStart AND a.AOnDutyEnd
	                             GROUP BY b.EmployeeID
		UPDATE #AttendanceDetail SET OnDuty1 = b.BrushTime
	                            FROM #AttendanceDetail a,#Tbrush b
	                            WHERE LEFT(a.stretchshift,1)=0 AND a.Degree>=1 AND  DATEDIFF(d,a.OnDutyDate,@NowDate)=0  
	                            AND a.EmployeeID=b.EmployeeID
	                            AND DATEADD(d,-DATEDIFF(d,0,a.OnDutyDate),b.BrushTime) BETWEEN a.AOndutyStart AND a.AOnDutyEnd and a.onduty1 is null
		TRUNCATE TABLE #Tbrush


		INSERT INTO #Tbrush 
                            SELECT b.EmployeeID,MIN(BrushTime) AS BrushTime 
	                            FROM #BrushCardAttend b,#AttendanceDetail a 
	                            WHERE a.stretchshift=0 AND a.Degree>=2 AND  DATEDIFF(d,a.OnDutyDate,@NowDate)=0  AND  a.EmployeeID=b.EmployeeID 
	                            AND DATEADD(d,-DATEDIFF(d,0,a.OnDutyDate),b.BrushTime) BETWEEN a.BOnDutyStart AND a.BOnDutyEnd 
	                            GROUP BY b.EmployeeID
	        UPDATE #AttendanceDetail SET OnDuty2 = b.BrushTime
	                            FROM #Tbrush b
	                            WHERE LEFT(#AttendanceDetail.stretchshift,1)=0 AND #AttendanceDetail.Degree>=2 AND  DATEDIFF(d,#AttendanceDetail.OnDutyDate,@NowDate)=0 AND  #AttendanceDetail.ShiftID IS NOT NULL AND #AttendanceDetail.EmployeeID=b.EmployeeID
	                            AND DATEADD(d,-DATEDIFF(d,0,#AttendanceDetail.OnDutyDate),b.BrushTime) BETWEEN #AttendanceDetail.BOnDutyStart AND #AttendanceDetail.BOnDutyEnd
                TRUNCATE TABLE #Tbrush
		INSERT INTO #Tbrush 
                            SELECT b.EmployeeID,MIN(BrushTime) AS BrushTime
	                             FROM #BrushCardAttend b,#AttendanceDetail a
	                             WHERE a.stretchshift=0 AND a.Degree>=3 AND  DATEDIFF(d,a.OnDutyDate, @NowDate)=0  AND a.EmployeeID=b.EmployeeID 
	                             AND DATEADD(d,-DATEDIFF(d, 0  ,a.OnDutyDate),b.BrushTime) BETWEEN a.condutystart AND a.COnDutyEnd 
	                             GROUP BY b.EmployeeID
                UPDATE #AttendanceDetail SET OnDuty3 = b.BrushTime 
	                             FROM #Tbrush b
	                             WHERE #AttendanceDetail.stretchshift=0 AND #AttendanceDetail.Degree>=3 AND DATEDIFF(d,#AttendanceDetail.OnDutyDate, @NowDate)=0 AND #AttendanceDetail.ShiftID IS NOT NULL
	                             AND #AttendanceDetail.EmployeeID=b.EmployeeID
	                             AND DATEADD(d,-DATEDIFF(d, 0  ,#AttendanceDetail.OnDutyDate),b.BrushTime) BETWEEN #AttendanceDetail.condutystart AND #AttendanceDetail.COnDutyEnd
                TRUNCATE TABLE #Tbrush

                --分析下班卡
	                
	        INSERT INTO #Tbrush 
                                SELECT  b.EmployeeID,case when @strOptionOffduty ='0' Then MIN(BrushTime) else MAX(BrushTime) end AS BrushTime
	                                  FROM #BrushCardAttend b,#AttendanceDetail a
	                                  WHERE a.stretchshift=0 AND a.Degree>=1 AND  DATEDIFF(d,a.OnDutyDate,@NowDate)=0  AND a.EmployeeID=b.EmployeeID
	                                  AND DATEADD(d,-DATEDIFF(d,0 ,a.OnDutyDate),b.BrushTime) BETWEEN a.AOffDutyStart AND a.AOffDutyEnd
	                                  GROUP BY b.EmployeeID
                UPDATE #AttendanceDetail SET OffDuty1= b.BrushTime
	                                  FROM #Tbrush b
	                                  WHERE #AttendanceDetail.stretchshift=0 AND #AttendanceDetail.Degree>=1 AND  DATEDIFF(d,#AttendanceDetail.OnDutyDate, @NowDate)=0 
	                                  AND #AttendanceDetail.EmployeeID=b.EmployeeID
	                                  AND DATEADD(d,-DATEDIFF(d, 0  ,#AttendanceDetail.OnDutyDate),b.BrushTime) BETWEEN #AttendanceDetail.AOffDutyStart AND #AttendanceDetail.AOffDutyEnd 
	        TRUNCATE TABLE #Tbrush

		INSERT INTO #Tbrush
                                  SELECT  b.EmployeeID,case when @strOptionOffduty   =0 Then MIN(BrushTime) else MAX(BrushTime) end AS BrushTime
	                                  FROM #BrushCardAttend b,#AttendanceDetail a
	                                  WHERE a.stretchshift=0 AND a.Degree>=2 AND  DATEDIFF(d,a.OnDutyDate, @NowDate)=0  AND a.EmployeeID=b.EmployeeID
	                                  AND DATEADD(d,-DATEDIFF(d, 0  ,a.OnDutyDate),b.BrushTime) BETWEEN a.BOffDutyStart AND a.BOffDutyEnd
	                                  GROUP BY b.EmployeeID
                UPDATE #AttendanceDetail SET OffDuty2= b.BrushTime
	                                  FROM #Tbrush b
	                                  WHERE #AttendanceDetail.stretchshift=0 AND #AttendanceDetail.Degree>=2 AND  DATEDIFF(d,#AttendanceDetail.OnDutyDate, @NowDate)=0 
	                                  AND #AttendanceDetail.EmployeeID=b.EmployeeID
	                                  AND DATEADD(d,-DATEDIFF(d, 0  ,#AttendanceDetail.OnDutyDate),b.BrushTime) BETWEEN #AttendanceDetail.BOffDutyStart AND #AttendanceDetail.BOffDutyEnd 
		TRUNCATE TABLE #Tbrush
	
		INSERT INTO #Tbrush
                                  SELECT  b.EmployeeID,case when @strOptionOffduty=0 Then MIN(BrushTime) else MAX(BrushTime) end AS BrushTime
	                                  FROM #BrushCardAttend b,#AttendanceDetail a
	                                  WHERE a.stretchshift=0 AND a.Degree>=3 AND  DATEDIFF(d,a.OnDutyDate, @NowDate)=0  AND a.EmployeeID=b.EmployeeID
	                                  AND DATEADD(d,-DATEDIFF(d, 0  ,a.OnDutyDate),b.BrushTime) BETWEEN a.COffDutyStart AND a.COffDutyEnd
	                                  GROUP BY b.EmployeeID
                UPDATE #AttendanceDetail SET OffDuty3= b.BrushTime
	                                  FROM #Tbrush b
	                                  WHERE #AttendanceDetail.stretchshift=0 AND #AttendanceDetail.Degree>=3 AND  DATEDIFF(d,#AttendanceDetail.OnDutyDate, @NowDate)=0 
	                                  AND #AttendanceDetail.EmployeeID=b.EmployeeID
	                                  AND DATEADD(d,-DATEDIFF(d, 0  ,#AttendanceDetail.OnDutyDate),b.BrushTime) BETWEEN #AttendanceDetail.COffDutyStart AND #AttendanceDetail.COffDutyEnd 
		TRUNCATE TABLE #Tbrush
		--IF OBJECT_ID('tempdb..#BrushCardAttend') IS NOT NULL DROP TABLE #BrushCardAttend

		--分析弹性班次！
                --算法及约定：
                --弹性班次仅有一个时段。
                --第一次上班:大于等于起始时间 (第一次上下班) AND 小于截止下班(第一次上下班)中的第一笔。
                --如果仅有一次刷卡，那么取两标准时间的中点大于中点即为下班卡，否则为上班卡。
                --IF OBJECT_ID('tempdb..#BrushCardAttend') IS NOT NULL DROP TABLE #BrushCardAttend
                --SELECT EmployeeID,BrushTime INTO #BrushCardAttend FROM BrushcardAttend WHERE  EmployeeID IN(SELECT DISTINCT EmployeeID FROM #AttendanceDetail) AND BrushTime BETWEEN @SmallDate  AND @LargeDate 

		--TRUNCATE TABLE #BrushCardAttend
                --INSERT INTO #BrushCardAttend  SELECT EmployeeID,BrushTime FROM BrushcardAttend WHERE  EmployeeID IN(SELECT DISTINCT EmployeeID FROM #AttendanceDetail) AND BrushTime BETWEEN @SmallDate  AND @LargeDate 

--		取上下班卡中点前的刷卡数据
                INSERT INTO #Tbrush
                           SELECT b.EmployeeID, MIN(BrushTime) AS BrushTime 
                           FROM #AttendanceDetail a,#BrushCardAttend b
                           WHERE a.stretchshift=1 AND a.Degree=1 AND DATEDIFF(d,a.OnDutyDate, @NowDate)=0  AND a.EmployeeID=b.EmployeeID 
                           AND DATEADD(d,-DATEDIFF(d,0,a.OnDutyDate),b.BrushTime) BETWEEN a.AOndutyStart AND a.AOffDutyEnd AND datediff(mi,dateadd(d,DATEDIFF(d,0,a.OnDutyDate),a.AOnDuty),BrushTime)< datediff(mi,a.AOnDuty,a.AOffDuty)/2 
                           GROUP BY b.EmployeeID
                
                UPDATE #AttendanceDetail SET OnDuty1 = b.BrushTime
                           FROM #Tbrush b
                           WHERE #AttendanceDetail.stretchshift=1 AND #AttendanceDetail.Degree=1 AND  DATEDIFF(d,#AttendanceDetail.OnDutyDate, @NowDate)=0  AND #AttendanceDetail.ShiftID IS NOT NULL
                           AND #AttendanceDetail.EmployeeID=b.EmployeeID
                           AND DATEADD(d,-DATEDIFF(d,0,#AttendanceDetail.OnDutyDate),b.BrushTime) BETWEEN #AttendanceDetail.AOndutyStart AND #AttendanceDetail.AOffDutyEnd
                TRUNCATE TABLE #Tbrush
		--如果没有上班卡数据,取上下班卡之间的刷卡数据
                INSERT INTO #Tbrush
                           SELECT b.EmployeeID,MIN(BrushTime) AS BrushTime 
                           FROM #AttendanceDetail a,#BrushCardAttend b
                           WHERE a.stretchshift=1 AND a.Degree=1 AND DATEDIFF(d,a.OnDutyDate, @NowDate)=0  AND a.EmployeeID=b.EmployeeID 
                           AND DATEADD(d,-DATEDIFF(d,0,a.OnDutyDate),b.BrushTime) BETWEEN a.AOndutyStart AND a.AOffDutyEnd
                           GROUP BY b.EmployeeID
                
                UPDATE #AttendanceDetail SET OnDuty1 = b.BrushTime
                           FROM #Tbrush b
                           WHERE #AttendanceDetail.stretchshift=1 AND #AttendanceDetail.Degree=1 AND  DATEDIFF(d,#AttendanceDetail.OnDutyDate, @NowDate)=0  AND #AttendanceDetail.ShiftID IS NOT NULL
                           AND #AttendanceDetail.EmployeeID=b.EmployeeID
                           AND DATEADD(d,-DATEDIFF(d,0,#AttendanceDetail.OnDutyDate),b.BrushTime) BETWEEN #AttendanceDetail.AOndutyStart AND #AttendanceDetail.AOffDutyEnd AND Onduty1 IS NULL
                TRUNCATE TABLE #Tbrush
                /*取下班卡算法及约定：
                '弹性班次仅有一个时段。
                '第一次下班班:大于等于起始时间  AND 小于截止下班中的最后笔。
                '如果仅有一次刷卡，那么取两标准时间的中点大于中点即为下班卡，否则为上班卡。
		*/
                INSERT INTO #Tbrush
                          SELECT b.EmployeeID, MAX(BrushTime) AS BrushTime 
                          FROM #AttendanceDetail a,#BrushCardAttend b
                          WHERE a.stretchshift=1 AND a.Degree=1 AND DATEDIFF(d,a.OnDutyDate,@NowDate)=0  AND a.EmployeeID=b.EmployeeID 
                          AND DATEADD(d,-DATEDIFF(d,0,a.OnDutyDate),b.BrushTime) BETWEEN a.AOndutyStart AND a.AOffDutyEnd AND datediff(mi,dateadd(d,DATEDIFF(d,0,a.OnDutyDate),a.AOnDuty),BrushTime)> datediff(mi,a.AOnDuty,a.AOffDuty)/2
                          GROUP BY b.EmployeeID
                UPDATE #AttendanceDetail SET OffDuty1 = b.BrushTime
                          FROM #Tbrush b
                          WHERE #AttendanceDetail.stretchshift=1 AND #AttendanceDetail.Degree=1 AND  DATEDIFF(d,#AttendanceDetail.OnDutyDate,@NowDate)=0  AND #AttendanceDetail.ShiftID IS NOT NULL
                          AND #AttendanceDetail.EmployeeID=b.EmployeeID
                          AND DATEADD(d,-DATEDIFF(d,0,#AttendanceDetail.OnDutyDate),b.BrushTime) BETWEEN #AttendanceDetail.AOndutyStart AND #AttendanceDetail.AOffDutyEnd
                TRUNCATE TABLE #Tbrush

                INSERT INTO #Tbrush
                          SELECT b.EmployeeID, MAX(BrushTime) AS BrushTime 
                          FROM #AttendanceDetail a,#BrushCardAttend b
                          WHERE a.stretchshift=1 AND a.Degree=1 AND DATEDIFF(d,a.OnDutyDate,@NowDate)=0  AND a.EmployeeID=b.EmployeeID 
                          AND DATEADD(d,-DATEDIFF(d,0,a.OnDutyDate),b.BrushTime) BETWEEN a.AOndutyStart AND a.AOffDutyEnd
                          GROUP BY b.EmployeeID
                UPDATE #AttendanceDetail SET OffDuty1 = b.BrushTime
                          FROM #Tbrush b
                          WHERE #AttendanceDetail.stretchshift=1 AND #AttendanceDetail.Degree=1 AND  DATEDIFF(d,#AttendanceDetail.OnDutyDate,@NowDate)=0  AND #AttendanceDetail.ShiftID IS NOT NULL
                          AND #AttendanceDetail.EmployeeID=b.EmployeeID
                          AND DATEADD(d,-DATEDIFF(d,0,#AttendanceDetail.OnDutyDate),b.BrushTime) BETWEEN #AttendanceDetail.AOndutyStart AND #AttendanceDetail.AOffDutyEnd AND OffDuty1 IS NULL
                TRUNCATE TABLE #Tbrush

                --如果只有一笔上下班卡,则取为相应的上班或下班卡               
                Update #Attendancedetail set Onduty1=Null 
                			 Where Onduty1=Offduty1 and onduty1 is not null AND datediff(mi,dateadd(d,DATEDIFF(d,0,OnDutyDate),AOnDuty),Offduty1)> datediff(mi,AOnDuty,AOffDuty)/2
				
                Update #Attendancedetail set Offduty1=Null
               				 Where Onduty1=Offduty1 and onduty1 is not null AND datediff(mi,dateadd(d,DATEDIFF(d,0,OnDutyDate),AOnDuty),Offduty1)<= datediff(mi,AOnDuty,AOffDuty)/2
                
                IF OBJECT_ID('tempdb..#BrushCardAttend') IS NOT NULL DROP TABLE #BrushCardAttend
		Set @Nowdate=dateadd(dd,1,@nowdate)
	End

IF OBJECT_ID('tempdb..#Tbrush') IS NOT NULL DROP TABLE #Tbrush

--分析补签卡

--分析非弹性班次补签卡
IF OBJECT_ID('tempdb..#SigninCard') IS NOT NULL DROP TABLE #SigninCard
Select Employeeid,Brushtime into #SigninCard from attendancesignin where left(status,1)='2' and left(nextstep,1)='E' and brushtime between @StartDate and dateadd(dd,1,@EndDate)
/*
1,已存在的临时表，删除再创建在同一过程中存在问题。
2,已存在的临时表，在同一个批处理中，做过任何操作后，增加字段，是无效的，不能访问增加的字段。
3,在同一个批处理中，创建临时表，作过任何操作后，即使删除原有的操作，立即向其增加字段，也是无效的，不能访问。
4,解决方法，在同一个过程中，创建不同名的临时表，不重复创建与删除同一个临时表。
*/

SELECT @Recordnum=count(*) from #SigninCard
if @Recordnum>0 
	begin
		IF OBJECT_ID('tempdb..#TSignin') IS NOT NULL DROP TABLE #Tsignin
		CREATE TABLE #TSignin(EmployeeID INT,BrushTime DATETIME,OndutyDate datetime)
		
--		insert into #Tbrush (employeeid,brushtime,ondutydate)  values (1,getdate(),getdate())
	        INSERT INTO #TSignin (employeeid,brushtime,ondutydate)  
	                  SELECT b.Employeeid,Min(b.brushtime) as Brushtime, a.ondutydate 
	                  From #Attendancedetail a,#SigninCard b where a.employeeid=b.employeeid and 
	                       a.stretchshift=0 AND a.Degree>=1  
	                       AND DATEADD(d,-DATEDIFF(d,0,a.OnDutyDate),b.BrushTime) BETWEEN a.AOndutyStart AND a.AOnDutyEnd 
	                       Group by b.employeeid,a.ondutydate
	        UPDATE #Attendancedetail set Onduty1=b.brushtime,signinflag=stuff(signinflag,1,1,'1') 
	                  FROM #TSignin b WHERE #Attendancedetail.employeeid=b.employeeid and #Attendancedetail.ondutydate=b.ondutydate

		TRUNCATE TABLE #TSignin


	        INSERT INTO #TSignin 
	                  Select b.employeeid,Min(b.brushtime),a.ondutydate
	                  From #Attendancedetail a,#SigninCard b where a.employeeid=b.employeeid and 
	                     a.stretchshift=0 AND a.Degree>=2  
	                     AND DATEADD(d,-DATEDIFF(d,0,a.OnDutyDate),b.BrushTime) BETWEEN a.BOndutyStart AND a.BOnDutyEnd 
	                     Group by b.employeeid,a.ondutydate
	        UPDATE #Attendancedetail set Onduty2=b.brushtime,signinflag=stuff(signinflag,3,1,'1') 
	                  FROM #TSignin b WHERE #Attendancedetail.employeeid=b.employeeid and #Attendancedetail.ondutydate=b.ondutydate
	        TRUNCATE TABLE #TSignin
	        
	        INSERT INTO #TSignin Select b.Employeeid,Min(b.brushtime),a.Ondutydate
	                     From #Attendancedetail a,#SigninCard b where a.employeeid=b.employeeid and 
	                     a.stretchshift=0 AND a.Degree>=3  
	                     AND DATEADD(d,-DATEDIFF(d,0,a.OnDutyDate),b.BrushTime) BETWEEN a.COndutyStart AND a.COnDutyEnd
	                     Group by b.employeeid,a.ondutydate
	        UPDATE #Attendancedetail set Onduty3=b.brushtime,signinflag=stuff(signinflag,5,1,'1') 
	                  FROM #TSignin b WHERE #Attendancedetail.employeeid=b.employeeid and #Attendancedetail.ondutydate=b.ondutydate
	        TRUNCATE TABLE #TSignin
	                    
	        INSERT INTO #TSignin Select b.Employeeid as Employeeid,case when @strOptionOffduty =0 
	                     Then MIN(b.BrushTime) else MAX(b.BrushTime) end as BrushTime ,a.Ondutydate as Ondutydate
	                     From #Attendancedetail a,#SigninCard b where a.employeeid=b.employeeid and 
	                     a.stretchshift=0 AND a.Degree>=1  
	                     AND DATEADD(d,-DATEDIFF(d,0,a.OnDutyDate),b.BrushTime) BETWEEN a.AOffdutyStart AND a.AOffDutyEnd
	                     Group by b.employeeid,a.ondutydate

	        UPDATE #Attendancedetail set OffDuty1=b.brushtime,signinflag=stuff(signinflag,2,1,'1') 
	                  FROM #TSignin b WHERE #Attendancedetail.employeeid=b.employeeid and #Attendancedetail.ondutydate=b.ondutydate
	        TRUNCATE TABLE #TSignin

	        INSERT INTO #TSignin Select b.Employeeid,case when @strOptionOffduty =0 
	                     Then MIN(b.BrushTime) else MAX(b.BrushTime) end as Brushtime ,a.Ondutydate
	                     From #Attendancedetail a,#SigninCard b where a.employeeid=b.employeeid and 
	                     a.stretchshift=0 AND a.Degree>=2  
	                     AND DATEADD(d,-DATEDIFF(d,0,a.OnDutyDate),b.BrushTime) BETWEEN a.BOffdutyStart AND a.BOffDutyEnd
	                     Group by b.employeeid,a.ondutydate
	        UPDATE #Attendancedetail set Offduty2=b.brushtime,signinflag=stuff(signinflag,4,1,'1') 
	                  FROM #TSignin b WHERE #Attendancedetail.employeeid=b.employeeid and #Attendancedetail.ondutydate=b.ondutydate
	        TRUNCATE TABLE #TSignin

	        INSERT INTO #TSignin Select b.Employeeid,case when @strOptionOffduty =0 
	                     Then MIN(b.BrushTime) else MAX(b.BrushTime) end as Brushtime ,a.Ondutydate
	                     From #Attendancedetail a,#SigninCard b where a.employeeid=b.employeeid and 
	                     a.stretchshift=0 AND a.Degree>=3  
	                     AND DATEADD(d,-DATEDIFF(d,0,a.OnDutyDate),b.BrushTime) BETWEEN a.COffdutyStart AND a.COffDutyEnd
	                     Group by b.employeeid,a.ondutydate
	        UPDATE #Attendancedetail set OffDuty3=b.brushtime,signinflag=stuff(signinflag,6,1,'1') 
	                  FROM #TSignin b WHERE #Attendancedetail.employeeid=b.employeeid and #Attendancedetail.ondutydate=b.ondutydate
	        TRUNCATE TABLE #TSignin
		IF OBJECT_ID('tempdb..#TSignin') IS NOT NULL DROP TABLE #Tsignin
		/*
		'分析弹性班次补签卡
		'说明
		'如果仅有一次签卡，那么取两标准时间的中点大于中点即为签下班卡，否则为签上班卡。
		*/
		IF OBJECT_ID('tempdb..#TSignin1') IS NOT NULL DROP TABLE #Tsignin1
		CREATE TABLE #TSignin1(EmployeeID INT,BrushCount int,BrushTime DATETIME)--BrushCount用于判断条件。
		Set @NowDate=@StartDate
		While @NowDate<=@EndDate
			Begin
				Select @SmallDate=Dateadd(ss,-86399,@NowDate),@LargeDate=Dateadd(ss,86399,@NowDate)
		                INSERT INTO #TSignin1
		                                 SELECT b.EmployeeID,Count(*) as BrushCount,MIN(BrushTime) AS BrushTime 
		                                 FROM #AttendanceDetail a,#SigninCard b
		                                 WHERE a.stretchshift=1 AND a.Degree=1 AND DATEDIFF(d,a.OnDutyDate,@NowDate)=0  AND a.EmployeeID=b.EmployeeID 
		                                 AND DATEADD(d,-DATEDIFF(d,0,a.OnDutyDate),b.BrushTime) BETWEEN a.AOndutyStart AND a.AOffDutyEnd AND datediff(mi,a.AOnDuty,BrushTime)< datediff(mi,a.AOnDuty,a.AOffDuty)/2 
		                                 GROUP BY b.EmployeeID
		
		                UPDATE #AttendanceDetail SET OnDuty1 =  b.BrushTime,signinflag=stuff(signinflag,1,1,'1') 
		                                 FROM #TSignin1 b
		                                 WHERE #AttendanceDetail.stretchshift=1 AND #AttendanceDetail.Degree=1 AND  DATEDIFF(d,#AttendanceDetail.OnDutyDate,@NowDate)=0  AND #AttendanceDetail.ShiftID IS NOT NULL
		                                 AND #AttendanceDetail.EmployeeID=b.EmployeeID
		                                 AND DATEADD(d,-DATEDIFF(d,0,#AttendanceDetail.OnDutyDate),b.BrushTime) BETWEEN #AttendanceDetail.AOndutyStart AND #AttendanceDetail.AOffDutyEnd and b.brushtime is not null
		                TRUNCATE TABLE #TSignin1
		                
		                INSERT INTO #TSignin1
		                                 SELECT b.EmployeeID,Count(*) as BrushCount,MIN(BrushTime) AS BrushTime 
		                                 FROM #AttendanceDetail a,#SigninCard b
		                                 WHERE a.stretchshift=1 AND a.Degree=1 AND DATEDIFF(d,a.OnDutyDate,@NowDate)=0  AND a.EmployeeID=b.EmployeeID 
		                                 AND DATEADD(d,-DATEDIFF(d,0,a.OnDutyDate),b.BrushTime) BETWEEN a.AOndutyStart AND a.AOffDutyEnd 
		                                 GROUP BY b.EmployeeID
		
		                UPDATE #AttendanceDetail SET OnDuty1 = Case when b.BrushCount>1 then b.BrushTime Else #Attendancedetail.OnDuty1 end,signinflag=stuff(signinflag,1,1,'1') 
		                                 FROM #TSignin1 b
		                                 WHERE #AttendanceDetail.stretchshift=1 AND #AttendanceDetail.Degree=1 AND  DATEDIFF(d,#AttendanceDetail.OnDutyDate,@NowDate)=0  AND #AttendanceDetail.ShiftID IS NOT NULL
		                                 AND #AttendanceDetail.EmployeeID=b.EmployeeID
		                                 AND DATEADD(d,-DATEDIFF(d,0,#AttendanceDetail.OnDutyDate),b.BrushTime) BETWEEN #AttendanceDetail.AOndutyStart AND #AttendanceDetail.AOffDutyEnd and b.brushtime is not null and #Attendancedetail.Onduty1 is Null
		                TRUNCATE TABLE #TSignin1
		
		                INSERT INTO #TSignin1
		                                 SELECT b.EmployeeID,Count(*) as BrushCount, MAX(BrushTime) AS BrushTime 
		                                 FROM #AttendanceDetail a,#SigninCard b
		                                 WHERE a.stretchshift=1 AND a.Degree=1 AND DATEDIFF(d,a.OnDutyDate,@NowDate)=0  AND a.EmployeeID=b.EmployeeID 
		                                 AND DATEADD(d,-DATEDIFF(d,0,a.OnDutyDate),b.BrushTime) BETWEEN a.AOndutyStart AND a.AOffDutyEnd And datediff(mi,a.AOnDuty,BrushTime)> datediff(mi,a.AOnDuty,a.AOffDuty)/2
		                                 GROUP BY b.EmployeeID
		
		                UPDATE #AttendanceDetail SET OffDuty1= b.BrushTime ,signinflag=stuff(signinflag,2,1,'1')
		                                 FROM #TSignin1 b
		                                 WHERE #AttendanceDetail.stretchshift=1 AND #AttendanceDetail.Degree=1 AND  DATEDIFF(d,#AttendanceDetail.OnDutyDate,@NowDate)=0  AND #AttendanceDetail.ShiftID IS NOT NULL
		                                 AND #AttendanceDetail.EmployeeID=b.EmployeeID
		                                 AND DATEADD(d,-DATEDIFF(d,0,#AttendanceDetail.OnDutyDate),b.BrushTime) BETWEEN #AttendanceDetail.AOndutyStart AND #AttendanceDetail.AOffDutyEnd and b.brushtime is not null
		                TRUNCATE TABLE #TSignin1
		                
		                INSERT INTO #TSignin1
		                                 SELECT b.EmployeeID,Count(*) as BrushCount, MAX(BrushTime) AS BrushTime 
		                                 FROM #AttendanceDetail a,#SigninCard b
		                                 WHERE a.stretchshift=1 AND a.Degree=1 AND DATEDIFF(d,a.OnDutyDate,@NowDate)=0  AND a.EmployeeID=b.EmployeeID 
		                                 AND DATEADD(d,-DATEDIFF(d,0,a.OnDutyDate),b.BrushTime) BETWEEN a.AOndutyStart AND a.AOffDutyEnd
		                                 GROUP BY b.EmployeeID
		
		                UPDATE #AttendanceDetail SET OffDuty1= Case when b.BrushCount>1 then b.BrushTime 
		                                 Else #AttendanceDetail.OffDuty1 End,signinflag=stuff(signinflag,2,1,'1') 
		                                 FROM #TSignin1 b
		                                 WHERE #AttendanceDetail.stretchshift=1 AND #AttendanceDetail.Degree=1 AND  DATEDIFF(d,#AttendanceDetail.OnDutyDate,@NowDate)=0  AND #AttendanceDetail.ShiftID IS NOT NULL
		                                 AND #AttendanceDetail.EmployeeID=b.EmployeeID
		                                 AND DATEADD(d,-DATEDIFF(d,0,#AttendanceDetail.OnDutyDate),b.BrushTime) BETWEEN #AttendanceDetail.AOndutyStart AND #AttendanceDetail.AOffDutyEnd and b.brushtime is not null and #Attendancedetail.Offduty1 is null
		                TRUNCATE TABLE #TSignin1
				Set @NowDate=DateAdd(dd,1,@NowDate)
			End
			IF OBJECT_ID('tempdb..#TSignin1') IS NOT NULL DROP TABLE #TSignin1
	end
IF OBJECT_ID('tempdb..#SigninCard') IS NOT NULL DROP TABLE #SigninCard



-----------------------------------------------------------------------------------------------------------------------------------------------------


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if exists (select name from sysObjects where name = 'pAttendTotal' and type = 'p')
	drop Procedure pAttendTotal
GO

Create Procedure [pAttendTotal](@StartDate datetime,@EndDate datetime,@strmonth nvarchar(7),@strTotalType varchar(1),@blnDimission bit)
As
--@strTotalType 取值为1表示手动统计，取值2为自动统计，取值3为统计当日
--@blnDimission=1是否仅统计本月离职员工。

--统计时间由调用者输入！
--每次统计都是统计所有的员工！
/*
declare @startdate datetime,@enddate datetime,@strmonth nvarchar(10),@strtotaltype varchar(1),@blndimission bit
set @Startdate='2015-04-01'
set @Enddate='2015-04-12'
set @strmonth='2015-04'
select @strtotaltype='1',@blndimission=0
*/
SET NoCount On
SET DateFirst 7

Declare @Tempdate datetime
Declare @RecordNum int

Declare @Day varchar(2),@month varchar(2),@year varchar(4)
Declare @maxday int

Declare @Sdate datetime
Declare	@Edate Datetime
Declare @totalcycle nvarchar(50)
Declare @sum int
Declare @TotalYear varchar(20)
Declare @Tempmonth varchar(20)
Declare @blnAnalyseWorkDay bit
Declare @strOnduty varchar(10)
Declare @blnOnduty bit
Declare @blnOffduty bit

select @stronduty=variablevalue from options where variablename='strOnduty'
set @stronduty=isnull(@stronduty,'0,0')
set @blnonduty=cast(left(@stronduty,1) as bit)
set @blnOffduty=stuff(@stronduty,1,charindex(',',@stronduty),'')

select @startdate=datename(yy,@startdate)+'-'+datename(mm,@startdate)+'-'+datename(dd,@startdate),@enddate=datename(yy,@enddate)+'-'+datename(mm,@enddate)+'-'+datename(dd,@enddate)

if @strtotaltype='2' or @strtotaltype='3'	--取得自动统计与当日统计的@strmonth值。
	begin
		select @totalcycle=variablevalue from Options where variablename='StrTotalCycle'
		select @sum=dbo.fsumcharnum(@totalcycle,',')
		if @sum=3
			begin
				if left(@totalcycle,1)='0'
					begin
						set @maxday=day(dateadd(dd,-1,(cast(year(dateadd(mm,1,getdate())) as varchar(4))+'-'+cast(month(dateadd(mm,1,getdate())) as varchar(2))+'-01')))
--print cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-'+substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,charindex(',',stuff(@totalcycle,1,charindex(',',@totalcycle),''))-1) 
						--set @sdate= cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-'+substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,charindex(',',stuff(@totalcycle,1,charindex(',',@totalcycle),''))-1) 
						if cast(substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,charindex(',',stuff(@totalcycle,1,charindex(',',@totalcycle),''))-1) as int)>@maxday
							set @sdate=cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-'+cast(@maxday as varchar(2))
						else
							set @sdate= cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-'+substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,charindex(',',stuff(@totalcycle,1,charindex(',',@totalcycle),''))-1) 

					end
				if left(@totalcycle,1)='1'
					begin
						set @maxday=day(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01')))
						if cast(substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,charindex(',',stuff(@totalcycle,1,charindex(',',@totalcycle),''))-1) as int)>@maxday
							set @sdate=cast(year(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01'))) as varchar(4)) +'-'+cast(month(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01'))) as varchar(2))+'-'+cast(@maxday as varchar(2))
						else
							set @sdate=cast(year(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01'))) as varchar(4)) +'-'+cast(month(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01'))) as varchar(2))+'-'+substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,charindex(',',stuff(@totalcycle,1,charindex(',',@totalcycle),''))-1) 
					end				
-- 				print @sdate
-- 				end end
				set @totalcycle=stuff(@totalcycle,1,charindex(',',@totalcycle),'')
				set @totalcycle=stuff(@totalcycle,1,charindex(',',@totalcycle),'')
				if left(@totalcycle,1)='0'
					begin
						set @maxday=day(dateadd(dd,-1,(cast(year(dateadd(mm,1,getdate())) as varchar(4))+'-'+cast(month(dateadd(mm,1,getdate())) as varchar(2))+'-01')))

						if cast(substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,len(@totalcycle)-charindex(',',@totalcycle)) as int)>@maxday
							set @edate=cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-'+cast(@maxday as varchar(2))
						else
							set @edate= cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-'+substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,len(@totalcycle)-charindex(',',@totalcycle))
					end
				if left(@totalcycle,1)='1'
					begin
						set @maxday=day(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01')))
						if cast(substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,len(@totalcycle)-charindex(',',@totalcycle)) as int)>@maxday
							set @edate=cast(year(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01'))) as varchar(4)) +'-'+cast(month(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01'))) as varchar(2))+'-'+cast(@maxday as varchar(2))
						else
							set @edate=cast(year(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01'))) as varchar(4)) +'-'+cast(month(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01'))) as varchar(2))+'-'+substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,len(@totalcycle)-charindex(',',@totalcycle))
					end				
-- 				print @sdate
-- 				print @edate
-- 				end end 
				if @sdate>@edate
					return

				if cast(convert(char,getdate(),112) as datetime) >cast(convert(char,@edate,112) as datetime)
					begin

						set @strmonth=right('20'+cast(year(dateadd(mm,1,getdate())) as varchar(4)),4)+'-'+right('00'+cast(month(dateadd(mm,1,getdate())) as varchar(2)),2)
						select @sdate=dateadd(mm,1,@sdate),@edate=dateadd(mm,1,@edate)
					end
				else
					begin
						if cast(convert(char,getdate(),112) as datetime) <cast(convert(char,@sdate,112) as datetime)
							begin
								set @strmonth=right('20'+cast(year(dateadd(mm,-1,getdate())) as varchar(4)),4)+'-'+right('00'+cast(month(dateadd(mm,-1,getdate())) as varchar(2)),2)
								select @sdate=dateadd(mm,-1,@sdate),@edate=dateadd(mm,-1,@edate)
							end
						else
							begin
								set @strmonth=right('20'+cast(year(getdate()) as varchar(4)),4)+'-'+right('00'+cast(month(getdate()) as varchar(2)),2)
							end
					end
			end
		else
			return 

		if @strTotalType='2' --自动统计
			begin
				select @startdate=@sdate,@enddate=@edate
				if @enddate>getdate()
					set @enddate=convert(varchar(20),getdate(),120)
			end	
	end


select @startdate=cast( convert(varchar(10),@Startdate,120)as datetime),@EndDate=cast(convert(varchar(10),@EndDate,120) as datetime)--初始化统计日期
--select @startdate,@enddate
select @blnAnalyseWorkDay=variablevalue from options where variablename='blnAnalyseWorkDay'

IF OBJECT_ID('tempdb..#Tempdatetable') IS NOT NULL DROP TABLE #Tempdatetable
CREATE TABLE #Tempdatetable (Adate DATETIME)
Set @Tempdate=@StartDate
While DateDiff(dd, @TempDate, @EndDate) >= 0
	Begin
		INSERT INTO #Tempdatetable (Adate) values (@Tempdate)
		Set @TempDate=Dateadd(dd,1,@Tempdate)
	End
IF OBJECT_ID('Tempdb..#TbrushempShifts') is not null drop table #TbrushempShifts
Select * into #TbrushempShifts from attendanceshifts where 1=2
exec ('Alter table #TbrushempShifts drop column shiftname')

IF OBJECT_ID('tempdb..#AttendanceDetail') IS NOT NULL DROP TABLE #Attendancedetail
SELECT * INTO #AttendanceDetail FROM AttendanceDetail,#TbrushempShifts WHERE 1=2

--Exec ('ALTER TABLE #AttendanceDetail ADD TemplateId int null, noBrushCard bit,RuleId int,Leave1 int,leave2 int,leave3 int,LateCount int,LeaveEarlyCount int,abnormitycount int,Standardtime int default 0')
Exec ('ALTER TABLE #AttendanceDetail ADD TemplateId int null,RuleId int,LateCount int,LeaveEarlyCount int,abnormitycount int,workTimeholiday int default 0,aottime1 int default 0,aottime2 int default 0,bottime1 int default 0,bottime2 int default 0,cottime1 int default 0,cottime2 int default 0')

Alter Table #attendanceDetail  alter Column Shiftid int null
Alter Table #attendanceDetail  alter Column Degree int null
Alter Table #attendanceDetail  alter Column  Night Bit null
Alter Table #attendanceDetail  alter Column AonDutyStart Datetime null
Alter Table #attendanceDetail  alter Column AoffDuty datetime null
Alter Table #attendanceDetail  alter Column AonDuty datetime null
Drop table #TbrushempShifts

If left(@strTotalType,1)='1' and @blnDimission=1
	Begin
	--20150412 mike Templateid的值为0
	--INSERT INTO #AttendanceDetail (Employeeid,OndutyDate,Templateid) SELECT Employees.Employeeid,a.Adate,Employees.Templateid FROM  Employees,#Tempdatetable a,EmployeeDimission b WHERE Employees.IncumbencyStatus='1' and employees.employeeid=b.employeeid and b.dimissiondate between @startdate and @enddate
		INSERT INTO #AttendanceDetail (Employeeid,OndutyDate,Templateid) SELECT Employees.Employeeid,a.Adate,0 FROM  Employees,#Tempdatetable a WHERE Employees.IncumbencyStatus='1' and employees.dimissiondate between @startdate and @enddate
	End
Else
	Begin
	--INSERT INTO #AttendanceDetail (Employeeid,OndutyDate,Templateid) SELECT Employees.Employeeid,a.Adate,Employees.Templateid FROM  Employees,#Tempdatetable a
		INSERT INTO #AttendanceDetail (Employeeid,OndutyDate,Templateid) SELECT Employees.Employeeid,a.Adate,0 FROM  Employees,#Tempdatetable a
	End
IF OBJECT_ID('tempdb..#Tempdatetable') IS NOT NULL DROP TABLE #Tempdatetable


--自动排班
exec pAutoShifts @Startdate,@EndDate
-- select * from #attendancedetail where nobrushcard=1 and employeeid=2
-- select * from brushcardattend where employeeid=2
--分析刷卡
exec pAnalyseBrushAndSign @startdate,@enddate
--select * from #AttendanceDetail order by EmployeeId,OnDutyDate
--分析请假
--exec pAnalyseAskforleave @startdate,@enddate

/*
	    '请假时间以天计！
	    'strSkipHoliday内容格式为：“假期名+判断位，假期名+判断位，假期名+判断位，。。。。。”
	    
	'    LactationLeave  Holiday     哺乳假
	'    PublicHoliday   Holiday     法定假
	'    PeriodLeave Holiday     女性假
	'    CompensatoryLeave   Holiday     补假
	'    VisitLeave  Holiday     探亲假
	'    OnTrip  NULL        出差
	'    FuneralLeave    Holiday     丧假
	'    PersonalLeave   Holiday     事假
	'    MaternityLeave  Holiday     产假
	'    AnnualVacation  Holiday     年假
	'    InjuryLeave Holiday     工伤
	'    SickLeave   Holiday     病假
	'    WeddingLeave    Holiday     婚假
*/
-- 	    Dim rsAskForLeave
-- 	    Dim rsOptions
Declare @strSkipHoliday nvarchar(4000)

select @strSkipHoliday= case when variablevalue is null or variablevalue='' then '' else variablevalue end  from options where variablename='strSkipHoliday'
Set @strSkipHoliday=isnull(@strSkipHoliday,'')
-- '整天请假
-- '整天请假时，StartTime与EndTime中只有日期没有时间的。 类似于2015-04-01 00:00:00
Update #Attendancedetail Set onduty1=null,offduty1=null,Result1= b.AskForLeaveType ,Result2=b.AskForLeaveType
         From AttendanceAskforLeave b 
         where #Attendancedetail.employeeid=b.employeeid and b.allday=1 and #Attendancedetail.Ondutydate between  b.StartTime  and  EndTime and #Attendancedetail.Degree>=1 and left(b.status,1)='2'  and left(b.nextstep,1)='E' 
-- Onduty1 = OndutyDate+AOnduty ,Offduty1=  OndutyDate+AOffduty 
Update #Attendancedetail Set onduty2=null,offduty2=null,Result3= b.AskForLeaveType ,Result4= b.AskForLeaveType
         From AttendanceAskforLeave b 
         where #Attendancedetail.employeeid=b.employeeid and b.allday=1 and #Attendancedetail.Ondutydate between b.StartTime and EndTime  and #Attendancedetail.Degree>=2 and left(b.status,1)='2'  and left(b.nextstep,1)='E'
Update #Attendancedetail Set onduty3=null,offduty3=null,Result5= b.AskForLeaveType  ,Result6= b.AskForLeaveType
         From AttendanceAskforLeave b 
         where #Attendancedetail.employeeid=b.employeeid and b.allday=1 and #Attendancedetail.Ondutydate between b.StartTime  and  EndTime  and #Attendancedetail.Degree>=3 and left(b.status,1)='2'  and left(b.nextstep,1)='E'


-- '非整天请假
-- '补请假跨过时间点的标准时间。
--select * from #attendancedetail where employeeid=104
Update #Attendancedetail Set Onduty1 =  OndutyDate+AOnduty ,
			signinflag=  stuff(signinflag,1,1,'1') 
             From attendanceaskforleave  b 
             Where b.AllDay<>1 and #Attendancedetail.Degree>=1 and #Attendancedetail.Employeeid=b.Employeeid and 
                      left(b.status,1)='2'  and left(b.nextstep,1)='E' and OndutyDate+AOnduty>=b.StartTime and OndutyDate+AOnduty<=b.EndTime
--select * from #attendancedetail where employeeid=19
-- 
-- Update #Attendancedetail Set Offduty1 =  Convert(char,a.OndutyDate+a.AOffDuty,120),
-- 			signinflag= stuff(signinflag,2,1,'1')
--          From #Attendancedetail a,AttendanceAskforleave b 
--          Where b.AllDay<>1 and a.Degree>=1 and a.Employeeid=b.Employeeid and 
--                  a.AOffDuty is Not Null and left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.AOffduty,120)>=b.StartTime and Convert(char,a.OndutyDate+a.AOffDuty,120)<=b.EndTime
--                 
-- Update #Attendancedetail Set Onduty2 = Convert(char,a.OndutyDate+a.BOnduty,120) ,
-- 			signinflag=  stuff(signinflag,3,1,'1')
--          From #Attendancedetail a,AttendanceAskforleave b 
--          Where b.AllDay<>1 and a.Degree>=2 and a.Employeeid=b.Employeeid and 
--                  a.BOnduty is Not Null and left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.BOnduty,120)>=b.StartTime and Convert(char,a.OndutyDate+a.BOnduty,120)<=b.EndTime
-- Update #Attendancedetail Set OffDuty2 =  Convert(char,a.OndutyDate+a.BOffDuty,120) ,
-- 			signinflag= stuff(signinflag,4,1,'1') 
--          From #Attendancedetail a,AttendanceAskforleave b 
--          Where b.AllDay<>1 and a.Degree>=2 and a.Employeeid=b.Employeeid and 
--                  a.BOffDuty is Not Null  and left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.BOffDuty,120)=b.StartTime and Convert(char,a.OndutyDate+a.BOffDuty,120)<=b.EndTime 
-- Update #Attendancedetail Set Onduty3 = Convert(char,a.OndutyDate+a.COnduty,120) ,
-- 			signinflag= stuff(signinflag,5,1,'1')
--          From #Attendancedetail a,AttendanceAskforleave b 
--          Where b.AllDay<>1 and a.Degree>=3 and a.Employeeid=b.Employeeid and 
--                  a.COnduty is Not Null  and left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.COnduty,120)>=b.StartTime and Convert(char,a.OndutyDate+a.COnduty,120)<=b.EndTime
-- Update #Attendancedetail Set OffDuty3 =  Convert(char,a.OndutyDate+a.COffDuty,120),
-- 			signinflag= stuff(signinflag,6,1,'1')
--          From #Attendancedetail a,AttendanceAskforleave b 
--          Where b.AllDay<>1 and a.Degree>=3 and a.Employeeid=b.Employeeid and 
--                  a.COffDuty is Not Null and left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.COffDuty,120)>=b.StartTime and Convert(char,a.OndutyDate+a.COffDuty,120)<=b.EndTime

Update #Attendancedetail Set Offduty1 =  Convert(char,a.OndutyDate+a.AOffDuty,120),
			signinflag= stuff(signinflag,2,1,'1')
         From #Attendancedetail a,AttendanceAskforleave b 
         Where b.AllDay<>1 and a.Degree>=1 and a.Employeeid=b.Employeeid and 
                 left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.AOffduty,120)>=b.StartTime and Convert(char,a.OndutyDate+a.AOffDuty,120)<=b.EndTime
                
Update #Attendancedetail Set Onduty2 = Convert(char,a.OndutyDate+a.BOnduty,120) ,
			signinflag=  stuff(signinflag,3,1,'1')
         From #Attendancedetail a,AttendanceAskforleave b 
         Where b.AllDay<>1 and a.Degree>=2 and a.Employeeid=b.Employeeid and 
                 left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.BOnduty,120)>=b.StartTime and Convert(char,a.OndutyDate+a.BOnduty,120)<=b.EndTime
Update #Attendancedetail Set OffDuty2 =  Convert(char,a.OndutyDate+a.BOffDuty,120) ,
			signinflag= stuff(signinflag,4,1,'1') 
         From #Attendancedetail a,AttendanceAskforleave b 
         Where b.AllDay<>1 and a.Degree>=2 and a.Employeeid=b.Employeeid and 
                 left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.BOffDuty,120)>=b.StartTime and Convert(char,a.OndutyDate+a.BOffDuty,120)<=b.EndTime 
Update #Attendancedetail Set Onduty3 = Convert(char,a.OndutyDate+a.COnduty,120) ,
			signinflag= stuff(signinflag,5,1,'1')
         From #Attendancedetail a,AttendanceAskforleave b 
         Where b.AllDay<>1 and a.Degree>=3 and a.Employeeid=b.Employeeid and 
                 left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.COnduty,120)>=b.StartTime and Convert(char,a.OndutyDate+a.COnduty,120)<=b.EndTime
Update #Attendancedetail Set OffDuty3 =  Convert(char,a.OndutyDate+a.COffDuty,120),
			signinflag= stuff(signinflag,6,1,'1')
         From #Attendancedetail a,AttendanceAskforleave b 
         Where b.AllDay<>1 and a.Degree>=3 and a.Employeeid=b.Employeeid and 
                 left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.COffDuty,120)>=b.StartTime and Convert(char,a.OndutyDate+a.COffDuty,120)<=b.EndTime


--'处理整段时间请假，置整段请假的刷卡点为相应的假期
Update #AttendanceDetail Set  onduty1=null,offduty1=null,Result1= b.AskForLeaveType,Result2= b.AskForLeaveType
         From AttendanceAskforleave b 
         Where b.Allday<>1 and #AttendanceDetail.employeeid=b.employeeid and left(b.status,1)='2'  and left(b.nextstep,1)='E' and 
                 #AttendanceDetail.Ondutydate+#AttendanceDetail.AOnduty>=b.StartTime and 
                 #AttendanceDetail.Ondutydate+#AttendanceDetail.AOffDuty<=b.EndTime 
Update #AttendanceDetail Set onduty2=null,offduty2=null,Result3= b.AskForLeaveType ,Result4=b.AskForLeaveType 
         From AttendanceAskForLeave b
         Where b.Allday<>1 and #Attendancedetail.employeeid=b.employeeid and left(b.status,1)='2'  and left(b.nextstep,1)='E' and 
                #Attendancedetail.Ondutydate+#Attendancedetail.BOnduty>=b.StartTime and 
                #Attendancedetail.Ondutydate+#Attendancedetail.BOffduty<=b.EndTime 
    
Update #AttendanceDetail Set onduty3=null,offduty3=null,Result5=b.AskForLeaveType ,Result6=b.AskForLeaveType 
         From AttendanceAskForLeave b
         Where b.Allday<>1 and #Attendancedetail.employeeid=b.employeeid and left(b.status,1)='2'  and left(b.nextstep,1)='E' and
                 #Attendancedetail.Ondutydate+#Attendancedetail.COnduty>=b.StartTime and 
                 #Attendancedetail.Ondutydate+#Attendancedetail.COffduty<=b.EndTime 


-- '超时加班参数。
-- Dim AheadOnDuty
-- Dim delayOffDuty
-- Dim AllTime
-- Dim BaseNumber
-- Dim i
Declare @NowDate datetime
Declare @SmallDate datetime,
	@LargeDate datetime

-- '审批加班处理！
-- 
-- '非整天加班。整天0-休息加班
-- '取刷卡数据为开始与结束时间前后30分钟到开始与结束时间中间点。
-- '跨零点加班，计为开始时间所在的那天的加班时间。

IF OBJECT_ID('tempdb..#t') IS NOT NULL DROP TABLE #t
CREATE TABLE #t(EmployeeID INT,BrushTime DATETIME)

--'用加班表产生一个非整天加班临时表。增加上班刷卡，下班刷卡，加班时间三字段。
IF OBJECT_ID('tempdb..#OverTime') IS NOT NULL DROP TABLE #OverTime

--Select employeeid, starttime,endtime into #OverTime from AttendanceOT Where allday =0 and left(status,1)='2' and left(nextstep,1)='E' and Endtime between @Startdate and dateadd(dd,1,@Enddate)

--Exec ('alter table #OverTime add StartBrush datetime,EndBrush datetime,OtTime int default 0')

CREATE TABLE #overtime (Employeeid int,Starttime datetime,endtime datetime,StartBrush datetime null,EndBrush datetime null,OtTime int default 0)
insert into #overtime (employeeid ,starttime,endtime) select employeeid ,starttime,endtime from attendanceot  Where allday =0 and left(status,1)='2' and left(nextstep,1)='E' and Endtime between @Startdate and dateadd(dd,1,@Enddate)
insert into #overtime (employeeid ,starttime,endtime) select a.employeeid,b.ondutydate,dateadd(mi,-1,(dateadd(dd,1,b.ondutydate))) from attendanceot a ,#attendancedetail b where a.allday=1 and a.employeeid=b.employeeid and b.ondutydate between a.starttime and a.endtime and left(b.ondutytype,1)='1' and left(nextstep,1)='E'
--select * from #overtime where employeeid=103
--select * from brushcardattend where employeeid=15 or employeeid=17
-- insert into brushcardattend (controllernumber,card,employeeid,brushtime)
-- 	values (1,0,15,'2015-04-10 18:00:00')
Set @NowDate=@StartDate
While @NowDate<=@EndDate
	Begin
		--'过夜班次取值向前向后各廷伸一天。
		Select @SmallDate=Dateadd(ss,-86399,@NowDate),@LargeDate=Dateadd(ss,86399,@NowDate)
		--'加班刷卡
		IF OBJECT_ID('tempdb..#BrushCardAttend') IS NOT NULL DROP TABLE #BrushCardAttend
		SELECT EmployeeID,BrushTime INTO #BrushCardAttend 
			FROM BrushcardAttend WHERE  EmployeeID IN(SELECT DISTINCT EmployeeID FROM #OverTime) AND BrushTime BETWEEN @SmallDate AND @LargeDate
		CREATE CLUSTERED INDEX BrushTime_ind ON #BrushCardAttend(EmployeeID,BrushTime)
		if @blnonduty=0
			insert into #brushcardattend (employeeid,brushtime)
				select employeeid,starttime from attendanceot 
				where allday=0 and left(status,1)='2' and left(nextstep,1)='E' and starttime between  @SmallDate AND @LargeDate 
		if @blnoffduty=0
			insert into #brushcardattend (employeeid,brushtime)
				select employeeid,endtime from attendanceot 
				where allday=0 and left(status,1)='2' and left(nextstep,1)='E' and endtime between  @SmallDate AND @LargeDate 

		INSERT INTO #t
		         SELECT b.EmployeeID,MIN(BrushTime) AS BrushTime
		         FROM #OverTime a,#BrushCardAttend b
		         WHERE  a.EmployeeID=b.EmployeeID And DATEDIFF(d,a.StartTime,@NowDate)=0  
		         AND (b.BrushTime BETWEEN Dateadd(mi,-30,a.Starttime)  AND dateadd(mi,datediff(mi,a.Starttime,a.Endtime)/2,a.starttime))
		         GROUP BY b.EmployeeID,a.starttime
		
		UPDATE #OverTime SET StartBrush = b.BrushTime
		         FROM  #t b
		         WHERE DATEDIFF(d,#OverTime.StartTime,@NowDate)=0  
		         AND #OverTime.EmployeeID=b.EmployeeID
		         AND b.BrushTime BETWEEN Dateadd(mi,-30,#OverTime.Starttime)  AND dateadd(mi,datediff(mi,#OverTime.Starttime,#OverTime.Endtime)/2,#OverTime.starttime)
		TRUNCATE TABLE #t

		INSERT INTO #t 
		         SELECT b.EmployeeId,Max(Brushtime) as Brushtime
		         FROM #Overtime a,#BrushCardAttend b
		         WHERE a.Employeeid=b.employeeid and DateDiff(d,a.StartTime,@NowDate)=0 
		         And b.BrushTime Between dateadd(mi,datediff(mi,a.Starttime,a.Endtime)/2,a.starttime) and dateadd(mi,30,a.Endtime)
		         Group By b.employeeid,a.starttime
		UpDate #OverTime Set EndBrush =b.Brushtime
		         From #OverTime a,#t b
		         WHERE DATEDIFF(d,a.StartTime,@NowDate)=0  
		         AND a.EmployeeID=b.EmployeeID
		         And b.BrushTime Between dateadd(mi,datediff(mi,a.Starttime,a.Endtime)/2,a.starttime) and dateadd(mi,30,a.Endtime)
		TRUNCATE TABLE #t
		TRUNCATE TABLE #BrushCardAttend
		
		--'加班补卡
		IF OBJECT_ID('tempdb..#SigninCard') IS NOT NULL DROP TABLE #SigninCard
		SELECT EmployeeID,BrushTime INTO #SigninCard FROM AttendanceSignin WHERE EmployeeID IN(SELECT DISTINCT EmployeeID FROM #OverTime) AND left(status,1)='2' and left(nextstep,1)='E'  AND BrushTime BETWEEN @SmallDate AND @LargeDate
		 CREATE CLUSTERED INDEX BrushTime_ind ON #SigninCard(EmployeeID,BrushTime)
		                  			
		INSERT INTO #t
		         SELECT b.Employeeid,Min(Brushtime) as BrushTime
		         FROM #OverTime a,#SigninCard b
		         WHERE a.employeeid=b.employeeid and datediff(d,a.StartTime,@NowDate)=0 
		         AND b.BrushTime BETWEEN Dateadd(mi,-30,a.Starttime)  AND dateadd(mi,datediff(mi,a.Starttime,a.Endtime)/2,a.starttime)
		         GROUP BY b.employeeid,a.starttime
		UPDATE #OverTime SET StartBrush = b.BrushTime
		         FROM #OverTime a,#t b
		         WHERE DATEDIFF(d,a.StartTime,@NowDate)=0  
		         AND a.EmployeeID=b.EmployeeID
		         AND b.BrushTime BETWEEN Dateadd(mi,-30,a.Starttime)  AND dateadd(mi,datediff(mi,a.Starttime,a.Endtime)/2,a.starttime)
		TRUNCATE TABLE #t
--		select * from #t where employeeid=103
		INSERT INTO #t 
		         SELECT b.EmployeeId,Max(Brushtime) as Brushtime
		         FROM #Overtime a,#SigninCard b
		         WHERE a.Employeeid=b.employeeid and DateDiff(d,a.StartTime,@NowDate)=0 
		         And b.BrushTime Between dateadd(mi,datediff(mi,a.Starttime,a.Endtime)/2,a.starttime) and dateadd(mi,30,a.Endtime)
		         Group By b.employeeid,a.starttime
		UpDate #OverTime Set EndBrush =b.Brushtime
		         From #OverTime a,#t b
		         WHERE DATEDIFF(d,a.StartTime,@NowDate)=0  
		         AND a.EmployeeID=b.EmployeeID
		         And b.BrushTime Between dateadd(mi,datediff(mi,a.Starttime,a.Endtime)/2,a.starttime) and dateadd(mi,30,a.Endtime)
		TRUNCATE TABLE #t
		TRUNCATE TABLE #SigninCard
		Set @NowDate=Dateadd(dd,1,@NowDate)
	End


Update #OverTime set StartBrush= case when startbrush<=StartTime then starttime else startbrush end where StartBrush is not null
Update #OverTime Set EndBrush=case When endbrush>=endtime then endtime else endbrush end where endbrush is not null
Update #OverTime Set OtTime=datediff(mi,startbrush,endbrush) where startbrush is not null and endbrush is not null

--修改内容：1，节假日，休息日上班，必须在加班处申请。
--	   2，休息日，节假日的加班，在attendancetotal表中体现，且汇总为worktime_1,worktime_2，以分钟,在attendancedetail 中汇总入worktime
--         3，休息日，节假日申请的加班不需要打卡，申请多少计算为多少。
--	   4，不再存在应补休假。
--	   5，汇总表中，不再有休息日迟到早退时间，迟到早退异常次数，出勤，超时加班。
Update #Attendancedetail set ottime=b.ottime
                 From (select employeeid,convert(char,starttime,110) as starttime,sum(ottime) as ottime from #OverTime b group by employeeid,convert(char,starttime,110)) b where b.employeeid=#attendancedetail.employeeid and datediff(dd,#attendancedetail.ondutydate,b.starttime)=0 and left(#attendancedetail.ondutytype,1)='0'

-- update #overtime set ottime=datediff(mi,starttime,endtime) from #attendancedetail a 
-- 	where a.employeeid=#overtime.employeeid and (left(a.ondutytype,1)='1' or left(a.ondutytype,1)='2') and datediff(dd,a.ondutydate,#overtime.starttime)=0
Update #Attendancedetail set worktimeholiday=c.ottime
                 From (select employeeid,convert(char,starttime,110) as starttime,sum(ottime) as ottime from #OverTime b group by employeeid,convert(char,starttime,110)) c where c.employeeid=#attendancedetail.employeeid and datediff(dd,#attendancedetail.ondutydate,c.starttime)=0 and (left(#attendancedetail.ondutytype,1)='1' or left(#attendancedetail.ondutytype,1)='2')

-- '整天加班的计算放在计算出勤后来处理！
-- '整日加班的申请中，如果跨过'1-休息'的工作日，则自动为上不过夜的弹性班次:从当日：00：00：01至23:29:59止。
-- '超时加班处理!
-- '超时算加班，是针对第一次时间的上班，与最后一次上
Declare @strLate varchar(100)
Declare @blnLate bit                --'计算迟到包含该时间？
Declare @intLate int                --'迟到范围
Declare @strLeaveEarly varchar(100)
Declare @blnLeaveEarly int           --'计算早退包含该时间？
Declare @intLeaveEarly int           --'早退范围

Declare @strAbnormity varchar(100)			--'异常是否记旷工,1表示记为旷工,0表示不记
--Declare @strSkipHoliday nvarchar(4000)


Declare @strOverTime varchar(100)
Declare @blnBefor bit                --'提前计加班否
Declare @blnAfter bit                --'延后计加班否
Declare @blnFull bit                 --'提前或延后所有时间计加班
Declare @intBase int                 --'加班时间基数


Select @strLate=variablevalue from options where variablename='strlate'
If len(@strlate)>=3
	select @intlate=cast(substring(@strLate,1,patindex('%,%',@strlate)-1) as int),@blnlate=cast(substring(@strlate,patindex('%,%',@strlate)+1,1) as bit)


Select @intlate=isnull(@intlate,0),@blnlate=isnull(@blnlate,0)

Select @strLeaveEarly=variablevalue from options where variablename='strleaveearly'
If len(@strleaveEarly)>3
	select @intLeaveEarly=cast(substring(@strleaveEarly,1, patindex('%,%',@strleaveEarly)-1) as int),@blnLeaveEarly=cast(substring(@strleaveEarly,patindex('%,%',@strleaveEarly)+1,1) as bit)
Select @intLeaveEarly=isnull(@intLeaveEarly,0),@blnLeaveEarly=isnull(@blnLeaveEarly,0)

Select @strAbnormity=variablevalue from options where variablename='strAbnormity'
Set @strAbnormity=isnull(@strAbnormity,'0')
	
select @strSkipHoliday= case when variablevalue is null or variablevalue='' then '' else variablevalue end  from options where variablename='strSkipHoliday'
Set @strSkipHoliday=isnull(@strSkipHoliday,'')

select @strOverTime=variablevalue from options where variablename='strOTType'
if len(@strOverTime)>=9
	Begin
		select @blnBefor=cast(substring(@strOvertime,1,charindex(',',@strovertime,1)-1) as bit)
		set @strovertime=stuff(@strovertime,1,charindex(',',@strovertime,1),'')
		select @blnafter=cast(substring(@strOvertime,1,charindex(',',@strovertime,1)-1) as bit)
		set @strovertime=stuff(@strovertime,1,charindex(',',@strovertime,1),'')
		select @blnfull=cast(substring(@strOvertime,1,charindex(',',@strovertime,1)-1) as bit)
		set @strovertime=stuff(@strovertime,1,charindex(',',@strovertime,1),'')
		set @intbase =cast(stuff(@strovertime,1,charindex(',',@strovertime,1),'') as int)

	end
Select @blnBefor=isnull(@blnBefor,0),@blnafter=isnull(@blnafter,0),@blnfull=isnull(@blnfull,0),@intbase=isnull(@intbase,0)

--'计算非弹性班次中的迟到早退.
--20150412  by mike 
	
Update #Attendancedetail 
                 set LateTime1= Case when @blnLate  =1 then datediff(mi,ondutydate+Aonduty,onduty1)
                                 Else Datediff(mi,dateadd(mi,AcalculateLate ,Ondutydate+Aonduty),onduty1) end 
                 Where stretchshift=0 and noBrushcard <> 1 and degree >=1 and datediff(mi,dateadd(mi,AcalculateLate ,ondutydate+aonduty),onduty1)>0 
Update #AttendanceDetail 
                Set LateTime2= Case When @blnLate  =1 then Datediff(mi,Ondutydate+Bonduty,Onduty2)
                                 Else Datediff(mi,dateadd(mi,BcalculateLate ,Ondutydate+Bonduty),Onduty2) end 
                 Where Stretchshift=0 and noBrushcard <> 1  and degree >=2 and datediff(mi,dateadd(mi,BcalculateLate ,ondutydate+Bonduty),onduty2)>0
Update #AttendanceDetail 
                Set LateTime3= Case When @blnLate =1 then Datediff(mi,Ondutydate+Conduty,Onduty3)
                                 Else Datediff(mi,dateadd(mi,CcalculateLate ,Ondutydate+Conduty),Onduty3) end 
                 Where Stretchshift=0 and noBrushcard <> 1  and degree >=3 and datediff(mi,dateadd(mi,CcalculateLate ,ondutydate+Conduty),onduty3)>0

Update #Attendancedetail 
                Set LeaveEarlyTime1 = Case When @blnLeaveEarly =1 Then Datediff(mi,Offduty1,Ondutydate+AOffduty) 
                                 Else Datediff(mi,Offduty1,Dateadd(mi,0-AcalculateEarly ,Ondutydate+AOffduty)) End 
                Where Stretchshift=0 and noBrushcard <> 1  and Degree>=1 and datediff(mi,Offduty1,dateadd(mi,0-AcalculateEarly ,ondutydate+AOffduty))>0

Update #Attendancedetail 
                Set LeaveEarlyTime2 = Case When @blnLeaveEarly =1 Then Datediff(mi,Offduty2,Ondutydate+BOffduty) 
                                 Else Datediff(mi,Offduty2,Dateadd(mi,0-BcalculateEarly ,Ondutydate+BOffduty)) End 
                Where Stretchshift=0 and noBrushcard <> 1  and Degree>=2 and datediff(mi,Offduty2,dateadd(mi,0-BcalculateEarly ,ondutydate+BOffduty))>0
Update #Attendancedetail 
                Set LeaveEarlyTime3 = Case When @blnLeaveEarly =1 Then Datediff(mi,Offduty3,Ondutydate+COffduty) 
                                 Else Datediff(mi,Offduty3,Dateadd(mi,0-CcalculateEarly ,Ondutydate+COffduty)) End 
                Where Stretchshift=0 and noBrushcard <> 1  and Degree>=3 and datediff(mi,Offduty3,dateadd(mi,0-CcalculateEarly ,ondutydate+COffduty))>0
						
-------------------------------------------------
/*
Update #Attendancedetail 
                 set LateTime1= Case when @blnLate  =1 then datediff(mi,ondutydate+Aonduty,onduty1)
                                 Else Datediff(mi,dateadd(mi,@intLate ,Ondutydate+Aonduty),onduty1) end 
                 Where stretchshift=0 and noBrushcard <> 1 and degree >=1 and datediff(mi,dateadd(mi,@intLate ,ondutydate+aonduty),onduty1)>0 
Update #AttendanceDetail 
                Set LateTime2= Case When @blnLate  =1 then Datediff(mi,Ondutydate+Bonduty,Onduty2)
                                 Else Datediff(mi,dateadd(mi,@intLate ,Ondutydate+Bonduty),Onduty2) end 
                 Where Stretchshift=0 and noBrushcard <> 1  and degree >=2 and datediff(mi,dateadd(mi,@intLate ,ondutydate+Bonduty),onduty2)>0
Update #AttendanceDetail 
                Set LateTime3= Case When @blnLate =1 then Datediff(mi,Ondutydate+Conduty,Onduty3)
                                 Else Datediff(mi,dateadd(mi,@intLate ,Ondutydate+Conduty),Onduty3) end 
                 Where Stretchshift=0 and noBrushcard <> 1  and degree >=3 and datediff(mi,dateadd(mi,@intLate ,ondutydate+Conduty),onduty3)>0

Update #Attendancedetail 
                Set LeaveEarlyTime1 = Case When @blnLeaveEarly =1 Then Datediff(mi,Offduty1,Ondutydate+AOffduty) 
                                 Else Datediff(mi,Offduty1,Dateadd(mi,-@intLeaveEarly ,Ondutydate+AOffduty)) End 
                Where Stretchshift=0 and noBrushcard <> 1  and Degree>=1 and datediff(mi,Offduty1,dateadd(mi,-@intLeaveEarly ,ondutydate+AOffduty))>0

Update #Attendancedetail 
                Set LeaveEarlyTime2 = Case When @blnLeaveEarly =1 Then Datediff(mi,Offduty2,Ondutydate+BOffduty) 
                                 Else Datediff(mi,Offduty2,Dateadd(mi,-@intLeaveEarly ,Ondutydate+BOffduty)) End 
                Where Stretchshift=0 and noBrushcard <> 1  and Degree>=2 and datediff(mi,Offduty2,dateadd(mi,-@intLeaveEarly ,ondutydate+BOffduty))>0
Update #Attendancedetail 
                Set LeaveEarlyTime3 = Case When @blnLeaveEarly =1 Then Datediff(mi,Offduty3,Ondutydate+COffduty) 
                                 Else Datediff(mi,Offduty3,Dateadd(mi,-@intLeaveEarly ,Ondutydate+COffduty)) End 
                Where Stretchshift=0 and noBrushcard <> 1  and Degree>=3 and datediff(mi,Offduty3,dateadd(mi,-@intLeaveEarly ,ondutydate+COffduty))>0
*/
/*	
'    strOTType   超时加班    如：1,1,1,0,30  表示提前及延时工作均算加班，加班方式为：按提前或延后的所有工时计为加班
'    超时加班功能：可以根据超时加班的设定，将"开始刷卡至标准"或"标准至截卡刷卡"之间的上班时间计为加班时间
*/
--**********
UPdate #Attendancedetail set overtime=case when overtime is null then 0 else overtime end 
Update #Attendancedetail Set aOttime1= 
         Case When @blnBefor  =1 and @blnFull =1 then datediff(mi,onduty1,ondutydate+Aonduty)-overtime
              When @blnBefor  =1 and @blnFull =0 Then (datediff(mi,onduty1,ondutydate+Aonduty)-overtime)/@intBase *@intBase 
              Else aottime1 end 
         Where Stretchshift=0 and degree>=1 and datediff(mi,onduty1,ondutydate+Aonduty)>0

Update #Attendancedetail Set bOttime1= 
         Case When @blnBefor  =1 and @blnFull =1 then datediff(mi,onduty2,ondutydate+Bonduty) -overtime
              When @blnBefor  =1 and @blnFull =0 Then (datediff(mi,onduty2,ondutydate+Bonduty)-overtime)/@intBase *@intBase 
              Else bottime1 end 
         Where Stretchshift=0 and degree>=2 and datediff(mi,onduty2,ondutydate+Bonduty)>0
Update #Attendancedetail Set cOttime1= 
         Case When @blnBefor  =1 and @blnFull =1 then datediff(mi,onduty3,ondutydate+Conduty) -overtime
              When @blnBefor  =1 and @blnFull =0 Then (datediff(mi,onduty3,ondutydate+Conduty)-overtime)/@intBase*@intBase 
              Else cottime1 end 
         Where Stretchshift=0 and degree>=3 and datediff(mi,onduty3,ondutydate+Conduty)>0
        
Update #Attendancedetail Set aOttime2= 
         Case When @blnAfter  =1 and @blnFull =1 then datediff(mi,ondutydate+AOffduty,Offduty1) -overtime
              When @blnAfter  =1 and @blnFull =0 Then (datediff(mi,ondutydate+AOffduty,Offduty1)-overtime)/@intBase *@intBase 
              Else aottime2 end 
         Where Stretchshift=0 and degree>=1 and datediff(mi,ondutydate+AOffduty,Offduty1)>0
Update #Attendancedetail Set bOttime2= 
         Case When @blnAfter  =1 and @blnFull =1 then datediff(mi,ondutydate+BOffduty,Offduty2) -overtime
              When @blnAfter  =1 and @blnFull =0 Then (datediff(mi,ondutydate+BOffduty,Offduty2)-overtime)/@intBase*@intBase 
              Else bottime2 end 
         Where Stretchshift=0 and degree>=2 and datediff(mi,ondutydate+BOffduty,Offduty2)>0
Update #Attendancedetail Set cOttime2= 
         Case When @blnAfter  =1 and @blnFull =1 then datediff(mi,ondutydate+COffduty,Offduty3) -overtime
              When @blnAfter  =1 and @blnFull =0 Then (datediff(mi,ondutydate+COffduty,Offduty3)-overtime)/@intBase *@intBase 
              Else cottime2 end 
         Where Stretchshift=0 and degree>=3 and datediff(mi,ondutydate+COffduty,Offduty3)>0
Update #Attendancedetail set aottime1 =case when aottime1<0 then 0 else aottime1 end,
							bottime1=case when bottime1<0 then 0 else bottime1 end ,
							cottime1=case when cottime1<0 then 0 else cottime1 end,
							aottime2=case when aottime2<0 then 0 else aottime2 end ,
							bottime2=case when bottime2<0 then 0 else bottime2 end,
							cottime2=case when cottime2<0 then 0 else cottime2 end 
							
--分析超时加班与申请加班之间有无冲突(即超时加班的刷卡是否跨申请加班，跨就是冲突了)有冲突，则以审请的为准，否则。两者都算。

UpDate #Attendancedetail set aottime1=0 
	from attendanceot a
	where #attendancedetail.employeeid=a.employeeid and ((onduty1>=a.starttime and onduty1<=a.endtime) or (onduty1<a.starttime and a.starttime<=Aonduty+ondutydate))

UpDate #Attendancedetail set bottime1=0 
	from attendanceot a
	where #attendancedetail.employeeid=a.employeeid and ((onduty2>=a.starttime and onduty2<=a.endtime) or (onduty2<a.starttime and a.starttime<=Bonduty+ondutydate))

UpDate #Attendancedetail set Cottime1=0 
	from attendanceot a
	where #attendancedetail.employeeid=a.employeeid and ((onduty3>=a.starttime and onduty3<=a.endtime) or (onduty3<a.starttime and a.starttime<=Conduty+ondutydate))

Update #attendancedetail set aottime2=0
	from attendanceot a
	where #attendancedetail.employeeid =a.employeeid and ((offduty1>=a.starttime and offduty1<=a.endtime) or (offduty1>a.endtime and a.starttime>=Aoffduty+ondutydate))

Update #attendancedetail set bottime2=0
	from attendanceot a
	where #attendancedetail.employeeid =a.employeeid and ((offduty2>=a.starttime and offduty2<=a.endtime) or (offduty2>a.endtime and a.starttime>=boffduty+ondutydate))
Update #attendancedetail set cottime2=0
	from attendanceot a
	where #attendancedetail.employeeid =a.employeeid and ((offduty3>=a.starttime and offduty3<=a.endtime) or (offduty3>a.endtime and a.starttime>=coffduty+ondutydate))

update #attendancedetail set ottime=isnull(ottime,0)+aottime1+aottime2+bottime1+bottime2+cottime1+cottime2
update #attendancedetail set worktime=worktimeholiday where (worktime is null or worktime=0)and left(ondutytype,1) in ('1','2')
--select * from #attendancedetail where employeeid=103
--lect * from brushcardattend

--**********
--   '计算各假期及出差时间
--'整天请假,请假为1（以天来计算）
--'整天请假时，StartTime与EndTime中只有日期没有时间的。 类似于2015-04-01 00:00:00

Declare @Fieldname varchar(100),
	@AskforleaveName nvarchar(200)
Declare @intworktime numeric(18,2)
select @intworktime=isnull(variablevalue,8) from options where variablename='intworktime'
set @intworktime=isnull(@intworktime,8)

--计算工时：标准时间至标准时间-请假时间-迟到时间-早退时间
--修改内容: 工时的计算，原来一时段内有两种类型的请假时，工时仅减去了其中一种类型的时间。
--	    将工时的计算中的减迟到早退中间休息，提到请假处理过程外提次处理。其它的在请假处理过程内，有什么请假即减什么请假。
Update #Attendancedetail Set workTime1= datediff(mi,Ondutydate+AOnduty,Ondutydate+AOffduty)-Isnull(Latetime1,0)-Isnull(LeaveearlyTime1,0)-isnull(ArestTime,0) 
             Where degree>=1 and Onduty1 is not null and Offduty1 is not null 
            
Update #Attendancedetail Set WorkTime2=  Datediff(mi,Ondutydate+Bonduty,Ondutydate+BOffduty)-IsNull(LateTime2,0)-IsNull(LeaveEarlytime2,0) -isnull(brestTime,0) 
             Where Degree>=2 and Onduty2 is Not null and OffDuty2 is Not null 
            
Update #Attendancedetail Set WorkTime3= Datediff(mi,Ondutydate+cOnduty,Ondutydate+COffduty)-Isnull(LateTime3,0)-Isnull(LeaveEarlytime3,0)-isnull(crestTime,0)  
             Where Degree>=3 and Onduty3 is not null and offduty3 is not null 

--免卡时，加入按班次的标准时间计算工时
update #attendancedetail set worktime1=datediff(mi,(ondutydate+aonduty),(ondutydate+aoffduty))-isnull(Aresttime,0) where nobrushcard=1 and degree>=1 
update #attendancedetail set worktime2=datediff(mi,(ondutydate+bonduty),(ondutydate+boffduty))-isnull(Bresttime,0) where nobrushcard=1 and degree>=2
update #attendancedetail set worktime3=datediff(mi,(ondutydate+conduty),(ondutydate+coffduty))-isnull(Cresttime,0) where nobrushcard=1 and degree>=3 

Declare AskForleave cursor
	for select fieldname,fielddesc from tablestructure where (fieldname='OnTrip' or fieldproperty1='Holiday') and tableid in (select tableid from tables where tablename='attendancedetail')
Open Askforleave
Fetch Askforleave into @Fieldname,@AskforleaveName
while @@fetch_status=0
	begin
		Exec ('Update #Attendancedetail Set '+@Fieldname+ '=1 ,worktime1=null,worktime2=null,worktime3=null
				From AttendanceAskforLeave b ,#Attendancedetail a 
				where a.employeeid=b.employeeid and b.allday=1 and b.AskForLeaveType='''+@AskforleaveName+''' and 
					a.Ondutydate between b.StartTime  and  b.EndTime  and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')
 
	--         '非整天请假.
	--         '整段请假，如果班次中有休息则请假时间应减去休息。非整段不减休息时间。
	-- '？？？注意，非整天请假在计算上班时间时要减去。

	--	修改内容：用临时表，处理同一时段申请多段请假，只能计算出其中一段请假时间的问题
		if object_id('tempdb..#askforleave') is not null drop table #askforleave
		create table #askforleave (employeeid int,ondutydate datetime,leave1 int default 0,leave2 int default 0,leave3 int default 0)
--		分拆sql语句，提高效率
-- 	        Exec ('insert into #askforleave (employeeid,ondutydate,leave1,leave2,leave3) select #attendancedetail.employeeid,ondutydate, 
-- 	                         Case When b.Starttime<=Cast(ConVert(char,OndutyDate+AOnduty,120) as Datetime) and b.endtime>=Cast(ConVert(char,Ondutydate+AOffduty,120) as Datetime) 
-- 	                                     Then datediff(mi,AOnduty,AOffDuty)-isnull(ArestTime,0) 
-- 	                              When b.Starttime<=Cast(ConVert(char,Ondutydate+AOnduty,120) as Datetime) and b.Endtime < Cast(ConVert(char,Ondutydate+AOffduty,120) as Datetime) and b.EndTime > Cast(ConVert(char,Ondutydate+AOnduty,120) as Datetime) 
-- 	                                     Then Datediff(mi,OndutyDate+Aonduty,b.EndTime) 
-- 	                              When b.StartTime>Cast(conVert(char,Ondutydate+Aonduty,120) as Datetime) and b.EndTime < Cast(ConVert(char,Ondutydate+AOffduty,120) as DAtetime) 
-- 	                                     Then Datediff(mi,b.starttime,b.endtime) 
-- 	                              When b.Starttime>Cast(ConVert(char,Ondutydate+AonDuty,120) as Datetime) and b.EndTime>=Cast(Convert(char,Ondutydate+AOffduty,120) as Datetime)  and b.StartTime< Cast(Convert(char,Ondutydate+AOffduty,120) as Datetime)
-- 	                                     Then Datediff(mi,b.starttime,Ondutydate+AOffduty) End ,
-- 	                         Case When b.Starttime<=Cast(ConVert(char,OndutyDate+BOnduty,120) as Datetime) and b.endtime>=Cast(ConVert(char,Ondutydate+BOffduty,120) as Datetime) 
-- 	                                     Then datediff(mi,BOnduty,BOffDuty)-isnull(BrestTime,0) 
-- 	                              When b.Starttime<=Cast(ConVert(char,Ondutydate+BOnduty,120) as Datetime) and b.Endtime < Cast(ConVert(char,Ondutydate+BOffduty,120) as Datetime) and b.EndTime > Cast(ConVert(char,Ondutydate+BOnduty,120) as Datetime)
-- 	                                     Then Datediff(mi,OndutyDate+Bonduty,b.EndTime) 
-- 	                              When b.StartTime>Cast(conVert(char,Ondutydate+Bonduty,120) as Datetime) and b.EndTime < Cast(ConVert(char,Ondutydate+BOffduty,120) as DAtetime) 
-- 	                                     Then Datediff(mi,b.starttime,b.endtime) 
-- 	                              When b.Starttime>Cast(ConVert(char,Ondutydate+BonDuty,120) as Datetime) and b.EndTime>=Cast(Convert(char,Ondutydate+BOffduty,120) as Datetime)  and b.StartTime < Cast(Convert(char,Ondutydate+BOffduty,120) as Datetime) 
-- 	                                     Then Datediff(mi,b.starttime,Ondutydate+BOffduty) End ,
-- 	                         Case When b.Starttime<=Cast(ConVert(char,OndutyDate+COnduty,120) as Datetime) and b.endtime>=Cast(ConVert(char,Ondutydate+COffduty,120) as Datetime) 
-- 	                                     Then datediff(mi,COnduty,COffDuty)-isnull(CrestTime,0) 
-- 	                              When b.Starttime<=Cast(ConVert(char,Ondutydate+COnduty,120) as Datetime) and b.Endtime < Cast(ConVert(char,Ondutydate+COffduty,120) as Datetime) and b.EndTime > Cast(ConVert(char,Ondutydate+COnduty,120) as Datetime)
-- 	                                     Then Datediff(mi,OndutyDate+Conduty,b.EndTime) 
-- 	                              When b.StartTime > Cast(conVert(char,Ondutydate+Conduty,120) as Datetime) and b.EndTime < Cast(ConVert(char,Ondutydate+COffduty,120) as DAtetime) 
-- 	                                     Then Datediff(mi,b.starttime,b.endtime) 
-- 	                              When b.Starttime > Cast(ConVert(char,Ondutydate+ConDuty,120) as Datetime) and b.EndTime>=Cast(Convert(char,Ondutydate+COffduty,120) as Datetime)  and b.StartTime < Cast(Convert(char,Ondutydate+COffduty,120) as Datetime) 
-- 	                                     Then Datediff(mi,b.starttime,Ondutydate+COffduty) End 
-- 	                     From AttendanceAskforleave b,#Attendancedetail
-- 	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+'''  and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')


	        Exec ('insert into #askforleave (employeeid,ondutydate,leave1) 
				select #attendancedetail.employeeid,ondutydate,datediff(mi,AOnduty,AOffDuty)-isnull(ArestTime,0) 
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=1 and  b.Starttime<=Cast(ConVert(char,OndutyDate+AOnduty,120) as Datetime) and b.endtime>=Cast(ConVert(char,Ondutydate+AOffduty,120) as Datetime)  and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave1) 
				select #attendancedetail.employeeid,ondutydate,Datediff(mi,OndutyDate+Aonduty,b.EndTime) 
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=1 and b.Starttime<=Cast(ConVert(char,Ondutydate+AOnduty,120) as Datetime) and b.Endtime < Cast(ConVert(char,Ondutydate+AOffduty,120) as Datetime) and b.EndTime > Cast(ConVert(char,Ondutydate+AOnduty,120) as Datetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave1) 
				select #attendancedetail.employeeid,ondutydate,Datediff(mi,b.starttime,b.endtime) 
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=1 and b.StartTime>Cast(conVert(char,Ondutydate+Aonduty,120) as Datetime) and b.EndTime < Cast(ConVert(char,Ondutydate+AOffduty,120) as DAtetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave1) 
				select #attendancedetail.employeeid,ondutydate,Datediff(mi,b.starttime,Ondutydate+AOffduty)
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=1 and b.Starttime>Cast(ConVert(char,Ondutydate+AonDuty,120) as Datetime) and b.EndTime>=Cast(Convert(char,Ondutydate+AOffduty,120) as Datetime)  and b.StartTime< Cast(Convert(char,Ondutydate+AOffduty,120) as Datetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')
		--*
	        Exec ('insert into #askforleave (employeeid,ondutydate,leave2) 
				select #attendancedetail.employeeid,ondutydate,datediff(mi,BOnduty,BOffDuty)-isnull(BrestTime,0)
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=2 and b.Starttime<=Cast(ConVert(char,OndutyDate+BOnduty,120) as Datetime) and b.endtime>=Cast(ConVert(char,Ondutydate+BOffduty,120) as Datetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave2) 
				select #attendancedetail.employeeid,ondutydate,Datediff(mi,OndutyDate+Bonduty,b.EndTime)
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=2 and b.Starttime<=Cast(ConVert(char,Ondutydate+BOnduty,120) as Datetime) and b.Endtime < Cast(ConVert(char,Ondutydate+BOffduty,120) as Datetime) and b.EndTime > Cast(ConVert(char,Ondutydate+BOnduty,120) as Datetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave2) 
				select #attendancedetail.employeeid,ondutydate,Datediff(mi,b.starttime,b.endtime) 
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=2 and b.StartTime>Cast(conVert(char,Ondutydate+Bonduty,120) as Datetime) and b.EndTime < Cast(ConVert(char,Ondutydate+BOffduty,120) as DAtetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave2) 
				select #attendancedetail.employeeid,ondutydate,Datediff(mi,b.starttime,Ondutydate+BOffduty)
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=2 and b.Starttime>Cast(ConVert(char,Ondutydate+BonDuty,120) as Datetime) and b.EndTime>=Cast(Convert(char,Ondutydate+BOffduty,120) as Datetime)  and b.StartTime < Cast(Convert(char,Ondutydate+BOffduty,120) as Datetime) and b.StartTime< Cast(Convert(char,Ondutydate+AOffduty,120) as Datetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')
		--*

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave3) 
				select #attendancedetail.employeeid,ondutydate,datediff(mi,COnduty,COffDuty)-isnull(CrestTime,0) 
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=3 and b.Starttime<=Cast(ConVert(char,OndutyDate+COnduty,120) as Datetime) and b.endtime>=Cast(ConVert(char,Ondutydate+COffduty,120) as Datetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave3) 
				select #attendancedetail.employeeid,ondutydate,Datediff(mi,OndutyDate+Conduty,b.EndTime) 
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=3 and b.Starttime<=Cast(ConVert(char,Ondutydate+COnduty,120) as Datetime) and b.Endtime < Cast(ConVert(char,Ondutydate+COffduty,120) as Datetime) and b.EndTime > Cast(ConVert(char,Ondutydate+COnduty,120) as Datetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave3) 
				select #attendancedetail.employeeid,ondutydate,Datediff(mi,b.starttime,b.endtime) 
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=3 and b.StartTime > Cast(conVert(char,Ondutydate+Conduty,120) as Datetime) and b.EndTime < Cast(ConVert(char,Ondutydate+COffduty,120) as DAtetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave3) 
				select #attendancedetail.employeeid,ondutydate,Datediff(mi,b.starttime,Ondutydate+COffduty)
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=3 and b.Starttime > Cast(ConVert(char,Ondutydate+ConDuty,120) as Datetime) and b.EndTime>=Cast(Convert(char,Ondutydate+COffduty,120) as Datetime)  and b.StartTime < Cast(Convert(char,Ondutydate+COffduty,120) as Datetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')


		--修改内容: 工时的计算，原来一时段内有两种类型的请假时，工时仅减去了其中一种类型的时间。
		--	    将工时的计算中的减迟到早退中间休息，提到请假处理过程外提次处理。其它的在请假处理过程内，有什么请假即减什么请假。		
	         Exec ('Update #Attendancedetail set '+@Fieldname+'= (isnull(t.leave1,0)+isnull(t.leave2,0)+isnull(t.leave3,0)) / 60.0/shifttime ,
				worktime1=worktime1-t.leave1,worktime2=worktime2-t.leave2,worktime3=worktime3-t.leave3
			     From (select employeeid,ondutydate,sum(isnull(leave1,0)) as Leave1,sum(isnull(leave2,0)) as Leave2,sum(isnull(leave3,0)) as Leave3 from #askforleave group by employeeid,ondutydate) t
	                     Where #attendancedetail.employeeid=t.employeeid and #attendancedetail.ondutydate=t.ondutydate')
		
		--修改内容：1，休息日，节假日不会有排班，但可以申请非整天的请假以及出差。
		--	   2，由于没有班次，一天的基本工时在选项中设置。
		--  	   3，跨天非整天请假，出差，算作是申请开始时间所在天的请假或出差。
		--         4,非整天请假出差不能跨24小时。
		if object_id('tempdb..#attendaskforleave') is not null drop table #attendaskforleave
		Create table #attendaskforleave (employeeid int,ondutydate datetime,starttime datetime,endtime datetime,askforleavetype nvarchar(50),leavetime int default 0)
		exec ('insert into #attendaskforleave (employeeid,ondutydate,starttime,endtime,askforleavetype,leavetime)
			select a.employeeid ,a.ondutydate,b.starttime,b.endtime,b.askforleavetype,datediff(mi,b.starttime,b.endtime) from #attendancedetail a,attendanceaskforleave b
				where a.employeeid=b.employeeid and datediff(dd,a.ondutydate,b.starttime)=0 and b.allday=0 and (left(a.ondutytype,1) =''1'' or left(a.ondutytype,1)=''2'') and b.askforleavetype='''+@AskforleaveName+'''')
		Exec ('Update #attendancedetail set '+@Fieldname+'=a.leavetime/60.0/'+@intworktime+' 
				from (select employeeid,ondutydate,sum(isnull(leavetime,0)) as leavetime from  #attendaskforleave  group by employeeid,ondutydate)a 
				where #attendancedetail.employeeid=a.employeeid and #attendancedetail.ondutydate=a.ondutydate and (left(#attendancedetail.ondutytype,1)=''1'' or left(#attendancedetail.ondutytype,1)=''2'')'
			)

		
-- 		if @Askforleavename='事假'
-- 			begin
-- 			select * from #attendancedetail where employeeid=1875
-- 			select * from #attendaskforleave
-- 			select employeeid,ondutydate,sum(isnull(leavetime,0)) as leavetime from  #attendaskforleave  group by employeeid,ondutydate
-- 			end
-- 
-- 	        Exec ('Update #Attendancedetail set Leave1= 
-- 	                         Case When b.Starttime<=Cast(ConVert(char,OndutyDate+AOnduty,120) as Datetime) and b.endtime>=Cast(ConVert(char,Ondutydate+AOffduty,120) as Datetime) 
-- 	                                     Then datediff(mi,AOnduty,AOffDuty)-isnull(ArestTime,0) 
-- 	                              When b.Starttime<=Cast(ConVert(char,Ondutydate+AOnduty,120) as Datetime) and b.Endtime < Cast(ConVert(char,Ondutydate+AOffduty,120) as Datetime) and b.EndTime > Cast(ConVert(char,Ondutydate+AOnduty,120) as Datetime) 
-- 	                                     Then Datediff(mi,OndutyDate+Aonduty,b.EndTime) 
-- 	                              When b.StartTime>Cast(conVert(char,Ondutydate+Aonduty,120) as Datetime) and b.EndTime < Cast(ConVert(char,Ondutydate+AOffduty,120) as DAtetime) 
-- 	                                     Then Datediff(mi,b.starttime,b.endtime) 
-- 	                              When b.Starttime>Cast(ConVert(char,Ondutydate+AonDuty,120) as Datetime) and b.EndTime>=Cast(Convert(char,Ondutydate+AOffduty,120) as Datetime)  and b.StartTime< Cast(Convert(char,Ondutydate+AOffduty,120) as Datetime)
-- 	                                     Then Datediff(mi,b.starttime,Ondutydate+AOffduty) End 
-- 	                     From AttendanceAskforleave b
-- 	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
-- 	                         #Attendancedetail.degree>=1  and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')
--             
-- 	         Exec ('Update #Attendancedetail set Leave2= 
-- 	                         Case When b.Starttime<=Cast(ConVert(char,OndutyDate+BOnduty,120) as Datetime) and b.endtime>=Cast(ConVert(char,Ondutydate+BOffduty,120) as Datetime) 
-- 	                                     Then datediff(mi,BOnduty,BOffDuty)-isnull(BrestTime,0) 
-- 	                              When b.Starttime<=Cast(ConVert(char,Ondutydate+BOnduty,120) as Datetime) and b.Endtime < Cast(ConVert(char,Ondutydate+BOffduty,120) as Datetime) and b.EndTime > Cast(ConVert(char,Ondutydate+BOnduty,120) as Datetime)
-- 	                                     Then Datediff(mi,OndutyDate+Bonduty,b.EndTime) 
-- 	                              When b.StartTime>Cast(conVert(char,Ondutydate+Bonduty,120) as Datetime) and b.EndTime < Cast(ConVert(char,Ondutydate+BOffduty,120) as DAtetime) 
-- 	                                     Then Datediff(mi,b.starttime,b.endtime) 
-- 	                              When b.Starttime>Cast(ConVert(char,Ondutydate+BonDuty,120) as Datetime) and b.EndTime>=Cast(Convert(char,Ondutydate+BOffduty,120) as Datetime)  and b.StartTime < Cast(Convert(char,Ondutydate+BOffduty,120) as Datetime) 
-- 	                                     Then Datediff(mi,b.starttime,Ondutydate+BOffduty) End 
-- 	                     From AttendanceAskforleave b
-- 	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
-- 	                         #Attendancedetail.degree>=2  and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')
	                       
-- 	        Exec ('Update #Attendancedetail set Leave3= 
-- 	                         Case When b.Starttime<=Cast(ConVert(char,OndutyDate+COnduty,120) as Datetime) and b.endtime>=Cast(ConVert(char,Ondutydate+COffduty,120) as Datetime) 
-- 	                                     Then datediff(mi,COnduty,COffDuty)-isnull(CrestTime,0) 
-- 	                              When b.Starttime<=Cast(ConVert(char,Ondutydate+COnduty,120) as Datetime) and b.Endtime < Cast(ConVert(char,Ondutydate+COffduty,120) as Datetime) and b.EndTime > Cast(ConVert(char,Ondutydate+COnduty,120) as Datetime)
-- 	                                     Then Datediff(mi,OndutyDate+Conduty,b.EndTime) 
-- 	                              When b.StartTime > Cast(conVert(char,Ondutydate+Conduty,120) as Datetime) and b.EndTime < Cast(ConVert(char,Ondutydate+COffduty,120) as DAtetime) 
-- 	                                     Then Datediff(mi,b.starttime,b.endtime) 
-- 	                              When b.Starttime > Cast(ConVert(char,Ondutydate+ConDuty,120) as Datetime) and b.EndTime>=Cast(Convert(char,Ondutydate+COffduty,120) as Datetime)  and b.StartTime < Cast(Convert(char,Ondutydate+COffduty,120) as Datetime) 
-- 	                                     Then Datediff(mi,b.starttime,Ondutydate+COffduty) End 
-- 	                     From AttendanceAskforleave b
-- 	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
-- 	                         #Attendancedetail.degree>=3  and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')
-- 	--             '计算工时：标准时间至标准时间-请假时间-迟到时间-早退时间
-- 	--             '如果同一时段存在两种请假？暂不考虑！WokeTime1>0
-- 
-- 	        Update #Attendancedetail Set workTime1= datediff(mi,Ondutydate+AOnduty,Ondutydate+AOffduty)-isnull(Leave1,0)-Isnull(Latetime1,0)-Isnull(LeaveearlyTime1,0)-isnull(ArestTime,0) 
-- 	                     Where degree>=1 and Onduty1 is not null and Offduty1 is not null and Leave1 is not null 
-- 	                    
-- 	        Update #Attendancedetail Set WorkTime2=  Datediff(mi,Ondutydate+Bonduty,Ondutydate+BOffduty)-Isnull(Leave2,0)-IsNull(LateTime2,0)-IsNull(LeaveEarlytime2,0) -isnull(brestTime,0) 
-- 	                     Where Degree>=2 and Onduty2 is Not null and OffDuty2 is Not null and Leave2 is not null 
-- 	                    
-- 	        Update #Attendancedetail Set WorkTime3= Datediff(mi,Ondutydate+cOnduty,Ondutydate+COffduty)-isNull(Leave3,0)-Isnull(LateTime3,0)-Isnull(LeaveEarlytime3,0)-isnull(crestTime,0)  
-- 	                     Where Degree>=3 and Onduty3 is not null and offduty3 is not null and Leave3 is not null

-- 
-- 	         Exec ('Update #Attendancedetail set '+@Fieldname+'= (IsNull(Leave1, 0) + IsNull(Leave2, 0) + IsNull(Leave3, 0)) / 60.0/shifttime 
-- 	                     Where '+@Fieldname+' is null')

-- 	        --按标准算时，一天不以班次中的工时为准，而是以标准时间之和减中间休息为准。
-- 		if @blnanalyseworkday=1
-- 			begin
-- 			         Exec ('Update #Attendancedetail set '+@Fieldname+'= (IsNull(Leave1, 0) + IsNull(Leave2, 0) + IsNull(Leave3, 0)) / 60.0/shifttime 
-- 			                     Where '+@Fieldname+' is null')
-- 
-- 			end
-- 		else
-- 			begin
-- 
-- 			         Exec ('Update #Attendancedetail set '+@Fieldname+'= (IsNull(Leave1, 0) + IsNull(Leave2, 0) + IsNull(Leave3, 0)) / standardtime 
-- 			                     Where '+@Fieldname+' is null and standardtime>0')
-- 
-- 			end
	                              
	
--	        Update #Attendancedetail set Leave1=null,Leave2=null,Leave3=Null
	
	        If Charindex(@Fieldname, @strSkipHoliday, 1) > 0 
			Begin
				If substring(@strSkipHoliday, Charindex(@Fieldname, @strSkipHoliday, 1) + Len(@Fieldname), 1) = '1'
					begin
					--print @fieldname
					--print substring(@strSkipHoliday, Charindex(@Fieldname, @strSkipHoliday, 1) + Len(@Fieldname), 1)

					 Exec ('Update #Attendancedetail set '+@Fieldname+'=0
					                ,Result1= case when Result1='''+@Askforleavename+''' then null else Result1 end 
					                ,Result2= case when Result2='''+@Askforleavename+''' then null else Result2 end 
					                ,Result3= case when Result3='''+@Askforleavename+''' then null else Result3 end 
					                ,Result4= case when Result4='''+@Askforleavename+''' then null else Result4 end 
					                ,Result5= case when Result5='''+@Askforleavename+''' then null else Result5 end 
					                ,Result6= case when Result6='''+@Askforleavename+''' then null else Result6 end 
					                 where left(ondutytype,1) in (''1'',''2'')')
					end
			end
		Fetch Askforleave into @Fieldname,@Askforleavename
	end
Close Askforleave
DealLocate Askforleave
--select * from #attendancedetail where employeeid=1

-- '无请假时的工时
-- '一个时段时，弹性班次上班多少时间计多少时间！
Update #Attendancedetail Set workTime1=case when LEFT(stretchshift,1)=0 then Datediff(mi,Ondutydate+Aonduty,Ondutydate+AOffduty)-Isnull(ArestTime,0)-IsNull(LateTime1,0)-IsNull(LeaveEarlytime1,0) 
				else  Datediff(mi,Ondutydate+onduty1,Ondutydate+Offduty1)-Isnull(ArestTime,0)-IsNull(LateTime1,0)-IsNull(LeaveEarlytime1,0) end  
             Where degree>=1 and Onduty1 is not null and Offduty1 is not null and Worktime1 is null 
Update #Attendancedetail Set workTime2=Datediff(mi,Ondutydate+Bonduty,Ondutydate+BOffduty)-Isnull(BrestTime,0)-IsNull(LateTime2,0)-IsNull(LeaveEarlytime2,0) 
             Where degree>=2 and Onduty2 is not null and Offduty2 is not null and Worktime2 is null 
Update #Attendancedetail Set workTime3=Datediff(mi,Ondutydate+Conduty,Ondutydate+COffduty)-Isnull(CrestTime,0)-IsNull(LateTime3,0)-IsNull(LeaveEarlytime3,0) 
             Where degree>=3 and Onduty3 is not null and Offduty3 is not null and Worktime3 is null 
Update #Attendancedetail Set WorkTime= isnull(Worktime1,0)+Isnull(WorkTime2,0)+Isnull(Worktime3,0) where left(ondutytype,1)='0'

Update #Attendancedetail set OtTime = WorkTime
             From #Attendancedetail a,Attendanceot b 
             Where a.employeeid=b.employeeid and a.Ondutydate Between b.Starttime and B.Endtime and b.allday=1 and left(a.ondutytype,1)<>'1'

--将正常班次调整为休息时。shifttime将为0，会导致除以0错误。
UpDate #attendancedetail set shifttime=null where Shifttime=0

if @blnAnalyseWorkDay=1 
	Update #attendancedetail set Workday =isnull(WorkTime,0)/60.00/isnull(ShiftTime,8) --'加入的弹性班次要设定shifttime
else
	Update #attendancedetail set Workday =
		(isnull(WorkTime1,0)+case when isnull(worktime1,0)>0 then isnull(latetime1,0)+isnull(leaveearlytime1,0) else 0 end 
		 +isnull(Worktime2,0)+case when isnull(worktime2,0)>0 then isnull(latetime2,0)+isnull(leaveearlytime2,0) else 0 end 
		 +isnull(Worktime3,0)+case when isnull(worktime3,0)>0 then isnull(latetime3,0)+isnull(leaveearlytime3,0) else 0 end )
		/60.00/isnull(ShiftTime,8) 

--select * from #attendancedetail where nobrushcard=1 and employeeid=2

--'处理上班性质
Update #Attendancedetail set Result1= case when latetime1>0 then '迟到' else result1 end, 
				  Result2= case when LeaveEarlytime1>0 then '早退' else Result2 end, 
				  Result3= case when Latetime2>0 then '迟到' else Result3 end, 
				  Result4= case when LeaveEarlyTime2>0 then '早退' else Result4 end, 
				  Result5= case when latetime3>0 then '迟到' else Result5 end, 
				  Result6 =case when LeaveEarlytime3>0 then '早退' else Result6 end 
Update #attendancedetail set Result1= case when onduty1 is null and result1 is null then '未打' when Onduty1 is not null and result1 is null then '正常' else Result1 end, 
				  Result2= case When offduty1 is null and result2 is null then '未打' when offduty1 is not null and result2 is null then '正常' else Result2 end 
				 where Degree>=1 and NoBrushcard<>1 
Update #attendancedetail set Result3= case when onduty2 is null and result3 is null then '未打' when Onduty2 is not null and result3 is null then '正常' else Result3 end, 
				  Result4= case When offduty2 is null and result4 is null then '未打' when offduty2 is not null and result4 is null then '正常' else Result4 end 
				 where Degree>=2 and NoBrushcard<>1 
Update #attendancedetail set Result5= case when onduty3 is null and result5 is null then '未打' when Onduty3 is not null and result5 is null then '正常' else Result5 end, 
				  Result6= case When offduty3 is null and result6 is null then '未打' when offduty3 is not null and result6 is null then '正常' else Result6 end 
				 where Degree=3 and NoBrushcard<>1 
Update #Attendancedetail set result1=null ,result2=null
				where left(ondutytype,1)='2' and degree>=1 and (result1 ='未打' and result2='未打')
Update #Attendancedetail set result3=null ,result4=null
				where left(ondutytype,1)='2' and degree>=2 and (result3 ='未打' and result4='未打')
Update #Attendancedetail set result5=null ,result6=null
				where left(ondutytype,1)='2' and degree>=3 and (result5 ='未打' and result6='未打')
update #AttendanceDetail set result1= case when  degree>=1 and result1 is null then holidayname else result1 end ,
			 result2= case when  degree>=1 and result2 is null then holidayname else result2 end ,
			 result3= case when  degree>=2 and result3 is null then holidayname else result3 end ,
			 result4= case when  degree>=2 and result4 is null then holidayname else result4 end ,
			 result5= case when  degree>=3 and result5 is null then holidayname else result5 end ,
			 result6= case when  degree>=3 and result6 is null then holidayname else result6 end 
	 from attendanceholiday b where #AttendanceDetail.ondutydate=b.HolidayDate and left(#AttendanceDetail.ondutytype,1)<>'1'

if @strAbnormity='1'
	Begin
		Update #Attendancedetail Set Absent= (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0))/60.00/isnull(ShiftTime,8)
		         Where Degree=1  and noBrushcard <> 1 and (Onduty1 is null or Offduty1 is null) and (result1  ='未打' or result2  ='未打')  and Left(ondutytype,1)<>'1' 
		Update #Attendancedetail Set Absent= Case when ((Onduty1 is null or Offduty1 is null) and (result1  ='未打' or result2  ='未打')) and ((Onduty2 is null or Offduty2 is null) and (result3  ='未打' or result4  ='未打')) Then ((datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty))-isnull(Aresttime,0)-isnull(Bresttime,0))/60.00/isnull(ShiftTime,8) 
		         When ((Onduty1 is null or Offduty1 is null) and (result1  ='未打' or result2  ='未打')) and Onduty2 is not null and Offduty2 is not null Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0))/60.00/isnull(ShiftTime,8)
		         When  (Onduty1 is not null and Offduty1 is not null) and ((Onduty2 is null or Offduty2 is null) and (result3  ='未打' or result4  ='未打')) Then (datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)-isnull(BrestTime,0))/60.00/isnull(ShiftTime,8) end
		         Where Degree=2 and noBrushcard <> 1  and Left(ondutytype,1)<>'1'
		Update #Attendancedetail Set Absent=Case when ((Onduty1 is null or Offduty1 is null) and (result1  ='未打' or result2  ='未打')) and ((Onduty2 is null or Offduty2 is null) and (result3  ='未打' or result4  ='未打')) and ((Onduty3 is null or Offduty3 is null) and (result5  ='未打' or result6  ='未打')) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)+datediff(mi,ondutydate+Conduty,ondutydate+Coffduty)-isnull(ArestTime,0)-isnull(BrestTime,0)-isnull(CrestTime,0))/60.00/isnull(ShiftTime,8) 
		         When ((Onduty1 is null or Offduty1 is null) and (result1  ='未打' Or result2  ='未打')) and ((Onduty2 is null or Offduty2 is null) and (result3  ='未打' or result4  ='未打')) and (Onduty3 is not null and Offduty3 is not null) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)-isnull(Aresttime,0)-isnull(BrestTime,0))/60.00/isnull(ShiftTime,8) 
		         When ((Onduty1 is null or Offduty1 is null) and (result1  ='未打' or result2  ='未打')) and (Onduty2 is not null and Offduty2 is not null) and (Onduty3 is not null and Offduty3 is not null) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0))/60.00/isnull(ShiftTime,8) 
		         When (Onduty1 is not null and  Offduty1 is not null) and ((Onduty2 is null or Offduty2 is null) and (result3  ='未打' or result4  ='未打')) and (Onduty3 is not null and Offduty3 is not null) Then (datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)-isnull(Bresttime,0))/60.00/isnull(ShiftTime,8) 
		         When (Onduty1 is not null and  Offduty1 is not null) and (Onduty2 is not null and Offduty2 is not null) and ((Onduty3 is null or Offduty3 is  null) and (result5  ='未打' or result6  ='未打')) Then (datediff(mi,Ondutydate+COnduty,Ondutydate+COffduty)-isnull(Cresttime,0))/60.00/isnull(ShiftTime,8) 
		         When (Onduty1 is not null and  Offduty1 is not null) and ((Onduty2 is null or Offduty2 is null) and (result3  ='未打' or result4  ='未打'))  and ((Onduty3 is null or Offduty3 is null) and (result5  ='未打' or result6  ='未打')) Then (datediff(mi,ondutydate+Bonduty,Ondutydate+BOffduty)+datediff(mi,Ondutydate+Conduty,Ondutydate+COffduty)-isnull(Bresttime,0)-isnull(Cresttime,0))/60.00/isnull(ShiftTime,8) 
		         When ((Onduty1 is null or Offduty1 is null) and (result1  ='未打' or result2  ='未打')) and (Onduty2 is not null and Offduty2 is not null) and ((Onduty3 is  null or Offduty3 is null) and (result5  ='未打' Or result6  ='未打')) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+COnduty,Ondutydate+COffduty)-isnull(Aresttime,0)-isnull(CrestTime,0))/60.00/isnull(ShiftTime,8) end 
		        Where Degree=3 and noBrushcard <> 1  and Left(ondutytype,1)<>'1'
-- 		if @blnanalyseworkday=1
-- 
-- 			begin
-- 				Update #Attendancedetail Set Absent= (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0))/60.00/isnull(ShiftTime,8)
-- 				         Where Degree=1  and noBrushcard <> 1 and (Onduty1 is null or Offduty1 is null) and (result1  ='未打' or result2  ='未打')  and Left(ondutytype,1)<>'1' 
-- 				Update #Attendancedetail Set Absent= Case when ((Onduty1 is null or Offduty1 is null) and (result1  ='未打' or result2  ='未打')) and ((Onduty2 is null or Offduty2 is null) and (result3  ='未打' or result4  ='未打')) Then ((datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty))-isnull(Aresttime,0)-isnull(Bresttime,0))/60.00/isnull(ShiftTime,8) 
-- 				         When ((Onduty1 is null or Offduty1 is null) and (result1  ='未打' or result2  ='未打')) and Onduty2 is not null and Offduty2 is not null Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0))/60.00/isnull(ShiftTime,8)
-- 				         When  (Onduty1 is not null and Offduty1 is not null) and ((Onduty2 is null or Offduty2 is null) and (result3  ='未打' or result4  ='未打')) Then (datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)-isnull(BrestTime,0))/60.00/isnull(ShiftTime,8) end
-- 				         Where Degree=2 and noBrushcard <> 1  and Left(ondutytype,1)<>'1'
-- 				Update #Attendancedetail Set Absent=Case when ((Onduty1 is null or Offduty1 is null) and (result1  ='未打' or result2  ='未打')) and ((Onduty2 is null or Offduty2 is null) and (result3  ='未打' or result4  ='未打')) and ((Onduty3 is null or Offduty3 is null) and (result5  ='未打' or result6  ='未打')) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)+datediff(mi,ondutydate+Conduty,ondutydate+Coffduty)-isnull(ArestTime,0)-isnull(BrestTime,0)-isnull(CrestTime,0))/60.00/isnull(ShiftTime,8) 
-- 				         When ((Onduty1 is null or Offduty1 is null) and (result1  ='未打' Or result2  ='未打')) and ((Onduty2 is null or Offduty2 is null) and (result3  ='未打' or result4  ='未打')) and (Onduty3 is not null and Offduty3 is not null) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)-isnull(Aresttime,0)-isnull(BrestTime,0))/60.00/isnull(ShiftTime,8) 
-- 				         When ((Onduty1 is null or Offduty1 is null) and (result1  ='未打' or result2  ='未打')) and (Onduty2 is not null and Offduty2 is not null) and (Onduty3 is not null and Offduty3 is not null) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0))/60.00/isnull(ShiftTime,8) 
-- 				         When (Onduty1 is not null and  Offduty1 is not null) and ((Onduty2 is null or Offduty2 is null) and (result3  ='未打' or result4  ='未打')) and (Onduty3 is not null and Offduty3 is not null) Then (datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)-isnull(Bresttime,0))/60.00/isnull(ShiftTime,8) 
-- 				         When (Onduty1 is not null and  Offduty1 is not null) and (Onduty2 is not null and Offduty2 is not null) and ((Onduty3 is null or Offduty3 is  null) and (result5  ='未打' or result6  ='未打')) Then (datediff(mi,Ondutydate+COnduty,Ondutydate+COffduty)-isnull(Cresttime,0))/60.00/isnull(ShiftTime,8) 
-- 				         When (Onduty1 is not null and  Offduty1 is not null) and ((Onduty2 is null or Offduty2 is null) and (result3  ='未打' or result4  ='未打'))  and ((Onduty3 is null or Offduty3 is null) and (result5  ='未打' or result6  ='未打')) Then (datediff(mi,ondutydate+Bonduty,Ondutydate+BOffduty)+datediff(mi,Ondutydate+Conduty,Ondutydate+COffduty)-isnull(Bresttime,0)-isnull(Cresttime,0))/60.00/isnull(ShiftTime,8) 
-- 				         When ((Onduty1 is null or Offduty1 is null) and (result1  ='未打' or result2  ='未打')) and (Onduty2 is not null and Offduty2 is not null) and ((Onduty3 is  null or Offduty3 is null) and (result5  ='未打' Or result6  ='未打')) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+COnduty,Ondutydate+COffduty)-isnull(Aresttime,0)-isnull(CrestTime,0))/60.00/isnull(ShiftTime,8) end 
-- 				        Where Degree=3 and noBrushcard <> 1  and Left(ondutytype,1)<>'1'
-- 
-- 			end
-- 		else		
-- 			begin
-- 				Update #Attendancedetail Set Absent= (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0))/isnull(standardtime,8)
-- 				         Where Degree=1  and noBrushcard <> 1 and (Onduty1 is null or Offduty1 is null) and (result1  ='未打' or result2  ='未打')  and Left(ondutytype,1)<>'1'  and standardtime>0
-- 				Update #Attendancedetail Set Absent= Case when ((Onduty1 is null or Offduty1 is null) and (result1  ='未打' or result2  ='未打')) and ((Onduty2 is null or Offduty2 is null) and (result3  ='未打' or result4  ='未打')) Then ((datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty))-isnull(Aresttime,0)-isnull(Bresttime,0))/isnull(standardtime,8) 
-- 				         When ((Onduty1 is null or Offduty1 is null) and (result1  ='未打' or result2  ='未打')) and Onduty2 is not null and Offduty2 is not null Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0))/60.00/isnull(standardtime,8)
-- 				         When  (Onduty1 is not null and Offduty1 is not null) and ((Onduty2 is null or Offduty2 is null) and (result3  ='未打' or result4  ='未打')) Then (datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)-isnull(BrestTime,0))/60.00/isnull(standardtime,8) end
-- 				         Where Degree=2 and noBrushcard <> 1  and Left(ondutytype,1)<>'1'  and standardtime>0
-- 				Update #Attendancedetail Set Absent=Case when ((Onduty1 is null or Offduty1 is null) and (result1  ='未打' or result2  ='未打')) and ((Onduty2 is null or Offduty2 is null) and (result3  ='未打' or result4  ='未打')) and ((Onduty3 is null or Offduty3 is null) and (result5  ='未打' or result6  ='未打')) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)+datediff(mi,ondutydate+Conduty,ondutydate+Coffduty)-isnull(ArestTime,0)-isnull(BrestTime,0)-isnull(CrestTime,0))/isnull(standardtime,8) 
-- 				         When ((Onduty1 is null or Offduty1 is null) and (result1  ='未打' Or result2  ='未打')) and ((Onduty2 is null or Offduty2 is null) and (result3  ='未打' or result4  ='未打')) and (Onduty3 is not null and Offduty3 is not null) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)-isnull(Aresttime,0)-isnull(BrestTime,0))/isnull(standardtime,8) 
-- 				         When ((Onduty1 is null or Offduty1 is null) and (result1  ='未打' or result2  ='未打')) and (Onduty2 is not null and Offduty2 is not null) and (Onduty3 is not null and Offduty3 is not null) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0))/isnull(ShiftTime,8) 
-- 				         When (Onduty1 is not null and  Offduty1 is not null) and ((Onduty2 is null or Offduty2 is null) and (result3  ='未打' or result4  ='未打')) and (Onduty3 is not null and Offduty3 is not null) Then (datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)-isnull(Bresttime,0))/isnull(ShiftTime,8) 
-- 				         When (Onduty1 is not null and  Offduty1 is not null) and (Onduty2 is not null and Offduty2 is not null) and ((Onduty3 is null or Offduty3 is  null) and (result5  ='未打' or result6  ='未打')) Then (datediff(mi,Ondutydate+COnduty,Ondutydate+COffduty)-isnull(Cresttime,0))/isnull(ShiftTime,8) 
-- 				         When (Onduty1 is not null and  Offduty1 is not null) and ((Onduty2 is null or Offduty2 is null) and (result3  ='未打' or result4  ='未打'))  and ((Onduty3 is null or Offduty3 is null) and (result5  ='未打' or result6  ='未打')) Then (datediff(mi,ondutydate+Bonduty,Ondutydate+BOffduty)+datediff(mi,Ondutydate+Conduty,Ondutydate+COffduty)-isnull(Bresttime,0)-isnull(Cresttime,0))/isnull(standardtime,8) 
-- 				         When ((Onduty1 is null or Offduty1 is null) and (result1  ='未打' or result2  ='未打')) and (Onduty2 is not null and Offduty2 is not null) and ((Onduty3 is  null or Offduty3 is null) and (result5  ='未打' Or result6  ='未打')) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+COnduty,Ondutydate+COffduty)-isnull(Aresttime,0)-isnull(CrestTime,0))/isnull(standardtime,8) end 
-- 				        Where Degree=3 and noBrushcard <> 1  and Left(ondutytype,1)<>'1'  and standardtime>0
-- 			
-- 			end		
			--'异常算旷工中，其中有迟到早退不计迟到早退。
		Update #Attendancedetail set LateTime1=0,LeaveEarlyTime1=0 
			 Where Degree>=1  and noBrushcard <> 1 and  (result1 ='未打' or result2 ='未打')  and Left(ondutytype,1)<>'1' 
		Update #Attendancedetail set Latetime2=0,LeaveEarlytime2=0 
			 Where Degree>=2  and noBrushcard <> 1 and  (result3 ='未打' or result4 ='未打')  and Left(ondutytype,1)<>'1' 
		Update #Attendancedetail set Latetime3=0,LeaveEarlytime3=0 
			 Where Degree>=3  and noBrushcard <> 1 and  (result5 ='未打' or result6 ='未打')  and Left(ondutytype,1)<>'1' 
	end
else
	Update #Attendancedetail Set Absent= (Case When Degree>=1 and onduty1 is null and offduty1 is null and result1  ='未打' and result2  ='未打' Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0)) else 0 end +
			 Case When Degree>=2 and onduty2 is null and Offduty2 is null and result3  ='未打' and result4  ='未打' then (datediff(mi,ondutydate+Bonduty,Ondutydate+BOffduty)-isnull(BrestTime,0))  else 0 end + 
			 Case When Degree>=3 and Onduty3 is null and Offduty3 is null and result5  ='未打' and result6  ='未打' then (datediff(mi,ondutydate+Conduty,Ondutydate+COffduty)-isnull(CrestTime,0)) else  0 end )/60.00 /isnull(ShiftTime,8)
	         Where noBrushcard <> 1  and Left(ondutytype,1)<>'1'

-- 	if @blnanalyseworkday=1
-- 	Update #Attendancedetail Set Absent= (Case When Degree>=1 and onduty1 is null and offduty1 is null and result1  ='未打' and result2  ='未打' Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0)) else 0 end +
-- 			 Case When Degree>=2 and onduty2 is null and Offduty2 is null and result3  ='未打' and result4  ='未打' then (datediff(mi,ondutydate+Bonduty,Ondutydate+BOffduty)-isnull(BrestTime,0))  else 0 end + 
-- 			 Case When Degree>=3 and Onduty3 is null and Offduty3 is null and result5  ='未打' and result6  ='未打' then (datediff(mi,ondutydate+Conduty,Ondutydate+COffduty)-isnull(CrestTime,0)) else  0 end )/60.00 /isnull(ShiftTime,8)
-- 	         Where noBrushcard <> 1  and Left(ondutytype,1)<>'1'
-- 	else
-- 	Update #Attendancedetail Set Absent= (Case When Degree>=1 and onduty1 is null and offduty1 is null and result1  ='未打' and result2  ='未打' Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0)) else 0 end +
-- 			 Case When Degree>=2 and onduty2 is null and Offduty2 is null and result3  ='未打' and result4  ='未打' then (datediff(mi,ondutydate+Bonduty,Ondutydate+BOffduty)-isnull(BrestTime,0))  else 0 end + 
-- 			 Case When Degree>=3 and Onduty3 is null and Offduty3 is null and result5  ='未打' and result6  ='未打' then (datediff(mi,ondutydate+Conduty,Ondutydate+COffduty)-isnull(CrestTime,0)) else  0 end )/isnull(standardtime,8)
-- 	         Where noBrushcard <> 1  and Left(ondutytype,1)<>'1'  and standardtime>0
-- 
--select * from #Attendancedetail where employeeid=2
if @strTotalType='3'--当日统计
	begin
		set @tempmonth=''
		select @tempmonth=postmonth from totalmonth where @startdate between startdate and enddate
		select @tempmonth=isnull(@tempmonth,'')

		if @tempmonth=''
			select @startdate=@sdate,@enddate=@edate
		else
			select @startdate=startdate,@enddate=enddate,@strmonth=postmonth from totalmonth where postmonth=@strmonth

		insert #attendancedetail (Result3,WorkTime,LactationLeave,Result5,Result2,WorkTime2,Absent,OnDuty3,
				PublicHoliday,Result4,WorkTime3,OtherLeave,OtTime,WorkDay,WorkTime1,LateTime1,OffDuty3,Result1,
				CompensatoryLeave,OnDutyType,VisitLeave,Result6,OffDuty2,OnTrip,FuneralLeave,ShiftName,LateTime2,
				OnDuty1,LeaveEarlyTime3,OnDuty2,EmployeeId,OnDutyDate,LeaveEarlyTime1,OffDuty1,LateTime3,
				LeaveEarlyTime2,PersonalLeave,MaternityLeave,AnnualVacation,InjuryLeave,SickLeave,WeddingLeave,signinflag)
				 select Result3,WorkTime,LactationLeave,Result5,Result2,WorkTime2,Absent,OnDuty3,PublicHoliday,
				Result4,WorkTime3,OtherLeave,OtTime,WorkDay,WorkTime1,LateTime1,OffDuty3,Result1,CompensatoryLeave,
				OnDutyType,VisitLeave,Result6,OffDuty2,OnTrip,FuneralLeave,ShiftName,LateTime2,OnDuty1,
				LeaveEarlyTime3,OnDuty2,EmployeeId,OnDutyDate,LeaveEarlyTime1,OffDuty1,LateTime3,LeaveEarlyTime2,
				PersonalLeave,MaternityLeave,AnnualVacation,InjuryLeave,SickLeave,WeddingLeave,signinflag 
				from attendancedetail where ondutydate >=@startdate and ondutydate <=@EndDate and cast(employeeid as varchar(12)) +cast(ondutydate as varchar(18)) not in 
				(select cast(employeeid as varchar(12)) +cast(ondutydate as varchar(18)) as employeeonduty from #attendancedetail )
			
	end
-- Update #Attendancedetail 
--                 Set LateCount =(Case When latetime1>0 then 1 else 0 end )+(Case When Latetime2>0 then 1 else 0 end ) +(Case When lateTime3>0 then 1 else 0 end ), 
--                     LeaveEarlyCount=(Case When LeaveEarlyTime1>0 then 1 else 0 end )+(Case When LeaveEarlyTime2>0 then 1 else 0 end )+(Case When LeaveEarlyTime3>0 then 1 else 0 end ), 
--                     abnormitycount=(Case when (onduty1 is not null and Offduty1 is null) or (Onduty1 is null and Offduty1 is not null) then 1 else 0 end ) +(Case When (Onduty2 is not null and Offduty2 is null)or (Onduty2 is null and Offduty2 is not null) then 1 else 0 end )+(Case When (onduty3 is not null and offduty3 is null) or (onduty3 is null and offduty3 is not null) then 1 else 0 end )
-- 	where nobrushcard=0
Update #Attendancedetail 
                Set LateCount =(Case When latetime1>0 then 1 else 0 end )+(Case When Latetime2>0 then 1 else 0 end ) +(Case When lateTime3>0 then 1 else 0 end ), 
                    LeaveEarlyCount=(Case When LeaveEarlyTime1>0 then 1 else 0 end )+(Case When LeaveEarlyTime2>0 then 1 else 0 end )+(Case When LeaveEarlyTime3>0 then 1 else 0 end ), 
                    abnormitycount=(Case when (result1 ='未打'  and result2 <>'未打') or (result1 <>'未打'  and result2 ='未打') then 1 else 0 end ) +(Case When (result3 ='未打'  and result4 <>'未打')or (result3 <>'未打'  and result4 ='未打') then 1 else 0 end )+(Case When (result5 ='未打'  and result6 <>'未打') or (result5 <>'未打'  and result6 ='未打') then 1 else 0 end )
	where nobrushcard=0

--select * from #attendancedetail where employeeid=1163
--假日没上班不记旷工。
Update #attendancedetail set absent=0 where left(ondutytype,1)='2'

--	'没有历史表,每次的数据得保存,统计时有重复的就用最新统计的复盖,不是重复的则增加!
Update Attendancedetail set employeeid=a.employeeid,ondutydate=a.ondutydate,Result3=a.Result3,WorkTime=a.WorkTime,LactationLeave=a.LactationLeave,Result5=a.Result5,Result2=a.Result2,WorkTime2=a.WorkTime2,Absent=a.Absent,OnDuty3=a.OnDuty3,
				PublicHoliday=a.PublicHoliday,Result4=a.Result4,WorkTime3=a.WorkTime3,OtherLeave=a.OtherLeave,OtTime=a.OtTime,WorkDay=a.WorkDay,WorkTime1=a.WorkTime1,LateTime1=a.LateTime1,OffDuty3=a.OffDuty3,Result1=a.Result1,
				CompensatoryLeave=a.CompensatoryLeave,OnDutyType=a.OnDutyType,VisitLeave=a.VisitLeave,Result6=a.Result6,OffDuty2=a.OffDuty2,OnTrip=a.OnTrip,FuneralLeave=a.FuneralLeave,ShiftName=a.ShiftName,LateTime2=a.LateTime2,
					OnDuty1=a.OnDuty1,LeaveEarlyTime3=a.LeaveEarlyTime3,OnDuty2=a.OnDuty2,LeaveEarlyTime1=a.LeaveEarlyTime1,OffDuty1=a.OffDuty1,LateTime3=a.LateTime3,nobrushcard=a.nobrushcard,
				LeaveEarlyTime2=a.LeaveEarlyTime2,PersonalLeave=a.PersonalLeave,MaternityLeave=a.MaternityLeave,AnnualVacation=a.AnnualVacation,InjuryLeave=a.InjuryLeave,SickLeave=a.SickLeave,WeddingLeave=a.WeddingLeave,signinflag=a.signinflag
				 from #attendancedetail a where a.employeeid =attendancedetail.employeeid and a.ondutydate=attendancedetail.ondutydate

-- select Result3,WorkTime,LactationLeave,Result5,Result2,WorkTime2,Absent,OnDuty3,PublicHoliday,
-- 				Result4,WorkTime3,OtherLeave,OtTime,WorkDay,WorkTime1,LateTime1,OffDuty3,Result1,CompensatoryLeave,
-- 				OnDutyType,VisitLeave,Result6,OffDuty2,OnTrip,FuneralLeave,ShiftName,LateTime2,OnDuty1,
-- 				LeaveEarlyTime3,OnDuty2,EmployeeId,OnDutyDate,LeaveEarlyTime1,OffDuty1,LateTime3,LeaveEarlyTime2,
-- 				PersonalLeave,MaternityLeave,AnnualVacation,InjuryLeave,SickLeave,WeddingLeave,signinflag 
-- 				from #attendancedetail where cast(employeeid as varchar(12)) +cast(ondutydate as varchar(18)) not in 
-- 				(select cast(employeeid as varchar(12)) +cast(ondutydate as varchar(18)) as employeeonduty from attendancedetail 
-- 				where ondutydate >=@startdate and ondutydate <=@EndDate)

Insert into Attendancedetail (Result3,WorkTime,LactationLeave,Result5,Result2,WorkTime2,Absent,OnDuty3,
				PublicHoliday,Result4,WorkTime3,OtherLeave,OtTime,WorkDay,WorkTime1,LateTime1,OffDuty3,Result1,
				CompensatoryLeave,OnDutyType,VisitLeave,Result6,OffDuty2,OnTrip,FuneralLeave,ShiftName,LateTime2,
				OnDuty1,LeaveEarlyTime3,OnDuty2,EmployeeId,OnDutyDate,LeaveEarlyTime1,OffDuty1,LateTime3,
				LeaveEarlyTime2,PersonalLeave,MaternityLeave,AnnualVacation,InjuryLeave,SickLeave,WeddingLeave,signinflag,nobrushcard)
				 select Result3,WorkTime,LactationLeave,Result5,Result2,WorkTime2,Absent,OnDuty3,PublicHoliday,
				Result4,WorkTime3,OtherLeave,OtTime,WorkDay,WorkTime1,LateTime1,OffDuty3,Result1,CompensatoryLeave,
				OnDutyType,VisitLeave,Result6,OffDuty2,OnTrip,FuneralLeave,ShiftName,LateTime2,OnDuty1,
				LeaveEarlyTime3,OnDuty2,EmployeeId,OnDutyDate,LeaveEarlyTime1,OffDuty1,LateTime3,LeaveEarlyTime2,
				PersonalLeave,MaternityLeave,AnnualVacation,InjuryLeave,SickLeave,WeddingLeave,signinflag,nobrushcard 
				from #attendancedetail where cast(employeeid as varchar(12)) +cast(ondutydate as varchar(18)) not in 
				(select cast(employeeid as varchar(12)) +cast(ondutydate as varchar(18)) as employeeonduty from attendancedetail 
				where ondutydate >=@startdate and ondutydate <=@EndDate)

--select * from attendancedetail where nobrushcard=1 and employeeid=2

--    '汇总考勤
if @strTotalType='3'--当日统计
	begin
-- 		Declare @Day varchar(2),@month varchar(2),@year varchar(4),@maxday int
-- 		Declare @Sdate datetime,@Edate Datetime
-- 		Declare @totalcycle nvarchar(50)
--		select @totalcycle=variablevalue from Options where variablename='StrTotalCycle'
		/*
		set @totalcycle='0-本月,1,0-本月,3'
		print charindex(',',@totalcycle,1)
		print charindex(',',@totalcycle,charindex(',',@totalcycle,charindex(',',@totalcycle,1)+1)+1)+1
		print substring(@totalcycle,charindex(',',@totalcycle,charindex(',',@totalcycle,charindex(',',@totalcycle,1)+1)+1)+1,2)
		Declare @strmonth nvarchar(50)
		Declare @startdate datetime
		set @startdate='2015-04-08'
		*/

-- 		set @tempmonth=''
-- 		select @tempmonth=postmonth from totalmonth where @startdate between startdate and enddate
-- 		select @tempmonth=isnull(@tempmonth,'')
-- 
-- 		if @tempmonth=''
-- 			select @startdate=@sdate,@enddate=@edate
-- 		else
-- 			select @startdate=startdate,@enddate=enddate,@strmonth=postmonth from totalmonth where postmonth=@strmonth
-- 		if @strmonth=''--从周期中取得统计月份
-- 			begin
-- 				select @year=cast(year(@startdate) as varchar(4)),@month=cast(month(@startdate) as varchar(2))
-- 				if len(@month)=1
-- 					set @month='0'+@month
-- 				set @maxday=day(dateadd(dd,-1,dateadd(mm,+1,(@year+@month+'01'))))
-- 				set @day=substring(@totalcycle,charindex(',',@totalcycle,1)+1,charindex(',',@totalcycle,charindex(',',@totalcycle,1)+1)-charindex(',',@totalcycle,1)-1) 
-- 				if len(@day)=1
-- 					set @day='0'+@day
-- 				if @maxday<cast(@day as int)
-- 					set @sdate= @year+'-'+@month+'-'+cast(@maxday as varchar(2))
-- 				else
-- 					set @sdate= @year+'-'+@month+'-'+@day
-- 				if substring(@totalcycle,1,1)='1'
-- 					set @sdate=dateadd(mm,-1,@sdate)
-- 
-- 				set @day=substring(@totalcycle,charindex(',',@totalcycle,charindex(',',@totalcycle,charindex(',',@totalcycle,1)+1)+1)+1,2)
-- 				if len(@day)=1
-- 					set @day='0'+@day
-- 				if @maxday<cast(@day as int)
-- 					set @edate=@year+'-'+@month+'-'+cast(@maxday as varchar(2))
-- 				else
-- 					set @edate=@year+'-'+@month+'-'+@day
-- 				if substring(@totalcycle,charindex(',',@totalcycle,charindex(',',@totalcycle,1)+1)+1,1)='1'
-- 					set @edate=dateadd(mm,-1,@sdate)
-- 				if @sdate>@edate
-- 					return
-- 				if @startdate>=@sdate and @startdate<=@edate
-- 					set @strmonth=@year+@month
-- 				if @startdate<@sdate
-- 					begin
-- 						set @month=cast(month(dateadd(mm,-1,(@year+@month+'01'))) as varchar(2))
-- 						if len(@month)<>2
-- 							set @month='0'+@month
-- 						set @strmonth=cast(year(dateadd(mm,-1,(@year+@month+'01'))) as varchar(4))+@month					
-- 					end
-- 				if @startdate>@sdate
-- 					begin
-- 						set @month=cast(month(dateadd(mm,1,(@year+@month+'01'))) as varchar(2))
-- 						if len(@month)<>2
-- 							set @month='0'+@month
-- 						set @strmonth=cast(year(dateadd(mm,1,(@year+@month+'01'))) as varchar(4))+@month					
-- 					end
-- 				select @startdate=@sdate,@enddate=@edate
-- 			end
-- 		else
-- 			begin
-- 				select @startdate=startdate,@enddate=enddate from totalmonth where postmonth=@strmonth
-- 			end
		Exec ('Update AttendanceTotal 
		                 Set InjuryLeave=t.InjuryLeave,WeddingLeave=t.WeddingLeave,OtherLeave=t.OtherLeave,
		                     LactationLeave=t.LactationLeave,VisitLeave=t.VisitLeave,OnTrip=t.OnTrip,
		                     CompensatoryLeave=t.CompensatoryLeave,FuneralLeave=t.FuneralLeave,PersonalLeave=t.PersonalLeave,
		                     Absent=t.Absent,MaternityLeave=t.MaternityLeave,SickLeave=t.SickLeave,
		                     PublicHoliday=t.PublicHoliday,AnnualVacation=t.AnnualVacation 
		                 From (Select Employeeid, Sum(isnull(InjuryLeave,0)) as InjuryLeave,Sum(IsNULL(WeddingLeave,0)) as Weddingleave,
		                       Sum(Isnull(OtherLeave,0)) as OtherLeave,Sum(isnull(LactationLeave,0)) as LactationLeave,
		                       Sum(isnull(VisitLeave,0)) as VisitLeave,Sum(isnull(OnTrip,0)) as OnTrip,
		                       Sum(isnull(CompensatoryLeave,0)) as CompensatoryLeave,Sum(isnull(FuneralLeave,0)) as FuneralLeave,
		                       Sum(isnull(PersonalLeave,0)) as PersonalLeave,Sum(isnull(Absent,0)) as Absent,
		                       sum(isnull(MaternityLeave,0)) as MaternityLeave,Sum(isnull(SickLeave,0)) as SickLeave,
		                       Sum(isnull(PublicHoliday,0)) as PublicHoliday,Sum(isnull(AnnualVacation,0)) as AnnualVacation 
		                       From attendancedetail where ondutydate between '''+@startdate+''' and ''' +@enddate+''' Group by Employeeid) t
		                 Where Attendancetotal.employeeid=t.employeeid and Attendancetotal.AttendMonth='''+@strmonth+'''')
		                
		Exec('Insert into AttendanceTotal (employeeid,attendmonth,InjuryLeave,WeddingLeave,OtherLeave,
		                             LactationLeave,VisitLeave,OnTrip,
		                             CompensatoryLeave,FuneralLeave,PersonalLeave,
		                             Absent,MaternityLeave,SickLeave,
		                             PublicHoliday,AnnualVacation )    
		                             Select Employeeid,'''+ @strmonth +''', Sum(isnull(InjuryLeave,0)) as InjuryLeave,Sum(IsNULL(WeddingLeave,0)) as Weddingleave,
		                               Sum(Isnull(OtherLeave,0)) as OtherLeave,Sum(isnull(LactationLeave,0)) as LactationLeave,
		                               Sum(isnull(VisitLeave,0)) as VisitLeave,Sum(isnull(OnTrip,0)) as OnTrip,
		                               Sum(isnull(CompensatoryLeave,0)) as CompensatoryLeave,Sum(isnull(FuneralLeave,0)) as FuneralLeave,
		                               Sum(isnull(PersonalLeave,0)) as PersonalLeave,Sum(isnull(Absent,0)) as Absent,
		                               sum(isnull(MaternityLeave,0)) as MaternityLeave,Sum(isnull(SickLeave,0)) as SickLeave,
		                               Sum(isnull(PublicHoliday,0)) as PublicHoliday,Sum(isnull(AnnualVacation,0)) as AnnualVacation 
		                               From attendancedetail 
		                               Where employeeid not in (select employeeid from 
		                               attendancetotal where AttendMonth='''+ @strmonth +''') Group by Employeeid')	
	end
else				    
	begin
		Exec ('Update AttendanceTotal 
		                 Set InjuryLeave=t.InjuryLeave,WeddingLeave=t.WeddingLeave,OtherLeave=t.OtherLeave,
		                     LactationLeave=t.LactationLeave,VisitLeave=t.VisitLeave,OnTrip=t.OnTrip,
		                     CompensatoryLeave=t.CompensatoryLeave,FuneralLeave=t.FuneralLeave,PersonalLeave=t.PersonalLeave,
		                     Absent=t.Absent,MaternityLeave=t.MaternityLeave,SickLeave=t.SickLeave,
		                     PublicHoliday=t.PublicHoliday,AnnualVacation=t.AnnualVacation 
		                 From (Select Employeeid, Sum(isnull(InjuryLeave,0)) as InjuryLeave,Sum(IsNULL(WeddingLeave,0)) as Weddingleave,
		                       Sum(Isnull(OtherLeave,0)) as OtherLeave,Sum(isnull(LactationLeave,0)) as LactationLeave,
		                       Sum(isnull(VisitLeave,0)) as VisitLeave,Sum(isnull(OnTrip,0)) as OnTrip,
		                       Sum(isnull(CompensatoryLeave,0)) as CompensatoryLeave,Sum(isnull(FuneralLeave,0)) as FuneralLeave,
		                       Sum(isnull(PersonalLeave,0)) as PersonalLeave,Sum(isnull(Absent,0)) as Absent,
		                       sum(isnull(MaternityLeave,0)) as MaternityLeave,Sum(isnull(SickLeave,0)) as SickLeave,
		                       Sum(isnull(PublicHoliday,0)) as PublicHoliday,Sum(isnull(AnnualVacation,0)) as AnnualVacation 
		                       From #attendancedetail Group by Employeeid) t
		                 Where Attendancetotal.employeeid=t.employeeid and Attendancetotal.AttendMonth='''+@strmonth+'''')
		                
		Exec('Insert into AttendanceTotal (employeeid,attendmonth,InjuryLeave,WeddingLeave,OtherLeave,
		                             LactationLeave,VisitLeave,OnTrip,
		                             CompensatoryLeave,FuneralLeave,PersonalLeave,
		                             Absent,MaternityLeave,SickLeave,
		                             PublicHoliday,AnnualVacation )    
		                             Select Employeeid,'''+ @strmonth +''', Sum(isnull(InjuryLeave,0)) as InjuryLeave,Sum(IsNULL(WeddingLeave,0)) as Weddingleave,
		                               Sum(Isnull(OtherLeave,0)) as OtherLeave,Sum(isnull(LactationLeave,0)) as LactationLeave,
		                               Sum(isnull(VisitLeave,0)) as VisitLeave,Sum(isnull(OnTrip,0)) as OnTrip,
		                               Sum(isnull(CompensatoryLeave,0)) as CompensatoryLeave,Sum(isnull(FuneralLeave,0)) as FuneralLeave,
		                               Sum(isnull(PersonalLeave,0)) as PersonalLeave,Sum(isnull(Absent,0)) as Absent,
		                               sum(isnull(MaternityLeave,0)) as MaternityLeave,Sum(isnull(SickLeave,0)) as SickLeave,
		                               Sum(isnull(PublicHoliday,0)) as PublicHoliday,Sum(isnull(AnnualVacation,0)) as AnnualVacation 
		                               From #attendancedetail 
		                               Where employeeid not in (select employeeid from 
		                               attendancetotal where AttendMonth='''+ @strmonth +''') Group by Employeeid')
 	end

--   '0-平常
Update Attendancetotal 
             set Workday_0=t.Workday_0,LateTime_0=t.LateTime_0,LateCount_0=t.LateCount_0,
             abnormitycount_0=t.abnormitycount_0,ottime_0 =t.ottime_0,Worktime_0=t.WorkTime_0,
             LeaveEarlytime_0=t.leaveearlytime_0,leaveearlycount_0=t.leaveearlycount_0 
             From (Select Employeeid,Sum(isnull(workday,0)) as WorkDay_0,Sum(isnull(Latetime1,0))+Sum(isnull(Latetime2,0))+Sum(isnull(latetime3,0)) as Latetime_0,
                     Sum(isnull(LateCount,0)) as LateCount_0,Sum(isnull(abnormitycount,0)) as abnormitycount_0,
                     Sum(isnull(ottime,0)) as OtTime_0,Sum(isnull(Worktime,0)) as WorkTime_0,
                     Sum(isnull(LeaveEarlyTime1,0))+Sum(isnull(leaveEarlyTime2,0))+Sum(isnull(Leaveearlytime3,0)) as LeaveEarlytime_0,
                     Sum(isnull(LeaveEarlyCount,0)) as LeaveEarlycount_0 From #Attendancedetail 
                     Where Left(ondutytype,1)='0' Group by Employeeid)t 
             Where Attendancetotal.employeeid=t.employeeid and attendancetotal.attendmonth=@strmonth
--    '1-休息
Update Attendancetotal 
             set Worktime_1=t.WorkTime_1
             From (Select Employeeid,Sum(isnull(workday,0)) as WorkDay_1,Sum(isnull(Latetime1,0))+Sum(isnull(Latetime2,0))+Sum(isnull(latetime3,0)) as Latetime_1,
                     Sum(isnull(LateCount,0)) as LateCount_1,Sum(isnull(abnormitycount,0)) as abnormitycount_1,
                     Sum(isnull(ottime,0)) as OtTime_1,Sum(isnull(Worktimeholiday,0)) as WorkTime_1,
                     Sum(isnull(LeaveEarlyTime1,0))+Sum(isnull(leaveEarlyTime2,0))+Sum(isnull(Leaveearlytime3,0)) as LeaveEarlytime_1,
                     Sum(isnull(LeaveEarlyCount,0)) as LeaveEarlycount_1 From #Attendancedetail 
                     Where Left(ondutytype,1)='1' Group by Employeeid)t 
             Where Attendancetotal.employeeid=t.employeeid and attendancetotal.attendmonth=@strmonth
--    '2-假日
Update Attendancetotal 
             set Worktime_2=t.WorkTime_2,publicholiday=t.publicholiday 
             From (Select Employeeid,Sum(isnull(workday,0)) as WorkDay_2,Sum(isnull(Latetime1,0))+Sum(isnull(Latetime2,0))+Sum(isnull(latetime3,0)) as Latetime_2,
                     Sum(isnull(LateCount,0)) as LateCount_2,Sum(isnull(abnormitycount,0)) as abnormitycount_2,
                     Sum(isnull(ottime,0)) as OtTime_2,Sum(isnull(Worktimeholiday,0)) as WorkTime_2,
                     Sum(isnull(LeaveEarlyTime1,0))+Sum(isnull(leaveEarlyTime2,0))+Sum(isnull(Leaveearlytime3,0)) as LeaveEarlytime_2,
                     Sum(isnull(LeaveEarlyCount,0)) as LeaveEarlycount_2,sum(case when worktimeholiday=0 then 1 else 0 end ) as publicholiday From #Attendancedetail 
                     Where Left(ondutytype,1)='2'  Group by Employeeid)t 
             Where Attendancetotal.employeeid=t.employeeid and attendancetotal.attendmonth=@strmonth

/*
--    '1-休息
Update Attendancetotal 
             set Workday_1=t.Workday_1,LateTime_1=t.LateTime_1,LateCount_1=t.LateCount_1,
             abnormitycount_1=t.abnormitycount_1,ottime_1 =t.ottime_1,Worktime_1=t.WorkTime_1,
             LeaveEarlytime_1=t.leaveearlytime_1,leaveearlycount_1=t.leaveearlycount_1 
             From (Select Employeeid,Sum(isnull(workday,0)) as WorkDay_1,Sum(isnull(Latetime1,0))+Sum(isnull(Latetime2,0))+Sum(isnull(latetime3,0)) as Latetime_1,
                     Sum(isnull(LateCount,0)) as LateCount_1,Sum(isnull(abnormitycount,0)) as abnormitycount_1,
                     Sum(isnull(ottime,0)) as OtTime_1,Sum(isnull(Worktime,0)) as WorkTime_1,
                     Sum(isnull(LeaveEarlyTime1,0))+Sum(isnull(leaveEarlyTime2,0))+Sum(isnull(Leaveearlytime3,0)) as LeaveEarlytime_1,
                     Sum(isnull(LeaveEarlyCount,0)) as LeaveEarlycount_1 From #Attendancedetail 
                     Where Left(ondutytype,1)='1' Group by Employeeid)t 
             Where Attendancetotal.employeeid=t.employeeid and attendancetotal.attendmonth=@strmonth
--    '2-假日
Update Attendancetotal 
             set Workday_2=t.Workday_2,LateTime_2=t.LateTime_2,LateCount_2=t.LateCount_2,
             abnormitycount_2=t.abnormitycount_2,ottime_2 =t.ottime_2,Worktime_2=t.WorkTime_2,
             LeaveEarlytime_2=t.leaveearlytime_2,leaveearlycount_2=t.leaveearlycount_2,publicholiday=t.publicholiday 
             From (Select Employeeid,Sum(isnull(workday,0)) as WorkDay_2,Sum(isnull(Latetime1,0))+Sum(isnull(Latetime2,0))+Sum(isnull(latetime3,0)) as Latetime_2,
                     Sum(isnull(LateCount,0)) as LateCount_2,Sum(isnull(abnormitycount,0)) as abnormitycount_2,
                     Sum(isnull(ottime,0)) as OtTime_2,Sum(isnull(Worktime,0)) as WorkTime_2,
                     Sum(isnull(LeaveEarlyTime1,0))+Sum(isnull(leaveEarlyTime2,0))+Sum(isnull(Leaveearlytime3,0)) as LeaveEarlytime_2,
                     Sum(isnull(LeaveEarlyCount,0)) as LeaveEarlycount_2,sum(case when worktime=0 then 1 else 0 end ) as publicholiday From #Attendancedetail 
                     Where Left(ondutytype,1)='2'  Group by Employeeid)t 
             Where Attendancetotal.employeeid=t.employeeid and attendancetotal.attendmonth=@strmonth
*/
--delete from attendancetotalyear where left(attendmonth,4)=left(@strmonth,4)
--直接修改已存在的数据语法存在问题。先删除再插入的方式也不行。借助临时表
-- update attendancetotalyear set WorkDay_1=a.WorkDay_1
-- 	FROM attendancetotalyear b,(select @strmonth,employeeid,WorkDay_1 from attendancetotal)a
-- 	where a.employeeid=b.employeeid


if object_id('tempdb..#totalyear') is not null drop table #totalyear
select @totalyear=right('20'+cast(year(@strmonth+'-01') as varchar(4)),4)

--select * into #totalyear from (select WorkDay_1,LateTime_0,InjuryLeave,WeddingLeave,LateCount_2,AbnormityCount_1,OtherLeave,OtTime_1,LactationLeave,VisitLeave,OnTrip,CompensatoryLeave,LeaveEarlyCount_1,OtTime_2,AbnormityCount_0,FuneralLeave,PersonalLeave,LateTime_2,LeaveEarlyCount_2,OtTime_0,Absent,WorkTime_0,LateTime_1,WorkDay_2,MaternityLeave,LateCount_0,WorkTime_1,LeaveEarlyCount_0,SickLeave,LeaveEarlyTime_0,LeaveEarlyTime_1,PublicHoliday,AbnormityCount_2,AnnualVacation,LeaveEarlyTime_2,WorkTime_2,LateCount_1,WorkDay_0,AnnualVacationRemanent,CompensatoryLeaveFree from attendancetotalyear where 1=2)a
Select * into #totalyear from attendancetotalyear where 1=2
insert into #totalyear (attendmonth,employeeid,LateTime_0,InjuryLeave,WeddingLeave,OtherLeave,LactationLeave,VisitLeave,OnTrip,CompensatoryLeave,AbnormityCount_0,FuneralLeave,PersonalLeave,OtTime_0,Absent,WorkTime_0,MaternityLeave,LateCount_0,WorkTime_1,LeaveEarlyCount_0,SickLeave,LeaveEarlyTime_0,PublicHoliday,AnnualVacation,WorkTime_2,WorkDay_0,AnnualVacationRemanent)
	select @totalyear,employeeid,sum(isnull(LateTime_0,0)),sum(isnull(InjuryLeave,0)),sum(isnull(WeddingLeave,0)),sum(isnull(OtherLeave,0)),sum(isnull(LactationLeave,0)),sum(isnull(VisitLeave,0)),sum(isnull(OnTrip,0)),sum(isnull(CompensatoryLeave,0)),sum(isnull(AbnormityCount_0,0)),sum(isnull(FuneralLeave,0)),sum(isnull(PersonalLeave,0)),sum(isnull(OtTime_0,0)),sum(isnull(Absent,0)),sum(isnull(WorkTime_0,0)),sum(isnull(MaternityLeave,0)),sum(isnull(LateCount_0,0)),sum(isnull(WorkTime_1,0)),sum(isnull(LeaveEarlyCount_0,0)),sum(isnull(SickLeave,0)),sum(isnull(LeaveEarlyTime_0,0)),sum(isnull(PublicHoliday,0)),sum(isnull(AnnualVacation,0)),sum(isnull(WorkTime_2,0)),sum(isnull(WorkDay_0,0)),sum(isnull(AnnualVacationRemanent,0))
		 from attendancetotal where left(attendmonth,4)=left(@strmonth,4) and employeeid in (select distinct employeeid from attendancetotalyear where left(attendmonth,4)=left(@strmonth,4) and len(attendmonth)=4) group by employeeid
--select * from #totalyear
Update attendancetotalyear set LateTime_0=a.LateTime_0,InjuryLeave=a.InjuryLeave,WeddingLeave=a.WeddingLeave,OtherLeave=a.OtherLeave,LactationLeave=a.LactationLeave,VisitLeave=a.VisitLeave,OnTrip=a.OnTrip,CompensatoryLeave=a.CompensatoryLeave,AbnormityCount_0=a.AbnormityCount_0,FuneralLeave=a.FuneralLeave,PersonalLeave=a.PersonalLeave,OtTime_0=a.OtTime_0,Absent=a.Absent,WorkTime_0=a.WorkTime_0,MaternityLeave=a.MaternityLeave,LateCount_0=a.LateCount_0,WorkTime_1=a.WorkTime_1,LeaveEarlyCount_0=a.LeaveEarlyCount_0,SickLeave=a.SickLeave,LeaveEarlyTime_0=a.LeaveEarlyTime_0,PublicHoliday=a.PublicHoliday,AnnualVacation=a.AnnualVacation,WorkTime_2=a.WorkTime_2,WorkDay_0=a.WorkDay_0,AnnualVacationRemanent=a.AnnualVacationRemanent
	from #totalyear a where a.attendmonth=attendancetotalyear.attendmonth and a.employeeid=attendancetotalyear.employeeid 
	
insert into attendancetotalyear (AttendMonth,EmployeeId,LateTime_0,InjuryLeave,WeddingLeave,OtherLeave,LactationLeave,VisitLeave,OnTrip,CompensatoryLeave,AbnormityCount_0,FuneralLeave,PersonalLeave,OtTime_0,Absent,WorkTime_0,MaternityLeave,LateCount_0,WorkTime_1,LeaveEarlyCount_0,SickLeave,LeaveEarlyTime_0,PublicHoliday,AnnualVacation,WorkTime_2,WorkDay_0,AnnualVacationRemanent) 
	select @totalyear,employeeid,sum(isnull(LateTime_0,0)),sum(isnull(InjuryLeave,0)),sum(isnull(WeddingLeave,0)),sum(isnull(OtherLeave,0)),sum(isnull(LactationLeave,0)),sum(isnull(VisitLeave,0)),sum(isnull(OnTrip,0)),sum(isnull(CompensatoryLeave,0)),sum(isnull(AbnormityCount_0,0)),sum(isnull(FuneralLeave,0)),sum(isnull(PersonalLeave,0)),sum(isnull(OtTime_0,0)),sum(isnull(Absent,0)),sum(isnull(WorkTime_0,0)),sum(isnull(MaternityLeave,0)),sum(isnull(LateCount_0,0)),sum(isnull(WorkTime_1,0)),sum(isnull(LeaveEarlyCount_0,0)),sum(isnull(SickLeave,0)),sum(isnull(LeaveEarlyTime_0,0)),sum(isnull(PublicHoliday,0)),sum(isnull(AnnualVacation,0)),sum(isnull(WorkTime_2,0)),sum(isnull(WorkDay_0,0)),sum(isnull(AnnualVacationRemanent,0)) 
		 from attendancetotal where left(attendmonth,4)=left(@strmonth,4) and employeeid not in (select distinct employeeid from attendancetotalyear where left(attendmonth,4)=left(@strmonth,4) and len(attendmonth)=4) group by employeeid
-- select @totalyear,employeeid,sum(isnull(WorkDay_1,0)),sum(isnull(LateTime_0,0)),sum(isnull(InjuryLeave,0)),sum(isnull(WeddingLeave,0)),sum(isnull(LateCount_2,0)),sum(isnull(AbnormityCount_1,0)),sum(isnull(OtherLeave,0)),sum(isnull(OtTime_1,0)),sum(isnull(LactationLeave,0)),sum(isnull(VisitLeave,0)),sum(isnull(OnTrip,0)),sum(isnull(CompensatoryLeave,0)),sum(isnull(LeaveEarlyCount_1,0)),sum(isnull(OtTime_2,0)),sum(isnull(AbnormityCount_0,0)),sum(isnull(FuneralLeave,0)),sum(isnull(PersonalLeave,0)),sum(isnull(LateTime_2,0)),sum(isnull(LeaveEarlyCount_2,0)),sum(isnull(OtTime_0,0)),sum(isnull(Absent,0)),sum(isnull(WorkTime_0,0)),sum(isnull(LateTime_1,0)),sum(isnull(WorkDay_2,0)),sum(isnull(MaternityLeave,0)),sum(isnull(LateCount_0,0)),sum(isnull(WorkTime_1,0)),sum(isnull(LeaveEarlyCount_0,0)),sum(isnull(SickLeave,0)),sum(isnull(LeaveEarlyTime_0,0)),sum(isnull(LeaveEarlyTime_1,0)),sum(isnull(PublicHoliday,0)),sum(isnull(AbnormityCount_2,0)),sum(isnull(AnnualVacation,0)),sum(isnull(LeaveEarlyTime_2,0)),sum(isnull(WorkTime_2,0)),sum(isnull(LateCount_1,0)),sum(isnull(WorkDay_0,0)),sum(isnull(AnnualVacationRemanent,0)),sum(isnull(CompensatoryLeaveFree,0))
-- 	 from attendancetotal where left(attendmonth,4)=left(@strmonth,4) and employeeid not in (select distinct employeeid from attendancetotalyear where left(attendmonth,4)=left(@strmonth,4) and len(attendmonth)=4) group by employeeid

-- Select * into #totalyear from attendancetotalyear where 1=2
-- insert into #totalyear (attendmonth,employeeid,WorkDay_1,LateTime_0,InjuryLeave,WeddingLeave,LateCount_2,AbnormityCount_1,OtherLeave,OtTime_1,LactationLeave,VisitLeave,OnTrip,CompensatoryLeave,LeaveEarlyCount_1,OtTime_2,AbnormityCount_0,FuneralLeave,PersonalLeave,LateTime_2,LeaveEarlyCount_2,OtTime_0,Absent,WorkTime_0,LateTime_1,WorkDay_2,MaternityLeave,LateCount_0,WorkTime_1,LeaveEarlyCount_0,SickLeave,LeaveEarlyTime_0,LeaveEarlyTime_1,PublicHoliday,AbnormityCount_2,AnnualVacation,LeaveEarlyTime_2,WorkTime_2,LateCount_1,WorkDay_0,AnnualVacationRemanent,CompensatoryLeaveFree)
-- 	select @totalyear,employeeid,sum(isnull(WorkDay_1,0)),sum(isnull(LateTime_0,0)),sum(isnull(InjuryLeave,0)),sum(isnull(WeddingLeave,0)),sum(isnull(LateCount_2,0)),sum(isnull(AbnormityCount_1,0)),sum(isnull(OtherLeave,0)),sum(isnull(OtTime_1,0)),sum(isnull(LactationLeave,0)),sum(isnull(VisitLeave,0)),sum(isnull(OnTrip,0)),sum(isnull(CompensatoryLeave,0)),sum(isnull(LeaveEarlyCount_1,0)),sum(isnull(OtTime_2,0)),sum(isnull(AbnormityCount_0,0)),sum(isnull(FuneralLeave,0)),sum(isnull(PersonalLeave,0)),sum(isnull(LateTime_2,0)),sum(isnull(LeaveEarlyCount_2,0)),sum(isnull(OtTime_0,0)),sum(isnull(Absent,0)),sum(isnull(WorkTime_0,0)),sum(isnull(LateTime_1,0)),sum(isnull(WorkDay_2,0)),sum(isnull(MaternityLeave,0)),sum(isnull(LateCount_0,0)),sum(isnull(WorkTime_1,0)),sum(isnull(LeaveEarlyCount_0,0)),sum(isnull(SickLeave,0)),sum(isnull(LeaveEarlyTime_0,0)),sum(isnull(LeaveEarlyTime_1,0)),sum(isnull(PublicHoliday,0)),sum(isnull(AbnormityCount_2,0)),sum(isnull(AnnualVacation,0)),sum(isnull(LeaveEarlyTime_2,0)),sum(isnull(WorkTime_2,0)),sum(isnull(LateCount_1,0)),sum(isnull(WorkDay_0,0)),sum(isnull(AnnualVacationRemanent,0)),sum(isnull(CompensatoryLeaveFree,0))
-- 		 from attendancetotal where left(attendmonth,4)=left(@strmonth,4) and employeeid in (select distinct employeeid from attendancetotalyear where left(attendmonth,4)=left(@strmonth,4) and len(attendmonth)=4) group by employeeid
-- Update attendancetotalyear set WorkDay_1=a.WorkDay_1,LateTime_0=a.LateTime_0,InjuryLeave=a.InjuryLeave,WeddingLeave=a.WeddingLeave,LateCount_2=a.LateCount_2,AbnormityCount_1=a.AbnormityCount_1,OtherLeave=a.OtherLeave,OtTime_1=a.OtTime_1,LactationLeave=a.LactationLeave,VisitLeave=a.VisitLeave,OnTrip=a.OnTrip,CompensatoryLeave=a.CompensatoryLeave,LeaveEarlyCount_1=a.LeaveEarlyCount_1,OtTime_2=a.OtTime_2,AbnormityCount_0=a.AbnormityCount_0,FuneralLeave=a.FuneralLeave,PersonalLeave=a.PersonalLeave,LateTime_2=a.LateTime_2,LeaveEarlyCount_2=a.LeaveEarlyCount_2,OtTime_0=a.OtTime_0,Absent=a.Absent,WorkTime_0=a.WorkTime_0,LateTime_1=a.LateTime_1,WorkDay_2=a.WorkDay_2,MaternityLeave=a.MaternityLeave,LateCount_0=a.LateCount_0,WorkTime_1=a.WorkTime_1,LeaveEarlyCount_0=a.LeaveEarlyCount_0,SickLeave=a.SickLeave,LeaveEarlyTime_0=a.LeaveEarlyTime_0,LeaveEarlyTime_1=a.LeaveEarlyTime_1,PublicHoliday=a.PublicHoliday,AbnormityCount_2=a.AbnormityCount_2,AnnualVacation=a.AnnualVacation,LeaveEarlyTime_2=a.LeaveEarlyTime_2,WorkTime_2=a.WorkTime_2,LateCount_1=a.LateCount_1,WorkDay_0=a.WorkDay_0,AnnualVacationRemanent=a.AnnualVacationRemanent,CompensatoryLeaveFree=a.CompensatoryLeaveFree
-- 	from #totalyear a where a.attendmonth=attendancetotalyear.attendmonth and a.employeeid=attendancetotalyear.employeeid 
-- 	
-- insert into attendancetotalyear (AttendMonth,EmployeeId,WorkDay_1,LateTime_0,InjuryLeave,WeddingLeave,LateCount_2,AbnormityCount_1,OtherLeave,OtTime_1,LactationLeave,VisitLeave,OnTrip,CompensatoryLeave,LeaveEarlyCount_1,OtTime_2,AbnormityCount_0,FuneralLeave,PersonalLeave,LateTime_2,LeaveEarlyCount_2,OtTime_0,Absent,WorkTime_0,LateTime_1,WorkDay_2,MaternityLeave,LateCount_0,WorkTime_1,LeaveEarlyCount_0,SickLeave,LeaveEarlyTime_0,LeaveEarlyTime_1,PublicHoliday,AbnormityCount_2,AnnualVacation,LeaveEarlyTime_2,WorkTime_2,LateCount_1,WorkDay_0,AnnualVacationRemanent,CompensatoryLeaveFree) 
-- 	select @totalyear,employeeid,sum(isnull(WorkDay_1,0)),sum(isnull(LateTime_0,0)),sum(isnull(InjuryLeave,0)),sum(isnull(WeddingLeave,0)),sum(isnull(LateCount_2,0)),sum(isnull(AbnormityCount_1,0)),sum(isnull(OtherLeave,0)),sum(isnull(OtTime_1,0)),sum(isnull(LactationLeave,0)),sum(isnull(VisitLeave,0)),sum(isnull(OnTrip,0)),sum(isnull(CompensatoryLeave,0)),sum(isnull(LeaveEarlyCount_1,0)),sum(isnull(OtTime_2,0)),sum(isnull(AbnormityCount_0,0)),sum(isnull(FuneralLeave,0)),sum(isnull(PersonalLeave,0)),sum(isnull(LateTime_2,0)),sum(isnull(LeaveEarlyCount_2,0)),sum(isnull(OtTime_0,0)),sum(isnull(Absent,0)),sum(isnull(WorkTime_0,0)),sum(isnull(LateTime_1,0)),sum(isnull(WorkDay_2,0)),sum(isnull(MaternityLeave,0)),sum(isnull(LateCount_0,0)),sum(isnull(WorkTime_1,0)),sum(isnull(LeaveEarlyCount_0,0)),sum(isnull(SickLeave,0)),sum(isnull(LeaveEarlyTime_0,0)),sum(isnull(LeaveEarlyTime_1,0)),sum(isnull(PublicHoliday,0)),sum(isnull(AbnormityCount_2,0)),sum(isnull(AnnualVacation,0)),sum(isnull(LeaveEarlyTime_2,0)),sum(isnull(WorkTime_2,0)),sum(isnull(LateCount_1,0)),sum(isnull(WorkDay_0,0)),sum(isnull(AnnualVacationRemanent,0)),sum(isnull(CompensatoryLeaveFree,0))
-- 		 from attendancetotal where left(attendmonth,4)=left(@strmonth,4) and employeeid not in (select distinct employeeid from attendancetotalyear where left(attendmonth,4)=left(@strmonth,4) and len(attendmonth)=4) group by employeeid

if object_id('tempdb..#totalyear') is not null drop table #totalyear

IF OBJECT_ID('tempdb..#Attendancedetail') IS NOT NULL DROP TABLE #Attendancedetail

select @Recordnum=count(*) from totalmonth where postmonth= @strmonth 
set @recordnum=isnull(@recordnum,0)

if @recordnum>0
	begin
	if @strTotalType<>'3'
		Exec ('update totalmonth set startdate='''+@StartDate+''',enddate='''+@EndDate+''' where postmonth=''' + @strmonth+'''')
	end
else
	begin
		Exec ('insert into totalmonth (postmonth,startdate,enddate) values (''' +@strmonth +''','''+@StartDate+''','''+@EndDate+''')')
-- 		if right(@strmonth,2)='01' --and (@strtotaltype='1' or @strtotaltype='2') 当第一次统计为一年的第一个月时，计算上年剩余年假
-- 			begin
-- 				Declare @blnContinueNext bit
-- 				select @blnContinueNext=cast(variablevalue as bit) from options where variablename='blnContinueNext'
-- 				if @blncontinuenext=1 --可延续。
-- 					begin
-- 						update attendancetotalyear set AnnualVacationRemanent= employees.AnnualVacation-attendancetotalyear.AnnualVacation --+attendancetotalyear.AnnualVacationRemanent
-- 							from employees 
-- 							where attendancetotalyear.employeeid=employees.employeeid and left(attendancetotalyear.AttendMonth,4)=cast(cast(left(@strmonth,4) as int)-1 as varchar(4))
-- 						update attendancetotalyear set AnnualVacationRemanent=0 where AttendMonth=@strmonth and AnnualVacationRemanent<0
-- 					end
-- 			end
	end

	Declare @oCode int
	declare @onote varchar(100)
	--20150412 mike 去掉年假
	--exec pUpdateAnnualVacation @ocode output,@onote output
	Update Options set VariableValue='' where VariableName='strTotal'


GO

Go

if exists (select * from dbo.sysobjects where id=object_id(N'[dbo].[fSumcharnum]') and xtype='fn')
drop function fSumcharnum
go

Create Function fSumcharnum(@InputString varchar(8000),@Check varchar(5))
Returns int
as 
begin
	Declare	@SumCharnum int,
		@TempNum int
	set @Sumcharnum=0
	set @tempnum=0
	while len(@inputstring)>0
		begin
			set @tempnum=charindex(@check,@inputstring)
			if @tempnum>0 
				begin
					set @sumcharnum=@sumcharnum+1
					set @inputstring=right(@inputstring,len(@inputstring)-@tempnum)
				end
			else
				set @inputstring=''
		end
	return @Sumcharnum
end
Go
------------------------------------------------------------------------------------------------------------------------------------------------------
