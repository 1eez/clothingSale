<%
if username = "" and Request.Cookies("usernamea")="" then
	response.write "<script>location.href='login.asp'</script>"
end if
%>
<HTML>
<link href="style.css" rel="stylesheet" type="text/css" media="all" />
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<style>
body{
	font-size:10pt;
	font-family:微软雅黑;
	margin:0px;
	border:0px;
	padding: 0px;
	overflow:hidden;
}
.navPoint {
FONT-SIZE: 6pt; CURSOR: hand; COLOR: blank; FONT-FAMILY: Webdings
}
P{
FONT-SIZE: 9pt;
}
table{
	padding:0px;
	margin:0px;
	border-collapse:collapse;
}
td{
	padding:0px;
	margin:0px;
	border:0px solid #BDD2DD;
}
IFRAME{
	padding:0px;
	margin:0px;
	width:100%;
	height:100%;
}
</STYLE>
<SCRIPT>
function switchSysBar()
{
if (switchPoint.innerText==3)
{
switchPoint.innerText=4
document.all("frmTitle").style.display="none"
}
else
{
switchPoint.innerText=3
document.all("frmTitle").style.display=""
}
}
</SCRIPT>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>服装进销存管理系统WEB版</title>
</head>
<body>
<base onmouseover="window.status='欢迎您！<%=Request.cookies("usernamea")%> 今天是：<%=year(date)%>年<%=month(date)%>月<%=day(date)%>日 <%=weekdayname(weekday(now))%>&nbsp;&nbsp;&nbsp;使用程序时可按F11进入全屏模式以达到最佳使用效果';return true">
<table width=100% height=100% border="0" cellpadding="0" cellspacing="0">
<tr height=61>
<td width=100% height="61" colspan=4>
<IFRAME id=top name=top src="menu.asp" scrolling=no></IFRAME>
</td></tr>
<TR>
<TD width="170" align=middle vAlign=bottom noWrap id=frmTitle name="frmTitle">
<IFRAME id=left name=left src="left.asp" frameBorder=0 scrolling=no></IFRAME>
</TD>
<td width="8" background="images/san_bg.jpg" bgColor=#D8ECFF style="width:2px;overflow:hidden" border=0>
<TABLE height="3">
<TR>
<TD width="4" style="HEIGHT: 100%;CURSOR: hand;" ONCLICK=switchSysBar()>
<SPAN class=navPoint id=switchPoint title=关闭/打开左栏>3</SPAN></TD>
</TR>
</table>
</td>
<td style="WIDTH:100%">
<iframe id=main style="Z-INDEX: 1; VISIBILITY: inherit; WIDTH: 100%; HEIGHT: 100%" name=main src="unit/stock_find_hp.asp" frameBorder=0 scrolling=auto></IFRAME>
</td>
</tr>
</table>
</body>
</html>