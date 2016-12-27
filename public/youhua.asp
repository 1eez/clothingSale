<!-- #include file="../public/conn.asp" -->
<!-- #include file="public.asp" -->
<%
q = "DELETE * FROM t_depotstart WHERE (((t_depotstart.depotstartid) not In (select max(depotstartid) from t_depotstart group by goodscode,depot)))"
conn.execute q
q = "select * from dict_cate where table='goods'"
set t = server.createobject("adodb.recordset")
t.open q, conn, 1, 1
while not t.eof
	sql = "update t_goods set typecode='"&t("c_select")&"' where goodstype='"&t("c_name")&"'"
	conn.execute sql
	t.movenext
wend
t.close
ff_table="goods"
q = "update dict_cate set longname=c_name where table='"&ff_table&"' and c_select<>'001'"
conn.execute q
q = "select * from dict_cate where table='"&ff_table&"'"
t.open q, conn, 1, 1
while not t.eof
	c_select = t("c_select")
	while len(c_select)>6
		set tt = server.createobject("adodb.recordset")
		q = "select * from dict_cate where c_select='"&left(c_select, len(c_select)-3)&"' and table='"&ff_table&"'"
		tt.open q, conn, 1, 1
		q = "update dict_cate set longname='"&tt("c_name")&"'+'/'+longname where table='"&ff_table&"' and c_select='"&t("c_select")&"'"
		conn.execute q
		c_select = left(c_select, len(c_select)-3)
		tt.close
		set tt=nothing
	wend
	c_select = ""
	t.movenext
wend
t.close
q = "update t_goods a, dict_cate b set a.longname=b.longname where a.typecode=b.c_select"
conn.execute q
ff_table="depart"
q = "update dict_cate set longname=c_name where table='"&ff_table&"' and c_select<>'001'"
conn.execute q
q = "select * from dict_cate where table='"&ff_table&"'"
t.open q, conn, 1, 1
while not t.eof
	c_select = t("c_select")
	while len(c_select)>6
		set tt = server.createobject("adodb.recordset")
		q = "select * from dict_cate where c_select='"&left(c_select, len(c_select)-3)&"' and table='"&ff_table&"'"
		tt.open q, conn, 1, 1
		q = "update dict_cate set longname='"&tt("c_name")&"'+'/'+longname where table='"&ff_table&"' and c_select='"&t("c_select")&"'"
		conn.execute q
		c_select = left(c_select, len(c_select)-3)
		tt.close
		set tt=nothing
	wend
	c_select = ""
	t.movenext
wend
q = "update t_depot a, dict_cate b set a.longname=b.longname where a.departcode=b.c_select"
conn.execute q
manageLog request.cookies("userName") & "对数据进行了优化"
t.close
set t=nothing
connClose()
response.write "<script>history.go(-1)</script>"
%>