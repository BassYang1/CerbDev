<!--#include file="Conn\ReadFile.asp"-->
<%
'20150704 mike 增加如下三行代码。解决当asp脚本发生异常时，导致整个项目乱码，需要重启浏览器才能解决。
Response.CodePage=65001
Response.Charset="utf-8" 
Session.CodePage=65001 

Response.Buffer=true 

response.Write(Application("p_language"))

%>



