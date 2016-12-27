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
	capsupply = "往来单位："
	capdepot = "仓库名称："
	if rs_depot("inorout")="调拨" then
		supply = rs_depot("depotname1")
		capsupply = "调出仓库："
		capdepot = "调入仓库："
		rk_type = "仓库调拨单"
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
<title>单据打印</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<body>
<% if request("ptype")<>"printd" then %>
<div class="Noprint" style="line-height:20px;padding-top:5px;">
<OBJECT id=WebBrowser  classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2  height=0  width=0>
</OBJECT>
<input class=dh type=button value=打印单据 onclick=document.all.WebBrowser.ExecWB(6,1)>
<input class=dh type=button value=页面设置 onclick=document.all.WebBrowser.ExecWB(8,1)>
<input class=dh type=button value=打印预览 onclick=document.all.WebBrowser.ExecWB(7,1)>
<input class=dh type="reset" value="关闭" onclick=window.opener=null;window.close()><br>
您可以根据纸张大小，在【系统设置】-【选项设置】中设置每页显示记录数。<br>
首次打印时，请点击【页面设置】按钮，设置页眉、页脚为空，页边距全部设置为零已达到最佳打印效果。<br>
如果页边距无法设置为零，请尝试如下操作<开始>-<运行>-<输入 regedit 然后回车>然后依次点开<br>
HKEY_CURRENT_USER\\Software\\Microsoft\\Internet Explorer\\PageSetup\\<br>
设置margin_bottom、margin_left、margin_right、margin_top数值数据为零即可
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
<span style=width:200px;><label class="10 b">制单日期：</label><label class="10"><%=makerdate%></span>
<span style=width:200px;><label class="10 b">单据号码：</label><label class="10"><%=billcode%></label></span>
<span style=width:160px;><label class="10 b">手工单号：</label><label class="10"><%=oldbill%></label></span>
<label class="10 b"><%=capdepot%></label><label class="10"><%=depotname%></label><br>
<span style=width:440px;><label class="10 b"><%=capsupply%></label><label class="10"><%=supply%></label></span>
<label class="10 b">备注：</label><label class="10"><%=strmemo%></label>
<div style="width:auto;height:<%=(printnum*17+51)%>px;">
<table <%=border%>>
<tr>
<td width=110 align=center><b>货品编码</td>
<td width=120 align=center><b>货品名称</td>
<td width=80 align=center><b>货品规格</td>
<td width=50 align=center><b>单位</td>
<td width=70 align=center><b>数量</td>
<td width=70 align=center><b>单价</td>
<td width=70 align=center><b>金额</td>
<td width=120 align=center><b>备注</td>
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
&nbsp;&nbsp;<span style=width:170px;><label class="10 b">经办人：</label><label class="10"><%=f_user%></label></span>
<span style=width:220px;><label class="10 b">保管员：</label><label class="10" style="text-decoration:underline">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label></span>
<span style=width:290px;><label class="10">打印时间：<%=now()%></label></span>
<label class="10 b">页码 <%=j%>/<%=page%></label></div>
<% if request("ptype")<>"printd" then %>
<hr align="center" width="100%" size="1" class="NOPRINT" >
<div class="PageNext"></div>
<% end if %>
<%
	end if
	
	if k=rs.recordcount then
	%>
		<tr style=border:0px;><td colspan=3 style=border:0px;><label class="10 b">大写金额：</span><%=rmb("123")%></label>
		<td align=right style=border:0px;><label class="10 b">合计：</label></td><td style=border:0px; colspan=2><label class="10"><%=tnumber%></label><td style=border:0px; colspan=2><label class="10"><%="123"%></label"></td>
		</table>
		</div>
		<span style=width:170px;><label class="10 b">经办人：</label><label class="10"><%=f_user%></label></span>
		<span style=width:220px;><label class="10 b">保管员：</label><label class="10" style="text-decoration:underline">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label></span>
		<span style=width:290px;><label class="10">打印时间：<%=now()%></label></span>
		<label class="10 b">页码 <%=j%>/<%=page%></label>
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