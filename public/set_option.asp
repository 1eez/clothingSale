<!-- #include file="../public/conn.asp" -->
<!-- #include file="public.asp" -->
<%
num1 = request.form("num1")
num2 = request.form("num2")
auto = request.form("auto")
notry = request.form("notry")
p_type = request("p_type")
fuchuku = request("fuchuku")
if notry<>"1" then
	notry="0"
end if
autocode = request.form("autocode")
if num1<>"" and num2<>"" then
	sql = "update t_appinfo set fuchuku='"&fuchuku&"',p_type='"&p_type&"',dotprice='"&request("dotprice")&"',dotmoney='"&request("dotmoney")&"',dotnumber='"&request("dotnumber")&"',notry="&notry&",num1="&num1&",printnum="&num2&",autocode='"&autocode&"',auto='"&auto&"'"
	conn.execute sql
	manageLog "���ѡ�������޸�"
end if
set t = server.createobject("adodb.recordset")
sql = "select * from t_appinfo"
t.open sql, conn, 1, 1
num1 = t("num1")
num2 = t("printnum")
notry = t("notry")
dotnumber=t("dotnumber")
dotprice=t("dotprice")
dotmoney=t("dotmoney")
fuchuku=t("fuchuku")
p_type=t("p_type")
if notry="True" then
	cnotry="checked"
end if
autocode = t("autocode")
auto = t("auto")
if auto="1" then
	f_check="checked"
end if
if p_type="price" then
	p_check="selected"
end if
if fuchuku="1" then
	fc_check="checked"
end if
%>
<html>
<title>ѡ������</title>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
<h1>ѡ������</h1><hr>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<form action="set_option.asp" method="post">
<% if trim(session("loginnameb"))<>"user" then %>
<input type="checkbox" name="notry" value="1" <%=cnotry%>>�����ʽ����<br>
<% end if %>
ÿҳ��ʾ��¼������<input type="text" style="text-align:right" name="num1" value="<%=num1%>" size=4><br>
���ݴ�ӡһҳ�����ʾ��¼����<input type="text" style="text-align:right" name="num2" value="<%=num2%>" size=4><br>
�Զ�����ǰ׺���ƣ�<input type="text" name="autocode" value="<%=autocode%>" size=4><input type="checkbox" value=1 name="auto" <%=f_check%>>�Զ����
<br>С����λ����������<input type="text" style="text-align:right" name="dotnumber" value="<%=dotnumber%>" size=2>
���ۣ�<input type="text" style="text-align:right" name="dotprice" value="<%=dotprice%>" size=2>
��<input type="text" style="text-align:right" name="dotmoney" value="<%=dotmoney%>" size=2>
<br><input name="fuchuku" type="checkbox" value="1" <%=fc_check%>>֧�ָ����⣬�����������Ϊ����
<hr><center>
<input class=dh type="submit" value=����>&nbsp;<input class=dh type="button" value="�ر�" onclick=window.opener=null;window.close()></center>
</form>
</body>
</html>