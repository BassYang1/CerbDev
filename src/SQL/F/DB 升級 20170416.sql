USE CerbDb
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


IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'LabelText') AND XType = N'U')
	AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'LabelText') AND name = N'LabelEnText')
	ALTER TABLE LabelText ALTER COLUMN LabelEnText NVARCHAR(1000) NULL --修改字段LabelEnText类型	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'LabelText') AND XType = N'U')
	AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'LabelText') AND name = N'LabelZhtwText')
	ALTER TABLE LabelText ALTER COLUMN LabelZhtwText NVARCHAR(500) NULL --修改字段LabelZhtwText类型	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'LabelText') AND XType = N'U')
	AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'LabelText') AND name = N'LabelZhcnText')
	ALTER TABLE LabelText ALTER COLUMN LabelZhcnText NVARCHAR(500) NULL --修改字段LabelZhcnText类型
		
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
SELECT 'Employees', NULL, 'AllDept', '所有部门', '所有部門', 'All Departments', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'AllDept');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'AllEmp', '所有职员', '所有職員', 'All Employees', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'AllDept');

--班次
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'ShiftNameUsed', '班次名称已使用', '班次名稱已使用', 'Shift Name already used', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'ShiftNameUsed');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', 'ExportDataExec.asp', 'shift', '班次', '班次', 'Shifts', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'shift');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'ExportShiftTitle', N'班次Id,班次名,基本工时,是否过夜,第一次上班刷卡,上班次数,弹性班次,上班标准时间1,上班开始时间1,上班截止时间1,下班开始时间1,下班标准时间1,下班截止时间1,允许迟到时间1,允许早退时间1,中间休息1,上班标准时间2,上班开始时间2,上班截止时间2,下班开始时间2,下班标准时间2,下班截止时间2,允许迟到时间2,允许早退时间2,中间休息2,上班标准时间3,上班开始时间3,上班截止时间3,下班开始时间3,下班标准时间3,下班截止时间3,允许迟到时间3,允许早退时间3,中间休息3', N'班次Id,班次名,基本工時,是否過夜,第壹次上班刷卡,上班次數,彈性班次,上班標準時間1,上班開始時間1,上班截止時間1,下班開始時間1,下班標準時間1,下班截止時間1,允許遲到時間1,允許早退時間1,中間休息1,上班標準時間2,上班開始時間2,上班截止時間2,下班開始時間2,下班標準時間2,下班截止時間2,允許遲到時間2,允許早退時間2,中間休息2,上班標準時間3,上班開始時間3,上班截止時間3,下班開始時間3,下班標準時間3,下班截止時間3,允許遲到時間3,允許早退時間3,中間休息3', 'Shift Id,Shift Name,Working Hour,Overnight,First Clock In,Time Period,Flexible Shifts,Standard Time 1 of On Duty,Start Time 1 of On Duty,End Time 1 of On Duty,Start Time 1 of Off Duty,Standard Time 1 of Off Duty,End Time 1 of Off Duty,Allow Late Time 1 (min),Allow Early Leave Time 1 (min),Rest 1 (min),Standard Time 2 of On Duty,Start Time 2 of On Duty,End Time 2 of On Duty,Start Time 2 of Off Duty,Standard Time 2 of Off Duty,End Time 2 of Off Duty,Allow Late Time 2 (min),Allow Early Leave Time 2 (min),Rest 2 (min),Standard Time 3 of On Duty,Start Time 3 of On Duty,End Time 3 of On Duty,Start Time 3 of Off Duty,Standard Time 3 of Off Duty,End Time 3 of Off Duty,Allow Late Time 3 (min),Allow Early Leave Time 3 (min),Rest 3 (min)', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'ExportShiftTitle');

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
				
	if ISNULL(@strEmCode,'') != '' and left(rtrim(ltrim(@strEmCode)), 1) <> '0'
	begin
		Set @strEmCode = '( EmployeeId in ('+ @strEmCode + '))'

		if ISNULL(@strDeptCode,'') != '' and left(rtrim(ltrim(@strDeptCode)), 1) <> '0'
			Set @strEmCode = '(' + @strEmCode + ' or (Departmentid In(' + @strDeptCode + ')))'	
	end
	else
	begin
		if ISNULL(@strDeptCode,'') != '' and left(rtrim(ltrim(@strDeptCode)), 1) <> '0'
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