<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
<div id="find-title">
���ñ����ʾ
</div>
<hr>
<form action="set_table.asp" method="post">
ѡ����<select name=tablename onChange="javascript:this.form.submit()">
<option value=""></option>
<option value="r_depotdetail" <% if request("tablename")="r_depotdetail" then response.write "selected"%>>�����ϸ��</option>
<option value="TotalDepot_Branch1" <% if request("tablename")="TotalDepot_Branch1" then response.write "selected"%>>����ѯ��</option>
<option value="DepotWarn" <% if request("tablename")="DepotWarn" then response.write "selected"%>>��汨����ϸ��</option>
<option value="DepotCount" <% if request("tablename")="DepotCount" then response.write "selected"%>>�����ܱ�</option>
<option value="AllBill2" <% if request("tablename")="AllBill2" then response.write "selected"%>>��ⵥ�ݲ�ѯ��</option>
<option value="rk_goods_find" <% if request("tablename")="rk_goods_find" then response.write "selected"%>>����Ʒ��ѯ��</option>
<option value="AllBill1" <% if request("tablename")="AllBill1" then response.write "selected"%>>���ⵥ�ݲ�ѯ��</option>
<option value="ck_goods_find" <% if request("tablename")="ck_goods_find" then response.write "selected"%>>�����Ʒ��ѯ��</option>
<option value="trac" <% if request("tablename")="trac" then response.write "selected"%>>�������ݲ�ѯ��</option>
<option value="DBGoods" <% if request("tablename")="DBGoods" then response.write "selected"%>>������Ʒ��ѯ��</option>
<option value="zzcx" <% if request("tablename")="zzcx" then response.write "selected"%>>��װ���ݲ�ѯ��</option>
<option value="R_ProviderDetail1" <% if request("tablename")="R_ProviderDetail1" then response.write "selected"%>>�ͻ�������ϸ��</option>
<option value="R_ProductInDetail" <% if request("tablename")="R_ProductInDetail" then response.write "selected"%>>�������������ϸ��</option>
<option value="AllGoods" <% if request("tablename")="AllGoods" then response.write "selected"%>>��Ʒ������</option>

<select>
</form>
<hr>
<form action="set_table_save.asp" method="post">
<div id="inner-table-hpzl">
<table width="100%">
<tr>
<th align=center>Դ����</th>
<th align=center>��ʾ����</th>
<th align=center>���</th>
<th align=center>�Ƿ�ɼ�</th>
<th align=center>˳��</th>
</tr>
<%
if request("tablename")<>"" then
	set t = server.createobject("adodb.recordset")
	q = "select * from t_fieldshow where tablename='"&request("tablename")&"' order by showid"
	t.open q, conn, 1, 1
	response.write "<input type=hidden name=intk value="""&t.recordcount&""">"
	response.write "<input type=hidden name=tablename value="""&request("tablename")&""">"
	for i=1 to t.recordcount
		f_checked=""
		if t("show")=True then
			f_checked="checked"
		end if
		response.write "<tr>"
		response.write "<td><input type=hidden name=tid"&i&" value="""&t("id")&"""><input type=text style=border:0px; readonly name=remark"&i&" value="""&t("remark")&"""></td>"
		response.write "<td><input type=text name=name"&i&" value="""&t("name")&"""></td>"
		response.write "<td><input type=text name=width"&i&" value="""&t("width")&"""></td>"
		response.write "<td><input type=checkbox name=show"&i&" value="""&t("show")&""" "&f_checked&"></td>"
		response.write "<td><input type=text name=showid"&i&" value="""&t("showid")&"""></td>"
		response.write "</tr>"
		t.movenext
	next
end if
%>
</table>
</div>
<center>
	<br>
<input type="submit" value="��������">
</body>
</html>