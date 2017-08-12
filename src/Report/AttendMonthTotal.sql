SELECT WorkDay_0, *
FROM Employees E, AttendanceTotal T
WHERE E.EmployeeId = T.EmployeeId
	AND T.AttendMonth = '2015-04'
	AND E.EmployeeId = 25

SELECT CONVERT(NVARCHAR(5),getdate(),108)

select CONVERT(NVARCHAR(10),OnDutyDate, 121), * from AttendanceDetail where Employeeid = 25 and OnDutyDate = '2015-04-01'

SELECT *
FROM AttendanceDetail
WHERE CONVERT(NVARCHAR(10),OnDutyDate, 121) LIKE '2015-04%'
AND EmployeeId = 25

select count(employeeid), employeeid from Attendancedetail where 1 > 0
and employeeid = 25 
and CONVERT(NVARCHAR(10), OnDutyDate, 121) LIKE '2015-04%'
and LEFT(ISNULL(OnDutyType, ''), 1) = '0'
group by employeeid

SELECT Rpt.*, WorkDay_0,
(SELECT COUNT(EmployeeId) FROM AttendanceDetail WHERE CONVERT(NVARCHAR(10), OnDutyDate, 121) LIKE '2015-04%' AND EmployeeId = T.EmployeeId AND LEFT(ISNULL(OnDutyType, ''), 1) = '0') AS WorkDay_1
FROM (
	SELECT E.EmployeeId, E.Name, 
	'Day' + CAST(DAY(ISNULL(OnDutyDate, NULL)) AS NVARCHAR(2)) AS DateDay, ISNULL(CONVERT(NVARCHAR(5), D.OnDuty1, 108) + ' ' + CONVERT(NVARCHAR(5), D.OffDuty1, 108), NULL) AS OndudyTime
	FROM Employees E, AttendanceDetail D
	WHERE E.EmployeeId = D.EmployeeId
		AND CONVERT(NVARCHAR(10), D.OnDutyDate, 121) LIKE '2015-04%'
		AND D.EmployeeId = 25
) Dt PIVOT(MAX(OndudyTime) FOR DateDay IN (IO, Day1, Day2)) Rpt, AttendanceTotal T
WHERE Rpt.EmployeeId = T.EmployeeId
	AND T.AttendMonth = '2015-04'
