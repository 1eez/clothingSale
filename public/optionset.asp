<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
if request("submit")="����" then
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
<title>ѡ������</title>
<body>
<form action="optionset.asp" method="post">
<fieldset style="width:400px;"><legend>С��λ������</legend>
������<input class=number name="number" type="text" size="8" value="<%=number%>">
���ۣ�<input class=number name="price" type="text" size="8" value="<%=price%>">
��<input class=number name="money" type="text" size="8" value="<%=money%>">
<legend>ÿҳ��ʾ��¼��</legend>
����<input class=number name="page1" type="text" size="8" value="<%=page1%>">
��ѯ��<input class=number name="page2" type="text" size="8" value="<%=page2%>">
<legend>���ݴ�ӡ��ʾ����</legend>
������<input class=number name="billpage" type="text" size="8" value="<%=billpage%>">
</fieldset>
<br><br><input class=dh name="submit" type="submit" value="����">
</form>
</body>
</html>