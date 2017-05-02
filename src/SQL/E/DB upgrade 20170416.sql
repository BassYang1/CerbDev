USE CerbDb
GO

--�������ֶ�ControllerTemplates
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'ControllerTemplates') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'ControllerTemplates') AND name = N'DepartmentCode')
	ALTER TABLE ControllerTemplates ADD DepartmentCode NTEXT NULL --���沿���б�����	


IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'ControllerTemplates') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'ControllerTemplates') AND name = N'EmployeeCode')
	ALTER TABLE ControllerTemplates ADD EmployeeCode NTEXT NULL --����ְԱ�б�����	

	
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'ControllerTemplates') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'ControllerTemplates') AND name = N'OtherCode')
	ALTER TABLE ControllerTemplates ADD OtherCode NTEXT NULL --Ԥ��,�������������ӵ�����	


IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'ControllerTemplates') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'ControllerTemplates') AND name = N'OnlyByCondition')
	ALTER TABLE ControllerTemplates ADD OnlyByCondition BIT NOT NULL DEFAULT(0) --����������, 1Ϊ���湴ѡ��,0��null ��ʾû��ѡ


--����LabelText
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Equipment', NULL, 'Yes', '��', '��', 'Yes', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Equipment' AND LabelId = 'Yes');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Equipment', NULL, 'No', '��', '��', 'No', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Equipment' AND LabelId = 'No');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Equipment', NULL, 'RegEmpCondition', 'δ����ע��Ա������', 'δ�O���]�ԆT���l��', 'Not set the staff conditions', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Equipment' AND LabelId = 'RegEmpCondition');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'AllDept', '���в���', '���в��T', ' All Departments', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'AllDept');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'AllEmp', '����ְԱ', '�����T', ' All Employees', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'AllDept');


--������ģ��ע�ᵽ�豸
if exists (select name from sysObjects where name = 'pRegCardTemplateRegister' and type = 'p')
	drop Procedure pRegCardTemplateRegister
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[pRegCardTemplateRegister]
( --ģ��Id
  @TemplateId VARCHAR(50),
  --ע�᷽ʽ��0Ϊ׷��ע�ᣨ��������ظ����ݣ���ע��Ŀ��ţ������κ��޸ģ�
  --1Ϊ����ע�ᣨ����ȫ�����ԭע�Ῠ�ţ���ע�ᣨע�⣺��ս���շ������豸���ݣ������Ӳ���ϵ����ݣ���
  @RegMode		bit = 0,  
  --��ģ���������ɸѡע����Ա������Ϊ�ձ�ʾ��ģ�������ȫ��ע��. ��ʽ��EmployeeIDֵ. �磺select EmployeeId from Employes where Employeeid In (1,2,3)
  @WhereEmployee VARCHAR(2000) = '',     
 --��ģ���������ɸѡ�豸��Ϊ�ձ�ʾ��ģ�������ȫ��ע��	. ��ʽ��ͬ��
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
	DECLARE @strEmCode VARCHAR(4000) --Ա��Id
	DECLARE @strDeptCode VARCHAR(4000) --����Id
	DECLARE @strOtherCode VARCHAR(4000) --��������
	DECLARE @strEmployeeScheID VARCHAR(100)
	DECLARE @strEmployeeDoor VARCHAR(100)
	DECLARE @strValidateMode VARCHAR(100)
	DECLARE @OnlyByCondition bit

	SET NOCOUNT ON
	--��ģ�����ȡ����ֶ�
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
	
	--WhereEmployee ��������ֱ�Ӳ��뵽strEmCode�У���Ϊ���ѡ�񡾽���������ע�᡿Ҫɾ���������е���Ա��  WhereEmployeeһ�����ڽӿ�ͬ��ʱ�������б䶯����Ա��Ϣ
	--IF @WhereEmployee <> '' 
	--	Set @strEmCode = @strEmCode + ' and EmployeeId IN (' + @WhereEmployee+')'	
		
	--��ȡ��Ҫע����豸�������豸ID������#TempConId��
	IF object_id('tempdb.dbo.#TempConId') IS not null
		DROP TABLE #TempConId

	Create Table #TempConId(ControllerId int null)
	Set @strSQL = 'INSERT #TempConId SELECT ControllerId  From Controllers '
	IF left(@strEmController,1)='0'
		 Set @strSQL = @strSQL + ' where ControllerId > 0 '
	Else
		Set @strSQL = @strSQL + ' where ControllerId in ('+@strEmController+') '

	--@WhereControllerid ��������ֱ�Ӳ��뵽@strEmController�У�ͬ@WhereEmployee
	--IF @WhereControllerid <> '' 
	--	Set @strSQL = @strSQL + ' and ControllerId in ('+@WhereControllerid+') '

	Exec(@strSQL)

	----ע��ʱ�������ǰʱ���IDû���豸ʱ����У�����һ��ScheduleCode��С��û��δע���ʱ����ļ�¼�����浱ǰʱ���ID
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
		--����ע�ᣬ��ɾ������ע��
		Set @strSQL = 'delete from ControllerEmployee where ControllerId in (select ControllerId from #TempConId) 
						and EmployeeId in (select EmployeeId from ('+@strEmCode+') A ); ' --ɾ��������ע��
						
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
		--����������ע�ᡣɾ���������е�����
		if	@OnlyByCondition = 1
		begin
			set @strSQL = @strSQL+';update ControllerEmployee set deleteflag = 1, status = 0 where ControllerId in (select ControllerId from #TempConId) 
							and EmployeeId not in (select EmployeeId from ('+@strEmCode+') A ); ' --����ɾ����ǰδע���ڸ��豸�ϵ�Ա������
		end
		
		Exec(@strSQL)	
	End	
	
	
	
	UPDATE ControllerDataSync set SyncStatus=0 where Controllerid in (select ControllerId from #TempConId) and SyncType='register'
		
	IF object_id('tempdb.dbo.#TempConId') IS not null
		DROP TABLE #TempConId

	SET NOCOUNT OFF
END
GO


--����ģ��ע�ᵽ�豸
if exists (select name from sysObjects where name = 'pRegCardTemplateRegisterAll' and type = 'p')
	drop Procedure pRegCardTemplateRegisterAll
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROC [dbo].[pRegCardTemplateRegisterAll]
( 
 /*ע�⣺ִ��ע��ʱ��ģ��ID�Ӵ�С���򣬼���ע�����IDģ�塡*/

  --ע�᷽ʽ��0Ϊ׷��ע�ᣨ��������ظ����ݣ���ע��Ŀ��ţ������κ��޸ģ�
  --1Ϊ����ע�ᣨ����ȫ�����ԭע�Ῠ�ţ���ע�ᣨע�⣺��ս���շ������豸���ݣ������Ӳ���ϵ����ݣ���
  @RegMode		bit = 0,  
  --��ģ���������ɸѡע����Ա������Ϊ�ձ�ʾ��ģ�������ȫ��ע��. ��ʽ��EmployeeIDֵ. �磺select EmployeeId from Employes where Employeeid In (1,2,3)
  @WhereEmployee VARCHAR(2000) = '',     
 --��ģ���������ɸѡ�豸��Ϊ�ձ�ʾ��ģ�������ȫ��ע��	. ��ʽ��ͬ��
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
	   
		OPEN RegCursor; --���α�
		FETCH NEXT FROM RegCursor INTO @TemplateId; --��ȡ��һ������,����ֵ�����ڱ�����
		WHILE @@FETCH_STATUS = 0
			BEGIN
				exec pRegCardTemplateRegister @TemplateId,@RegMode,@WhereEmployee,@WhereControllerid

				FETCH NEXT FROM RegCursor INTO @TemplateId; --��ȡ��һ������
			END
		CLOSE RegCursor; --�ر��α�
		DEALLOCATE RegCursor; --�ͷ��α�
	
	SET NOCOUNT OFF
END

GO