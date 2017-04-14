<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<%
dim page,rows,sidx,sord,strFieldId
page = request.QueryString("page") 'page
rows = request.QueryString("rows") 'pagesize
sidx = request.QueryString("sidx") 'order by ??
sord = request.QueryString("sord")
strFieldId = request.QueryString("FieldId")
if page="" then page = 1 end if
if rows = "" then rows = 10 end if
if sidx = "" then sidx = "RecordID" end if
if sord = "" then sord ="asc" end if
if strFieldId = "" then strFieldId = "0" end if

fConnectADODB()
dim a
set a=new JSONClass
a.Sqlstring="select RecordID,Content from TableFieldCode where FieldId="&strFieldId&" "&"order by "& sidx & " " & sord

set a.dbconnection=conn
response.Write(a.GetJSon())
'conn.close()
'set conn = nothing
fCloseADO()
%>
