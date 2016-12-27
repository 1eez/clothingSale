<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
if request("up")="go" then
	response.write "<script>self.opener.location.href=self.opener.location.href;</script>"
end if
qxlist = request.cookies("qxlist")
if instr(qxlist,"rk_add")=0 and request("detail")="" then 
	response.write "<script>alert('对不起，您没有该操作权限！');history.go(-1);</script>"
	response.end
end if
goodscodew = replace(request("goodscodew"),"!@#","'")
cklist = request.cookies("cklist")
co_name = request.cookies("co_name")
depotname=request.cookies("rkdepot")
rktype=request.cookies("rkutype")
billcode = Request.Querystring("billcode")
set t = server.createobject("adodb.recordset")
sql = "select * from t_user where loginname='"&loginname&"'"
t.open sql, conn, 1, 3
f_user = t("username")
f_depart = t("depart")
if t("ifprint1")="1" then
	f_checked = "checked"
end if
t.close
set t = nothing
reK=0
rk_date = setdate(date())
action = "rk_add_save.asp"
if billcode<>"" then
	set rs = server.createobject("adodb.recordset")
	sql = "select * from T_Depot where BillCode='"&billcode&"'"
	rs.open sql, conn, 1, 1
		rk_date = setdate(rs("adddate"))
		rktype = rs("type")
		depotname = rs("depotname")
		supply = rs("custname")
		f_user = rs("f_user")
		f_depart = rs("f_depart")
		oldbill = rs("oldbill")
		maker = rs("maker")
		makerdate = rs("makerdate")
		update_m = rs("update_m")
		update_t = rs("update_t")
		strmemo = rs("memo")
		typecode = rs("departcode")
		action = "rk_add_save.asp"&"?billcode="&billcode
		dtitle = rs("type")&rs("billcode")
	rs.close
	set rs = nothing
	
	set t = server.createobject("adodb.recordset")
	sql = "select count(*) as total from T_Depotdetail where BillCode='"&billcode&"'"
	t.open sql, conn, 1, 3
	reK = t("total")
	t.close
	set t = nothing
end if
tdstyle="font-size:10pt;text-align:right;"
%>
<html>
<title><%=co_name%>入库单登记</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script>var k=<%=reK%></script>
<script type='text/javascript' src='../js/public.js'></script>
<script type='text/javascript' src='../js/cgbill_add.js'></script>
<script type='text/javascript' src='../js/calendar.js'></script>
<script type="text/javascript" src="../js/jquery-1.3.2.min.js" ></script>
<script type="text/javascript" src="../js/mln.colselect.js"></script>
<link href="../style/mln-main.css" rel="stylesheet" type="text/css"/>
<link href="../style/mln.colselect.css" rel="stylesheet" type="text/css">
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<link href="../calendar.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
<% if request("detail")="" then %>

<% else %>
<input class=dh type="button" value="打印" onclick=openwin('bill_print.asp?ptype=printy&billcode=<%=billcode%>',850,500)>
<input class=dh type="button" value="打印(不要单价金额)" onclick=openwin('bill_printn.asp?ptype=printy&billcode=<%=billcode%>',850,500)>
<input class=dh type="button" value="导出excel" onclick=location.href='bill_print.asp?dtitle=<%=dtitle%>&ptype=printd&billcode=<%=billcode%>'>
<input class=dh type="reset" value="关闭" onclick=window.opener=null;window.close()>
<% end if %>
<form onKeyPress="if(event.keyCode==13){return false;}" name="form" method="post" action="<%=action%>" onSubmit="return validate_form()">
<center><h2>入库单登记</h2></center>
<%
if billcode <> "" then
	response.write "<table style=font-size:9pt;width:100%;><tr>"
	response.write "<td width='50%'>单号：<font style=font-size:10pt;color:#ff0000;>"&billcode&"</font></td>"
	response.write "<td width='20%'>制单人：<font style=color:#ff0000;>"&maker&"</font></td>"
	response.write "<td width='30%'>制单日期：<font style=color:#ff0000;>"&makerdate&"</font></td>"
	response.write "</tr></table>"
end if
%>
<hr>
<div id="cgshrk">
<table>
<tr>
<input type="hidden" name="intK">
<input type="hidden" name="maker" value="<%=maker%>">
<input type="hidden" name="makerdate" value="<%=makerdate%>">
<td width="15%" style=<%=tdstyle%>>入库日期：</td>
<td width="35%">
<input type="text" name="rkdate" size="12" value="<%=rk_date%>">
<img src="../images/calendar.gif" class=dh align="absmiddle" onClick="javascript:showCalendar(rkdate,0);">
<font color="#FF0000">*</font>
</td>
<td width="15%" style=<%=tdstyle%>>业务类型：</td>
<td width="35%" style="font-size:10pt;font-family:微软雅黑;">
<% SetComboy "rktype", "rk", rktype %>	
<font color="#FF0000">*</font>
</td></tr>
<tr>
<td width="15%" style=<%=tdstyle%> ><div id=ckmc>仓库：</div></td>
<td width="35%" style="font-size:10pt;font-family:微软雅黑;">
<% ComboDepot "depotname", depotname, "auto", "all"%>
<%
 ' SetCombo "depot", "select * from dict_depot where depotname in ("&cklist&")", "depotname", "depotname", depotname
%>
<font color="#FF0000">*</font>
</td>
<td width="15%" style=<%=tdstyle%>><div id=wldw>供应商：</div></td>
<td width="35%" id="dict_cate">
<div id=showcustname>
<input value="<%=supply%>" type="text" name="supply" size="24">
<font color="#FF0000">*</font>
<img style="cursor:hand" src="../images/f.gif" onclick=openrk()>
<input value="<%=departcode%>" type="hidden" name="departcode">
</div>
<div id=showdepart>
<% SetCate "depart", "typecode", supply, typecode %>
</div>
</td></tr>
<tr>
<td width="15%" style=<%=tdstyle%>>经办人：</td>
<td width="35%">
<input value="<%=f_user%>" type="text" name="f_user" size=12>
<img style="cursor:hand" src="../images/f.gif" onclick=openwin("../public/user_select.asp",500,400)>
</td>
<td width="15%" style=<%=tdstyle%>>经办部门：</td>
<td width="35%"><input value="<%=f_depart%>" type="text" name="f_depart" size=12></td>
</tr>
<tr>
<td width="15%" style=<%=tdstyle%>>备注：</td>
<td width="85%" colspan=3><textarea name="strmemo" cols=40 rows="2" wrap="VIRTUAL"><%=strmemo%></textarea></td>
</tr>
</table>
</div>
<div style="padding:4px 0;">
<input class=dh type=button onclick=checkdepot(0) name="addnew" value=添加货品>
<input class=dh type=button onclick=openwin('hp_add.asp',640,480) name="addnew" value=新增货品>
<!--
<input class=dh onclick=openwin("../public/set_table_b.asp?tablename=<%=tshow%>",480,360) type="button" name="expert" value="设置显示">
-->
条形码：<input type="text" name="barcode" size=12 onkeyup=setbarcode()>
手工单号：<input type="text" name="oldbill" size=12 value="<%=oldbill%>">
</div>
<div id="inner-table-hpzl">
<table id=t136>
<tr>
<th width=28 align=center></th>
<th width=30 align=center>序号</th>
<th width=110 align=center>货品编码</th>
<th width=120 align=center>货品名称</th>
<th width=80 align=center>货品规格</th>
<th width=30 align=center>单位</th>
<th width=60 align=center>数量</th>
<th width=60 align=center>单价</th>
<th width=60 align=center>金额</th>
<th width=62 align=center>备注</th>
</tr>
<%
if billcode <> "" then
	set t = server.createobject("adodb.recordset")
	sql = "select * from s_Depotdetail where BillCode='"&billcode&"' order by DepotDetailID"
	t.open sql, conn, 1, 3
	for i = 1 to t.RecordCount
		response.write "<tr height=25>"
		response.write "<td><a class=delete href=javascript:void(0) onclick=del()>删除</a></td>"
		response.write "<td>"&i&"</td>"
		response.write "<td><input value="""&t("goodscode")&""" style=width:80%;border:0px; readonly type=text name=goodscode"&i&"><img style=padding-top:10px;cursor:hand onclick=checkdepot("&i&"); src=../images/find.gif></td>" 
		response.write "<td><input value="""&t("goodsname")&""" style=width:100%;border:0px; readonly type=text name=goodsname"&i&"></td>"
		response.write "<td><input value="""&t("goodsunit")&""" style=width:100%;border:0px; readonly type=text name=goodsunit"&i&"></td>"
		response.write "<td><input value="""&t("units")&""" style=width:100%;border:0px; readonly type=text name=units"&i&"></td>"
		response.write "<td><input value="""&SetSmallInt(t("number"))&""" onkeyup=changenumber("&i&") style=width:100%;text-align:right type=text name=number"&i&"></td>"
		response.write "<td><input value="""&SetSmallInt(t("price"))&""" onkeyup=changeprice("&i&") style=width:100%;text-align:right type=text name=price"&i&"></td>"
		response.write "<td><input value="""&SetSmallInt(t("price") * t("number"))&""" onkeyup=changecmoney("&i&") style=width:100%;text-align:right type=text name=cmoney"&i&"></td>"
		response.write "<td><input value="""&t("note")&""" style=width:100%; type=text name=note"&i&"></td>"
		response.write "</tr>"
		t.movenext
	next
	response.write "<script>document.all.intK.value="&t.recordcount&"</script>"
	t.close
	set t = nothing	
end if
%>
<%
if goodscodew <> "" then
	set t = server.createobject("adodb.recordset")
	sql = "select * from t_goods where goodscode in ("&goodscodew&")"
	t.open sql, conn, 1, 3
	for i = 1 to t.RecordCount
		response.write "<tr height=25>"
		response.write "<td><a class=delete href=javascript:void(0) onclick=del()>删除</a></td>"
		response.write "<td>"&i&"</td>"
		response.write "<td><input value="""&t("goodscode")&""" style=width:70%; type=text name=goodscode"&i&"><img style=padding-top:10px;cursor:hand onclick=checkdepot("&i&"); src=../images/find.gif></td>" 
		response.write "<td><input value="""&t("goodsname")&""" style=width:100%; type=text name=goodsname"&i&"></td>"
		response.write "<td><input value="""&t("goodsunit")&""" style=width:100%; type=text name=goodsunit"&i&"></td>"
		response.write "<td><input value="""&t("units")&""" style=width:100%; type=text name=units"&i&"></td>"
		response.write "<td><input value=0 onkeyup=changenumber("&i&") style=width:100%; type=text name=number"&i&"></td>"
		response.write "<td><input value="""&SetSmallInt(t("inprice"))&""" onkeyup=changeprice("&i&") style=width:100%; type=text name=price"&i&"></td>"
		response.write "<td><input value=0 onkeyup=changecmoney("&i&") style=width:100%; type=text name=cmoney"&i&"></td>"
		response.write "<td><input value="""&t("note")&""" style=width:100%; type=text name=note"&i&"></td>"
		response.write "</tr>"
		t.movenext
	next
	response.write "<script>document.all.intK.value="&t.recordcount&"</script>"
	t.close
	set t = nothing	
end if
%>

</table>
<table style=border-top:0px #ff0000 solid;>
<tr>
<th clospan=2 width=58 style=border-top:0px #ff0000 solid; align=center>合计：</th>
<th colspan=4 width=340 style=border-top:0px #ff0000 solid;><div id=moneyd style=font-weight:normal>零</div></th>
<th colspan=2 width=120 style=border-top:0px #ff0000 solid;><div id=numbera style=font-weight:normal>0</div></th>
<th colspan=2 width=122 style=border-top:0px #ff0000 solid;><div id=moneyx style=font-weight:normal>0</div></th>
</tr>
</table>
</div>
<center>
<div style="padding:4px 0">
<% if request("detail")="" then %>
<input class=dh type="submit" value="保存" name=submit>
<input class=dh type="reset" value="重置">
<input class=dh type="reset" value="关闭" onclick=window.opener=null;window.close()><br>
<% else %>
<input class=dh type="button" value="打印" onclick=openwin('bill_print.asp?ptype=printy&billcode=<%=billcode%>',850,500)>
<input class=dh type="button" value="打印(不要单价金额)" onclick=openwin('bill_printn.asp?ptype=printy&billcode=<%=billcode%>',850,500)>
<input class=dh type="button" value="导出excel" onclick=location.href='bill_print.asp?dtitle=<%=dtitle%>&ptype=printd&billcode=<%=billcode%>'>
<input class=dh type="reset" value="关闭" onclick=window.opener=null;window.close()>
<% end if %>
<% if billcode="" then %>
<input type="checkbox" name="ifprint" value="1" <%=f_checked%>>保存后弹出打印
<% end if %>
</div>
<script>
changecaption();
document.all('moneyx').innerHTML=0
document.all('numbera').innerHTML=0
for(j=1;j<parseInt(document.all.intK.value)+1;j++){
	document.all('numbera').innerHTML=parseFloat(document.all('numbera').innerHTML)+parseFloat(document.all('number'+j).value);
}
for(j=1;j<parseInt(document.all.intK.value)+1;j++){
	document.all('moneyx').innerHTML=parseFloat(document.all('moneyx').innerHTML)+parseFloat(document.all('cmoney'+j).value);
}
document.all('moneyx').innerHTML=parseFloat((document.all('moneyx').innerHTML)).toFixed(2)
document.all('moneyd').innerHTML=number2num1(document.all('moneyx').innerHTML)
</script>
</center>
</form>
</body>
</html>