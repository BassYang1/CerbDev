use master
/*
if exists (select 1 from master..sysdatabases where name='CerbDb') 
	drop database CerbDb
go
*/

/*==============================================================*/
/* Database: CerbDb                                             */
/*==============================================================*/
create database CerbDb collate Chinese_Taiwan_Stroke_CI_AS
go

use CerbDb
go

create table Departments (
DepartmentID          int                  identity,
DepartmentCode       nvarchar(50)          null,
DepartmentName       nvarchar(100)          null,
ChiefId              int                   null,
LeadId               int                   null,
Remark               nvarchar(100)         null,
ParentDepartmentID		int					null,
constraint PK_DEPARTMENTS primary key nonclustered (DepartmentID)
      on [PRIMARY]
)
ON [PRIMARY]
go
create   index Index_deptCode on dbo.Departments (
DepartmentCode
)
GO

/*==============================================================*/
/* Table: Employees    
*/
/*==============================================================*/
create table Employees (
EmployeeId			int                  identity,
DepartmentID		int				not null,
Card				bigint			not null,
Number				nvarchar(20)	null,
Name				nvarchar(50)	null,
Sex					nvarchar(20)	null,
Marry				nvarchar(20)	null,
Knowledge			nvarchar(20)	null,
IdentityCard		nvarchar(20)	null,
BirthDate			datetime		null,
Country				nvarchar(50)	null,
NativePlace			nvarchar(50)	null,
Address				nvarchar(100)	null,
Telephone			nvarchar(20)	null,
JoinDate			datetime        null,
Position			nvarchar(50)	null,
Headship			nvarchar(50)	null,
Photo				image			null,
FingerPrint1		image			null,
FingerPrint2		image			null,
IncumbencyStatus	nvarchar(20)           null,
Email               nvarchar(50)        null,  
DimissionDate		datetime		null,
DimissionReason		nvarchar(100)	null,
FieldVal1			nvarchar(50)	null,
FieldDesc1			nvarchar(50)	null,
FieldVal2			nvarchar(50)	null,
FieldDesc2			nvarchar(50)	null,
FieldVal3			int				null,
FieldDesc3			nvarchar(50)	null,
constraint PK_EMPLOYEES primary key nonclustered (EmployeeId)
      on [PRIMARY]
)
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/*==============================================================*/
/* Table: BrushCardAttend   
Property	0為合法	1為非法卡 */
/*==============================================================*/
create table BrushCardAttend (
RecordID			int					identity,
EmployeeId			int					null,
Card				bigint				null,
Controllerid		int					null,
BrushTime			datetime			not null,
Door				nvarchar(2)			null,
Property			nvarchar(2)			null,
constraint PK_BRUSHCARDATTEND primary key NONCLUSTERED (RecordID)
)
ON [PRIMARY]
go
CREATE CLUSTERED INDEX idx_BrushCardAttend ON BrushCardAttend(
BrushTime, 
EmployeeId
)
ON [PRIMARY]
GO

/*==============================================================*/
/* Table: BrushCardACS   
Property	0為合法	1為非法卡  */
/*==============================================================*/
create table BrushCardACS (
RecordID			int					identity,
EmployeeId			int					null,
Card				bigint				null,
Controllerid		int					null,
BrushTime			datetime			not null,
Door				nvarchar(2)			null,
Property			nvarchar(2)			null,
constraint PK_BRUSHCARDACS primary key  (RecordID)
)
ON [PRIMARY]
go
create   index idx_BrushCardAcs on BrushCardAcs (
BrushTime, 
EmployeeId
)
ON [PRIMARY]
GO

/*==============================================================*/
/* Table: EventRecord                                           */
/*==============================================================*/
create table EventRecord (
RecordID			int					identity,
ControllerId		int					null,
InputPoint			nvarchar(2)			null,
OccurTime			datetime			not null,
constraint PK_EVENTRECORD primary key  (RecordID)
)
GO

/*==============================================================*/
/* Table: Controllers                                           */
/*==============================================================*/
create table Controllers (
ControllerId		int				identity,
ControllerNumber    nvarchar(20)	null,
ControllerName		nvarchar(20)	null,
Location            nvarchar(20)	null,
IP					nvarchar(30)	null,
MASK				nvarchar(20)	null,
GateWay				nvarchar(20)	null,
DNS					nvarchar(20)	null,
DNS2				nvarchar(20)	null,
EnableDHCP			bit				null,
ServerIP			nvarchar(50)	null,
WorkType			nvarchar(50)	not null,
StorageMode			nvarchar(50)	null,
IsFingerprint		bit				null,
AntiPassBackType	bit				null,
DoorType			nvarchar(20)	null,
CardReader1			nvarchar(20)	null,
CardReader2			nvarchar(20)	null,
DoorLocation1       nvarchar(50)    null,
DoorLocation2       nvarchar(50)    null,
SystemPassword		nvarchar(20)	null,
DataUpdateTime		int				null,
WaitTime			int				null,
CloseLightTime		smallint		null,
Sound				int				null,
BoardType			nvarchar(50)	null,
DownPhoto			bit				null,
DownFingerprint		bit				null,
ScreenFile1				image			null,
ScreenFile2				image			null,
ScreenFlash				image			null,
ScreenType			nvarchar(50)	null,
FieldVal1			nvarchar(50)	null,
FieldDesc1			nvarchar(50)	null,
FieldVal2			nvarchar(50)	null,
FieldDesc2			nvarchar(50)	null,
FieldVal3			nvarchar(50)	null,
FieldDesc3			nvarchar(50)	null,
FieldVal4			nvarchar(50)	null,
FieldDesc4			nvarchar(50)	null,
FieldVal5			nvarchar(50)	null,
FieldDesc5			nvarchar(50)	null,
constraint PK_Controllers primary key nonclustered (ControllerId)
      on [PRIMARY]
)
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/*==============================================================*/
/* Table: ControllerHoliday                                     */
/*==============================================================*/
create table ControllerHoliday (
RecordID			int				identity,
ControllerId		int				not null,
HolidayCode			int				not null,
TemplateId			int				null,
TemplateName		nvarchar(50)	null,
Status               bit            null,
constraint PK_ControllerHoliday primary key nonclustered (RecordID)
      on [PRIMARY]
)
ON [PRIMARY]
go
create   index Index_ConHoliday on ControllerHoliday (
ControllerId,
HolidayCode,
TemplateId
)
GO


/*==============================================================*/
/* Table: ControllerTemplateHoliday                             */
/*==============================================================*/
create table ControllerTemplateHoliday (
RecordID			int					identity,
TemplateId			int				not null,
HolidayNumber		int				not null,
HolidayName			nvarchar(50)	null,
HolidayDate			nvarchar(5)		null,
constraint PK_CONTROLLERHOLIDAYDETAIL primary key  (RecordID)
)
ON [PRIMARY]
go
create   index Index_ConTempHoliday on ControllerTemplateHoliday (
TemplateId,
HolidayNumber
)
GO


/*==============================================================*/
/* Table: ControllerSchedule                                    */
/*==============================================================*/
create table ControllerSchedule (
RecordID			int				identity,
ControllerId		int				not null,
ScheduleCode		int				not null,
TemplateId			int				null,
TemplateName		nvarchar(50)	null,
Status				bit				null,
constraint PK_ControllerSchedule primary key nonclustered (RecordID)
      on [PRIMARY]
)
ON [PRIMARY]
go
create   index Index_ConSchedule on ControllerSchedule (
ControllerId,
ScheduleCode,
TemplateId
)
GO


/*==============================================================*/
/* Table: ControllerTemplateSchedule                            */
/*==============================================================*/
create table ControllerTemplateSchedule (
RecordID			int				identity,
TemplateId           int             not null,
WeekDay              nvarchar(50)          not null,
HolidayTemplateId    smallint             null,
StartTime1           nvarchar(5)           null,
EndTime1             nvarchar(5)           null,
StartTime2           nvarchar(5)           null,
EndTime2             nvarchar(5)           null,
StartTime3           nvarchar(5)           null,
EndTime3             nvarchar(5)           null,
StartTime4           nvarchar(5)           null,
EndTime4             nvarchar(5)           null,
StartTime5           nvarchar(5)           null,
EndTime5             nvarchar(5)           null,
constraint PK_ControllerTemplateSchedule primary key nonclustered (RecordID)
)
ON [PRIMARY]
go
create   index Index_ConTempSchedule on ControllerTemplateSchedule (
TemplateId,
WeekDay
)
GO


/*==============================================================*/
/* Table: ControllerInout                                       */
/*==============================================================*/
create table ControllerInout (
RecordID			int				identity,
ControllerId		int				not null,
InoutPoint			int				null,
InoutDesc			nvarchar(50)	null,
ScheduleID			int				null,
ScheduleName		nvarchar(50)	null,
Out1				int				null,
Out2				int				null,
Out3				int				null,
Out4				int				null,
Out5				int				null,
status				bit				null,
constraint PK_CONTROLLERINOUT primary key  (RecordID)
)
ON [PRIMARY]
go
create   index Index_ControllerInout on ControllerInout (
ControllerId,
InoutPoint
)
GO

/*==============================================================*/
/* Table: ControllerTemplateInout                               */
/*==============================================================*/
create table ControllerTemplateInout (
RecordID			 int			 identity,
TemplateId           int             null,
InoutPoint           int             null,
InoutDesc            nvarchar(50)          null,
ScheduleId           int                  null,
ScheduleName         nvarchar(50)          null,
Out1                 int             null,
Out2                 int             null,
Out3                 int             null,
Out4                 int             null,
Out5                 int             null,
constraint PK_ControllerTemplateInout primary key  (RecordID)
)
ON [PRIMARY]
go
create   index Index_ConTempInout on ControllerTemplateInout (
InoutPoint,
TemplateId
)
GO


/*==============================================================*/
/* Table: ControllerEmployee        
CombinationID	組合開門的組號                            */
/*==============================================================*/
create table ControllerEmployee (
RecordID			int					identity,
ControllerId		int					not null,
EmployeeId			int					not null,
ScheduleCode		int					null,
EmployeeDoor		nvarchar(20)		null,
UserPassword		nvarchar(20)		null,
ValidateMode		nvarchar(20)		null,
DeleteFlag			bit					null,
Floor				nvarchar(700)		null ,
CombinationID		int					null,
Status				bit					null,
constraint PK_CONTROLLEREMPLOYEE primary key  (RecordID)
)
ON [PRIMARY]
GO
create  index idx_ControllerEmployee on ControllerEmployee (
ControllerId,
Status,
EmployeeId
)

/*==============================================================*/
/* Table: ControllerTemplates                                   */
/*==============================================================*/
create table ControllerTemplates (
TemplateId           int                  identity,
TemplateType         nchar(1)             null,
TemplateName         nvarchar(50)         null,
EmployeeDesc         ntext                null,
EmployeeCode         ntext                null,
EmployeeController   nvarchar(200)         null,
EmployeeScheID       smallint             null,
EmployeeDoor         nvarchar(20)         null,
ValidateMode		 nvarchar(20)		  null,
constraint PK_ControllerTemplates primary key  (TemplateId)
      on [PRIMARY]
)
ON [PRIMARY]
go
create   index Index_ConTemp on ControllerTemplates (
TemplateType
)
GO

/*==============================================================*/
/* Table: ControllerDataSync                                    */
/*==============================================================*/
create table ControllerDataSync (
ID                   int                  identity,
ControllerId         int                  null,
OperateUser          nvarchar(20)         null,
SyncType             nvarchar(20)         null,
SyncStatus           smallint                 null,
SyncTime             datetime             null,
TrueTimeInfo         nvarchar(60)         null,
constraint PK_CONTROLLERDATASYNC primary key nonclustered (ID)
)
GO
create  clustered index idx_dataSync on ControllerDataSync (
SyncType,
ControllerId
)
GO

/*==============================================================*/
/* Table: AdminControllers                                    */
/*==============================================================*/
create table AdminControllers (
RecordID                   int                  identity,
ControllerId         int                  null,
ExecType             nvarchar(30)         null,
ExecStatus           smallint                 null,
OperateTime			 datetime             null,	
CompleteTime		 datetime				null,	
HardVersion              nvarchar(50)         null,
Info1		         ntext         null,
Info2		         ntext         null,
constraint PK_AdminControllers primary key nonclustered (RecordID)
)
GO
create  clustered index idx_AdminCon on AdminControllers (
ControllerId,
ExecType
)
GO

/*==============================================================*/
/* Table: CombinationDoor         
組合開門 
CombinationID	分組ID
order			開門順序                      */
/*==============================================================*/
Create table CombinationDoor(
RecordID			int				identity,
CombinationID		int				not null,
EmployeeId			int				not null,
OpenOrder				int				null,
constraint PK_COMBINATIONDOOR primary key (CombinationID)
)

/*==============================================================*/
/* Table: Users	                                        */
/*==============================================================*/
create table Users (
UserId				int					identity,
LoginName			nvarchar(50)		null,
UserPassword		nvarchar(20)		null,
EmployeeId			int					null,
OperPermissions		int					null,
OperPermDesc		nvarchar(20)		null,
VisitTimeSignIn		nvarchar(20)		null,
constraint PK_Users primary key nonclustered (UserId)
      on [PRIMARY]
)
GO

/*==============================================================*/
/* Table: Bell                              */
/*==============================================================*/
create table Bell (
RecordID			int				identity,
Controllerid		int				not null,
EnableBell			bit				null,
WeekDay				nvarchar(50)	not null,
Voice				nvarchar(50)	null,
Out					int				null,
OutTime				int				null,
Time1				nchar(5)		null,
Time2				nchar(5)		null,
Time3				nchar(5)		null,
Time4				nchar(5)		null,
Time5				nchar(5)		null,
Time6				nchar(5)		null,
Time7				nchar(5)		null,
Time8				nchar(5)		null,
Time9				nchar(5)		null,
Time10				nchar(5)		null,
constraint PK_Bell primary key  (RecordID)
)
GO

/*==============================================================*/
/* Table: TableFieldCode                                        */
/*==============================================================*/
create table TableFieldCode (
RecordID			int					identity,
FieldId				int					null,
Content				nvarchar(100)		null
constraint PK_TableFieldCode primary key  (RecordID)
)
ON [PRIMARY]
go
create   index Index_1 on TableFieldCode (
FieldId
)
GO

/*==============================================================*/
/* Table: LogEvent                                              */
/*==============================================================*/
create table LogEvent (
EventID              int                  identity,
LoginName            nvarchar(50)          null,
LoginIP		         nvarchar(50)          null,
OperateTime          datetime			null,
Modules              nvarchar(200)         null,
Actions              nvarchar(50)          null,
Objects              nvarchar(2000)         null,
constraint PK_LogEvent primary key nonclustered (EventID)
      on [PRIMARY]
)
GO

/*==============================================================*/
/* Table: RoleDepartment                                        */
/*==============================================================*/
create table RoleDepartment (
UserId				int					not null,
DepartmentID		nvarchar(20)		not null,
Permission			bit					null
)
ON [PRIMARY]
go

/*==============================================================*/
/* Table: RoleController                                        */
/*==============================================================*/
create table RoleController (
UserId				int					not null,
ControllerID		nvarchar(20)		not null,
Permission			bit					null
)
ON [PRIMARY]
go

/*==============================================================*/
/* Table: AttendanceShifts                                  
 StretchShift 是否彈性班次
 Degree 上班次數
 ShiftTime 標準工時
 Night 是否過夜
 FirstOnDuty 第一次刷卡  0 當日  1上日
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

CREATE TABLE [LabelText](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[PageFolder] [nvarchar](50) NULL,
	[PageName] [nvarchar](50) NULL,
	[LabelId] [nvarchar](50) NULL,
	[LabelZhcnText] [nvarchar](150) NULL,
	[LabelZhtwText] [nvarchar](150) NULL,
	[LabelEnText] [nvarchar](300) NULL,
	[LabelCustomText] [nvarchar](300) NULL,
	constraint PK_LabelText PRIMARY KEY  ([RecordId])
)
Go

alter table RoleDepartment
   add constraint FK_ROLEDEPA_REFERENCE_USERS foreign key (UserId)
      references Users (UserId)
go

alter table RoleController
   add constraint FK_ROLECon_REFERENCE_USERS foreign key (UserId)
      references Users (UserId)
GO

alter table dbo.TableStructure
   add constraint FK_TABLESTR_REFERENCE_TABLES foreign key (TableId)
      references dbo.Tables (TableId)
go


--插入系統相關資料
SET IDENTITY_INSERT Users  ON
insert into Users(UserID,LoginName,UserPassword,OperPermissions,OperPermDesc) Values(1,'Admin','Admin',1,'系統管理員')
SET IDENTITY_INSERT Users  OFF
GO

SET IDENTITY_INSERT [ControllerTemplates]  ON
insert ControllerTemplates(TemplateId,TemplateType,TemplateName) values(1,'2', '0 - 24H進出') --24H時間表ID需為1
insert ControllerTemplates(TemplateId,TemplateType,TemplateName) values(2,'1' , '0 - 香港假期表')
insert ControllerTemplates(TemplateId,TemplateType,TemplateName) values(3,'1' , '1 - 大陸假期表')
insert ControllerTemplates(TemplateId,TemplateType,TemplateName) values(4,'1' , '2 - 其它假期表')
insert ControllerTemplates(TemplateId,TemplateType,TemplateName) values(5,'2',	'早九晚五')
insert ControllerTemplates(TemplateId,TemplateType,TemplateName) values(6,'2',	'早九晚五（五天半工作制）')
insert ControllerTemplates(TemplateId,TemplateType,TemplateName) values(7,'3',	'輸入/出範本')
SET IDENTITY_INSERT [ControllerTemplates]  OFF
GO
INSERT [ControllerTemplates] ([TemplateType],[TemplateName],[EmployeeDesc],[EmployeeController],[EmployeeScheID],[EmployeeDoor],[ValidateMode]) VALUES ( '4','Reg All Employees','0 - 所有職員','0 - 所有設備',1,'3 - 雙門','0 - 卡')

GO 
INSERT ControllerTemplateHoliday (TemplateId,[HolidayNumber],[HolidayName],[HolidayDate]) VALUES ( 2,1,'元旦','01-01')
INSERT ControllerTemplateHoliday (TemplateId,[HolidayNumber],[HolidayName],[HolidayDate]) VALUES ( 2,2,'清明','04-05')
INSERT ControllerTemplateHoliday (TemplateId,[HolidayNumber],[HolidayName],[HolidayDate]) VALUES ( 2,3,'耶穌受難節','04-18')
INSERT ControllerTemplateHoliday (TemplateId,[HolidayNumber],[HolidayName],[HolidayDate]) VALUES ( 2,4,'耶穌受難節翌日','04-19')
INSERT ControllerTemplateHoliday (TemplateId,[HolidayNumber],[HolidayName],[HolidayDate]) VALUES ( 2,5,'復活節','04-21')
INSERT ControllerTemplateHoliday (TemplateId,[HolidayNumber],[HolidayName],[HolidayDate]) VALUES ( 2,6,'勞動節','05-01')
INSERT ControllerTemplateHoliday (TemplateId,[HolidayNumber],[HolidayName],[HolidayDate]) VALUES ( 2,7,'佛誕','05-06')
INSERT ControllerTemplateHoliday (TemplateId,[HolidayNumber],[HolidayName],[HolidayDate]) VALUES ( 2,8,'香港特別行政區成立紀念日','07-01')
INSERT ControllerTemplateHoliday (TemplateId,[HolidayNumber],[HolidayName],[HolidayDate]) VALUES ( 2,9,'國慶日','10-02')
INSERT ControllerTemplateHoliday (TemplateId,[HolidayNumber],[HolidayName],[HolidayDate]) VALUES ( 2,10,'耶誕節','12-25')
INSERT ControllerTemplateHoliday (TemplateId,[HolidayNumber],[HolidayName],[HolidayDate]) VALUES ( 3,1,'元旦','01-01')
INSERT ControllerTemplateHoliday (TemplateId,[HolidayNumber],[HolidayName],[HolidayDate]) VALUES ( 3,2,'清明','04-05')
INSERT ControllerTemplateHoliday (TemplateId,[HolidayNumber],[HolidayName],[HolidayDate]) VALUES ( 3,3,'勞動節','05-01')
INSERT ControllerTemplateHoliday (TemplateId,[HolidayNumber],[HolidayName],[HolidayDate]) VALUES ( 3,4,'國慶日','10-01')
INSERT ControllerTemplateHoliday (TemplateId,[HolidayNumber],[HolidayName],[HolidayDate]) VALUES ( 3,5,'國慶日','10-02')
INSERT ControllerTemplateHoliday (TemplateId,[HolidayNumber],[HolidayName],[HolidayDate]) VALUES ( 3,6,'國慶日','10-03')
INSERT ControllerTemplateHoliday (TemplateId,[HolidayNumber],[HolidayName],[HolidayDate]) VALUES ( 4,1,'元旦','01-01')
GO
INSERT ControllerTemplateSchedule (TemplateId,[WeekDay],HolidayTemplateId,[StartTime1],[EndTime1]) VALUES ( 5,'holiday',1,'10:00','16:00')
INSERT ControllerTemplateSchedule (TemplateId,[WeekDay],[StartTime1],[EndTime1]) VALUES ( 5,'1','07:00','21:00')
INSERT ControllerTemplateSchedule (TemplateId,[WeekDay],[StartTime1],[EndTime1]) VALUES ( 5,'2','07:00','21:00')
INSERT ControllerTemplateSchedule (TemplateId,[WeekDay],[StartTime1],[EndTime1]) VALUES ( 5,'3','07:00','21:00')
INSERT ControllerTemplateSchedule (TemplateId,[WeekDay],[StartTime1],[EndTime1]) VALUES ( 5,'4','07:00','21:00')
INSERT ControllerTemplateSchedule (TemplateId,[WeekDay],[StartTime1],[EndTime1]) VALUES ( 5,'5','07:00','21:00')
INSERT ControllerTemplateSchedule (TemplateId,[WeekDay],[StartTime1],[EndTime1]) VALUES ( 5,'6','','')
INSERT ControllerTemplateSchedule (TemplateId,[WeekDay],[StartTime1],[EndTime1]) VALUES ( 5,'7','','')

INSERT ControllerTemplateSchedule (TemplateId,[WeekDay],HolidayTemplateId,[StartTime1],[EndTime1]) VALUES ( 6,'holiday',1,'10:00','16:00')
INSERT ControllerTemplateSchedule (TemplateId,[WeekDay],[StartTime1],[EndTime1]) VALUES ( 6,'1','07:00','21:00')
INSERT ControllerTemplateSchedule (TemplateId,[WeekDay],[StartTime1],[EndTime1]) VALUES ( 6,'2','07:00','21:00')
INSERT ControllerTemplateSchedule (TemplateId,[WeekDay],[StartTime1],[EndTime1]) VALUES ( 6,'3','07:00','21:00')
INSERT ControllerTemplateSchedule (TemplateId,[WeekDay],[StartTime1],[EndTime1]) VALUES ( 6,'4','07:00','21:00')
INSERT ControllerTemplateSchedule (TemplateId,[WeekDay],[StartTime1],[EndTime1]) VALUES ( 6,'5','07:00','21:00')
INSERT ControllerTemplateSchedule (TemplateId,[WeekDay],[StartTime1],[EndTime1]) VALUES ( 6,'6','07:00','14:00')
INSERT ControllerTemplateSchedule (TemplateId,[WeekDay],[StartTime1],[EndTime1]) VALUES ( 6,'7','','')
GO
INSERT ControllerTemplateInout ([TemplateId],[InoutPoint],[InoutDesc],[ScheduleID],[ScheduleName],[Out1],[Out2]) VALUES ( 7,1,'Button1',1,'0 - 24H進出',3000,0)
INSERT ControllerTemplateInout ([TemplateId],[InoutPoint],[Out1],[Out2]) VALUES ( 7,2,0,0)
INSERT ControllerTemplateInout ([TemplateId],[InoutPoint],[Out1],[Out2]) VALUES ( 7,3,0,0)
INSERT ControllerTemplateInout ([TemplateId],[InoutPoint],[Out1],[Out2]) VALUES ( 7,4,0,0)
INSERT ControllerTemplateInout ([TemplateId],[InoutPoint],[Out1],[Out2]) VALUES ( 7,5,0,0)
INSERT ControllerTemplateInout ([TemplateId],[InoutPoint],[InoutDesc],[Out1],[Out2]) VALUES ( 7,6,'讀卡器1-有效卡',3000,0)
INSERT ControllerTemplateInout ([TemplateId],[InoutPoint],[InoutDesc],[Out1],[Out2]) VALUES ( 7,7,'讀卡器1-非法卡',0,3000)
INSERT ControllerTemplateInout ([TemplateId],[InoutPoint],[InoutDesc],[Out1],[Out2]) VALUES ( 7,8,'讀卡器1-非法時段',0,0)
INSERT ControllerTemplateInout ([TemplateId],[InoutPoint],[InoutDesc],[Out1],[Out2]) VALUES ( 7,9,'讀卡器1-防遣返',0,0)
INSERT ControllerTemplateInout ([TemplateId],[InoutPoint],[InoutDesc],[Out1],[Out2]) VALUES ( 7,10,'讀卡器2-有效卡',3000,0)
INSERT ControllerTemplateInout ([TemplateId],[InoutPoint],[InoutDesc],[Out1],[Out2]) VALUES ( 7,11,'讀卡器2-非法卡',0,3000)
INSERT ControllerTemplateInout ([TemplateId],[InoutPoint],[InoutDesc],[Out1],[Out2]) VALUES ( 7,12,'讀卡器2-非法時段',0,0)
INSERT ControllerTemplateInout ([TemplateId],[InoutPoint],[InoutDesc],[Out1],[Out2]) VALUES ( 7,13,'讀卡器2-防遣返',0,0)
INSERT ControllerTemplateInout ([TemplateId],[InoutPoint],[InoutDesc],[Out1],[Out2]) VALUES ( 7,14,'門-常開',0,0)
INSERT ControllerTemplateInout ([TemplateId],[InoutPoint],[InoutDesc],[Out1],[Out2]) VALUES ( 7,15,'門-常閉',0,0)	
GO
insert tablefieldcode(FieldId,Content) values( 1,    '中國'   )
insert tablefieldcode(FieldId,Content) values( 2,    '北京市'  )
insert tablefieldcode(FieldId,Content) values( 2,    '天津市'  )
insert tablefieldcode(FieldId,Content) values( 2,    '河北省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '山西省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '遼寧省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '吉林省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '黑龍江省' )
insert tablefieldcode(FieldId,Content) values( 2,    '上海市'  )
insert tablefieldcode(FieldId,Content) values( 2,    '江蘇省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '浙江省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '安徽省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '福建省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '江西省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '山東省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '河南省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '湖北省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '湖南省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '廣東省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '海南省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '重慶市'  )
insert tablefieldcode(FieldId,Content) values( 2,    '四川省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '貴州省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '雲南省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '陝西省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '甘肅省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '青海省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '臺灣省'  )
insert tablefieldcode(FieldId,Content) values( 2,    '內蒙古自治區'   )
insert tablefieldcode(FieldId,Content) values( 2,    '廣西壯族自治區'  )
insert tablefieldcode(FieldId,Content) values( 2,    '西藏自治區')
insert tablefieldcode(FieldId,Content) values( 2,    '寧夏回族自治區'  )
insert tablefieldcode(FieldId,Content) values( 2,    '新疆維吾爾自治區' )
insert tablefieldcode(FieldId,Content) values( 2,    '香港特別行政區'  )
insert tablefieldcode(FieldId,Content) values( 2,    '澳門特別行政區'  )

insert tablefieldcode(FieldId,Content) values( 3,    '董事長'  )
insert tablefieldcode(FieldId,Content) values( 3,    '總經理'  )
insert tablefieldcode(FieldId,Content) values( 3,    '總監')
insert tablefieldcode(FieldId,Content) values( 3,    '經理'  )
insert tablefieldcode(FieldId,Content) values( 3,    '主管' )
insert tablefieldcode(FieldId,Content) values( 3,    '職員'  )

insert tablefieldcode(FieldId,Content) values( 4,    '總經理（總裁）'  )
insert tablefieldcode(FieldId,Content) values( 4,    '副總經理'  )
insert tablefieldcode(FieldId,Content) values( 4,    '人力資源總監'  )
insert tablefieldcode(FieldId,Content) values( 4,    '財務總監'  )
insert tablefieldcode(FieldId,Content) values( 4,    '行銷總監'  )
insert tablefieldcode(FieldId,Content) values( 4,    '市場總監'  )
insert tablefieldcode(FieldId,Content) values( 4,    '銷售總監'  )
insert tablefieldcode(FieldId,Content) values( 4,    '運營總監'  )
insert tablefieldcode(FieldId,Content) values( 4,    '技術總監'  )
insert tablefieldcode(FieldId,Content) values( 4,    '總經理助理'  )
insert tablefieldcode(FieldId,Content) values( 4,    '人力資源經理'  )
insert tablefieldcode(FieldId,Content) values( 4,    '招聘主管'  )
insert tablefieldcode(FieldId,Content) values( 4,    '培訓師'  )
insert tablefieldcode(FieldId,Content) values( 4,    '績效考核主管'  )
insert tablefieldcode(FieldId,Content) values( 4,    '薪酬分析師'  )
insert tablefieldcode(FieldId,Content) values( 4,    '財務經理'  )
insert tablefieldcode(FieldId,Content) values( 4,    '核算專員'  )
insert tablefieldcode(FieldId,Content) values( 4,    '出納員'  )
insert tablefieldcode(FieldId,Content) values( 4,    '簿記員'  )
insert tablefieldcode(FieldId,Content) values( 4,    '行政經理'  )
insert tablefieldcode(FieldId,Content) values( 4,    '秘書'  )
insert tablefieldcode(FieldId,Content) values( 4,    '檔案員'  )
insert tablefieldcode(FieldId,Content) values( 4,    '前臺'  )
insert tablefieldcode(FieldId,Content) values( 4,    '市場部經理'  )
insert tablefieldcode(FieldId,Content) values( 4,    '客戶開發主管'  )
insert tablefieldcode(FieldId,Content) values( 4,    '市場調研主管'  )
insert tablefieldcode(FieldId,Content) values( 4,    '市場拓展經理'  )
insert tablefieldcode(FieldId,Content) values( 4,    '媒介推廣專員'  )
insert tablefieldcode(FieldId,Content) values( 4,    '客戶代表'  )
insert tablefieldcode(FieldId,Content) values( 4,    '美工'  )
insert tablefieldcode(FieldId,Content) values( 4,    '銷售部經理'  )
insert tablefieldcode(FieldId,Content) values( 4,    '銷售代表'  )
insert tablefieldcode(FieldId,Content) values( 4,    '銷售統計員'  )
insert tablefieldcode(FieldId,Content) values( 4,    '電話銷售代表'  )
insert tablefieldcode(FieldId,Content) values( 4,    '研發主管'  )
insert tablefieldcode(FieldId,Content) values( 4,    '電腦系統管理員'  )
insert tablefieldcode(FieldId,Content) values( 4,    '軟體工程師'  )
insert tablefieldcode(FieldId,Content) values( 4,    '高級軟體工程師'  )
insert tablefieldcode(FieldId,Content) values( 4,    '測試主管'  )
insert tablefieldcode(FieldId,Content) values( 4,    '軟體測試工程師'  )
insert tablefieldcode(FieldId,Content) values( 4,    '資料庫工程師'  )
insert tablefieldcode(FieldId,Content) values( 4,    '系統分析員'  )
insert tablefieldcode(FieldId,Content) values( 4,    '網路工程師'  )
insert tablefieldcode(FieldId,Content) values( 4,    '網路系統管理員'  )
insert tablefieldcode(FieldId,Content) values( 4,    '清潔員'  )
insert tablefieldcode(FieldId,Content) values( 4,    '保安'  )

insert tablefieldcode(FieldId,Content) values( 5,    '小學'  )
insert tablefieldcode(FieldId,Content) values( 5,    '初中'  )
insert tablefieldcode(FieldId,Content) values( 5,    '中專'  )
insert tablefieldcode(FieldId,Content) values( 5,    '高中'  )
insert tablefieldcode(FieldId,Content) values( 5,    '大專'  )
insert tablefieldcode(FieldId,Content) values( 5,    '本科'  )
insert tablefieldcode(FieldId,Content) values( 5,    '碩士'  )
insert tablefieldcode(FieldId,Content) values( 5,    '博士'  )

insert tablefieldcode(FieldId,Content) values( 6,    '0 - 卡'  )
insert tablefieldcode(FieldId,Content) values( 6,    '1 - 指紋'  )
insert tablefieldcode(FieldId,Content) values( 6,    '2 - 卡+指紋'  )
insert tablefieldcode(FieldId,Content) values( 6,    '3 - 卡+密碼'  )
GO
set IDENTITY_INSERT [Bell]  ON
INSERT [Bell] ([RecordID],[Controllerid],[EnableBell],[WeekDay],[Voice],[Out],OutTime,Time1,Time2,Time3) VALUES ( 1,1,1,1,'test',3,60000,'08:00','12:00','18:00');
INSERT [Bell] ([RecordID],[Controllerid],[EnableBell],[WeekDay],[Voice],[Out],OutTime,Time1,Time2,Time3) VALUES ( 2,1,1,2,'test',3,60000,'08:00','12:00','18:00');
INSERT [Bell] ([RecordID],[Controllerid],[EnableBell],[WeekDay],[Voice],[Out],OutTime,Time1,Time2,Time3) VALUES ( 3,1,1,3,'test',3,60000,'08:00','12:00','18:00');
INSERT [Bell] ([RecordID],[Controllerid],[EnableBell],[WeekDay],[Voice],[Out],OutTime,Time1,Time2,Time3) VALUES ( 4,1,1,4,'test',3,60000,'08:00','12:00','18:00');
INSERT [Bell] ([RecordID],[Controllerid],[EnableBell],[WeekDay],[Voice],[Out],OutTime,Time1,Time2,Time3) VALUES ( 5,1,1,5,'test',3,60000,'08:00','12:00','18:00');
INSERT [Bell] ([RecordID],[Controllerid],[EnableBell],[WeekDay],[Voice],[Out],OutTime,Time1,Time2,Time3) VALUES ( 6,1,1,6,'test',3,60000,'08:00','12:00','18:00');
INSERT [Bell] ([RecordID],[Controllerid],[EnableBell],[WeekDay],[Voice],[Out],OutTime,Time1,Time2,Time3) VALUES ( 7,1,1,7,'test',3,60000,'08:00','12:00','18:00');
set IDENTITY_INSERT [Bell]  OFF
GO

SET IDENTITY_INSERT options ON
--------------------------------------------------------------------------------------- ----------- ---- ---------------------------------------------------- ---- ---------------------------------------------------- ---- ---------------------------------------------------- ---- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---- 
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 1 , 'strLate',    '遲到(第2位為1,計算遲到包括允許遲到時間)'    , '1,1,1' , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 2 , 'strLeaveEarly'  , '早退(第2位為1,計算早退包括允許早退時間)'  , '1,1,1'  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 3 , 'strAbnormity'   , '異常(1為異常視曠工)'  , '0'  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 4 , 'strVacationDesc', '休假說明', NULL  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 5 , 'strVacationCondition', '休假條件', NULL  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 6 , 'intBasicDay'    , '基本年假', '7'  , 'int'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 7 , 'strVacationType', '遞增方式', NULL  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 8 , 'intIncreasePerYear'  , '遞增天數', NULL  , 'int'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 9 , 'strIncreaseType1',    '遞增方式1',    NULL  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 10 , 'strIncreaseType2',    '遞增方式2',    NULL  , 'int'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 11, 'intMaxVacation' , '最大年假', '12'  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 12, 'blnContinueNext', '可延續' , '0'  , 'bln'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 13, 'strWeekendPrompt',    '週末提示', '0, '  , 'bln'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 14, 'strAskForLeaveOT',    '請假超時', '1,30'  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 15, 'strOTType', '超時加班(提前屬於加班,延後屬於加班,所有工時計加班,整數倍計為加班,整數)',    '0,0,1,0,30'  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 16, 'strTotalCycle'  , '匯總週期','0 – 本月,1,0 – 本月,31',    'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 17, 'strAbsent', '超時未上班',    '1,30'  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 18, 'strAnalyseOffDuty'   , '分析下班(0第一次刷卡,1最後一次刷卡)', '1'  , 'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 19, 'strSkipHoliday' , '休假時跨過法定假'  , 'PersonalLeave1,SickLeave1,CompensatoryLeave1,MaternityLeave,WeddingLeave,LactationLeave,OtherLeave,OnTrip,AnnualVacation,PublicHoliday,InjuryLeave,FuneralLeave,VisitLeave',  'str'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 20, 'blnAnalyseWorkDay'   , '[出勤]計算方式(0實際出勤,1實際工時)', '0'  , 'bln'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 21, 'blnautoTotal'   , '自動統計', '1'  , NULL               )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 22, 'datAutotime',    '自動統計的時間' , '10:00'  , NULL               )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 23, 'blnTotalDimission',    '僅統計離職員工' , '0'  , 'bln'  )
insert options(VariableId,VariableName,VariableDesc,VariableValue,VariableType) values( 24, 'intWorkTime',    '休息日默認工時' , '8'  , 'str'  )
Insert into options (VariableId,variablename,variabledesc, variabletype, variablevalue) values (31,'strOnduty','申請加班','str','0,1')
insert into options(VariableId,VariableName,VariableDesc,VariableType,VariableValue) values(32,'strTotal','統計(2,1,1,2015-04-1,2015-4-12)',null,null)
insert into options(VariableId,VariableName,VariableDesc,VariableType,VariableValue) values(33,'strEmail','電子郵件','str','1')
SET IDENTITY_INSERT options OFF
GO


SET IDENTITY_INSERT [Tables] ON

INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 1,'AttendanceShifts','正常班次')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 2,'Tables','表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 6,'TableStructure','表結構')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 7,'AttendanceSignIn','補卡')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 10,'AttendanceHoliday','法定假期')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 11,'Company','機構')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 12,'Employees','職員')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 13,'Departments','部門')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 14,'RoleDepartment','用戶部門許可權')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 15,'RoleController','使用者設備許可權')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 16,'BrushCardAcs','進出刷卡表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 17,'AttendanceTotal','考勤匯總表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 18,'AttendanceDetail','考勤明細表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 19,'BrushCardAttend','考勤刷卡表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 20,'ControllerDataSync','控制器同步')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 21,'Controllers','設備')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 22,'ControllerHoliday','設備假期表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 24,'ControllerTemplateHoliday','設備假期範本')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 25,'ControllerTemplates','設備範本')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 26,'ControllerSchedule','設備時間表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 28,'ControllerTemplateSchedule','設備時間表範本')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 29,'ControllerInout','設備輸入/輸出表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 30,'ControllerTemplateInout','設備輸入/輸出範本')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 31,'ControllerEmployee','設備註冊卡號')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 32,'TempShifts','班次調整')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 33,'AttendanceAskForLeave','請假')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 34,'LogEvent','日誌')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 35,'AttendanceOndutyRule','上班規則')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 36,'AttendanceOnDutyRuleChange','上班規則變動')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 37,'EventRecord','按鈕事件記錄表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 38,'Options','選項')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 39,'Users','用戶表')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 40,'AttendanceTotalYear','刪歷史數時的考勤年匯總')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 41,'AttendanceOT','加班')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 42,'TotalMonth','統計月份')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 43,'CombinationDoor','組合開門')
INSERT [Tables] ([TableId],[TableName],[TableDesc]) VALUES ( 45,'TableFieldCode','欄位代碼')

SET IDENTITY_INSERT [Tables] OFF
Go

SET IDENTITY_INSERT [TableStructure] ON

INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 1,1,'AttendanceShifts','ShiftName','班次名','nvarchar(50)',1,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 2,1,'AttendanceShifts','StretchShift','彈性班次','bit',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 3,1,'AttendanceShifts','ShiftTime','基本工時','numeric(5,2)',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 4,1,'AttendanceShifts','Degree','上班次數','int',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 5,1,'AttendanceShifts','Night','過夜','bit',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 6,1,'AttendanceShifts','AonDuty','上班標準1','datetime',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 7,1,'AttendanceShifts','AonDutyStart','上班開始1','datetime',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 8,1,'AttendanceShifts','AonDutyEnd','上班截止1','datetime',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 9,1,'AttendanceShifts','AoffDuty','下班標準1','datetime',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 10,1,'AttendanceShifts','AoffDutyStart','下班開始1','datetime',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 11,1,'AttendanceShifts','ArestTime','中間休息1','int',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 12,1,'AttendanceShifts','AcalculateLate','允許遲到1','int',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 13,1,'AttendanceShifts','AcalculateEarly','允許早退1','int',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 14,1,'AttendanceShifts','BonDuty','上班標準2','datetime',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 15,1,'AttendanceShifts','BonDutyEnd','上班截止2','datetime',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 16,1,'AttendanceShifts','BoffDuty','下班標準2','datetime',0,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 17,1,'AttendanceShifts','BoffDutyEnd','下班截止2','datetime',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 18,1,'AttendanceShifts','BrestTime','中間休息2','int',0,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 19,1,'AttendanceShifts','BcalculateLate','允許遲到2','int',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 20,1,'AttendanceShifts','BcalculateEarly','允許早退2','int',0,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 21,1,'AttendanceShifts','ConDuty','上班標準3','datetime',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 22,1,'AttendanceShifts','ConDutyEnd','上班截止3','datetime',0,22)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 23,1,'AttendanceShifts','CoffDuty','下班標準3','datetime',0,23)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 24,1,'AttendanceShifts','CrestTime','中間休息3','int',0,24)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 25,1,'AttendanceShifts','CcalculateLate','允許遲到3','int',0,25)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 26,1,'AttendanceShifts','CcalculateEarly','允許早退3','int',0,26)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 27,1,'AttendanceShifts','FirstOnDuty','第一次上下班','nchar(1)',0,27)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 28,1,'AttendanceShifts','AoffDutyEnd','下班截止1','datetime',0,28)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 29,1,'AttendanceShifts','BonDutyStart','上班開始2','datetime',0,29)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 30,1,'AttendanceShifts','BoffDutyStart','下班開始2','datetime',0,30)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 31,1,'AttendanceShifts','ConDutyStart','上班開始3','datetime',0,31)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 32,1,'AttendanceShifts','CoffDutyStart','下班開始3','datetime',0,32)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 33,1,'AttendanceShifts','CoffDutyEnd','下班截止3','datetime',0,33)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 34,1,'AttendanceShifts','ShiftId','班次ID','int',0,34)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 35,2,'Tables','TableName','表名','nvarchar(30)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 36,2,'Tables','TableDesc','說明','nvarchar(40)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 37,2,'Tables','TableId','表ID','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 38,6,'TableStructure','FieldDesc','欄位說明','nvarchar(50)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 39,6,'TableStructure','FieldId','欄位ID','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 40,6,'TableStructure','FieldType','欄位類型','nvarchar(50)',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 41,6,'TableStructure','TableId','表ID','int',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 42,6,'TableStructure','ViewOrder','顯示順序','int',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 43,6,'TableStructure','FieldName','欄位名','nvarchar(50)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 44,6,'TableStructure','AllowView','允許顯示','bit',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 45,6,'TableStructure','FieldProperty1','欄位屬性1','nvarchar(50)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 46,6,'TableStructure','FieldProperty2','欄位屬性2','nvarchar(50)',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 47,7,'AttendanceSignIn','SignId','補卡ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 48,7,'AttendanceSignIn','BrushTime','時間','datetime',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 49,7,'AttendanceSignIn','EmployeeId','職員ID','int',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 50,7,'AttendanceSignIn','Status','狀態','nvarchar(50)',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 51,7,'AttendanceSignIn','Remark','原因','nvarchar(50)',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 52,7,'AttendanceSignIn','WorkFlowId','工作流ID','int',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 53,7,'AttendanceSignIn','WorkFlowName','工作流名稱','nvarchar(50)',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 54,7,'AttendanceSignIn','OldStepId','撤銷時的步驟ID','int',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 55,7,'AttendanceSignIn','OldTransactorId','撤銷時的下步經辦人ID','int',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 56,7,'AttendanceSignIn','NowStep','當前步驟','int',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 57,7,'AttendanceSignIn','NextStep','下一步','nvarchar(50)',1,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 58,7,'AttendanceSignIn','TransactorDesc','經辦人說明','nvarchar(50)',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 59,7,'AttendanceSignIn','TransactorId','經辦人ID','int',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 60,7,'AttendanceSignIn','TransactorName','經辦人姓名','nvarchar(50)',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 61,10,'AttendanceHoliday','HolidayId','ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 62,10,'AttendanceHoliday','HolidayName','說明','nvarchar(50)',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 63,10,'AttendanceHoliday','HolidayDate','日期','datetime',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 64,10,'AttendanceHoliday','TransposalDate','調換日期','datetime',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 65,11,'Company','Tel','聯繫電話','nvarchar(50)',1,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 66,11,'Company','CompDesc','簡介','nvarchar(500)',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 67,11,'Company','Linkman','連絡人','nvarchar(50)',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 68,11,'Company','Address','地址','nvarchar(100)',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 69,11,'Company','CompName','公司名稱','nvarchar(100)',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 70,11,'Company','ChiefId','負責人ID','int',1,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 71,12,'Employees','EmployeeId','職員ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 72,12,'Employees','DepartmentID','部門ID','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 73,12,'Employees','Name','姓名','nvarchar(50)',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 74,12,'Employees','Sex','性別','nvarchar(20)',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 75,12,'Employees','Card','卡號','bigint',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 76,12,'Employees','Number','編號','nvarchar(20)',1,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 77,12,'Employees','Marry','婚否','nvarchar(20)',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 78,12,'Employees','Knowledge','學歷','nvarchar(20)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 79,12,'Employees','Position','職位','nvarchar(50)',1,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 80,12,'Employees','Headship','職務','nvarchar(50)',1,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 81,12,'Employees','JoinDate','入職日期','datetime',1,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 82,12,'Employees','IdentityCard','身份證','nvarchar(20)',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 83,12,'Employees','BirthDate','出生日期','datetime',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 84,12,'Employees','Country','國籍','nvarchar(20)',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 85,12,'Employees','NativePlace','籍貫','nvarchar(50)',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 86,12,'Employees','Address','地址','nvarchar(100)',0,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 87,12,'Employees','Telephone','電話','nvarchar(20)',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 88,12,'Employees','IncumbencyStatus','在職類型','nvarchar(20)',0,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 89,12,'Employees','Photo','照片','image',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 90,12,'Employees','FingerPrint1','指紋1','image',0,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 91,12,'Employees','FingerPrint2','指紋2','image',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 92,12,'Employees','Email','Email','nvarchar(50)',0,22)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 93,12,'Employees','DimissionDate','離職日期','datetime',0,23)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 94,12,'Employees','DimissionReason','離職說明','nvarchar(100)',0,24)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 95,12,'Employees','FieldVal1','保留欄位1值','nvarchar(50)',0,25)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 96,12,'Employees','FieldDesc1','保留欄位1說明','nvarchar(50)',0,26)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 97,12,'Employees','FieldVal2','保留欄位2值','nvarchar(50)',0,27)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 98,12,'Employees','FieldDesc2','保留欄位2說明','nvarchar(50)',0,28)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 99,12,'Employees','FieldVal3','保留欄位1值','int',0,29)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 100,12,'Employees','FieldDesc3','保留欄位1說明','nvarchar(50)',0,30)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 101,13,'Departments','DepartmentID','部門ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 102,13,'Departments','DepartmentCode','部門編碼','nvarchar(50)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 103,13,'Departments','DepartmentName','部門名稱','nvarchar(100)',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 104,13,'Departments','ChiefId','部門主管','nvarchar(50)',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 105,13,'Departments','LeadId','分管領導','nvarchar(50)',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 106,13,'Departments','ParentDepartmentID','父部門ID','int',1,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 107,13,'Departments','Remark','備註','nvarchar(100)',1,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 108,14,'RoleDepartment','DepartmentID','部門ID','nvarchar(20)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 109,14,'RoleDepartment','Permission','訪問','bit',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 110,14,'RoleDepartment','UserId','角色ID','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 111,15,'RoleController','ControllerID','部門ID','nvarchar(20)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 112,15,'RoleController','Permission','訪問','bit',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 113,15,'RoleController','UserId','角色ID','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 114,16,'BrushCardAcs','RecordID','記錄ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 115,16,'BrushCardAcs','Property','屬性','nvarchar(2)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 116,16,'BrushCardAcs','EmployeeId','職員ID','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 117,16,'BrushCardAcs','ControllerId','控制器ID','int',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 118,16,'BrushCardAcs','BrushTime','刷卡時間','datetime',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 119,16,'BrushCardAcs','Door','進出門','nvarchar(2)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 120,16,'BrushCardAcs','Card','卡號','bigint',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 121,17,'AttendanceTotal','EmployeeId','職員ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 122,17,'AttendanceTotal','AttendMonth','月份','nvarchar(7)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 123,17,'AttendanceTotal','LateCount_0','遲到次數(平)','numeric(18, 2)',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 124,17,'AttendanceTotal','LateTime_0','遲到時間(平)','numeric(18, 2)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 125,17,'AttendanceTotal','LeaveEarlyCount_0','早退次數(平)','numeric(18, 2)',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 126,17,'AttendanceTotal','LeaveEarlyTime_0','早退時間(平)','numeric(18, 2)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 127,17,'AttendanceTotal','AbnormityCount_0','異常次數(平)','numeric(18, 2)',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 128,17,'AttendanceTotal','WorkTime_0','工作時間(平)','numeric(18, 2)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 129,17,'AttendanceTotal','OtTime_0','超時加班(平)','numeric(18, 2)',1,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 130,17,'AttendanceTotal','WorkDay_0','出勤(平)','numeric(18, 2)',1,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 131,17,'AttendanceTotal','WorkTime_1','工作時間(休)','numeric(18, 2)',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 132,17,'AttendanceTotal','WorkTime_2','工作時間(假)','numeric(18, 2)',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 133,17,'AttendanceTotal','Absent','曠工','numeric(18, 2)',1,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 134,17,'AttendanceTotal','AnnualVacation','Holiday','年假','numeric(18, 2)',1,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 135,17,'AttendanceTotal','PersonalLeave','Holiday','事假','numeric(18, 2)',1,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 136,17,'AttendanceTotal','SickLeave','Holiday','病假','numeric(18, 2)',1,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 137,17,'AttendanceTotal','InjuryLeave','Holiday','工傷','numeric(18, 2)',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 138,17,'AttendanceTotal','WeddingLeave','Holiday','婚假','numeric(18, 2)',0,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 139,17,'AttendanceTotal','MaternityLeave','Holiday','產假','numeric(18, 2)',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 140,17,'AttendanceTotal','OnTrip','Holiday','出差','numeric(18, 2)',1,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 141,17,'AttendanceTotal','FuneralLeave','Holiday','喪假','numeric(18, 2)',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 142,17,'AttendanceTotal','CompensatoryLeave','Holiday','補假','numeric(18, 2)',1,22)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 143,17,'AttendanceTotal','OtherLeave','Holiday','其他假','numeric(18, 2)',0,23)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 144,17,'AttendanceTotal','LactationLeave','Holiday','哺乳假','numeric(18, 2)',0,24)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 145,17,'AttendanceTotal','VisitLeave','Holiday','探親假','numeric(18, 2)',0,25)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 146,17,'AttendanceTotal','PublicHoliday','Holiday','法定假','numeric(18, 2)',1,26)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 147,17,'AttendanceTotal','AnnualVacationRemanent','上年剩餘年假','numeric(18, 2)',0,27)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 148,18,'AttendanceDetail','EmployeeId','職員ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 149,18,'AttendanceDetail','OnDutyDate','上班日期','datetime',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 150,18,'AttendanceDetail','NoBrushCard','免打卡','bit',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 151,18,'AttendanceDetail','ShiftName','班次名','nvarchar(50)',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 152,18,'AttendanceDetail','OnDutyType','上班類型','nvarchar(50)',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 153,18,'AttendanceDetail','OnDuty1','上班刷卡1','datetime',1,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 154,18,'AttendanceDetail','OffDuty1','下班刷卡1','datetime',1,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 155,18,'AttendanceDetail','OnDuty2','上班刷卡2','datetime',1,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 156,18,'AttendanceDetail','OffDuty2','下班刷卡2','datetime',1,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 157,18,'AttendanceDetail','OnDuty3','上班刷卡3','datetime',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 158,18,'AttendanceDetail','OffDuty3','下班刷卡3','datetime',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 159,18,'AttendanceDetail','Result1','刷卡性質1','nvarchar(30)',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 160,18,'AttendanceDetail','Result2','刷卡性質2','nvarchar(30)',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 161,18,'AttendanceDetail','Result3','刷卡性質3','nvarchar(30)',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 162,18,'AttendanceDetail','Result4','刷卡性質4','nvarchar(30)',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 163,18,'AttendanceDetail','Result5','刷卡性質5','nvarchar(30)',0,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 164,18,'AttendanceDetail','Result6','刷卡性質6','nvarchar(30)',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 165,18,'AttendanceDetail','SignInFlag','補卡標誌','char(6)',0,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 166,18,'AttendanceDetail','LateTime1','遲到時間1','numeric(18, 0)',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 167,18,'AttendanceDetail','LateTime2','遲到時間2','numeric(18, 2)',0,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 168,18,'AttendanceDetail','LateTime3','遲到時間3','numeric(18, 2)',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 169,18,'AttendanceDetail','LeaveEarlyTime1','早退時間1','numeric(18, 2)',0,22)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 170,18,'AttendanceDetail','LeaveEarlyTime2','早退時間2','numeric(18, 2)',0,23)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 171,18,'AttendanceDetail','LeaveEarlyTime3','早退時間3','numeric(18, 2)',0,24)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 172,18,'AttendanceDetail','WorkTime1','工作時間1','numeric(18, 0)',0,25)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 173,18,'AttendanceDetail','WorkTime2','工作時間2','numeric(18, 0)',0,26)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 174,18,'AttendanceDetail','WorkTime3','工作時間3','numeric(18, 0)',0,27)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 175,18,'AttendanceDetail','WorkTime','總工作時間','numeric(18, 2)',0,28)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 176,18,'AttendanceDetail','OtTime','總超時加班','numeric(18, 2)',0,29)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 177,18,'AttendanceDetail','Absent','曠工','numeric(18, 2)',0,30)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 178,18,'AttendanceDetail','WorkDay','出勤','numeric(18, 2)',0,31)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 179,18,'AttendanceDetail','AnnualVacation','Holiday','年假','numeric(18, 2)',0,32)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 180,18,'AttendanceDetail','PersonalLeave','Holiday','事假','numeric(18, 2)',0,33)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 181,18,'AttendanceDetail','SickLeave','Holiday','病假','numeric(18, 2)',0,34)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 182,18,'AttendanceDetail','InjuryLeave','Holiday','工傷','numeric(18, 2)',0,35)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 183,18,'AttendanceDetail','WeddingLeave','Holiday','婚假','numeric(18, 2)',0,36)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 184,18,'AttendanceDetail','MaternityLeave','Holiday','產假','numeric(18, 2)',0,37)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 185,18,'AttendanceDetail','OnTrip','出差','numeric(18, 2)',0,38)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 186,18,'AttendanceDetail','FuneralLeave','Holiday','喪假','numeric(18, 2)',0,39)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 187,18,'AttendanceDetail','CompensatoryLeave','Holiday','補假','numeric(18, 2)',0,40)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 188,18,'AttendanceDetail','PublicHoliday','Holiday','法定假','numeric(18, 2)',0,41)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 189,18,'AttendanceDetail','OtherLeave','Holiday','其他假','numeric(18, 2)',0,42)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 190,18,'AttendanceDetail','VisitLeave','Holiday','探親假','numeric(18, 2)',0,43)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 191,18,'AttendanceDetail','LactationLeave','Holiday','哺乳假','numeric(18, 2)',0,44)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 192,19,'BrushCardAttend','Card','卡號','bigint',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 193,19,'BrushCardAttend','ControllerId','控制器ID','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 194,19,'BrushCardAttend','RecordID','記錄ID','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 195,19,'BrushCardAttend','EmployeeId','職員ID','int',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 196,19,'BrushCardAttend','BrushTime','刷卡時間','datetime',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 197,19,'BrushCardAttend','Door','進出門','nvarchar(2)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 198,19,'BrushCardAttend','property','屬性','smallint',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 199,20,'ControllerDataSync','ID','ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 200,20,'ControllerDataSync','ControllerId','控制器ID','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 201,20,'ControllerDataSync','OperateUser','操作用戶','nvarchar(20)',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 202,20,'ControllerDataSync','SyncType','同步類型','nvarchar(20)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 203,20,'ControllerDataSync','SyncStatus','是否同步','smallint',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 204,20,'ControllerDataSync','SyncTime','同步時間','datetime',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 205,20,'ControllerDataSync','TrueTimeInfo','監控資訊','nvarchar(60)',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 206,21,'Controllers','ConnectMode','連接方式','nvarchar(50)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 207,21,'Controllers','WorkType','工作目的','nvarchar(50)',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 208,21,'Controllers','ControllerNumber','設備編號','nvarchar(10)',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 209,21,'Controllers','ControllerName','設備名稱','nvarchar(10)',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 210,21,'Controllers','Location','位置','nvarchar(20)',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 211,21,'Controllers','StorageMode','存儲方式','nvarchar(50)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 212,21,'Controllers','IsFingerprint','含指紋模組','bit',1,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 213,21,'Controllers','ServerIP','伺服器地址','nvarchar(50)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 214,21,'Controllers','DNS','DNS','nvarchar(20)',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 215,21,'Controllers','DoorType','門','nvarchar(20)',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 216,21,'Controllers','CardReader1','讀卡器1','nvarchar(10)',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 217,21,'Controllers','CardReader2','讀卡器2','nvarchar(10)',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 218,21,'Controllers','DoorLocation1','門位置1','nvarchar(50)',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 219,21,'Controllers','DoorLocation2','門位置2','nvarchar(50)',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 220,21,'Controllers','Sound','語音音量','int',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 221,21,'Controllers','IP','IP','nvarchar(30)',1,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 222,21,'Controllers','AntiPassBackType','防遣返方式','bit',1,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 223,21,'Controllers','SystemPassword','設備設置密碼','nvarchar(20)',0,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 224,21,'Controllers','DownPhoto','下載照片','bit',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 225,21,'Controllers','WaitTime','等待時間','int',0,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 226,21,'Controllers','ControllerId','控制器ID','int',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 227,21,'Controllers','ScreenFile1','屏保文件1','image',0,22)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 228,21,'Controllers','ScreenFile2','屏保文件2','image',0,23)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 229,21,'Controllers','MASK','MASK','nvarchar(20)',0,24)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 230,21,'Controllers','GateWay','閘道','nvarchar(20)',0,25)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 231,21,'Controllers','DataUpdateTime','數據上傳下載間隔','int',0,26)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 232,21,'Controllers','DownFingerprint','下載指紋','bit',0,27)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 233,21,'Controllers','EnableDHCP','啟用IP','bit',0,28)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 234,21,'Controllers','DNS2','備用DNS','nvarchar(20)',0,29)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 235,21,'Controllers','CloseLightTime','關閉背光時間','smallint',0,30)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 236,21,'Controllers','BoardType','控制板類型','nvarchar(50)',0,31)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 237,21,'Controllers','FieldVal1','保留欄位1值','nvarchar(50)',0,32)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 238,21,'Controllers','FieldDesc1','保留欄位1說明','nvarchar(50)',0,33)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 239,21,'Controllers','FieldVal2','保留欄位2值','nvarchar(50)',0,34)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 240,21,'Controllers','FieldDesc2','保留欄位2說明','nvarchar(50)',0,35)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 241,21,'Controllers','FieldVal3','保留欄位3值','nvarchar(50)',0,36)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 242,21,'Controllers','FieldDesc3','保留欄位3說明','nvarchar(50)',0,37)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 243,21,'Controllers','FieldVal4','保留欄位4值','nvarchar(50)',0,38)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 244,21,'Controllers','FieldDesc4','保留欄位4說明','nvarchar(50)',0,39)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 245,21,'Controllers','FieldVal5','保留欄位5值','nvarchar(50)',0,40)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 246,21,'Controllers','FieldDesc5','保留欄位5說明','nvarchar(50)',0,41)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 247,22,'ControllerHoliday','TemplateId','假期範本ID','int',1,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 248,22,'ControllerHoliday','TemplateName','假期範本名稱','nvarchar(50)',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 249,22,'ControllerHoliday','ControllerId','控制器ID','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 250,22,'ControllerHoliday','Status','同步狀態','bit',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 251,22,'ControllerHoliday','RecordID','RecordID','int',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 252,22,'ControllerHoliday','HolidayCode','假期表編碼','int',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 253,24,'ControllerTemplateHoliday','HolidayNumber','假期編碼','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 254,24,'ControllerTemplateHoliday','HolidayDate','日期','nvarchar(5)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 255,24,'ControllerTemplateHoliday','HolidayName','假期名','nvarchar(50)',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 256,24,'ControllerTemplateHoliday','TemplateId','範本ID','int',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 257,24,'ControllerTemplateHoliday','RecordID','RecordID','int',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 258,25,'ControllerTemplates','TemplateId','範本ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 259,25,'ControllerTemplates','TemplateType','範本類型','nchar(1)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 260,25,'ControllerTemplates','TemplateName','範本名稱','nvarchar(50)',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 261,25,'ControllerTemplates','EmployeeDesc','進出職員','ntext',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 262,25,'ControllerTemplates','EmployeeCode','進出職員條件','ntext',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 263,25,'ControllerTemplates','EmployeeController','進出設備','nvarchar(20)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 264,25,'ControllerTemplates','EmployeeScheID','進出時間表','smallint',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 265,25,'ControllerTemplates','EmployeeDoor','進出門','nvarchar(20)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 266,26,'ControllerSchedule','ScheduleCode','時間表編號','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 267,26,'ControllerSchedule','ControllerId','控制器Id','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 268,26,'ControllerSchedule','Status','同步狀態','bit',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 269,26,'ControllerSchedule','TemplateName','時間範本名稱','nvarchar(50)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 270,26,'ControllerSchedule','TemplateId','時間範本ID','int',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 271,26,'ControllerSchedule','RecordID','RecordID','int',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 272,28,'ControllerTemplateSchedule','EndTime5','截止時間5','nvarchar(5)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 273,28,'ControllerTemplateSchedule','StartTime3','開始時間3','nvarchar(5)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 274,28,'ControllerTemplateSchedule','StartTime5','開始時間5','nvarchar(5)',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 275,28,'ControllerTemplateSchedule','WeekDay','星期','nvarchar(50)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 276,28,'ControllerTemplateSchedule','HolidayTemplateId','假期表範本ID','smallint',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 277,28,'ControllerTemplateSchedule','EndTime2','截止時間2','nvarchar(5)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 278,28,'ControllerTemplateSchedule','EndTime3','截止時間3','nvarchar(5)',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 279,28,'ControllerTemplateSchedule','StartTime2','開始時間2','nvarchar(5)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 280,28,'ControllerTemplateSchedule','StartTime4','開始時間4','nvarchar(5)',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 281,28,'ControllerTemplateSchedule','EndTime1','截止時間1','nvarchar(5)',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 282,28,'ControllerTemplateSchedule','EndTime4','截止時間4','nvarchar(5)',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 283,28,'ControllerTemplateSchedule','TemplateId','範本ID','int',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 284,28,'ControllerTemplateSchedule','StartTime1','開始時間1','nvarchar(5)',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 285,29,'ControllerInout','RecordID','記錄ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 286,29,'ControllerInout','Out4','輸出4','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 287,29,'ControllerInout','Out3','輸出3','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 288,29,'ControllerInout','ScheduleName','時間表','nvarchar(50)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 289,29,'ControllerInout','Out5','輸出5','int',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 290,29,'ControllerInout','Out1','輸出1','int',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 291,29,'ControllerInout','InoutDesc','輸入說明','nvarchar(50)',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 292,29,'ControllerInout','InoutPoint','輸入','int',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 293,29,'ControllerInout','ControllerId','控制器Id','int',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 294,29,'ControllerInout','ScheduleID','時間表ID','int',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 295,29,'ControllerInout','Out2','輸出2','int',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 296,29,'ControllerInout','Status','同步狀態','bit',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 297,30,'ControllerTemplateInout','InoutDesc','輸入說明','nvarchar(50)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 298,30,'ControllerTemplateInout','InoutPoint','輸入','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 299,30,'ControllerTemplateInout','Out1','輸出1','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 300,30,'ControllerTemplateInout','Out2','輸出2','int',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 301,30,'ControllerTemplateInout','Out5','輸出5','int',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 302,30,'ControllerTemplateInout','TemplateId','範本ID','int',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 303,30,'ControllerTemplateInout','Out4','輸出4','int',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 304,30,'ControllerTemplateInout','ScheduleName','時間表','nvarchar(50)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 305,30,'ControllerTemplateInout','Out3','輸出3','int',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 306,30,'ControllerTemplateInout','ScheduleId','時間表ID','int',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 307,31,'ControllerEmployee','RecordID','記錄ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 308,31,'ControllerEmployee','ControllerId','設備ID','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 309,31,'ControllerEmployee','EmployeeId','員工ID','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 310,31,'ControllerEmployee','ScheduleCode','時間表','int',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 311,31,'ControllerEmployee','EmployeeDoor','進出門','nvarchar(20)',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 312,31,'ControllerEmployee','UserPassword','使用者密碼','nvarchar(20)',1,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 313,31,'ControllerEmployee','PassBackFlag','防遣返','bit',1,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 314,31,'ControllerEmployee','Status','同步狀態','bit',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 315,31,'ControllerEmployee','DeleteFlag','刪除標誌','bit',1,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 316,31,'ControllerEmployee','ValidateMode','驗證方式','nvarchar(20)',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 317,31,'ControllerEmployee','Floor','電梯樓層許可權','nvarchar(700)',1,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 318,31,'ControllerEmployee','CombinationID','開門分組IDs','int',1,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 319,32,'TempShifts','AdjustDate','日期','datetime',1,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 320,32,'TempShifts','ShiftName','調整後班次','nvarchar(50)',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 321,32,'TempShifts','StretchShift','彈性班次','bit',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 322,32,'TempShifts','ShiftTime','基本工時','numeric(5,2)',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 323,32,'TempShifts','Degree','上班次數','int',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 324,32,'TempShifts','Night','過夜','bit',1,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 325,32,'TempShifts','ArestTime','中間休息1','int',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 326,32,'TempShifts','AcalculateLate','允許遲到1','int',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 327,32,'TempShifts','AcalculateEarly','允許早退1','int',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 328,32,'TempShifts','ShiftId','班次ID','int',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 329,32,'TempShifts','AoffDutyEnd','下班截止1','datetime',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 330,32,'TempShifts','TempShiftID','臨時班次ID','int',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 331,32,'TempShifts','EmployeeExpress','職員條件','ntext',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 332,32,'TempShifts','EmployeeDesc','職員說明','ntext',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 333,32,'TempShifts','CrestTime','中間休息3','int',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 334,32,'TempShifts','CcalculateLate','允許遲到3','int',0,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 335,32,'TempShifts','CcalculateEarly','允許早退3','int',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 336,32,'TempShifts','BonDuty','上班標準2','datetime',0,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 337,32,'TempShifts','AoffDutyStart','下班開始1','datetime',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 338,32,'TempShifts','CoffDuty','下班標準3','datetime',0,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 339,32,'TempShifts','AoffDuty','下班標準1','datetime',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 340,32,'TempShifts','CoffDutyEnd','下班截止3','datetime',0,22)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 341,32,'TempShifts','BoffDutyEnd','下班截止2','datetime',0,23)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 342,32,'TempShifts','ShiftType','班次類型','nchar(1)',0,24)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 343,32,'TempShifts','BonDutyEnd','上班截止2','datetime',0,25)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 344,32,'TempShifts','BoffDuty','下班標準2','datetime',0,26)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 345,32,'TempShifts','ConDutyEnd','上班截止3','datetime',0,27)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 346,32,'TempShifts','CoffDutyStart','下班開始3','datetime',0,28)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 347,32,'TempShifts','FirstOnDuty','第一次上下班','nvarchar(20)',0,29)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 348,32,'TempShifts','BonDutyStart','上班開始2','datetime',0,30)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 349,32,'TempShifts','AonDutyEnd','上班截止1','datetime',0,31)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 350,32,'TempShifts','ConDutyStart','上班開始3','datetime',0,32)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 351,32,'TempShifts','AonDutyStart','上班開始1','datetime',0,33)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 352,32,'TempShifts','BoffDutyStart','下班開始2','datetime',0,34)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 353,32,'TempShifts','AonDuty','上班標準1','datetime',0,35)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 354,32,'TempShifts','BrestTime','中間休息2','int',0,36)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 355,32,'TempShifts','BcalculateLate','允許遲到2','int',0,37)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 356,32,'TempShifts','BcalculateEarly','允許早退2','int',0,38)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 357,32,'TempShifts','ConDuty','上班標準3','datetime',0,39)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 358,32,'TempShifts','Description','調整說明','nvarchar(200)',0,40)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 359,33,'AttendanceAskForLeave','Status','狀態','nvarchar(50)',1,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 360,33,'AttendanceAskForLeave','AskForLeaveType','假別','nvarchar(50)',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 361,33,'AttendanceAskForLeave','TransactThing','擬辦事項','nvarchar(100)',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 362,33,'AttendanceAskForLeave','Note','說明','nvarchar(100)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 363,33,'AttendanceAskForLeave','AskForLeaveId','請假ID','int',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 364,33,'AttendanceAskForLeave','EmployeeId','職員ID','int',1,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 365,33,'AttendanceAskForLeave','SumTotal','合計','nvarchar(8)',1,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 366,33,'AttendanceAskForLeave','StartTime','開始時間','datetime',1,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 367,33,'AttendanceAskForLeave','EndTime','截止時間','datetime',1,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 368,33,'AttendanceAskForLeave','AllDay','整日','bit',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 369,33,'AttendanceAskForLeave','WorkFlowId','工作流ID','int',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 370,33,'AttendanceAskForLeave','WorkFlowName','工作流名稱','nvarchar(50)',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 371,33,'AttendanceAskForLeave','OldStepId','撤銷時的步驟ID','int',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 372,33,'AttendanceAskForLeave','OldTransactorId','撤銷時的下步經辦人ID','int',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 373,33,'AttendanceAskForLeave','NowStep','當前步驟','int',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 374,33,'AttendanceAskForLeave','NextStep','下一步','nvarchar(50)',1,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 375,33,'AttendanceAskForLeave','TransactorDesc','經辦人說明','nvarchar(50)',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 376,33,'AttendanceAskForLeave','TransactorId','經辦人ID','int',0,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 377,33,'AttendanceAskForLeave','TransactorName','經辦人姓名','nvarchar(50)',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 378,33,'AttendanceAskForLeave','DeputizeId','代理人ID','int',0,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 379,33,'AttendanceAskForLeave','DeputizeName','代理人姓名','nvarchar(50)',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 380,34,'LogEvent','EventID','日誌ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 381,34,'LogEvent','Actions','操作','nvarchar(50)',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 382,34,'LogEvent','LoginMachine','登錄機器','nvarchar(50)',1,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 383,34,'LogEvent','Modules','模組','nvarchar(200)',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 384,34,'LogEvent','LoginName','用戶名','nvarchar(50)',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 385,34,'LogEvent','Objects','對象','nvarchar(200)',1,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 386,34,'LogEvent','LoginDate','時間','datetime',1,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 387,34,'LogEvent','UserName','用戶名','nvarchar(50)',1,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 388,35,'AttendanceOndutyRule','EmployeeDesc','員工說明','ntext',1,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 389,35,'AttendanceOndutyRule','OnDutyMode','上班方式','nvarchar(20)',1,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 390,35,'AttendanceOndutyRule','Friday1','週五(1)','nvarchar(50)',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 391,35,'AttendanceOndutyRule','Wednesday1','週三(1)','nvarchar(50)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 392,35,'AttendanceOndutyRule','Thursday1','週四(1)','nvarchar(50)',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 393,35,'AttendanceOndutyRule','Saturday1','週六(1)','nvarchar(50)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 394,35,'AttendanceOndutyRule','Tuesday1','週二(1)','nvarchar(50)',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 395,35,'AttendanceOndutyRule','Wednesday2','週三(2)','nvarchar(50)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 396,35,'AttendanceOndutyRule','EmployeeCode','職員代碼','ntext',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 397,35,'AttendanceOndutyRule','Thursday2','週四(2)','nvarchar(50)',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 398,35,'AttendanceOndutyRule','Friday2','週五(2)','nvarchar(50)',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 399,35,'AttendanceOndutyRule','FirstWeekDate','第一周開始日','datetime',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 400,35,'AttendanceOndutyRule','Tuesday2','週二(2)','nvarchar(50)',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 401,35,'AttendanceOndutyRule','Monday1','週一(1)','nvarchar(50)',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 402,35,'AttendanceOndutyRule','Sunday1','周日(1)','nvarchar(50)',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 403,35,'AttendanceOndutyRule','Sunday2','周日(2)','nvarchar(50)',0,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 404,35,'AttendanceOndutyRule','RuleId','規則ID','int',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 405,35,'AttendanceOndutyRule','NoBrushCard','免打卡','bit',1,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 406,35,'AttendanceOndutyRule','Saturday2','週六(2)','nvarchar(50)',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 407,35,'AttendanceOndutyRule','Monday2','週一(2)','nvarchar(50)',0,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 408,36,'AttendanceOnDutyRuleChange','ChangeId','變動ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 409,36,'AttendanceOnDutyRuleChange','Monday1','週一(1)','nvarchar(50)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 410,36,'AttendanceOnDutyRuleChange','FirstWeekDate','第一周開始日','datetime',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 411,36,'AttendanceOnDutyRuleChange','Saturday2','週六(2)','nvarchar(50)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 412,36,'AttendanceOnDutyRuleChange','OnDutyMode','上班方式','nvarchar(20)',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 413,36,'AttendanceOnDutyRuleChange','NoBrushCard','免打卡','bit',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 414,36,'AttendanceOnDutyRuleChange','Sunday2','周日(2)','nvarchar(50)',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 415,36,'AttendanceOnDutyRuleChange','Sunday1','周日(1)','nvarchar(50)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 416,36,'AttendanceOnDutyRuleChange','EmployeeDesc','職員說明','ntext',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 417,36,'AttendanceOnDutyRuleChange','Saturday1','週六(1)','nvarchar(50)',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 418,36,'AttendanceOnDutyRuleChange','Friday2','週五(2)','nvarchar(50)',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 419,36,'AttendanceOnDutyRuleChange','Thursday1','週四(1)','nvarchar(50)',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 420,36,'AttendanceOnDutyRuleChange','EmployeeCode','職員代碼','ntext',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 421,36,'AttendanceOnDutyRuleChange','Friday1','週五(1)','nvarchar(50)',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 422,36,'AttendanceOnDutyRuleChange','Wednesday1','週三(1)','nvarchar(50)',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 423,36,'AttendanceOnDutyRuleChange','RuleId','規則ID','int',0,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 424,36,'AttendanceOnDutyRuleChange','ChangeDate','變動日期','datetime',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 425,36,'AttendanceOnDutyRuleChange','Wednesday2','週三(2)','nvarchar(50)',0,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 426,36,'AttendanceOnDutyRuleChange','Thursday2','週四(2)','nvarchar(50)',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 427,36,'AttendanceOnDutyRuleChange','Monday2','週一(2)','nvarchar(50)',0,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 428,36,'AttendanceOnDutyRuleChange','Tuesday2','週二(2)','nvarchar(50)',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 429,36,'AttendanceOnDutyRuleChange','Tuesday1','週二(1)','nvarchar(50)',0,22)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 430,37,'EventRecord','RecordID','記錄ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 431,37,'EventRecord','ControllerID','控制器編號','nvarchar(10)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 432,37,'EventRecord','InputPoint','輸入點','nvarchar(2)',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 433,37,'EventRecord','OccurTime','發生時間','datetime',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 434,38,'Options','VariableType','類型','nvarchar(50)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 435,38,'Options','VariableId','變數ID','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 436,38,'Options','VariableDesc','說明','nvarchar(50)',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 437,38,'Options','VariableValue','值','nvarchar(500)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 438,38,'Options','VariableName','變數名','nvarchar(50)',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 439,39,'Users','LoginName','登錄名','nvarchar(50)',1,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 440,39,'Users','UserId','用戶ID','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 441,39,'Users','EmployeeId','職員ID','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 442,39,'Users','Name','職員姓名','nvarchar(50)',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 443,39,'Users','PrivateUser','私用帳號','bit',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 444,39,'Users','UserPassword','使用者密碼','nvarchar(20)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 445,39,'Users','OperableEmployees','可操作職員','bit',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 446,39,'Users','OperableExpress','職員運算式','nvarchar(20)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 447,39,'Users','VisitTimeLeave','訪問請假時間','nvarchar(19)',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 448,39,'Users','VisitTimeOntrip','訪問出差時間','nvarchar(19)',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 449,39,'Users','VisitTimeSignIn','訪問補卡時間','nvarchar(19)',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 450,39,'Users','VisitTimeOT','訪問加班時間','nvarchar(19)',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 451,39,'Users','VisitProbation','訪問轉正模組時間','nvarchar(19)',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 452,39,'Users','VisitDimission','訪問離職模組時間','nvarchar(19)',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 453,40,'AttendanceTotalYear','LateTime_0','遲到時間(平)','numeric(18, 2)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 454,40,'AttendanceTotalYear','InjuryLeave','Holiday','工傷','numeric(18, 2)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 455,40,'AttendanceTotalYear','WeddingLeave','Holiday','婚假','numeric(18, 2)',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 456,40,'AttendanceTotalYear','OtherLeave','Holiday','女性假','numeric(18, 2)',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 457,40,'AttendanceTotalYear','LactationLeave','Holiday','哺乳假','numeric(18, 2)',0,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 458,40,'AttendanceTotalYear','VisitLeave','Holiday','探親假','numeric(18, 2)',0,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 459,40,'AttendanceTotalYear','OnTrip','Holiday','出差','numeric(18, 2)',0,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 460,40,'AttendanceTotalYear','CompensatoryLeave','Holiday','補假','numeric(18, 2)',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 461,40,'AttendanceTotalYear','AbnormityCount_0','異常次數(平)','numeric(18, 2)',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 462,40,'AttendanceTotalYear','FuneralLeave','Holiday','喪假','numeric(18, 2)',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 463,40,'AttendanceTotalYear','PersonalLeave','Holiday','事假','numeric(18, 2)',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 464,40,'AttendanceTotalYear','OtTime_0','超時加班(平)','numeric(18, 2)',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 465,40,'AttendanceTotalYear','Absent','曠工','numeric(18, 2)',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 466,40,'AttendanceTotalYear','WorkTime_0','工作時間(平)','numeric(18, 2)',0,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 467,40,'AttendanceTotalYear','AttendMonth','月份','nvarchar(7)',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 468,40,'AttendanceTotalYear','MaternityLeave','Holiday','產假','numeric(18, 2)',0,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 469,40,'AttendanceTotalYear','LateCount_0','遲到次數(平)','numeric(18, 2)',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 470,40,'AttendanceTotalYear','EmployeeId','職員ID','int',0,18)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 471,40,'AttendanceTotalYear','WorkTime_1','工作時間(休)','numeric(18, 2)',0,19)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 472,40,'AttendanceTotalYear','LeaveEarlyCount_0','早退次數(平)','numeric(18, 2)',0,20)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 473,40,'AttendanceTotalYear','SickLeave','Holiday','病假','numeric(18, 2)',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 474,40,'AttendanceTotalYear','LeaveEarlyTime_0','早退時間(平)','numeric(18, 2)',0,22)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 475,40,'AttendanceTotalYear','PublicHoliday','Holiday','法定假','numeric(18, 2)',0,23)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldProperty1],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 476,40,'AttendanceTotalYear','AnnualVacation','Holiday','年假','numeric(18, 2)',0,24)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 477,40,'AttendanceTotalYear','WorkTime_2','工作時間(假)','numeric(18, 2)',0,25)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 478,40,'AttendanceTotalYear','WorkDay_0','出勤(平)','numeric(18, 2)',0,26)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 479,40,'AttendanceTotalYear','AnnualVacationRemanent','上年度剩餘年假','numeric(18, 2)',0,27)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 480,40,'AttendanceTotalYear','AnnualVacationYear','應休年假','numeric(18, 2)',0,28)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 481,41,'AttendanceOT','Status','狀態','nvarchar(50)',1,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 482,41,'AttendanceOT','Note','事由','nvarchar(100)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 483,41,'AttendanceOT','OTId','請假ID','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 484,41,'AttendanceOT','EmployeeId','職員ID','int',1,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 485,41,'AttendanceOT','SumTotal','合計','nvarchar(8)',1,5)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 486,41,'AttendanceOT','StartTime','開始時間','datetime',1,6)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 487,41,'AttendanceOT','EndTime','截止時間','datetime',1,7)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 488,41,'AttendanceOT','AllDay','整天','bit',0,8)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 489,41,'AttendanceOT','WorkFlowId','工作流ID','int',0,9)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 490,41,'AttendanceOT','WorkFlowName','工作流名稱','nvarchar(50)',0,10)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 491,41,'AttendanceOT','OldStepId','撤銷時的步驟ID','int',0,11)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 492,41,'AttendanceOT','OldTransactorId','撤銷時的下步經辦ID','int',0,12)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 493,41,'AttendanceOT','NowStep','當前步驟','int',0,13)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 494,41,'AttendanceOT','NextStep','下一步','nvarchar(50)',1,14)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 495,41,'AttendanceOT','TransactorDesc','經辦人說明','nvarchar(50)',0,15)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 496,41,'AttendanceOT','TransactorId','經辦人ID','int',0,16)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 497,41,'AttendanceOT','TransactorName','經辦人姓名','nvarchar(50)',0,17)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 498,42,'TotalMonth','TotalMonth','統計月份','nvarchar(10)',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 499,42,'TotalMonth','StartDate','開始日期','datetime',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 500,42,'TotalMonth','EndDate','截止日期','datetime',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 501,43,'CombinationDoor','RecordID','RecordID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 502,43,'CombinationDoor','CombinationID','組ID','int',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 503,43,'CombinationDoor','EmployeeId','EmployeeId','int',0,3)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 504,43,'CombinationDoor','OpenOrder','開門順序','int',0,4)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 505,45,'TableFieldCode','FieldId','欄位ID','int',0,1)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 506,45,'TableFieldCode','Content','內容','nvarchar(50)',0,2)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 507,35,'AttendanceOndutyRule','LoopCount','迴圈天數','bit',0,21)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 508,35,'AttendanceOndutyRule','day15','迴圈(15)','nvarchar(50)',0,22)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 509,35,'AttendanceOndutyRule','day16','迴圈(16)','nvarchar(50)',0,23)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 510,35,'AttendanceOndutyRule','day17','迴圈(17)','nvarchar(50)',0,24)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 511,35,'AttendanceOndutyRule','day18','迴圈(18)','nvarchar(50)',0,25)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 512,35,'AttendanceOndutyRule','day19','迴圈(19)','nvarchar(50)',0,26)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 513,35,'AttendanceOndutyRule','day20','迴圈(20)','nvarchar(50)',0,27)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 514,35,'AttendanceOndutyRule','day21','迴圈(21)','nvarchar(50)',0,28)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 515,35,'AttendanceOndutyRule','day22','迴圈(22)','nvarchar(50)',0,29)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 516,35,'AttendanceOndutyRule','day23','迴圈(23)','nvarchar(50)',0,30)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 517,35,'AttendanceOndutyRule','day24','迴圈(24)','nvarchar(50)',0,31)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 518,35,'AttendanceOndutyRule','day25','迴圈(25)','nvarchar(50)',0,32)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 519,35,'AttendanceOndutyRule','day26','迴圈(26)','nvarchar(50)',0,33)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 520,35,'AttendanceOndutyRule','day27','迴圈(27)','nvarchar(50)',0,34)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 521,35,'AttendanceOndutyRule','day28','迴圈(28)','nvarchar(50)',0,35)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 522,35,'AttendanceOndutyRule','day28','迴圈(29)','nvarchar(50)',0,36)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 523,35,'AttendanceOndutyRule','day30','迴圈(30)','nvarchar(50)',0,37)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 524,35,'AttendanceOndutyRule','day31','迴圈(31)','nvarchar(50)',0,38)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 525,36,'AttendanceOnDutyRuleChange','LoopCount','迴圈天數','bit',0,23)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 526,36,'AttendanceOnDutyRuleChange','day15','迴圈(15)','nvarchar(50)',0,24)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 527,36,'AttendanceOnDutyRuleChange','day16','迴圈(16)','nvarchar(50)',0,25)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 528,36,'AttendanceOnDutyRuleChange','day17','迴圈(17)','nvarchar(50)',0,26)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 529,36,'AttendanceOnDutyRuleChange','day18','迴圈(18)','nvarchar(50)',0,27)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 530,36,'AttendanceOnDutyRuleChange','day19','迴圈(19)','nvarchar(50)',0,28)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 531,36,'AttendanceOnDutyRuleChange','day20','迴圈(20)','nvarchar(50)',0,29)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 532,36,'AttendanceOnDutyRuleChange','day21','迴圈(21)','nvarchar(50)',0,30)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 533,36,'AttendanceOnDutyRuleChange','day22','迴圈(22)','nvarchar(50)',0,31)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 534,36,'AttendanceOnDutyRuleChange','day23','迴圈(23)','nvarchar(50)',0,32)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 535,36,'AttendanceOnDutyRuleChange','day24','迴圈(24)','nvarchar(50)',0,33)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 536,36,'AttendanceOnDutyRuleChange','day25','迴圈(25)','nvarchar(50)',0,34)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 537,36,'AttendanceOnDutyRuleChange','day26','迴圈(26)','nvarchar(50)',0,35)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 538,36,'AttendanceOnDutyRuleChange','day27','迴圈(27)','nvarchar(50)',0,36)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 539,36,'AttendanceOnDutyRuleChange','day28','迴圈(28)','nvarchar(50)',0,37)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 540,36,'AttendanceOnDutyRuleChange','day28','迴圈(29)','nvarchar(50)',0,38)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 541,36,'AttendanceOnDutyRuleChange','day30','迴圈(30)','nvarchar(50)',0,39)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 542,36,'AttendanceOnDutyRuleChange','day31','迴圈(31)','nvarchar(50)',0,40)

INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 543,1,'AttendanceShifts','Overtime','超時休息','int',0,35)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 544,32,'TempShifts','Overtime','超時休息','int',0,41)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 545,21,'Controllers','ScreenFlash','Flash屏保文件','image',0,42)
INSERT [TableStructure] ([FieldId],[TableId],[TableName],[FieldName],[FieldDesc],[FieldType],[AllowView],[ViewOrder]) VALUES ( 546,21,'Controllers','ScreenType','屏保類型','nvarchar(50)',0,43)
SET IDENTITY_INSERT [TableStructure] OFF
GO

SET IDENTITY_INSERT [LabelText] ON

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
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 438,N'Monitor',N'strMonitor',N'实时监控',N'即時監控',N'Monitor')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 439,N'Monitor',N'DoorStatus',N'监控门状态',N'監控門狀態',N'Monitor Door')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 440,N'Monitor',N'OpenDoor',N'远程开门',N'遠程開門',N'Open Door')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 441,N'Monitor',N'SyncData',N'立即同步',N'立即同步',N'Sync Data')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 442,N'Monitor',N'SyncTime',N'立即校时',N'立即校時',N'Calibration Time')
INSERT [LabelText] ([RecordId],[PageFolder],[LabelId],[LabelZhcnText],[LabelZhtwText],[LabelEnText]) VALUES ( 443,N'Monitor',N'Controller',N'设备',N'設備',N'Controller')

SET IDENTITY_INSERT [LabelText] OFF
GO

--------------------------插入默認班次----------------------------------------
SET IDENTITY_INSERT [AttendanceOndutyRule] ON
INSERT [AttendanceOndutyRule] ([RuleId],[EmployeeDesc],[EmployeeCode],[OnDutyMode],[NoBrushCard],[Monday1],[Tuesday1],[Wednesday1],[Thursday1],[Friday1],[Saturday1],[Sunday1]) VALUES ( 1,'在職類型不等於離職','((left(IncumbencyStatus,1) not in(''1'')))','1-單周迴圈',0,'1-正常班','1-正常班','1-正常班','1-正常班','1-正常班','1-正常班','1-正常班')
SET IDENTITY_INSERT [AttendanceOndutyRule] OFF

SET IDENTITY_INSERT [AttendanceOnDutyRuleChange] ON
INSERT [AttendanceOnDutyRuleChange] ([ChangeId],[ChangeDate],[RuleId],[EmployeeDesc],[EmployeeCode],[OnDutyMode],[NoBrushCard],[Monday1],[Tuesday1],[Wednesday1],[Thursday1],[Friday1],[Saturday1],[Sunday1]) VALUES ( 1,'2011-05-01 0:00:00',1,'在職類型不等於離職','((left(IncumbencyStatus,1) not in(''1'')))','1-單周迴圈',0,'1-正常班','1-正常班','1-正常班','1-正常班','1-正常班','1-正常班','1-正常班')
SET IDENTITY_INSERT [AttendanceOnDutyRuleChange] OFF

SET IDENTITY_INSERT [AttendanceShifts] ON
INSERT [AttendanceShifts] ([ShiftId],[ShiftName],[StretchShift],[Degree],[Night],[FirstOnDuty],[ShiftTime],[AonDuty],[AonDutyStart],[AonDutyEnd],[AoffDuty],[AoffDutyStart],[AoffDutyEnd],[ArestTime],[AcalculateLate],[AcalculateEarly],[Overtime]) VALUES ( 1,'正常班',0,1,1,'0',8.00,'1900-01-01 9:00:00','1900-01-01 6:00:00','1900-01-01 13:29:59','1900-01-01 18:00:00','1900-01-01 13:30:00','1900-01-02 5:59:59',60,5,0,0)
SET IDENTITY_INSERT [AttendanceShifts] OFF

SET IDENTITY_INSERT [TempShifts] ON
INSERT [TempShifts] ([TempShiftID],[ShiftType],[ShiftId],[ShiftName],[StretchShift],[Degree],[Night],[FirstOnDuty],[ShiftTime],[AonDuty],[AonDutyStart],[AonDutyEnd],[AoffDuty],[AoffDutyStart],[AoffDutyEnd],[ArestTime],[Overtime]) VALUES ( 1,'0',1,'正常班',0,1,1,'0',8.00,'1900-01-01 9:00:00','1900-01-01 6:00:00','1900-01-01 13:29:59','1900-01-01 18:00:00','1900-01-01 13:30:00','1900-01-02 5:59:59',60,0)
SET IDENTITY_INSERT [TempShifts] OFF

--------------------------插入默認班次  結束----------------------------------------



------------------------分頁存儲過程-----------------------------------------------
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
---分頁存儲過程 
if exists (select name from sysObjects where name = 'pPagePROCTables'
			and type = 'p')
	drop Procedure pPagePROCTables
GO

Create   PROCEDURE pPagePROCTables
	--表名 單個表就寫表名就可以了
	--多個表關聯這樣寫：Users inner join UserRole on Users.UserID=UserRole.UserID
    @tblName      varchar(2000),
	--主鍵欄位名        
    @fldName      varchar(50),        
	--返回的列,*表示所有列,多表：表名.欄位名
    @listFldName      varchar(2000), 
	--排序的列名：
    @orderFldName      varchar(50),
	--排序列的類型：如int,varchar等等
    @orderFldType      varchar(50),  
	--每頁顯示的列數      
    @PageSize    int = 10,           
	--當前頁數
    @PageIndex    int = 1,              
	--排序類型0昇冪列，1降冪
    @OrderType    bit = 0,  
	--查詢的條件(不加where)            
    @strWhere    varchar(2000) = '',  
	--為配合JSON的寫法，顯示需要哪些欄位及欄位順序.若分佈後與其它表有關聯，則寫成TB.
	@strShowField    varchar(2000) = ''	,
	--分頁後再與其它表關聯。分頁後的資料集表名為TB,寫法：left join Controllers C on TB.Controllerid=C.Controllerid
	@strJoinTable    varchar(2000) = '' 
AS
declare @strSQL  nvarchar(3000)      -- 主語句  
declare @strTmp  varchar(2000)      -- 臨時變數  
declare @strOrder varchar(500)        -- 排序類型  
declare @strOrder2 varchar(500)      --  ; ;
declare @orderFldValue nvarchar(100)  --排序欄位對應的值    
declare @keyFldValue nvarchar(100)  --主鍵欄位對應的值 add  
declare @operator char(1) --add by caoy  
declare @tempValueSql varchar(500)  
declare @strOrderby varchar(5)  
declare @TotalRecord int
DECLARE @TotalPage int
        -- 記錄總數
	declare @countSql nvarchar(4000) 
	if(@strWhere!='') 
		set @countSql='SELECT @TotalRecord=Count(*) From '+@tblName+' where '+@strWhere
	else
		set @countSql='SELECT @TotalRecord=Count(*) From '+@tblName

	execute sp_executesql @countSql,N'@TotalRecord int out',@TotalRecord out
	--頁數
	SET @TotalPage=(@TotalRecord-1)/@PageSize+1

if (@orderFldType='float')  
    set @tempValueSql='cast(@orderFldValue as float)'  
else  
    set @tempValueSql='@orderFldValue'  

--獲取表明 。 
declare @tablename varchar(20)  
if charindex('.',@orderFldName)>1  
    set @tablename=left(@orderFldName,charindex('.',@orderFldName)-1) 
else   
    set @tablename=@orderFldName  
if @OrderType != 0   
begin  
    set @operator='<'  
    set @strOrderby=' desc'  
    set @strOrder2=' asc' 
end  
else  
begin  
    set @operator='>' 
    set @strOrderby=' asc'  
    set @strOrder2=' desc' 
end  
set @strOrder=' order by '+ @orderFldName+@strOrderby  
if @fldName!=@orderFldName  --如果排序欄位不是主鍵欄位，則增加主鍵排序  
    set @strOrder=@strOrder+','+@fldName+@strOrderby  
--先得到orderFldValue和keyValue 
set @strSQL='select top 1 @orderFldValue=convert(nvarchar(100),'+@orderFldName+',20)'  /**//***注意，如果需要排序的欄位的值長度超過Nvarchar(100)，請修改此處***********/  
if @fldName!=@orderFldName    
    set @strSQL=@strSQL+',@keyFldValue='+@fldName  
else  
    set @strSQL=@strSQL+',@keyFldValue=1'  
set @strSQL=@strSQL+' from (select top ' + str((@PageIndex-1)*@PageSize) + ' ' 
    + @orderFldName 
if @fldName!=@orderFldName  --add by caoy  
    set @strSQL=@strSQL+','+@fldName  
set @strSQL=@strSQL+ ' from ' + @tblName + ''  
if @strWhere != ''  
    set @strSQL=@strSQL+ ' where '+@strWhere 
set @strSQL=@strSQL+ @strOrder + ') as '+@tablename+' order by ' + @orderFldName +@strOrder2  
if @fldName!=@orderFldName  --add by caoy 
    set @strSQL=@strSQL+',' + @fldName +@strOrder2  
exec  sp_executesql @strSQL,N'@orderFldValue nvarchar(100) output,@keyFldValue nvarchar(100) output',@orderFldValue output,@keyFldValue output    /**//***注意，如果需要排序的欄位的值長度超過Nvarchar(100)，請修改此處***********/   
--得到排序欄位值和主鍵值結束  

if @PageIndex = 1  
begin  
    set @strTmp = ''  
    if @strWhere != ''  
        set @strTmp = ' where (' + @strWhere + ')'  

    set @strSQL = 'select top ' + str(@PageSize) + ' '+ @listFldName+' from '  
        + @tblName + '' + @strTmp + ' ' + @strOrder  

	--mike 
	if @strShowField != ''  
        set @strSQL = N'select ' + @strShowField + ' from ('+@strSQL+') TB '
	if @strJoinTable != ''  
        set @strSQL = @strSQL + @strJoinTable

    exec (@strSQL) 
	--print (@strSQL)
end  
else  
begin  
    --取得top資料並返回  
    set @strSQL = N'select top ' + str(@PageSize) +' ' +  @listFldName+' from ' 
        + @tblName + ' where ('+@orderFldName+@operator+@tempValueSql+' and @keyFldValue=@keyFldValue'  
    if @fldName!=@orderFldName 
        set @strSQL=@strSQL+ ' or ('+@orderFldName+'='+@tempValueSql+' and '+@fldName+@operator+'@keyFldValue)) and (1=1' 
 
    if @strWhere != ''  
        set @strSQL=@strSQL+' and ' + @strWhere  
    set @strSQL=@strSQL+ ')'+@strOrder 
        if @fldName=@orderFldName          
        set @keyFldValue=1  
    
	--set @strSQL = 'select TB.*,C.Location,D.DepartmentName from ('+@strSQL+') TB left join Controllers C on TB.Controllerid = C.ControllerId left Join Departments D on TB.DepartmentID=D.DepartmentID '
	--mike 
	if @strShowField != ''  
        set @strSQL = N'select ' + @strShowField + ' from ('+@strSQL+') TB '
	if @strJoinTable != ''  
        set @strSQL = @strSQL + @strJoinTable
exec sp_executesql @strSQL,N'@orderFldValue nvarchar(100),@keyFldValue nvarchar(100)',@orderFldValue,@keyFldValue
	--print (@strSQL)

end
SET QUOTED_IDENTIFIER OFF  
	
	-- 返回總記錄數和總頁數
	SELECT @TotalRecord as RecordCount,@TotalPage as TotalPage

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
/*
--------------------Create Procedure End--------------------------
*/


---------------------進出明細 ---------------
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysObjects where name = 'V_BrushCardACS'
			and type = 'v')
	drop View V_BrushCardACS
GO

Create View V_BrushCardACS
As
Select B.RecordID,E.Employeeid,E.DepartmentId,E.Card,E.Number,E.Name,E.sex,E.Marry,
	E.Knowledge,E.identityCard,E.BirthDate,E.Country,E.NativePlace,E.Address,
	E.Telephone,E.JoinDate,E.Position,E.Headship,E.IncumbencyStatus,E.Email,B.Controllerid,B.BrushTime,
	CONVERT(CHAR(10),B.Brushtime,108) as BrushTime2,B.Door,B.Property
	From  Employees E 
		Right join BrushCardAcs B on (E.Employeeid = B.Employeeid or (E.card=B.card and E.card>0))
		where Left(E.IncumbencyStatus,1) <>'1'
/*union 
Select B.RecordID,E.Employeeid,E.DepartmentId,E.Card,E.Number,E.Name,E.sex,E.Marry,
	E.Knowledge,E.identityCard,E.BirthDate,E.Country,E.NativePlace,E.Address,
	E.Telephone,E.JoinDate,E.Position,E.Headship,E.IncumbencyStatus,E.Email,B.Controllerid,B.BrushTime,
	CONVERT(CHAR(10),B.Brushtime,108) as BrushTime2,B.Door,B.Property
	From  Employees E 
		Right join BrushCardAcs B on ((E.card=B.card and E.card>0))
		where Left(E.IncumbencyStatus,1) <>'1'
*/
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--------------------End 進出明細--------------------------------


----------------------------非法進出
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysObjects where name = 'V_BrushCardACS_Illegal'
			and type = 'v')
	drop View V_BrushCardACS_Illegal
GO

Create View V_BrushCardACS_Illegal
As
Select B.RecordID,B.Employeeid,E.DepartmentId,B.Card,E.Number,E.Name,E.sex,E.Marry,
	E.Knowledge,E.identityCard,E.BirthDate,E.Country,E.NativePlace,E.Address,
	E.Telephone,E.JoinDate,E.Position,E.Headship,E.IncumbencyStatus,
	E.Email,B.Controllerid,B.BrushTime,
	CONVERT(CHAR(10),B.Brushtime,108) as BrushTime1,CONVERT(CHAR(10),B.Brushtime,108) as BrushTime2,B.Door,B.Property
	From  Employees E 
		right join BrushCardAcs B on (E.Employeeid = B.Employeeid  or (E.card=B.card and E.card>0))
	where B.property > 0
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
---------------------end  非法進出-------------------------


---------------------考勤原始刷卡明細 ---------------------
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysObjects where name = 'V_BrushCardAttend'
			and type = 'v')
	drop View V_BrushCardAttend
GO

Create View [V_BrushCardAttend]
As
Select B.RecordID,E.Employeeid,E.DepartmentId,E.Card,E.Number,E.Name,E.sex,E.Marry,
	E.Knowledge,E.identityCard,E.BirthDate,E.Country,E.NativePlace,E.Address,
	E.Telephone,E.JoinDate,E.Position,E.Headship,E.IncumbencyStatus,E.Email,B.Controllerid,B.BrushTime,
	CONVERT(CHAR(10),B.Brushtime,108) as BrushTime2,B.Door,B.Property
	From  Employees E 
		Right join BrushCardAttend B on (E.Employeeid = B.Employeeid or (E.card=B.card and E.card>0))
		where Left(E.IncumbencyStatus,1) <>'1'
/*union 
Select B.RecordID,E.Employeeid,E.DepartmentId,E.Card,E.Number,E.Name,E.sex,E.Marry,
	E.Knowledge,E.identityCard,E.BirthDate,E.Country,E.NativePlace,E.Address,
	E.Telephone,E.JoinDate,E.Position,E.Headship,E.IncumbencyStatus,E.Email,B.Controllerid,B.BrushTime,
	CONVERT(CHAR(10),B.Brushtime,108) as BrushTime2,B.Door,B.Property
	From  Employees E 
		Right join BrushCardAttend B on ((E.card=B.card and E.card>0))
		where Left(E.IncumbencyStatus,1) <>'1'
*/
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

--------------------End 考勤原始刷卡明細--------------------------------


---------------------按鈕事件進出明細 ---------------------
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
--------------------End 按鈕事件進出明細--------------------------------


----資料匯出存儲過程 
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

if exists (select name from sysObjects where name = 'pExprotBrushcardData' and type = 'p')
	drop Procedure pExprotBrushcardData
GO

create PROC [dbo].[pExprotBrushcardData]
( @BrushTimeStart VARCHAR(20),
  @BrushTimeEND VARCHAR(20),	
  @Controllerid VARCHAR(1000),	/*-1包含所有位置*/ 	
  @Status VARCHAR(100),			-- -1包含所有屬性
  @Conditon nvarchar(4000),
  @TableName VARCHAR(20)) --表名 BrushCardAcs或BrushCardAttend

AS
DECLARE @StrFind VARCHAR(1000)
DECLARE @StrSQL nvarchar(max)

SET NOCOUNT ON

SET @StrFind=''
IF @Controllerid>-1 
	SET @StrFind=' AND B.Controllerid='+@Controllerid
IF @Status<>''
	SET @strFind=@strFind+' AND '+@Status

IF object_id('tempdb.dbo.#BrushData') IS not null
	DROP TABLE #BrushData
IF object_id('tempdb.dbo.#Employees') IS not null
	DROP TABLE #Employees

CREATE TABLE #BrushData
( Recordid int,
	Employeeid BIGINT,
  Card		 BIGINT,
  ControllerId int,
  Brushtime1  VARCHAR(10),
  BrushTime2  VARCHAR(10),
  ControllerNumber    nvarchar(100),
  Location   VARCHAR(100),
  Property   VARCHAR(2))

EXEC( 'INSERT INTO #BrushData(Recordid,Employeeid,Card,ControllerId,Brushtime1,BrushTime2,ControllerNumber,Location,Property)
	SELECT B.Recordid,B.Employeeid,B.Card,B.ControllerId,
		CONVERT(CHAR(10),Brushtime,121) AS Brushtime,
		CONVERT(CHAR(10),Brushtime,108) as Brushtime1,
		C.ControllerNumber,
		C.Location+CASE B.Door 
			WHEN ''1''  THEN ''(''+ISNULL(LTRIM(C.DoorLocation1),'''')+ '',''+ISNULL(LTRIM(Right(C.CardReader1, 1)),'''') +'')'' 
			WHEN ''2'' THEN ''(''+CASE ISNULL(LTRIM(left(C.DoorType,1)),'''') 
								WHEN ''0'' THEN ISNULL(LTRIM(C.DoorLocation1),'''') 
								ELSE ISNULL(LTRIM(C.DoorLocation2),'''') 
								END +'',''+ISNULL(LTRIM(Right(C.CardReader2, 1)),'''') 
							+'')'' 
 		    ELSE '''' END 
		AS Location,
		B.Property
	FROM '+@TableName+' B LEFT JOIN Controllers C 
		ON C.ControllerId=B.ControllerId  
	WHERE B.Brushtime BETWEEN ''' +@BrushTimeStart +''' AND '''+ @BrushTimeEND+'''' +@strFind)

--建立員工臨時表
SET @StrSQL = 'SELECT Employeeid,D.DepartmentName,E.DepartmentID,Card,Number,Name,Sex,Marry,Knowledge,
	IdentityCard,BirthDate,Country,NativePlace,Address,Telephone,JoinDate,Position,Headship,IncumbencyStatus,Email
	INTO #Employees
	FROM Employees E,DepartMents D
	WHERE E.DepartmentID=D.DepartmentID
		AND (E.card IN (select card From #BrushData) or E.Employeeid IN (select Employeeid From #BrushData)) '

--查詢資料
--SET @StrSQL = @StrSQL + ';  SELECT B.recordid,B.EmployeeId,B.ControllerId,E.DepartmentName,E.Name,E.Number,B.Card,B.Brushtime1,B.BrushTime2,B.Location,B.Property
--FROM #BrushData B LEFT JOIN #Employees E
--ON 	(E.Employeeid = B.Employeeid  or (E.card=B.card and E.card>0)) ' +@Conditon

SET @StrSQL = @StrSQL + ';  Select DepartmentName,Name,Number,Card,ControllerNumber,Location,Brushtime1,Brushtime2,Property From  (SELECT E.DepartmentName,E.DepartmentID,Number,Name,Sex,Marry,Knowledge,
	IdentityCard,BirthDate,Country,NativePlace,Address,Telephone,JoinDate,Position,Headship,IncumbencyStatus,Email,B.recordid,B.EmployeeId,B.ControllerId,B.Card,B.Brushtime1,B.BrushTime2,B.ControllerNumber,B.Location,B.Property
FROM #BrushData B LEFT JOIN #Employees E
ON 	(E.Employeeid = B.Employeeid  or (E.card=B.card and E.card>0)) WHERE Left(E.IncumbencyStatus,1)<>''1'' ) AS T ' +@Conditon

EXEC(@StrSQL)

IF object_id('tempdb.dbo.#BrushData') IS not null
	DROP TABLE #BrushData
IF object_id('tempdb.dbo.#Employees') IS not null
	DROP TABLE #Employees
SET NOCOUNT OFF
GO

-------------------------------考勤原始刷卡行轉列存儲過程(僅支援SQL2005及以上資料庫)-----------------------
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
---考勤原始刷卡行轉列 
if exists (select name from sysObjects where name = 'pGetBrushCardRowToCol'
			and type = 'p')
	drop Procedure pGetBrushCardRowToCol
GO

Create   PROCEDURE pGetBrushCardRowToCol
	--開始日期
    @startTime		varchar(50),
	--截止日期        
    @endTime		varchar(50), 
	--顯示日期範圍所有行 1顯示所有行，0顯示僅有刷卡資料的行
    @showAllRow		bit = 1,         
	--查詢的條件(不加where)  如： Employeeid = 1 or card=123         
    @strWhere    nvarchar(max) = ''
AS
declare @strSQL  nvarchar(max)      -- 主語句  
declare @strTmp  nvarchar(max)    
declare @TotalRecord int
declare @TotalPage int
set @TotalPage = 0

IF object_id('tempdb.dbo.#temp') IS not null
	DROP TABLE #temp

 select A.Employeeid,A.card,A.BrushTime,A.door,A.Property,Convert(nvarchar(10),BrushTime,120) as BrushTime1,CONVERT(nvarchar(10),BrushTime,108) as BrushTime2,
			row_number() over (partition by Convert(nvarchar(10),BrushTime,120) order by BrushTime) as depth 
			into #temp from BrushCardAttend as A where 1!=1

--使用row_number()函數
set @strSQL = ' insert into #temp select A.Employeeid,A.card,A.BrushTime,A.door,A.Property,Convert(nvarchar(10),BrushTime,120) as BrushTime1,CONVERT(nvarchar(10),BrushTime,108) as BrushTime2,
			row_number() over (partition by Convert(nvarchar(10),BrushTime,120) order by BrushTime) as depth 
			from BrushCardAttend as A 
where A.BrushTime Between '''+@startTime+''' and '''+@endTime+''' and ' + @strWhere + ' order by BrushTime;  '
exec(@strSQL)

--行轉列，如果是非法卡資料，加上()標識 
declare @s nvarchar(max)
set @s=''
--Select @s=@s+','+quotename([depth])+'=max(case when [depth]='+quotename([depth],'''')+' then BrushTime2 else '''' end)'
Select @s=@s+'max(case when [depth]='+quotename([depth],'''')+' then (case when property=''0'' then BrushTime2 else ''(''+BrushTime2+'')'' end )else '''' end)'+'+''  ''+'
from #temp group by [depth] order by [depth]
Select @s=@s+''''''
set @strSQL = 'select BrushTime1, BrushTime2='+@s+' into #Ret from #temp group by BrushTime1 ; '
--返回列不能包含Employeeid,因為非法卡Employeeid為0
--set @strSQL = 'select Employeeid,BrushTime1, BrushTime2='+@s+' into #Ret from #temp group by Employeeid,BrushTime1 ; '


--是否顯示日期範圍內所有行
if @showAllRow = 1
begin 
	declare @i int,@totalDays int
	set @i=0
	set @totalDays=datediff(d,@startTime,@endTime) 
	set @strTmp = 'create table #Day(D1 nvarchar(10)); '
	while @i<=@totalDays
	begin
		set @strTmp = @strTmp + 'insert into #Day select '''+Convert(nvarchar(10),DATEADD(d,@i,Convert(datetime,@startTime) ),120) + '''; '
		set @i=@i+1
	end
	set @strSQL = @strSQL + @strTmp + ' select D.D1,R.BrushTime2 from #Day D left join #Ret R on D.D1=R.BrushTime1 order by D.D1; '
	set @TotalRecord = @totalDays+1 --總記錄數
	-- 返回總記錄數和總頁數
	set @strSQL = @strSQL + 'select '''+convert(nvarchar(10),@TotalRecord) + ''' as RecordCount,'''+convert(nvarchar(10),@TotalPage) + ''' as TotalPage  ;  '
	exec(@strSQL)
end 
else
begin
	set @strSQL = @strSQL + 'select * from #Ret R order by R.BrushTime1; '
	-- 返回總記錄數和總頁數
	set @strSQL = @strSQL + 'select Count(*) as RecordCount,'''+convert(nvarchar(10),@TotalPage) + ''' as TotalPage from #Ret R ;  '
	exec(@strSQL)
end
--print(@strSQL)

SET QUOTED_IDENTIFIER OFF  
	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
-----------------------------------------------------------------


--------------------------------------------匯出考勤原始刷卡(行轉列)-----------------------------------------------
---匯出考勤原始刷卡(行轉列) 
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysObjects where name = 'pExportBrushCardRowToCol'
			and type = 'p')
	drop Procedure pExportBrushCardRowToCol
GO

Create   PROCEDURE pExportBrushCardRowToCol
	--開始日期
    @startTime		varchar(50),
	--截止日期        
    @endTime		varchar(50), 
	--顯示日期範圍所有行 1顯示所有行，0顯示僅有刷卡資料的行
    @showAllRow		bit = 1,        
	--查詢的條件(加where)  如： where Employeeid = 1 or card=123         
    @strWhere    nvarchar(max) = ''
AS
DECLARE @strSQL  nvarchar(max)
DECLARE @EmployeeId int        
DECLARE @DepartmentName nvarchar(100)
DECLARE @Name nvarchar(50)
DECLARE @Number nvarchar(50)
DECLARE @Card bigint  
DECLARE @strTemp nvarchar(1000)

IF object_id('tempdb.dbo.#tempBrushCard') IS not null
	DROP TABLE #tempBrushCard

create table #tempBrushCard (
RecordID			int				identity,
DepartmentName      nvarchar(100)   null,
Name				nvarchar(50)	null,
Number				nvarchar(50)	null,
Card				bigint			null,
Brushtime1			nvarchar(10)	null,
Brushtime2			nvarchar(max)	null
)

if exists( select * from master.dbo.syscursors where cursor_name='My_Cursor')
	DEALLOCATE  My_Cursor 
     
set @strSQL='declare My_Cursor cursor for select E.EmployeeID,D.DepartmentName,E.Name,E.Number,E.Card from Employees E left join Departments D on E.DepartmentID = D.DepartmentID '
if @strWhere <> '' 
begin
	set @strSQL = @strSQL + ' ' + @strWhere
end 
exec sp_executesql  @strSQL
   
OPEN My_Cursor; --打開游標
FETCH NEXT FROM My_Cursor INTO @EmployeeId,@DepartmentName,@Name,@Number,@Card; --讀取第一行資料,並將值保存於變數中
WHILE @@FETCH_STATUS = 0
    BEGIN
    
    IF object_id('tempdb.dbo.#tempBrushCardSingle') IS not null
		DROP TABLE #tempBrushCardSingle
    Create table #tempBrushCardSingle (Brushtime1 nvarchar(10),Brushtime2 nvarchar(max))
    --調用pGetBrushCardRowToCol行轉列，並將資料集存儲於#tempBrushCard表中
	set @strTemp = ' ( Employeeid in ('''+convert(nvarchar(10),@EmployeeId)+''') or (Card in (select Card from Employees where Employeeid in ('''+convert(nvarchar(10),@EmployeeId)+''')) and property <> ''0'' ) ) ' 
	insert into #tempBrushCardSingle(Brushtime1,Brushtime2)
		exec dbo.pGetBrushCardRowToCol @startTime,@endTime,@showAllRow,@strTemp
		
	insert into #tempBrushCard(DepartmentName,Name,Number,Card,Brushtime1,Brushtime2)
		select @DepartmentName,@Name,@Number,@Card,Brushtime1,Brushtime2 
		from #tempBrushCardSingle where ISNULL(Brushtime2,'1')<>'0' --Brushtime2為0，表示存儲過程返回的第二個記錄集，這裡不取。

        FETCH NEXT FROM My_Cursor INTO @EmployeeId,@DepartmentName,@Name,@Number,@Card; --讀取下一行資料
    END
CLOSE My_Cursor; --關閉游標
DEALLOCATE My_Cursor; --釋放游標

Exec ('select DepartmentName,Name,Number,Card,Brushtime1,Brushtime2 from #tempBrushCard order by RecordID ')

IF object_id('tempdb.dbo.#tempBrushCard') IS not null
	DROP TABLE #tempBrushCard


SET QUOTED_IDENTIFIER OFF  
	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
---------------------------------------------------------------------------------------------------------
---------分頁存儲過程結束------------------




-----------------按單個範本註冊到設備--------------------
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

if exists (select name from sysObjects where name = 'pRegCardTemplateRegister' and type = 'p')
	drop Procedure pRegCardTemplateRegister
GO

create PROC [dbo].[pRegCardTemplateRegister]
( --範本Id
  @TemplateId VARCHAR(50),
  --註冊方式，0為追加註冊（不會產生重復資料，已註冊的卡號，不做任何修改）
  --1為覆蓋註冊（即先全部清空原註冊卡號，再註冊（注意：清空僅清空伺服器設備資料，不清空硬體上的資料））
  @RegMode		bit = 0,  
  --在範本的條件中篩選註冊人員條件；為空表示按範本的條件全部註冊. 格式：EmployeeID值. 如：select EmployeeId from Employes where Employeeid In (1,2,3)
  @WhereEmployee VARCHAR(2000) = '',     
 --在範本的條件中篩選設備；為空表示按範本的條件全部註冊	. 格式：同上
  @WhereControllerid VARCHAR(2000) = ''
)
AS
DECLARE @StrSQL nvarchar(max)
DECLARE @strEmController VARCHAR(1000)
DECLARE @strEmDesc VARCHAR(4000)
DECLARE @strEmCode VARCHAR(4000)
DECLARE @strEmployeeScheID VARCHAR(100)
DECLARE @strEmployeeDoor VARCHAR(100)
DECLARE @strValidateMode VARCHAR(100)

SET NOCOUNT ON
--從範本表獲取相關欄位
SELECT @strEmDesc=EmployeeDesc,@strEmCode=EmployeeCode,@strEmController=ISNULL(EmployeeController,''),
		@strEmployeeScheID=ISNULL(EmployeeScheID,''),@strEmployeeDoor=ISNULL(EmployeeDoor,''),@strValidateMode=ValidateMode
		FROM ControllerTemplates where TemplateType=4 and TemplateId=+@TemplateId

if ISNULL(@strEmCode,'')='' 
	Set @strEmCode = 'select EmployeeId from Employees where Left(IncumbencyStatus,1) != ''1'' '
IF @WhereEmployee <> '' 
	Set @strEmCode = @strEmCode + ' and EmployeeId IN (' + @WhereEmployee+') '

--獲取需要註冊的設備，並將設備ID保存於#TempConId中
IF object_id('tempdb.dbo.#TempConId') IS not null
	DROP TABLE #TempConId
Create Table #TempConId(ControllerId int null)
Set @StrSQL = 'INSERT #TempConId SELECT ControllerId  From Controllers '
IF left(@strEmController,1)='0'
	 Set @StrSQL = @StrSQL + ' where ControllerId > 0 '
Else
	Set @StrSQL = @StrSQL + ' where ControllerId in ('+@strEmController+') '

IF @WhereControllerid <> '' 
	Set @StrSQL = @StrSQL + ' and ControllerId in ('+@WhereControllerid+') '

Exec(@StrSQL)

----註冊時間表。當前時間表ID沒在設備時間表中，則找一個ScheduleCode最小且沒有未註冊的時間表的記錄來保存當前時間表ID
IF @strEmployeeScheID <> ''
BEGIN
	Set @StrSQL = 'update CS set TemplateId='+@strEmployeeScheID+',TemplateName=(select top 1 TemplateName from ControllerTemplates where TemplateId='+@strEmployeeScheID+' ),Status=0 From ControllerSchedule CS 
					where CS.ScheduleCode=(select MIN(ScheduleCode) From ControllerSchedule CS2 
								where CS.Controllerid=CS2.Controllerid and (ISNULL(CS2.TemplateId,0)=0 or ISNULL(CS2.TemplateId,'''')='''')  ) 
						and CS.Controllerid in (Select Controllerid from #TempConId ) 
						and CS.ControllerId NOT IN(select Controllerid from ControllerSchedule where TemplateId='+@strEmployeeScheID+' ) ' 
End
EXEC(@StrSQL)

--覆蓋註冊，先刪除，再註冊
if @RegMode=1 
Begin
	Set @StrSQL = 'delete from ControllerEmployee where ControllerId in (select ControllerId from #TempConId) 
					and EmployeeId in (select EmployeeId from ('+@strEmCode+') A ); '
	Set @StrSQL = @StrSQL+'insert into ControllerEmployee(ControllerId,Employeeid,UserPassword,ScheduleCode,EmployeeDoor,DeleteFlag,Status, ValidateMode) 
					select C.ControllerId, Emp.Employeeid, U.Userpassword,'''+@strEmployeeScheID+''','''+@strEmployeeDoor+''',0,0, '''+@strValidateMode+''' 
					from Controllers C,Employees Emp left join Users U on  Emp.Employeeid=U.Employeeid 
					where  Emp.EmployeeId in (select EmployeeId from ('+@strEmCode+') A ) and Left(Emp.IncumbencyStatus,1)!=''1'' and Emp.Card>0 
					and C.ControllerID in (select ControllerId from #TempConId) 
					and NOT EXISTS(SELECT 1 FROM ControllerEmployee AS CE 
						WHERE CE.Employeeid=Emp.Employeeid and CE.Controllerid = C.Controllerid 
						and CE.ControllerID in (select ControllerId from #TempConId) ) '
	Exec(@StrSQL)	
End
Else
Begin
	Set @StrSQL = 'insert into ControllerEmployee(ControllerId,Employeeid,UserPassword,ScheduleCode,EmployeeDoor,DeleteFlag,Status, ValidateMode) 
					select C.ControllerId, Emp.Employeeid, U.Userpassword,'''+@strEmployeeScheID+''','''+@strEmployeeDoor+''',0,0, '''+@strValidateMode+''' 
					from Controllers C,Employees Emp left join Users U on  Emp.Employeeid=U.Employeeid 
					where  Emp.EmployeeId in (select EmployeeId from ('+@strEmCode+') A ) and Left(Emp.IncumbencyStatus,1)!=''1'' and Emp.Card>0 
					and C.ControllerID in (select ControllerId from #TempConId) 
					and NOT EXISTS(SELECT 1 FROM ControllerEmployee AS CE 
						WHERE CE.Employeeid=Emp.Employeeid and CE.Controllerid = C.Controllerid 
						and CE.ControllerID in (select ControllerId from #TempConId) ) '
	Exec(@StrSQL)	
End

UPDATE ControllerDataSync set SyncStatus=0 where Controllerid in (select ControllerId from #TempConId) and SyncType='register'

SET NOCOUNT OFF
GO


------------所有範本註冊到設備
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

if exists (select name from sysObjects where name = 'pRegCardTemplateRegisterAll' and type = 'p')
	drop Procedure pRegCardTemplateRegisterAll
GO

create PROC [dbo].[pRegCardTemplateRegisterAll]
( 
 /*注意：執行註冊時，範本ID從大到小排序，即先註冊最大ID範本　*/

  --註冊方式，0為追加註冊（不會產生重復資料，已註冊的卡號，不做任何修改）
  --1為覆蓋註冊（即先全部清空原註冊卡號，再註冊（注意：清空僅清空伺服器設備資料，不清空硬體上的資料））
  @RegMode		bit = 0,  
  --在範本的條件中篩選註冊人員條件；為空表示按範本的條件全部註冊. 格式：EmployeeID值. 如：select EmployeeId from Employes where Employeeid In (1,2,3)
  @WhereEmployee VARCHAR(2000) = '',     
 --在範本的條件中篩選設備；為空表示按範本的條件全部註冊	. 格式：同上
  @WhereControllerid VARCHAR(2000) = ''
)
AS
DECLARE @StrSQL NVARCHAR(2000)
DECLARE @TemplateId VARCHAR(50)

SET NOCOUNT ON

	if exists( select * from master.dbo.syscursors where cursor_name='RegCursor')
		DEALLOCATE  RegCursor 
	     
	set @strSQL='declare RegCursor cursor for select TemplateId from ControllerTemplates where TemplateType=4 order by TemplateId Desc '
	exec sp_executesql  @strSQL
	   
	OPEN RegCursor; --打開游標
	FETCH NEXT FROM RegCursor INTO @TemplateId; --讀取第一行資料,並將值保存於變數中
	WHILE @@FETCH_STATUS = 0
		BEGIN
			exec pRegCardTemplateRegister @TemplateId,@RegMode,@WhereEmployee,@WhereControllerid

			FETCH NEXT FROM RegCursor INTO @TemplateId; --讀取下一行資料
		END
	CLOSE RegCursor; --關閉游標
	DEALLOCATE RegCursor; --釋放游標
	
SET NOCOUNT OFF
GO


------------匯出考勤卡存儲過程
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

if exists (select name from sysObjects where name = 'pExportAttendCard' and type = 'p')
	drop Procedure pExportAttendCard
GO


CREATE   PROCEDURE [pExportAttendCard]
	--日期 格式:'2015-04-01' and '2015-04-30'  
    @strDate		varchar(100),
	--統計月份  格式:'2015-04'      
    @strAttendMonth		varchar(50), 
  
	--查詢的條件(加where)  如： where Employeeid = 1 or card=123         
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
   
OPEN My_Cursor_Card; --打開游標
FETCH NEXT FROM My_Cursor_Card INTO @EmployeeId,@DepartmentName,@Name,@Number,@Card; --讀取第一行資料,並將值保存於變數中
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

        FETCH NEXT FROM My_Cursor_Card INTO @EmployeeId,@DepartmentName,@Name,@Number,@Card; --讀取下一行資料
    END
CLOSE My_Cursor_Card; --關閉游標
DEALLOCATE My_Cursor_Card; --釋放游標

Exec ('select * from #tempAttendCard order by RecordID ')

IF object_id('tempdb.dbo.#tempAttendCard') IS not null
	DROP TABLE #tempAttendCard


SET QUOTED_IDENTIFIER OFF  
	
	
	
--------------------考勤統計------------------------------------------------

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
--處理班次規則
--按最新的處理方式處理班次規則。班次規則的處理將直接以attendanceondutyrulechange表的先後來處理。
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
		--要用全域的臨時表代替下面語句中的子查詢
--		select @fchagedate=min(t.changedate) from (select top @trulecount * from AttendanceOndutyRulechange where ruleid=@Sourceruleid and changedate<=@enddate order by changedate desc) t

		If OBJECT_ID('Tempdb..##TempRule') is not null drop table ##TempRule
		set @RuleSql='select top '+ cast(@trulecount as varchar(20)) +' * into ##temprule from AttendanceOndutyRulechange where ruleid='+cast(@Sourceruleid as varchar(20)) +' and convert(char,changedate,120)<='''+ convert(char,@enddate,120) +''' order by changedate desc'
		exec (@RuleSql)
		select @fchangedate=min(changedate) from ##temprule
		If OBJECT_ID('Tempdb..##Temprule') is not null drop table ##Temprule
		*/
		--修改因全域臨時表，在多用戶統計時，相互刪除的問題。
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

--處理班次變動
set @strsql=''
declare @TCount int,
	@Shiftid int,
	@SCount int,
	@SShiftid int 
declare @adjustdate datetime
--修改。因全域臨時表在多用戶同時統計時存在相互刪除的問題
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
--處理臨時班次（注：如同班次同一天有多條臨時班次，以後面的蓋掉前面的。）
--候改內容:按臨時班次表裡設定的條件，滿足條件的員工的當天的班次，改為臨時表裡的班次。
--	   但如果是節假日的話。在調整完後，將用節假日再覆蓋掉原來的班次。

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
--處理新入職員工的排班。
delete attendancedetail from employees a where a.employeeid=attendancedetail.employeeid and attendancedetail.ondutydate <a.joindate
delete #attendancedetail from employees a where a.employeeid=#attendancedetail.employeeid and #attendancedetail.ondutydate <a.joindate
--處理離職員工的排班問題。
set @strsqlset=''

Select @strSqlset = @strSqlset + fieldname+'=Null,'  from tablestructure where tableid in (select tableid from tables where tablename='attendanceshifts') and fieldname<>'shiftid'
if len(@strsqlset)>1 set @strsqlset=substring(@strsqlset,1,len(@strsqlset)-1)

---20150412 by mike 處理離職員工,從Employees表判斷
--exec ('update #attendancedetail set '+@strsqlset + ' from EmployeeDimission a where a.employeeid=#attendancedetail.employeeid and ondutydate>a.dimissiondate and (left(a. status,1)=''2'' or left(a.status,1)=''7'') and left(a.nextstep,1)=''E''')
exec ('update #attendancedetail set '+@strsqlset + ' from Employees a where a.employeeid=#attendancedetail.employeeid and left(a.IncumbencyStatus,1)=''1'' and (ondutydate>a.dimissiondate) ')

update #AttendanceDetail set ondutytype='0-平常' where shiftid is not null
update #AttendanceDetail set ondutytype='0-平常' where shiftid=0 and shiftname is not null--規則中排了0-休息的初始班次名為'休息。'
update #AttendanceDetail set ondutytype='1-休息' where shiftid=0 and shiftname is null--規則中排了0-休息的初始班次名為'休息。'

update #AttendanceDetail set ondutytype='0-平常' from attendanceholiday b where #AttendanceDetail.ondutydate=b.transposaldate  and #AttendanceDetail.templateid=b.templateid
update #AttendanceDetail set ondutytype='2-假日' from attendanceholiday b where #AttendanceDetail.ondutydate=b.HolidayDate and left(#AttendanceDetail.ondutytype,1)<>'1' and #AttendanceDetail.templateid=b.templateid
update #attendancedetail set ShiftId=null,ShiftName=null,StretchShift=null,ShiftTime=null,Degree=null,Night=null,AonDuty=null,AonDutyStart=null,AonDutyEnd=null,AoffDuty=null,AoffDutyStart=null,ArestTime=null,BonDuty=null,BonDutyEnd=null,BoffDuty=null,BoffDutyEnd=null,BrestTime=null,ConDuty=null,ConDutyEnd=null,CoffDuty=null,CrestTime=null,FirstOnDuty=null,AoffDutyEnd=null,BonDutyStart=null,BoffDutyStart=null,ConDutyStart=null,CoffDutyStart=null,CoffDutyEnd=null  where left(ondutytype,1)='2'
update #attendancedetail set ShiftName=null,StretchShift=null,ShiftTime=null,Degree=null,Night=null,AonDuty=null,AonDutyStart=null,AonDutyEnd=null,AoffDuty=null,AoffDutyStart=null,ArestTime=null,BonDuty=null,BonDutyEnd=null,BoffDuty=null,BoffDutyEnd=null,BrestTime=null,ConDuty=null,ConDutyEnd=null,CoffDuty=null,CrestTime=null,FirstOnDuty=null,AoffDutyEnd=null,BonDutyStart=null,BoffDutyStart=null,ConDutyStart=null,CoffDutyStart=null,CoffDutyEnd=null where left(ondutytype,1)='1'

update #AttendanceDetail set shiftname='休息' where shiftid=0 and shiftname is null--規則中排了0-休息的初始班次名為'休息。'
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

--如果brushcardattend\brushcardacs表中的employeeid為0時，則從employees表中找回ID
Update brushcardattend set employeeid =employees.employeeid from employees where brushcardattend.employeeid=0 and brushcardattend.card=employees.card and employees.IncumbencyStatus<>'1'
Update brushcardacs set employeeid =employees.employeeid from employees where brushcardacs.employeeid=0 and brushcardacs.card=employees.card and employees.IncumbencyStatus<>'1'

Update #attendancedetail set signinflag ='000000'--初始化補卡標誌

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
		--分析非彈性班次刷卡
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

		--分析彈性班次！
                --演算法及約定：
                --彈性班次僅有一個時段。
                --第一次上班:大於等於起始時間 (第一次上下班) AND 小於截止下班(第一次上下班)中的第一筆。
                --如果僅有一次刷卡，那麼取兩標準時間的中點大於中點即為下班卡，否則為上班卡。
                --IF OBJECT_ID('tempdb..#BrushCardAttend') IS NOT NULL DROP TABLE #BrushCardAttend
                --SELECT EmployeeID,BrushTime INTO #BrushCardAttend FROM BrushcardAttend WHERE  EmployeeID IN(SELECT DISTINCT EmployeeID FROM #AttendanceDetail) AND BrushTime BETWEEN @SmallDate  AND @LargeDate 

		--TRUNCATE TABLE #BrushCardAttend
                --INSERT INTO #BrushCardAttend  SELECT EmployeeID,BrushTime FROM BrushcardAttend WHERE  EmployeeID IN(SELECT DISTINCT EmployeeID FROM #AttendanceDetail) AND BrushTime BETWEEN @SmallDate  AND @LargeDate 

--		取上下班卡中點前的刷卡數據
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
		--如果沒有上班卡資料,取上下班卡之間的刷卡資料
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
                /*取下班卡演算法及約定：
                '彈性班次僅有一個時段。
                '第一次下班班:大於等於起始時間  AND 小於截止下班中的最後筆。
                '如果僅有一次刷卡，那麼取兩標準時間的中點大於中點即為下班卡，否則為上班卡。
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

                --如果只有一筆上下班卡,則取為相應的上班或下班卡               
                Update #Attendancedetail set Onduty1=Null 
                			 Where Onduty1=Offduty1 and onduty1 is not null AND datediff(mi,dateadd(d,DATEDIFF(d,0,OnDutyDate),AOnDuty),Offduty1)> datediff(mi,AOnDuty,AOffDuty)/2
				
                Update #Attendancedetail set Offduty1=Null
               				 Where Onduty1=Offduty1 and onduty1 is not null AND datediff(mi,dateadd(d,DATEDIFF(d,0,OnDutyDate),AOnDuty),Offduty1)<= datediff(mi,AOnDuty,AOffDuty)/2
                
                IF OBJECT_ID('tempdb..#BrushCardAttend') IS NOT NULL DROP TABLE #BrushCardAttend
		Set @Nowdate=dateadd(dd,1,@nowdate)
	End

IF OBJECT_ID('tempdb..#Tbrush') IS NOT NULL DROP TABLE #Tbrush

--分析補簽卡

--分析非彈性班次補簽卡
IF OBJECT_ID('tempdb..#SigninCard') IS NOT NULL DROP TABLE #SigninCard
Select Employeeid,Brushtime into #SigninCard from attendancesignin where left(status,1)='2' and left(nextstep,1)='E' and brushtime between @StartDate and dateadd(dd,1,@EndDate)
/*
1,已存在的臨時表，刪除再創建在同一過程中存在問題。
2,已存在的臨時表，在同一個批次處理中，做過任何操作後，增加欄位，是無效的，不能訪問增加的欄位。
3,在同一個批次處理中，創建臨時表，作過任何操作後，即使刪除原有的操作，立即向其增加欄位，也是無效的，不能訪問。
4,解決方法，在同一個過程中，創建不同名的臨時表，不重複創建與刪除同一個臨時表。
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
		'分析彈性班次補簽卡
		'說明
		'如果僅有一次簽卡，那麼取兩標準時間的中點大於中點即為簽下班卡，否則為簽上班卡。
		*/
		IF OBJECT_ID('tempdb..#TSignin1') IS NOT NULL DROP TABLE #Tsignin1
		CREATE TABLE #TSignin1(EmployeeID INT,BrushCount int,BrushTime DATETIME)--BrushCount用於判斷條件。
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
--@strTotalType 取值為1表示手動統計，取值2為自動統計，取值3為統計當日
--@blnDimission=1是否僅統計本月離職員工。

--統計時間由調用者輸入！
--每次統計都是統計所有的員工！
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

if @strtotaltype='2' or @strtotaltype='3'	--取得自動統計與當日統計的@strmonth值。
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

		if @strTotalType='2' --自動統計
			begin
				select @startdate=@sdate,@enddate=@edate
				if @enddate>getdate()
					set @enddate=convert(varchar(20),getdate(),120)
			end	
	end


select @startdate=cast( convert(varchar(10),@Startdate,120)as datetime),@EndDate=cast(convert(varchar(10),@EndDate,120) as datetime)--初始化統計日期
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
	--20150412 mike Templateid的值為0
	--INSERT INTO #AttendanceDetail (Employeeid,OndutyDate,Templateid) SELECT Employees.Employeeid,a.Adate,Employees.Templateid FROM  Employees,#Tempdatetable a,EmployeeDimission b WHERE Employees.IncumbencyStatus='1' and employees.employeeid=b.employeeid and b.dimissiondate between @startdate and @enddate
		INSERT INTO #AttendanceDetail (Employeeid,OndutyDate,Templateid) SELECT Employees.Employeeid,a.Adate,0 FROM  Employees,#Tempdatetable a WHERE Employees.IncumbencyStatus='1' and employees.dimissiondate between @startdate and @enddate
	End
Else
	Begin
	--INSERT INTO #AttendanceDetail (Employeeid,OndutyDate,Templateid) SELECT Employees.Employeeid,a.Adate,Employees.Templateid FROM  Employees,#Tempdatetable a
		INSERT INTO #AttendanceDetail (Employeeid,OndutyDate,Templateid) SELECT Employees.Employeeid,a.Adate,0 FROM  Employees,#Tempdatetable a
	End
IF OBJECT_ID('tempdb..#Tempdatetable') IS NOT NULL DROP TABLE #Tempdatetable


--自動排班
exec pAutoShifts @Startdate,@EndDate
-- select * from #attendancedetail where nobrushcard=1 and employeeid=2
-- select * from brushcardattend where employeeid=2
--分析刷卡
exec pAnalyseBrushAndSign @startdate,@enddate
--select * from #AttendanceDetail order by EmployeeId,OnDutyDate
--分析請假
--exec pAnalyseAskforleave @startdate,@enddate

/*
	    '請假時間以天計！
	    'strSkipHoliday內容格式為：“假期名+判斷位，假期名+判斷位，假期名+判斷位，。。。。。”
	    
	'    LactationLeave  Holiday     哺乳假
	'    PublicHoliday   Holiday     法定假
	'    PeriodLeave Holiday     女性假
	'    CompensatoryLeave   Holiday     補假
	'    VisitLeave  Holiday     探親假
	'    OnTrip  NULL        出差
	'    FuneralLeave    Holiday     喪假
	'    PersonalLeave   Holiday     事假
	'    MaternityLeave  Holiday     產假
	'    AnnualVacation  Holiday     年假
	'    InjuryLeave Holiday     工傷
	'    SickLeave   Holiday     病假
	'    WeddingLeave    Holiday     婚假
*/
-- 	    Dim rsAskForLeave
-- 	    Dim rsOptions
Declare @strSkipHoliday nvarchar(4000)

select @strSkipHoliday= case when variablevalue is null or variablevalue='' then '' else variablevalue end  from options where variablename='strSkipHoliday'
Set @strSkipHoliday=isnull(@strSkipHoliday,'')
-- '整天請假
-- '整天請假時，StartTime與EndTime中只有日期沒有時間的。 類似於2015-04-01 00:00:00
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


-- '非整天請假
-- '補請假跨過時間點的標準時間。
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


--'處理整段時間請假，置整段請假的刷卡點為相應的假期
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


-- '超時加班參數。
-- Dim AheadOnDuty
-- Dim delayOffDuty
-- Dim AllTime
-- Dim BaseNumber
-- Dim i
Declare @NowDate datetime
Declare @SmallDate datetime,
	@LargeDate datetime

-- '審批加班處理！
-- 
-- '非整天加班。整天0-休息加班
-- '取刷卡資料為開始與結束時間前後30分鐘到開始與結束時間中間點。
-- '跨零點加班，計為開始時間所在的那天的加班時間。

IF OBJECT_ID('tempdb..#t') IS NOT NULL DROP TABLE #t
CREATE TABLE #t(EmployeeID INT,BrushTime DATETIME)

--'用加班表產生一個非整天加班臨時表。增加上班刷卡，下班刷卡，加班時間三欄位。
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
		--'過夜班次取值向前向後各廷伸一天。
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
		
		--'加班補卡
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

--修改內容：1，節假日，休息日上班，必須在加班處申請。
--	   2，休息日，節假日的加班，在attendancetotal表中體現，且匯總為worktime_1,worktime_2，以分鐘,在attendancedetail 中匯總入worktime
--         3，休息日，節假日申請的加班不需要打卡，申請多少計算為多少。
--	   4，不再存在應補休假。
--	   5，匯總表中，不再有休息日遲到早退時間，遲到早退異常次數，出勤，超時加班。
Update #Attendancedetail set ottime=b.ottime
                 From (select employeeid,convert(char,starttime,110) as starttime,sum(ottime) as ottime from #OverTime b group by employeeid,convert(char,starttime,110)) b where b.employeeid=#attendancedetail.employeeid and datediff(dd,#attendancedetail.ondutydate,b.starttime)=0 and left(#attendancedetail.ondutytype,1)='0'

-- update #overtime set ottime=datediff(mi,starttime,endtime) from #attendancedetail a 
-- 	where a.employeeid=#overtime.employeeid and (left(a.ondutytype,1)='1' or left(a.ondutytype,1)='2') and datediff(dd,a.ondutydate,#overtime.starttime)=0
Update #Attendancedetail set worktimeholiday=c.ottime
                 From (select employeeid,convert(char,starttime,110) as starttime,sum(ottime) as ottime from #OverTime b group by employeeid,convert(char,starttime,110)) c where c.employeeid=#attendancedetail.employeeid and datediff(dd,#attendancedetail.ondutydate,c.starttime)=0 and (left(#attendancedetail.ondutytype,1)='1' or left(#attendancedetail.ondutytype,1)='2')

-- '整天加班的計算放在計算出勤後來處理！
-- '整日加班的申請中，如果跨過'1-休息'的工作日，則自動為上不過夜的彈性班次:從當日：00：00：01至23:29:59止。
-- '超時加班處理!
-- '超時算加班，是針對第一次時間的上班，與最後一次上
Declare @strLate varchar(100)
Declare @blnLate bit                --'計算遲到包含該時間？
Declare @intLate int                --'遲到範圍
Declare @strLeaveEarly varchar(100)
Declare @blnLeaveEarly int           --'計算早退包含該時間？
Declare @intLeaveEarly int           --'早退範圍

Declare @strAbnormity varchar(100)			--'異常是否記曠工,1表示記為曠工,0表示不記
--Declare @strSkipHoliday nvarchar(4000)


Declare @strOverTime varchar(100)
Declare @blnBefor bit                --'提前計加班否
Declare @blnAfter bit                --'延後計加班否
Declare @blnFull bit                 --'提前或延後所有時間計加班
Declare @intBase int                 --'加班時間基數


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

--'計算非彈性班次中的遲到早退.
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
'    strOTType   超時加班    如：1,1,1,0,30  表示提前及延時工作均算加班，加班方式為：按提前或延後的所有工時計為加班
'    超時加班功能：可以根據超時加班的設定，將"開始刷卡至標準"或"標準至截卡刷卡"之間的上班時間計為加班時間
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
							
--分析超時加班與申請加班之間有無衝突(即超時加班的刷卡是否跨申請加班，跨就是衝突了)有衝突，則以審請的為准，否則。兩者都算。

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
--   '計算各假期及出差時間
--'整天請假,請假為1（以天來計算）
--'整天請假時，StartTime與EndTime中只有日期沒有時間的。 類似於2015-04-01 00:00:00

Declare @Fieldname varchar(100),
	@AskforleaveName nvarchar(200)
Declare @intworktime numeric(18,2)
select @intworktime=isnull(variablevalue,8) from options where variablename='intworktime'
set @intworktime=isnull(@intworktime,8)

--計算工時：標準時間至標準時間-請假時間-遲到時間-早退時間
--修改內容: 工時的計算，原來一時段內有兩種類型的請假時，工時僅減去了其中一種類型的時間。
--	    將工時的計算中的減遲到早退中間休息，提到請假處理過程外提次處理。其它的在請假處理過程內，有什麼請假即減什麼請假。
Update #Attendancedetail Set workTime1= datediff(mi,Ondutydate+AOnduty,Ondutydate+AOffduty)-Isnull(Latetime1,0)-Isnull(LeaveearlyTime1,0)-isnull(ArestTime,0) 
             Where degree>=1 and Onduty1 is not null and Offduty1 is not null 
            
Update #Attendancedetail Set WorkTime2=  Datediff(mi,Ondutydate+Bonduty,Ondutydate+BOffduty)-IsNull(LateTime2,0)-IsNull(LeaveEarlytime2,0) -isnull(brestTime,0) 
             Where Degree>=2 and Onduty2 is Not null and OffDuty2 is Not null 
            
Update #Attendancedetail Set WorkTime3= Datediff(mi,Ondutydate+cOnduty,Ondutydate+COffduty)-Isnull(LateTime3,0)-Isnull(LeaveEarlytime3,0)-isnull(crestTime,0)  
             Where Degree>=3 and Onduty3 is not null and offduty3 is not null 

--免卡時，加入按班次的標準時間計算工時
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
 
	--         '非整天請假.
	--         '整段請假，如果班次中有休息則請假時間應減去休息。非整段不減休息時間。
	-- '？？？注意，非整天請假在計算上班時間時要減去。

	--	修改內容：用臨時表，處理同一時段申請多段請假，只能計算出其中一段請假時間的問題
		if object_id('tempdb..#askforleave') is not null drop table #askforleave
		create table #askforleave (employeeid int,ondutydate datetime,leave1 int default 0,leave2 int default 0,leave3 int default 0)
--		分拆sql語句，提高效率
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


		--修改內容: 工時的計算，原來一時段內有兩種類型的請假時，工時僅減去了其中一種類型的時間。
		--	    將工時的計算中的減遲到早退中間休息，提到請假處理過程外提次處理。其它的在請假處理過程內，有什麼請假即減什麼請假。		
	         Exec ('Update #Attendancedetail set '+@Fieldname+'= (isnull(t.leave1,0)+isnull(t.leave2,0)+isnull(t.leave3,0)) / 60.0/shifttime ,
				worktime1=worktime1-t.leave1,worktime2=worktime2-t.leave2,worktime3=worktime3-t.leave3
			     From (select employeeid,ondutydate,sum(isnull(leave1,0)) as Leave1,sum(isnull(leave2,0)) as Leave2,sum(isnull(leave3,0)) as Leave3 from #askforleave group by employeeid,ondutydate) t
	                     Where #attendancedetail.employeeid=t.employeeid and #attendancedetail.ondutydate=t.ondutydate')
		
		--修改內容：1，休息日，節假日不會有排班，但可以申請非整天的請假以及出差。
		--	   2，由於沒有班次，一天的基本工時在選項中設置。
		--  	   3，跨天非整天請假，出差，算作是申請開始時間所在天的請假或出差。
		--         4,非整天請假出差不能跨24小時。
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
-- 	--             '計算工時：標準時間至標準時間-請假時間-遲到時間-早退時間
-- 	--             '如果同一時段存在兩種請假？暫不考慮！WokeTime1>0
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

-- 	        --按標準算時，一天不以班次中的工時為准，而是以標準時間之和減中間休息為准。
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

-- '無請假時的工時
-- '一個時段時，彈性班次上班多少時間計多少時間！
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

--將正常班次調整為休息時。shifttime將為0，會導致除以0錯誤。
UpDate #attendancedetail set shifttime=null where Shifttime=0

if @blnAnalyseWorkDay=1 
	Update #attendancedetail set Workday =isnull(WorkTime,0)/60.00/isnull(ShiftTime,8) --'加入的彈性班次要設定shifttime
else
	Update #attendancedetail set Workday =
		(isnull(WorkTime1,0)+case when isnull(worktime1,0)>0 then isnull(latetime1,0)+isnull(leaveearlytime1,0) else 0 end 
		 +isnull(Worktime2,0)+case when isnull(worktime2,0)>0 then isnull(latetime2,0)+isnull(leaveearlytime2,0) else 0 end 
		 +isnull(Worktime3,0)+case when isnull(worktime3,0)>0 then isnull(latetime3,0)+isnull(leaveearlytime3,0) else 0 end )
		/60.00/isnull(ShiftTime,8) 

--select * from #attendancedetail where nobrushcard=1 and employeeid=2

--'處理上班性質
Update #Attendancedetail set Result1= case when latetime1>0 then '遲到' else result1 end, 
				  Result2= case when LeaveEarlytime1>0 then '早退' else Result2 end, 
				  Result3= case when Latetime2>0 then '遲到' else Result3 end, 
				  Result4= case when LeaveEarlyTime2>0 then '早退' else Result4 end, 
				  Result5= case when latetime3>0 then '遲到' else Result5 end, 
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
			--'異常算曠工中，其中有遲到早退不計遲到早退。
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
if @strTotalType='3'--當日統計
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
--假日沒上班不記曠工。
Update #attendancedetail set absent=0 where left(ondutytype,1)='2'

--	'沒有歷史表,每次的資料得保存,統計時有重複的就用最新統計的覆蓋,不是重複的則增加!
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

--    '匯總考勤
if @strTotalType='3'--當日統計
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
-- 		if @strmonth=''--從週期中取得統計月份
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
--直接修改已存在的資料語法存在問題。先刪除再插入的方式也不行。借助臨時表
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
-- 		if right(@strmonth,2)='01' --and (@strtotaltype='1' or @strtotaltype='2') 當第一次統計為一年的第一個月時，計算上年剩餘年假
-- 			begin
-- 				Declare @blnContinueNext bit
-- 				select @blnContinueNext=cast(variablevalue as bit) from options where variablename='blnContinueNext'
-- 				if @blncontinuenext=1 --可延續。
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


GO
-----插入使用者預設資料 --------------------------------
SET IDENTITY_INSERT [Departments] ON
INSERT [Departments] ([DepartmentID],[DepartmentCode],[DepartmentName],[ParentDepartmentID]) VALUES ( 1,'00001','Admin Dept.',0)
SET IDENTITY_INSERT [Departments]  OFF
GO

SET IDENTITY_INSERT [Employees] ON
INSERT [Employees] ([EmployeeId],[DepartmentID],[Card],[Number],[Name],[Sex],[Knowledge],[BirthDate],[Country],[NativePlace],[JoinDate],[Position],[Headship],[IncumbencyStatus]) VALUES ( 1,1,1234,'U001','user1','男','碩士','1900-01-01','中國','北京市','2014-11-10','行政經理','主管','0-在職')
INSERT [Employees] ([EmployeeId],[DepartmentID],[Card],[Number],[Name],[Sex],[Knowledge],[BirthDate],[Country],[NativePlace],[JoinDate],[Position],[Headship],[IncumbencyStatus]) VALUES ( 2,1,1235,'U002','user2','女','碩士','1900-01-01','中國','北京市','2014-11-10','行政經理','主管','0-在職')
SET IDENTITY_INSERT [Employees]  OFF
GO

UPDATE Users SET EmployeeId=(Select Top 1 EmployeeId From Employees where left(IncumbencyStatus,1) <> '1' Order by EmployeeID) where UserID=1
GO

SET IDENTITY_INSERT [Controllers] ON
INSERT [Controllers] ([ControllerId],[ControllerNumber],[ControllerName],[Location],[IP],[MASK],[GateWay],[EnableDHCP],[ServerIP],[WorkType],[StorageMode],[IsFingerprint],[AntiPassBackType],[DoorType],[CardReader1],[CardReader2],[SystemPassword],[DataUpdateTime],[WaitTime],[CloseLightTime],[Sound],[BoardType],[DownPhoto],[DownFingerprint]) VALUES ( 1,'NO.1','Attend&Acs','main door','192.168.1.218','255.255.255.0','192.168.1.1',0,'192.168.1.1/sync','2 - 上下班+進出入','0 - 所有刷卡',0,0,'2','0 - 進','0 - 進','666666',60,3,180,8,'0-門禁控制',0,0)
SET IDENTITY_INSERT [Controllers] OFF
GO

SET IDENTITY_INSERT [ControllerHoliday] ON
INSERT [ControllerHoliday] ([RecordID],[ControllerId],[HolidayCode],[TemplateId],[Status]) VALUES ( 1,1,1,0,0)
INSERT [ControllerHoliday] ([RecordID],[ControllerId],[HolidayCode],[TemplateId],[Status]) VALUES ( 2,1,2,0,0)
INSERT [ControllerHoliday] ([RecordID],[ControllerId],[HolidayCode],[TemplateId],[Status]) VALUES ( 3,1,3,0,0)
INSERT [ControllerHoliday] ([RecordID],[ControllerId],[HolidayCode],[TemplateId],[Status]) VALUES ( 4,1,4,0,0)
INSERT [ControllerHoliday] ([RecordID],[ControllerId],[HolidayCode],[TemplateId],[Status]) VALUES ( 5,1,5,0,0)
INSERT [ControllerHoliday] ([RecordID],[ControllerId],[HolidayCode],[TemplateId],[Status]) VALUES ( 6,1,6,0,0)
INSERT [ControllerHoliday] ([RecordID],[ControllerId],[HolidayCode],[TemplateId],[Status]) VALUES ( 7,1,7,0,0)
INSERT [ControllerHoliday] ([RecordID],[ControllerId],[HolidayCode],[TemplateId],[Status]) VALUES ( 8,1,8,0,0)
INSERT [ControllerHoliday] ([RecordID],[ControllerId],[HolidayCode],[TemplateId],[Status]) VALUES ( 9,1,9,0,0)
INSERT [ControllerHoliday] ([RecordID],[ControllerId],[HolidayCode],[TemplateId],[Status]) VALUES ( 10,1,10,0,0)
SET IDENTITY_INSERT [ControllerHoliday] OFF
GO

SET IDENTITY_INSERT [ControllerSchedule] ON
INSERT [ControllerSchedule] ([RecordID],[ControllerId],[ScheduleCode],[TemplateId],[TemplateName],[Status]) VALUES ( 1,1,1,1,'0 - 24H進出',0)
INSERT [ControllerSchedule] ([RecordID],[ControllerId],[ScheduleCode],[TemplateId],[Status]) VALUES ( 2,1,2,0,0)
INSERT [ControllerSchedule] ([RecordID],[ControllerId],[ScheduleCode],[TemplateId],[Status]) VALUES ( 3,1,3,0,0)
INSERT [ControllerSchedule] ([RecordID],[ControllerId],[ScheduleCode],[TemplateId],[Status]) VALUES ( 4,1,4,0,0)
INSERT [ControllerSchedule] ([RecordID],[ControllerId],[ScheduleCode],[TemplateId],[Status]) VALUES ( 5,1,5,0,0)
INSERT [ControllerSchedule] ([RecordID],[ControllerId],[ScheduleCode],[TemplateId],[Status]) VALUES ( 6,1,6,0,0)
INSERT [ControllerSchedule] ([RecordID],[ControllerId],[ScheduleCode],[TemplateId],[Status]) VALUES ( 7,1,7,0,0)
INSERT [ControllerSchedule] ([RecordID],[ControllerId],[ScheduleCode],[TemplateId],[Status]) VALUES ( 8,1,8,0,0)
INSERT [ControllerSchedule] ([RecordID],[ControllerId],[ScheduleCode],[TemplateId],[Status]) VALUES ( 9,1,9,0,0)
INSERT [ControllerSchedule] ([RecordID],[ControllerId],[ScheduleCode],[TemplateId],[Status]) VALUES ( 10,1,10,0,0)
INSERT [ControllerSchedule] ([RecordID],[ControllerId],[ScheduleCode],[TemplateId],[Status]) VALUES ( 11,1,11,0,0)
INSERT [ControllerSchedule] ([RecordID],[ControllerId],[ScheduleCode],[TemplateId],[Status]) VALUES ( 12,1,12,0,0)
INSERT [ControllerSchedule] ([RecordID],[ControllerId],[ScheduleCode],[TemplateId],[Status]) VALUES ( 13,1,13,0,0)
INSERT [ControllerSchedule] ([RecordID],[ControllerId],[ScheduleCode],[TemplateId],[Status]) VALUES ( 14,1,14,0,0)
INSERT [ControllerSchedule] ([RecordID],[ControllerId],[ScheduleCode],[TemplateId],[Status]) VALUES ( 15,1,15,0,0)
SET IDENTITY_INSERT [ControllerSchedule] OFF
GO

SET IDENTITY_INSERT [ControllerInout] ON
INSERT [ControllerInout] ([RecordID],[ControllerId],[InoutPoint],[InoutDesc],[ScheduleID],[ScheduleName],[Out1],[Out2],[Out3],[Out4],[Out5],[status]) VALUES ( 1,1,1,'Button1',1,'0 - 24H進出',3000,0,0,0,0,0)
INSERT [ControllerInout] ([RecordID],[ControllerId],[InoutPoint],[ScheduleID],[Out1],[Out2],[Out3],[Out4],[Out5],[status]) VALUES ( 2,1,2,0,0,0,0,0,0,0)
INSERT [ControllerInout] ([RecordID],[ControllerId],[InoutPoint],[ScheduleID],[Out1],[Out2],[Out3],[Out4],[Out5],[status]) VALUES ( 3,1,3,0,0,0,0,0,0,0)
INSERT [ControllerInout] ([RecordID],[ControllerId],[InoutPoint],[ScheduleID],[Out1],[Out2],[Out3],[Out4],[Out5],[status]) VALUES ( 4,1,4,0,0,0,0,0,0,0)
INSERT [ControllerInout] ([RecordID],[ControllerId],[InoutPoint],[ScheduleID],[Out1],[Out2],[Out3],[Out4],[Out5],[status]) VALUES ( 5,1,5,0,0,0,0,0,0,0)
INSERT [ControllerInout] ([RecordID],[ControllerId],[InoutPoint],[InoutDesc],[Out1],[Out2],[Out3],[Out4],[Out5],[status]) VALUES ( 6,1,6,'讀卡器1-有效卡',3000,0,0,0,0,0)
INSERT [ControllerInout] ([RecordID],[ControllerId],[InoutPoint],[InoutDesc],[Out1],[Out2],[Out3],[Out4],[Out5],[status]) VALUES ( 7,1,7,'讀卡器1-非法卡',0,0,0,0,0,0)
INSERT [ControllerInout] ([RecordID],[ControllerId],[InoutPoint],[InoutDesc],[Out1],[Out2],[Out3],[Out4],[Out5],[status]) VALUES ( 8,1,8,'讀卡器1-非法時段',0,0,0,0,0,0)
INSERT [ControllerInout] ([RecordID],[ControllerId],[InoutPoint],[InoutDesc],[Out1],[Out2],[Out3],[Out4],[Out5],[status]) VALUES ( 9,1,9,'讀卡器1-防遣返',0,0,0,0,0,0)
INSERT [ControllerInout] ([RecordID],[ControllerId],[InoutPoint],[InoutDesc],[Out1],[Out2],[Out3],[Out4],[Out5],[status]) VALUES ( 10,1,10,'讀卡器2-有效卡',3000,0,0,0,0,0)
INSERT [ControllerInout] ([RecordID],[ControllerId],[InoutPoint],[InoutDesc],[Out1],[Out2],[Out3],[Out4],[Out5],[status]) VALUES ( 11,1,11,'讀卡器2-非法卡',0,0,0,0,0,0)
INSERT [ControllerInout] ([RecordID],[ControllerId],[InoutPoint],[InoutDesc],[Out1],[Out2],[Out3],[Out4],[Out5],[status]) VALUES ( 12,1,12,'讀卡器2-非法時段',0,0,0,0,0,0)
INSERT [ControllerInout] ([RecordID],[ControllerId],[InoutPoint],[InoutDesc],[Out1],[Out2],[Out3],[Out4],[Out5],[status]) VALUES ( 13,1,13,'讀卡器2-防遣返',0,0,0,0,0,0)
INSERT [ControllerInout] ([RecordID],[ControllerId],[InoutPoint],[InoutDesc],[Out1],[Out2],[Out3],[Out4],[Out5],[status]) VALUES ( 14,1,14,'門-常開',0,0,0,0,0,0)
INSERT [ControllerInout] ([RecordID],[ControllerId],[InoutPoint],[InoutDesc],[Out1],[Out2],[Out3],[Out4],[Out5],[status]) VALUES ( 15,1,15,'門-常閉',0,0,0,0,0,0)
SET IDENTITY_INSERT [ControllerInout] OFF
GO

INSERT [ControllerDataSync] ([ControllerId],[SyncType],[SyncStatus],[SyncTime]) VALUES ( 1,'controller',0,GETDATE())
INSERT [ControllerDataSync] ([ControllerId],[SyncType],[SyncStatus],[SyncTime]) VALUES ( 1,'holiday',0,GETDATE())
INSERT [ControllerDataSync] ([ControllerId],[SyncType],[SyncStatus],[SyncTime]) VALUES ( 1,'inout',0,GETDATE())
INSERT [ControllerDataSync] ([ControllerId],[SyncType],[SyncStatus],[SyncTime]) VALUES ( 1,'register',0,GETDATE())
INSERT [ControllerDataSync] ([ControllerId],[SyncType],[SyncStatus],[SyncTime]) VALUES ( 1,'schedule',0,GETDATE())
INSERT [ControllerDataSync] ([ControllerId],[SyncType]) VALUES ( 1,'online')
GO



