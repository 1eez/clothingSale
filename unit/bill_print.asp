<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" --> 
<%
if request("ptype")="printd" then
	border="border=1"
	Response.AddHeader "Content-Disposition", "attachment;filename="&request("dtitle")&".xls"
	Response.ContentType  =  "application/vnd.ms-excel"
end if
billcode = Request.Querystring("billcode")
if billcode<>"" then
	set t = server.createobject("adodb.recordset")
	sql = "select * from t_appinfo"
	t.open sql, conn, 1, 1
	num1 = t("num1")
	num2 = t("num2")
	dotnum=t("dotnumber")
	dotprice=t("dotprice")
	dotmoney=t("dotmoney")
	printnum=t("printnum")
if request("ptype")="printd" then
	printnum=300
end if
	t.close
	set t = nothing
	set rs_depot = server.createobject("adodb.recordset")
	sql = "select * from T_Depot where BillCode='"&billcode&"'"
	rs_depot.open sql, conn, 1, 1
	rk_date = rs_depot("adddate")
	rk_type = rs_depot("type")
	depotname = rs_depot("depotname")
	supply = rs_depot("custname")
	f_user = rs_depot("f_user")
	oldbill = rs_depot("oldbill")
	f_depart = rs_depot("f_depart")
	strmemo = rs_depot("memo")
	capsupply = "������λ��"
	capdepot = "�ֿ����ƣ�"
	if rs_depot("inorout")="����" then
		supply = rs_depot("depotname1")
		capsupply = "�����ֿ⣺"
		capdepot = "����ֿ⣺"
		rk_type = "�ֿ������"
	end if
	makerdate = rs_depot("makerdate")
	action = "rk_add_save.asp"&"?billcode="&billcode	
	rs_depot.close
	set rs_depot = nothing
	
	set t = server.createobject("adodb.recordset")
	sql = "select * from t_coinfo"
	t.open sql, conn, 1, 1
	co = t("co_long")
	t.close
	
	sql = "select sum(number*price) as tmoney,sum(number) as tnum from t_depotdetail where billcode='"&billcode&"'"
	t.open sql, conn, 1, 1
	tmoney = FormatNumber(t("tmoney"), cint(dotmoney), -1,false,false)
	tnumber = FormatNumber(t("tnum"), cint(dotnum), -1,false,false)
	t.close
	set t = nothing
end if
%>
<style media=print>
.Noprint{display:none;}
.PageNext{page-break-after: always;}
</style>
<html>
<title>���ݴ�ӡ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<body>
<% if request("ptype")<>"printd" then %>
<div class="Noprint" style="line-height:20px;padding-top:5px;">
<OBJECT id=WebBrowser  classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2  height=0  width=0>
</OBJECT>
<input class=dh type=button value=��ӡ���� onclick=document.all.WebBrowser.ExecWB(6,1)>
<input class=dh type=button value=ҳ������ onclick=document.all.WebBrowser.ExecWB(8,1)>
<input class=dh type=button value=��ӡԤ�� onclick=document.all.WebBrowser.ExecWB(7,1)>
<input class=dh type="reset" value="�ر�" onclick=window.opener=null;window.close()><br>
�����Ը���ֽ�Ŵ�С���ڡ�ϵͳ���á�-��ѡ�����á�������ÿҳ��ʾ��¼����<br>
�״δ�ӡʱ��������ҳ�����á���ť������ҳü��ҳ��Ϊ�գ�ҳ�߾�ȫ������Ϊ���Ѵﵽ��Ѵ�ӡЧ����<br>
���ҳ�߾��޷�����Ϊ�㣬�볢�����²���<��ʼ>-<����>-<���� regedit Ȼ��س�>Ȼ�����ε㿪<br>
HKEY_CURRENT_USER\\Software\\Microsoft\\Internet Explorer\\PageSetup\\<br>
����margin_bottom��margin_left��margin_right��margin_top��ֵ����Ϊ�㼴��
<hr align="center" width="100%" size="1" noshade>
</div>
<% end if %>
<%
k=0
j=0
set rs = server.createobject("adodb.recordset")
sql = "select * from s_depotdetail where billcode='"&billcode&"'"
rs.open sql, conn, 1, 1
page = cint(rs.recordcount/printnum+0.5)
while not rs.eof
	if k mod printnum=0 then
		j=j+1
%>
<div id="print">
<center><label class="14 b"><%=co%></label><br><label class="12 b"><%=rk_type%></label></center>
<span style=width:200px;><label class="10 b">�Ƶ����ڣ�</label><label class="10"><%=makerdate%></span>
<span style=width:200px;><label class="10 b">���ݺ��룺</label><label class="10"><%=billcode%></label></span>
<span style=width:160px;><label class="10 b">�ֹ����ţ�</label><label class="10"><%=oldbill%></label></span>
<label class="10 b"><%=capdepot%></label><label class="10"><%=depotname%></label><br>
<span style=width:440px;><label class="10 b"><%=capsupply%></label><label class="10"><%=supply%></label></span>
<label class="10 b">��ע��</label><label class="10"><%=strmemo%></label>
<div style="width:auto;height:<%=(printnum*17+51)%>px;">
<table <%=border%>>
<tr>
<td width=110 align=center><b>��Ʒ����</td>
<td width=120 align=center><b>��Ʒ����</td>
<td width=80 align=center><b>��Ʒ���</td>
<td width=50 align=center><b>��λ</td>
<td width=70 align=center><b>����</td>
<td width=70 align=center><b>����</td>
<td width=70 align=center><b>���</td>
<td width=120 align=center><b>��ע</td>
</tr>
<%
	end if
	k=k+1
	response.write "<tr>"
	response.write "<td>"&rs("goodscode")&"</td>"
	response.write "<td>"&rs("goodsname")&"</td>"
	response.write "<td>"&rs("goodsunit")&"</td>"
	response.write "<td>"&rs("units")&"</td>"
	response.write "<td align=center>"&FormatNumber(rs("number"), cint(dotnum), -1,false,false)&"</td>"
	response.write "<td align=center>"&FormatNumber(rs("price"), cint(dotprice), -1,false,false)&"</td>"
	response.write "<td align=center>"&FormatNumber(rs("price")*rs("number"), cint(dotmoney), -1,false,false)&"</td>"
	response.write "<td>"&rs("note")&"</td>"
	response.write "</tr>"
	
	if k mod printnum = 0 and k<rs.recordcount then
%>
</table></div>
&nbsp;&nbsp;<span style=width:170px;><label class="10 b">�����ˣ�</label><label class="10"><%=f_user%></label></span>
<span style=width:220px;><label class="10 b">����Ա��</label><label class="10" style="text-decoration:underline">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label></span>
<span style=width:290px;><label class="10">��ӡʱ�䣺<%=now()%></label></span>
<label class="10 b">ҳ�� <%=j%>/<%=page%></label></div>
<% if request("ptype")<>"printd" then %>
<hr align="center" width="100%" size="1" class="NOPRINT" >
<div class="PageNext"></div>
<% end if %>
<%
	end if
	
	if k=rs.recordcount then
	%>
		<tr style=border:0px;><td colspan=3 style=border:0px;><label class="10 b">��д��</span><%=rmb("123")%></label>
		<td align=right style=border:0px;><label class="10 b">�ϼƣ�</label></td><td style=border:0px; colspan=2><label class="10"><%=tnumber%></label><td style=border:0px; colspan=2><label class="10"><%="123"%></label"></td>
		</table>
		</div>
		<span style=width:170px;><label class="10 b">�����ˣ�</label><label class="10"><%=f_user%></label></span>
		<span style=width:220px;><label class="10 b">����Ա��</label><label class="10" style="text-decoration:underline">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label></span>
		<span style=width:290px;><label class="10">��ӡʱ�䣺<%=now()%></label></span>
		<label class="10 b">ҳ�� <%=j%>/<%=page%></label>
		</div>
	<%	
	end if
	
	rs.movenext
wend
rs.close
set rs = nothing
%>
<%
conn.close
set conn = nothing
%>
</body>
</html>