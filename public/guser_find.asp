<!-- #include file="../public/date.js" -->
<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
dim sqlexcel, tshow
sqlwhere = ""
if Trim(Request("username"))<>"" then
	sqlwhere = " and username like '%"&Trim(Request("username"))&"%'"
end if
if Trim(Request("depart"))<>"" then
	sqlwhere = " and depart like '%"&Trim(Request("depart"))&"%'"
end if
getfields("guser_find")
sqlexcel =  "select "&fields&" from t_guser where gusername<>'��ѡ��' "&sqlwhere&" and 1=1 "
tshow = "guser_find"
%>
<script>
	function firm(el){
		if(confirm('��ȷ��Ҫɾ�������š��ǡ�' + el.showvalue + '���ļ�¼��\n�˲�������ɾ���˵����������Ļ�Ʒ��ϸ\nɾ�������ݲ��ɻָ���'))
		  {location.href="guser_delete.asp?gusername=" + el.value;}
		else
			{}
	}
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<title>���ⵥ��ѯ</title>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<form name="form" method="get" action="user_find.asp">
<div id="find-title">
Ȩ�����ѯ
</div>
<hr>
<% SetTable "guser_find", sqlexcel, "1"%>
</body>
</html>