<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
enddate = setdate(date())
if request("enddate") then
	on error resume next
	conn.BeginTrans	
		q = "delete from t_odepotstart"
		conn.execute q
		set t = server.createobject("adodb.recordset")
		q = "select * from dict_depot"
		t.open q, conn, 1, 1
		while not t.eof
			depot_f = ",depotname "
			depot_q = " depotname = '"&t("depotname")&"' and "	
			q = "select a.goodscode,b.avgprice as startprice,b.totalmoney as startmoney,b.t_num as startdepot"&depot_f
			q = q&" as depot from t_goods a right join (select goodscode, "
			q = q&" iif(Sum([sign]*[number])=0 or isnull(Sum([sign]*[number])),0,round(Sum([sign]*[number]*[price])/Sum([sign]*[number]),2)) AS avgprice, "
			q = q&" iif(Sum([sign]*[number])=0 or isnull(Sum([sign]*[number])),0,Sum([sign]*[number]*[price])) AS totalmoney, " 
			q = q&" iif(isnull(Sum([sign]*[number])),0,Sum([sign]*[number])) AS T_Num"&depot_f
			q = q&" from S_GoodsNum where "&depot_q
			q = q&" cdate(adddate)<=#"&enddate&"#"
			q = q&" group by goodscode"&depot_f&") b on a.goodscode=b.goodscode "
			q = "insert into t_odepotstart(goodscode,startprice,startmoney,startdepot,depot) select goodscode,startprice,startmoney,startdepot,depot from ("&q&")"
			conn.execute q		
			t.movenext
		wend
		q = "insert into t_odepot select * from t_depot"
		conn.execute q
		
		q = "insert into t_odepotdetail select * from t_depotdetail"
		conn.execute q
		
		q = "delete from t_depot"
		conn.execute q
		
		q = "delete from t_depotdetail"
		conn.execute q
		
		q = "delete from t_depotstart"
		conn.execute q
		
		q = "insert into t_depotstart select * from t_odepotstart"
		conn.execute q		
	if err.number=0 then
		manageLog "年终结转：" & enddate
		conn.CommitTrans
		conn.close
		set conn=nothing
		Response.Write"<script>alert('结转成功！')</SCRIPT>"
	else
		conn.RollbackTrans
		response.write err.description
	end if	
end if
%>
<html>
<head>
<script type='text/javascript' src='../js/calendar.js'></script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<link href="../calendar.css" rel="stylesheet" type="text/css" media="all" />
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>数据结转</title>
</head>
<form method=post action=year_carry.asp>
<font color="#FF0000">注意：结转将会把单据结束日期之前的库存数量转变为当前的期初数量<br>
以往的单据可在数据查询的过往单据查询中查询看到，但不能修改<br>
此功能适合于单据数量过多的情况以提高软件运行速度<br>
此操作为不可逆操作，请您操作前考虑清楚，务必操作之前做好数据备份</font><br>
单据结束日期：<input type="text" name="enddate" size="10" value="<%=enddate%>">
<img src="../images/calendar.gif" class=dh align="absmiddle" onClick="javascript:showCalendar(enddate,0);"><br><br>
<input type=submit name=carry class=dh value=开始结转>
</form>
<body>
</body>
</html>
