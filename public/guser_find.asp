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
sqlexcel =  "select "&fields&" from t_guser where gusername<>'请选择' "&sqlwhere&" and 1=1 "
tshow = "guser_find"
%>
<script>
	function firm(el){
		if(confirm('您确定要删除【单号】是【' + el.showvalue + '】的记录吗？\n此操作将会删除此单据所附带的货品明细\n删除后数据不可恢复！'))
		  {location.href="guser_delete.asp?gusername=" + el.value;}
		else
			{}
	}
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<title>出库单查询</title>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<form name="form" method="get" action="user_find.asp">
<div id="find-title">
权限组查询
</div>
<hr>
<% SetTable "guser_find", sqlexcel, "1"%>
</body>
</html>