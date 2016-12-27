<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
qxlist = request.cookies("qxlist")
if instr(qxlist,"kc_find")=0 then 
	response.write "<script>alert('对不起，您没有该操作权限！');history.go(-1);</script>"
	response.end
end if
sqlexcel = "select * from t_online where online=true"
%>
<html>
<title>在线列表</title>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type='text/javascript' src='../js/calendar.js'></script>
<script type='text/javascript' src='../js/public.js'></script>
<script type="text/javascript" src="../js/jquery-1.3.2.min.js" ></script>
<script type="text/javascript" src="../js/mln.colselect.js"></script>
<link href="../style/mln-main.css" rel="stylesheet" type="text/css"/>
<link href="../style/mln.colselect.css" rel="stylesheet" type="text/css">
<link href="../calendar.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<form name="form" method="get" action="kc_find.asp">
<h1>在线列表</h1><hr>
<% SetTable "online", sqlexcel, "0"%>
<form>
</body>
</html>