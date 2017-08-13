Declare
	@StartDate datetime = '2017-07-01',
	@EndDate datetime = '2017-08-01'
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
