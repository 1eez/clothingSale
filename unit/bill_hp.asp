<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "单据横排显示"
if request("ptype")="printd" then
	border="border=1"
	Response.AddHeader "Content-Disposition", "attachment;filename="&dTitle&".xls"
	Response.ContentType  =  "application/vnd.ms-excel"
end if
BillCode = request("BillCode")
set t = server.createobject("adodb.recordset")
sql = "select * from tSoftInfo"
t.open sql, conn, 1, 1
coname = t("coname")
printnum = t("billpage")
t.close
q = "select * from tBill where BillCode='"&BillCode&"'"
t.open q, conn, 1, 1
billtype = t("billtype")
custname = t("custname")
depotname = t("depotname")
oldbill = t("oldbill")
mremark = t("mremark")
fuser = t("fuser")
t.close
colwhere =  " and colPosition in (select colPosition from vBillDetail where BillCode='"&BillCode&"')"
rowwhere =  " and rowPosition in (select rowPosition from vBillDetail where BillCode='"&BillCode&"')"
if billtype="采购进货" then
	billtypecaption = "　供应商："
	sHpSql = SetHpSql(colwhere)
end if
if billtype="期初录入" then
	billtypecaption = ""
	sHpSql = SetHpSql(colwhere)
end if
if billtype="采购退货" then
	billtypecaption = "　供应商："
	sHpSql = SetHpSqlCk(colwhere)
end if
if billtype="销售出货" then
	billtypecaption = "　　客户："
	sHpSql = SetHpSqlCk(colwhere)
end if
if billtype="销售退货" then
	billtypecaption = "　　客户："
	sHpSql = SetHpSqlCk(colwhere)
end if
if billtype="店铺调拨" then
	billtypecaption = "调入仓库："
	sHpSql = SetHpSqlCk(colwhere)
	sqlw = " and sign=1"
end if
sqlexcel = "select "&sHpSql&" BillCode, [Units], CustName, [GoodsStyle], [GoodsName], ColorName, ColorCode,ColorValue, Price, sum(money1) AS tMon, sum(Number1) AS tNum FROM vBillDetail where BillCode='"&BillCode&"' "&sqlw&" GROUP BY BillCode, [Units], CustName, [GoodsStyle], [GoodsName], ColorName, ColorCode, ColorValue, Price"
q = "select sum(tnum),sum(tmon) from ("&sqlexcel&") as a1"
t.open q, conn, 1, 1
tnumber = t.fields(0).value
tmon = t.fields(1).value
t.close
bottom = "<span style=width:170px;><label class='10 b'>经办人：</label><label class='10'>"&fuser&"</label></span>"
bottom = bottom&"<span style=width:220px;><label class='10 b'>保管员：</label>"
bottom = bottom&"<label class='10' style='text-decoration:underline'>"
bottom = bottom&"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label></span>"
bottom = bottom&"<span style=width:290px;><label class='10'>打印时间："&now()&"</label></span>"
%>
<html>
<title><%=dTitle%></title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%=scharset%>"> 
<script>
var hkey_root,hkey_path,hkey_key;
hkey_root = "HKEY_CURRENT_USER";
hkey_path = "\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";
document.write("<OBJECT classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0 VIEWASTEXT></OBJECT>");
    var RegWsh = new ActiveXObject("WScript.Shell");
    hkey_key="header";
    RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"");
    hkey_key="footer";
    RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"");
	hkey_key="margin_bottom";
    RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"0");
	hkey_key="margin_left";
    RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"0");
	hkey_key="margin_right";
    RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"0");
	hkey_key="margin_top";
    RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"0");
</script>
</head>
<body>
<script type='text/javascript' src='../js/public.js'></script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<style media=print>
.Noprint{display:none;}
.PageNext{page-break-after: always;}
</style>
<% if request("ptype")<>"printd" then %>
<div class="Noprint" style="line-height:20px;padding-top:5px;">
<OBJECT id=WebBrowser  classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2  height=0  width=0>
</OBJECT>
<input class=dh type=button value=打印单据 onclick=document.all.WebBrowser.ExecWB(6,1)>
<input class=dh type=button value=页面设置 onclick=document.all.WebBrowser.ExecWB(8,1)>
<input class=dh type=button value=打印预览 onclick=document.all.WebBrowser.ExecWB(7,1)>
<input class=dh type=button value=关闭 onclick=window.opener=null;window.close();><br>
<font color="#FF0000">您可以根据纸张大小，在【系统设置】-【选项设置】中设置每页显示记录数。</font>
<hr align="center" width="100%" size="1" noshade>
</div>
<% end if %>
<%
k=0
m=0
set rs = server.createobject("adodb.recordset")
set t = server.createobject("adodb.recordset")
set f = server.createobject("adodb.recordset")
rs.open sqlexcel, conn, 1, 1
page = cint(rs.recordcount/printnum+0.5)
while not rs.eof
	if k mod printnum=0 then
		m=m+1
%>
<div id=print>
<center><label class="14 b"><%=coname%></label><br><label class="12 b"><font color="#0000FF"><%=billtype%></font></label></center>
<span style=width:200px;><label class="10 b"><%=billtypecaption%></label><label class="10"><%=custname%></span>
<span style=width:240px;><label class="10 b">单据号码：</label><label class="10"><%=billcode%></label></span>
<span style=width:160px;><label class="10 b">手工单号：</label><label class="10"><%=oldbill%></label></span><br>
<span style=width:200px;><label class="10 b">店铺名称：</label><label class="10"><%=depotname%></label></span>
<label class="10 b">　　备注：</label><label class="10"><%=MRemark%></label>
<%
dim sizecola()
q = "select distinct colPosition from tSize where 1=1 "&colwhere&" order by colPosition"
t.open q, conn, 1, 1
redim sizecola(t.recordcount)
sizecol = t.recordcount
for i = 0 to t.recordcount - 1
	sizecola(i) = t.fields(0).value
	t.movenext
next
t.close
q = "select distinct rowPosition from tSize where 1=1 "&rowwhere&" order by rowPosition"
t.open q, conn, 1, 1
rownum = t.recordcount
l = 0
%><div style="width:auto;height:<%=(printnum*17+51+rownum*17)%>px;">
<table <%=border%>>
<%
while not t.eof
	if l=0 then
		response.write "<tr><th colspan=8 rowspan="&rownum&">商品尺码横排信息</th>"
	else
		response.write "<tr>"
	end if
	q = "select * from tSize where rowPosition="&t.fields(0).value&" "&colwhere&" order by colPosition"
	f.open q, conn, 1, 1
	j = 0
	for i = 0 to f.recordcount - 1
		if f("colPosition")=sizecola(j) then
			response.write "<th width=25><b>"&f("SizeName")&"</th>"
			j = j + 1
		else
			response.write "<th></th>"
			do while f("colPosition")<>sizecola(j)
				j = j + 1
				if f("colPosition")=sizecola(j) then
					response.write "<th width=40 align=center><b>"&f("SizeName")&"</th>"
					j = j + 1
					exit do
				else
					response.write "<th></th>"
				end if
			loop			
		end if
		f.movenext
	next
	f.close
	response.write "</tr>"
	l = l +1
	t.movenext
wend
t.close
response.write "<tr>"
response.write "<th width=30>序号</th>"
response.write "<th width=80>商品款号</th>"
response.write "<th width=100>商品名称</th>"
response.write "<th width=30>单位</th>"
response.write "<th width=40>颜色</th>"
response.write "<th width=50>合计</th>"
response.write "<th width=70>单价</th>"
response.write "<th width=70>金额</th>"
for i = 1 to sizecol
	response.write "<th>数量</th>"
next
response.write "</tr>"
	end if'输出表头
	k = k + 1
	response.write "<tr>"
	response.write "<td align=center>"&k&"</td>"
	response.write "<td>"&rs("goodsstyle")&"</td>"
	response.write "<td>"&rs("goodsname")&"</td>"
	response.write "<td>"&rs("units")&"</td>"
	response.write "<td>"&rs("colorname")&"</td>"
	response.write "<td align=center>"&FormatNumber(rs("tnum"), dotnumber, -1,false,false)&"</td>"
	response.write "<td align=center>"&FormatNumber(rs("price"), dotprice, -1,false,false)&"</td>"
	response.write "<td align=center>"&FormatNumber(rs("tMon"), dotmoney, -1,false,false)&"</td>"
	j = 0
	for i = 0 to sizecol - 1
		if isnull(rs("a"&sizecola(i))) then
			response.write "<td></td>"
		else
			response.write "<td align=center>"&FormatNumber(rs("a"&sizecola(i)), dotnumber, -1,false,false)&"</td>"
		end if
	next
	if k mod printnum = 0 and k<rs.recordcount then
		response.write "</table></div>"
		response.write strbottom
		%>
<label class="10 b">页码 <%=m%>/<%=page%></label>
        <%
		response.write "</div>"
		if request("ptype")<>"printd" then
	        response.write "<hr align=center width=100% size=1 class=NOPRINT >"
        	response.write "<div class=PageNext></div>"
        end if	
	end if
	if k=rs.recordcount then
		%>
		<tr style=border:0px;><td colspan=5 style=border:0px;><label class="10 b">大写金额：</span><%=rmb(tmon)%></label>
		<td align=center style=border:0px;><label class="10 b"><%=tnumber%></label></td><td align=center style=border:0px;></td><td style=border:0px; align=center><label class="10 b"><%=tmon%></label></td></tr></table></div>
<%=bottom%>
<label class="10 b">页码 <%=m%>/<%=page%></label>        
        <%
		response.write "</div>"
	end if
	rs.movenext
wend
rs.close
set rs=nothing
%>
<% if request("ptype")<>"printd" then %>
<div class="Noprint" style="line-height:20px;">
<form acton="Bill_Hp.asp" method="post">
<center>
<input type=hidden name="ptype" value="printd">
<input type=hidden name="billcode" value="<%=BillCode%>">
<input class=dh type="submit" name=submit value="导出excel">
</center>
</form>
</div>
<% end if %>
</body>
</html>