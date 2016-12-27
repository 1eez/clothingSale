<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
if request("submit")="保存" then
	q = "select * from tSoftInfo"
	set t= Server.CreateObject("adodb.recordset")
	t.open q, conn, 1, 3
		t("number") = request("number")
		t("price") = request("price")
		t("money") = request("money")
		t("page1") = request("page1")
		t("page2") = request("page2")
		t("billpage") = request("billpage")
	t.update
	t.close
	set t=nothing
end if
q = "select * from tSoftInfo"
set t= Server.CreateObject("adodb.recordset")
t.open q, conn, 1, 1
number = t("number")
price = t("price")
money = t("money")
page1 = t("page1")
page2 = t("page2")
billpage = t("billpage")
t.close
set t=nothing
%>
<html>
<head>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<script type='text/javascript' src='../js/public.js'></script>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
</head>
<title>选项设置</title>
<body>
<form action="optionset.asp" method="post">
<fieldset style="width:400px;"><legend>小数位数设置</legend>
数量：<input class=number name="number" type="text" size="8" value="<%=number%>">
单价：<input class=number name="price" type="text" size="8" value="<%=price%>">
金额：<input class=number name="money" type="text" size="8" value="<%=money%>">
<legend>每页显示记录数</legend>
报表：<input class=number name="page1" type="text" size="8" value="<%=page1%>">
查询：<input class=number name="page2" type="text" size="8" value="<%=page2%>">
<legend>单据打印显示行数</legend>
行数：<input class=number name="billpage" type="text" size="8" value="<%=billpage%>">
</fieldset>
<br><br><input class=dh name="submit" type="submit" value="保存">
</form>
</body>
</html>