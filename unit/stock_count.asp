<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "商品进销存汇总"
if  request("ptype")="printd" then
	border="border=1"
	Response.AddHeader "Content-Disposition", "attachment;filename="&dTitle&setdate(date())&".xls"
	Response.ContentType  =  "application/vnd.ms-excel"
end if
DeleteKey = "商品款号"
DeleteNote = ""
sAdd = "hp_add"
sEdit = "hp_edit"
sDetail = "hp_detail"
sDelete = "hp_delete"
tShow = "tStockCount"
EditUrl = "../unit/Hp_Add.asp"
DeleteUrl = "tGoods"
SelectUrl = "cgBill"
FormName = "stock_count.asp"
KeyField = "GoodsStyle"
EditWidth = "120"
fDo = "0"
fWidth="640"
fHeight="480"
EditTh = ""
sqlwhere = ""
GoodsStyle=request("GoodsStyle")
GoodsName=request("GoodsName")
GoodsType=request("GoodsType")
TypeCode=request("TypeCode")
GoodsBrand=request("GoodsBrand")
begindate=request("begindate")
enddate=request("enddate")
DepotName=request("DepotName")
if request("begindate")="" then
	begindate = setdate(Year(now)&"-"&Month(now)&"-01")
end if
if request("enddate")="" then
	enddate = setdate(date())
end if
sqlwhere = sqlwhere & addsql("GoodsStyle",GoodsStyle,"like")
sqlwhere = sqlwhere & addsql("GoodsName",GoodsName,"like")
sqlwhere = sqlwhere & addsql("TypeCode",TypeCode,"likecate")
if DepotName<>"" then
	depotgroup = ",depotname "
	depotfield = " depotname, "
	depotsql = " depotname='"&DepotName&"' and "
else
	depotsql = " 1=1 and "
end if
'-------------------------------------------------------------------------------------------------------------
	q = "select * from (select a.*,Avgprice,startnumber,startmon,innumber,inmoney,outnumber,outmoney,endnumber,endmon"
	q = q&" from (((tGoods a left join"
	q = q&" (select GoodsStyle,round(Sum([sign]*[number1]),2) AS Startnumber,"
	q = q&" iif(Sum([sign]*[number1])=0,0,Sum([sign]*[number1]*[inprice])) AS StartMon,'','',''"
	'q = q&" from vBillDetail where "&depotsql&" 1=1 and depotname in ("&cklist&") and cdate(adddate)<#"&begindate&"# group by GoodsStyle) b on a.GoodsStyle=b.GoodsStyle)"
	q = q&" from vBillDetail where "&depotsql&" 1=1 and cdate(adddate)<#"&begindate&"# group by GoodsStyle) b on a.GoodsStyle=b.GoodsStyle)"
	q = q&" left join (select"
	q = q&" iif(round(Sum([sign]*[number1]),2)=0 or isnull(Sum([sign]*[number1])),0,Sum([sign]*[number1]*[inprice])/Sum([sign]*[number1])) AS Avgprice, "
	q = q&" iif(round(Sum([sign]*[number1]),2)=0 or isnull(Sum([sign]*[number1])),0,Sum([sign]*[number1]*[inprice])) AS EndMon, " 
	q = q&" GoodsStyle, Sum([sign]*[number1]) AS Endnumber"
	q = q&" from vBillDetail where"
	q = q&  depotsql
	'q = q&" 1=1 and depotname in ("&cklist&") and cdate(adddate)<=#"&enddate&"# group by GoodsStyle) c on a.GoodsStyle=c.GoodsStyle)"
	q = q&" 1=1 and cdate(adddate)<=#"&enddate&"# group by GoodsStyle) c on a.GoodsStyle=c.GoodsStyle)"
	q = q&" left join (select"
	q = q&" iif(Sum([number1])=0 or isnull(Sum([number1])),0,Sum([number1]*[inprice])) AS OutMoney, " 
	q = q&" GoodsStyle, Sum([number1]) AS Outnumber"
	q = q&" from vBillDetail where"
	q = q&  depotsql
	'q = q&" 1=1 and  depotname in ("&cklist&") and sign=-1 and"
	q = q&" 1=1 and sign=-1 and"
	q = q&" cdate(adddate)>=#"&begindate&"# and cdate(adddate)<=#"&enddate&"# group by GoodsStyle) d on a.GoodsStyle=d.GoodsStyle)"
	q = q&" left join (select"
	q = q&" iif(Sum([number1])=0 or isnull(Sum([sign]*[number1])),0,Sum([sign]*[number1]*[inprice])) AS InMoney, " 
	q = q&" GoodsStyle, iif(round(Sum([number1]),2)=0 or isnull(Sum([sign]*[number1])),0,Sum([sign]*[number1])) AS Innumber"
	q = q&" from vBillDetail where"
	q = q&  depotsql
	'q = q&" 1=1 and depotname in ("&cklist&") and sign=1 and"
	q = q&" 1=1 and sign=1 and"
	q = q&" cdate(adddate)>=#"&begindate&"# and cdate(adddate)<=#"&enddate&"# group by GoodsStyle) e on a.GoodsStyle=e.GoodsStyle) as a23 "
	q = q&" where (startnumber<>0 or innumber<>0 or outnumber<>0 or endnumber<>0) and 1=1 "&sqlwhere
	'response.write q
  'response.end
	sqlexcel = q
'-------------------------------------------------------------------------------------------------------------
%>
<html>
<title><%=dtilte%></title>
<head><meta http-equiv="Content-Type" content="text/html; charset=<%=scharset%>">
<script type='text/javascript' src='../js/calendar.js'></script>
<script type='text/javascript' src='../js/public.js'></script>

</head>
<body>
<% if request("ptype")<>"printd" then %>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<link href="../calendar.css" rel="stylesheet" type="text/css" media="all" />
<fieldset style="width:auto;"><legend>查询信息</legend>
<form name="form" method="get" action="<%=FormName%>">
<div style="float:left;width:100%;height:auto;line-height:1px">
<table style="border:0px;font-size:12px;">
<tr>
<td style="border:0px">
起始日期：<input type="text" name="begindate" size="12" value="<%=begindate%>">
<input type="button" name="btnbgCalendarUI" class="btn_01" onclick="javascript:showCalendar(begindate,0);" style="width:17px; height:18px; background: url(../images/calendar.gif) no-repeat; padding:0; border:none; border:0; cursor:pointer;"/> 
<img src="../images/blank.png" width="1" /><br>
商品类别：<input type="text" class="catetree" name="GoodsType" value="<%=GoodsType%>" readonly size=12>
<img id="dt_3" style="cursor:hand" src="../images/f.gif">
<input type="hidden" name="TypeCode" value="<%=TypeCode%>">
<div id="mbDIV" style="display: none;"></div>
<div id="loginDIV" style="top:200px;left: 300px;display: none;">
<div id="loginTopDIV">&nbsp;单击选择类别</div>
<div id=height300 style="overflow:auto;">
<%
SetBasic "商品类别","TypeCode","GoodsType",""
%>
</div>
<div id=loginDIV1>
<center>
<input type="button" value="关闭" onclick=closeselect() style="cursor: pointer;">
</center>
</div>
</div>
<!-- #include file="../public/s_select.asp" --><br>
商品款号：<input type="text" name="GoodsStyle" value="<%=GoodsStyle%>" size=12>
</td>
<td style="border:0px">
截止日期：<input type="text" name="enddate" size="12" value="<%=enddate%>">
<input type="button" name="btnendCalendarUI" class="btn_01" onclick="javascript:showCalendar(enddate,0);" style="width:17px; height:18px; background: url(../images/calendar.gif) no-repeat; padding:0; border:none; border:0; cursor:pointer;"/> 
<img src="../images/blank.png" width="1"><br>
店铺名称：<% ComboDepot "DepotName", DepotName, "auto", "all"%><br>
商品名称：<input type="text" name="GoodsName" value="<%=GoodsName%>" size=12>
</td>
<td style="border:0px">
<input type="hidden" value="<%=request("orderf")%>" name=orderf>
<input type="hidden" value="<%=request("ordero")%>" name=ordero>
<input type="submit" name="find" value="查询" class=dh>
</td>
</form>
</tr>
</table>
</div>
</fieldset>
<fieldset style="width:auto;"><legend><%=dTitle%></legend>
<% end if %>
<%
chaetime = timer()
response.write "<script>var currentActiveRow;function change(el){var x = el.rowIndex;if(currentActiveRow)currentActiveRow.style.backgroundColor='';currentActiveRow=el;el.style.backgroundColor = ++d[x]%2 ? '#D5D5D5' : '#D5D5D5';}</script>"
if request("ptype")="printd" then
	response.write "<div><table id='table1' border=1 style=width:1px;height:1px;font-size:9pt>"
else
	response.write "<div id=inner-table-hpzl><table id=table1>"
end if
set t = server.createobject("adodb.recordset")
sql = "select * from tfieldshow where show=true and tablename='"&tshow&"' order by showid"
t.open sql, conn, 1, 1
Fieldcolspan=t.recordcount
response.write "<tr><th rowspan=2 width=30 align=center>序号</th>"
while not t.eof 
	img = ""
	img1 = ""
	if orderf=t("field") then
		if ordero = "desc" then
			img = "<img src=../images/desc.gif>"
		end if
		if ordero = "asc" then
			img = "<img src=../images/asc.gif>"
		end if
	end if
	if instr("startnumber,endnumber,innumber,outnumber",t("field"))<=0 then
		span=" rowspan=2"
		order=" onclick=order(this)"
	end if
	if t("field")="StartNumber" then
		if orderf=t("field") then
			if ordero = "desc" then
				img = "<img src=../images/desc.gif>"
			end if
			if ordero = "asc" then
				img = "<img src=../images/asc.gif>"
			end if
		end if
		span=" colspan=2"
		if orderf="StartNumber" then
			if ordero = "desc" then
				img = "<img border=0 src=../images/desc.gif>"
			end if
			if ordero = "asc" then
				img = "<img border=0 src=../images/asc.gif>"
			end if
		end if
		if orderf="StartMon" then
			if ordero = "desc" then
				img1 = "<img border=0 src=../images/desc.gif>"
			end if
			if ordero = "asc" then
				img1 = "<img border=0 src=../images/asc.gif>"
			end if
		end if
		str_th=str_th&"<th width=80 align=center><a class=operation href=# onclick=order(this) value=StartNumber>数量"&img&"</a></th>"
		str_th=str_th&"<th width=80 align=center><a href=# onclick=order(this) value=StartMon class=operation>金额"&img1&"</a></th>"
		order=""
	end if
	if t("field")="EndNumber" then
		span=" colspan=2"
		if orderf="EndNumber" then
			if ordero = "desc" then
				img = "<img border=0 src=../images/desc.gif>"
			end if
			if ordero = "asc" then
				img = "<img border=0 src=../images/asc.gif>"
			end if
		end if
		if orderf="EndMon" then
			if ordero = "desc" then
				img1 = "<img border=0 src=../images/desc.gif>"
			end if
			if ordero = "asc" then
				img1 = "<img border=0 src=../images/asc.gif>"
			end if
		end if
		str_th=str_th&"<th width=80 align=center><a href=# onclick=order(this) value=EndNumber class=operation>数量"&img&"</a></th>"
		str_th=str_th&"<th width=80 align=center><a href=# onclick=order(this) value=EndMon class=operation>金额"&img1&"</a></th>"
		order=""
	end if
	if t("field")="InNumber" then
		span=" colspan=2"
		if orderf="InNumber" then
			if ordero = "desc" then
				img = "<img border=0 src=../images/desc.gif>"
			end if
			if ordero = "asc" then
				img = "<img border=0 src=../images/asc.gif>"
			end if
		end if
		if orderf="InMoney" then
			if ordero = "desc" then
				img1 = "<img border=0 src=../images/desc.gif>"
			end if
			if ordero = "asc" then
				img1 = "<img border=0 src=../images/asc.gif>"
			end if
		end if
		str_th=str_th&"<th width=80 align=center><a href=# onclick=order(this) value=InNumber class=operation>数量"&img&"</a></th>"
		str_th=str_th&"<th width=80 align=center><a href=#  onclick=order(this) value=InMoney class=operation>金额"&img1&"</a></th>"
		order=""
	end if
	if t("field")="OutNumber" then
		span=" colspan=2"
		if orderf="OutNumber" then
			if ordero = "desc" then
				img = "<img border=0 src=../images/desc.gif>"
			end if
			if ordero = "asc" then
				img = "<img border=0 src=../images/asc.gif>"
			end if
		end if
		if orderf="OutMoney" then
			if ordero = "desc" then
				img1 = "<img border=0 src=../images/desc.gif>"
			end if
			if ordero = "asc" then
				img1 = "<img border=0 src=../images/asc.gif>"
			end if
		end if
		str_th=str_th&"<th width=80 align=center><a href=# onclick=order(this) value=OutNumber class=operation>数量"&img&"</a></th>"
		str_th=str_th&"<th width=80 align=center><a href=# onclick=order(this) value=OutMoney class=operation>金额"&img1&"</a></th>"
		order=""
	end if
	response.write "<th"&span&" align=center valign=center width="&t("width")&">"
	response.write "<a href=# "&order&" value='"&t("field")&"' class=operation>"&t("name")&"</a>"&img
	response.write "</th>"
	fields=fields & "," & t("field")
	t.movenext
wend
response.write "</tr>"
response.write "<tr>"&str_th&"</tr>"
Set mypage=new xdownpage
mypage.getconn = conn
mypage.getsql = sqlexcel
if request("ptype")<>"printd" then
	mypage.pagesize = 40
else
	mypage.pagesize = 400000
end if
set rs=mypage.getrs()
strwarning = ""
if rs.eof then
	strwarning = "此查询没有记录"
end if
for i = 1 to mypage.pagesize
	if not rs.eof then
	if request("page")="" then
		recno = i
	else
		recno = i + (request("page")-1)*mypage.pagesize
	end if
	response.write("<tr onClick=""change(this)""><th align=center><font color=#800080>"&recno&"</font></th>")
	set t = server.createobject("adodb.recordset")
	sql = "select * from tfieldshow where show=true and tablename='"&tshow&"' order by showid"
	sumsql = sql
	t.open sql, conn, 1, 1
	Fieldcolspan=t.recordcount
	while not t.eof
		f_field=t("field")
		f_field = replace(f_field, "a.", "")
		f_zero = rs(""&f_field&"")
		if t("dotsize")="1" then
			if isnull(f_zero) then
				f_zero = FormatNumber(0, cint(dotnum), -1,false,false)
			else
				f_zero = FormatNumber(f_zero, cint(dotnum), -1,false,false)
			end if
		end if
		if t("dotsize")="2" then
			if isnull(f_zero) then
				f_zero = FormatNumber(0, cint(dotprice), -1,false,false)
			else
				f_zero = FormatNumber(f_zero, cint(dotprice), -1,false,false)
			end if
		end if
		if t("dotsize")="3" then
			if isnull(f_zero) then
				f_zero = FormatNumber(0, cint(dotmoney), -1,false,false)
			else
				f_zero = FormatNumber(f_zero, cint(dotmoney), -1,false,false)
			end if
		end if	
		f_zero1=""
		if t("field")="EndNumber" then
			f_zero1=rs("endmon")
			if isnull(f_zero1) then
				f_zero1 = FormatNumber(0, cint(dotmoney), -1,false,false)
			else
				f_zero1 = FormatNumber(f_zero1, cint(dotmoney), -1,false,false)
			end if
		end if
		if t("field")="StartNumber" then
			f_zero1=rs("startmon")
			if isnull(f_zero1) then
				f_zero1 = FormatNumber(0, cint(dotmoney), -1,false,false)
			else
				f_zero1 = FormatNumber(f_zero1, cint(dotmoney), -1,false,false)
			end if
		end if
		if t("field")="InNumber" then
			f_zero1=rs("inmoney")
			if isnull(f_zero1) then
				f_zero1 = FormatNumber(0, cint(dotmoney), -1,false,false)
			else
				f_zero1 = FormatNumber(f_zero1, cint(dotmoney), -1,false,false)
			end if
		end if
		if t("field")="OutNumber" then
			f_zero1=rs("outmoney")
			if isnull(f_zero1) then
				f_zero1 = FormatNumber(0, cint(dotmoney), -1,false,false)
			else
				f_zero1 = FormatNumber(f_zero1, cint(dotmoney), -1,false,false)
			end if
		end if	
		response.write("<td "&fcolor&" title="""&f_zero&""">"&f_zero&"</td>")
		if f_zero1<>"" then
			response.write("<td "&fcolor&" title="""&f_zero1&""">"&f_zero1&"</td>")
		end if
		fcolor=""
		t.movenext
	wend
	rs.movenext
	end if
next

	strsum = "<td></td>"
	if f_do="1" then
		strsum = strsum & "<td></td>"
	end if
	set t = server.createobject("adodb.recordset")
	set t1 = server.createobject("adodb.recordset")
	if ifdo<>1 then
		sumsql = sql
		dosumsql = " from ("&sqlexcel&")"
		t.open sql, conn, 1, 1
		while not t.eof
			if t("sumfield")=1 then
				dosumsql1 = "select sum(" & t("field") & ") " & dosumsql
				t1.open dosumsql1, conn, 1, 1
				f_zero = t1.fields(0).value
				t1.close
				
				f_zero1 = ""
				if t("dotsize")="1" then
		  			if isnull(f_zero) then
			  			f_zero = FormatNumber(0, cint(dotnum), -1,false,false)
			  		else
			  			f_zero = FormatNumber(f_zero, cint(dotnum), -1,false,false)
			  		end if
				end if
				
				if t("dotsize")="3" then
		  			if isnull(f_zero) then
			  			f_zero = FormatNumber(0, cint(dotmoney), -1,false,false)
			  		else
			  			f_zero = FormatNumber(f_zero, cint(dotmoney), -1,false,false)
			  		end if
				end if
				
				if instr("StartNumber,InNumber,OutNumber,EndNumber",t("field"))  then
					if t("field")="StartNumber" then
						dosumsql1 = "select sum(startmon) " & dosumsql
					end if
					if t("field")="InNumber" then
						dosumsql1 = "select sum(inmoney) " & dosumsql
					end if
					if t("field")="OutNumber" then
						dosumsql1 = "select sum(outmoney) " & dosumsql
					end if
					if t("field")="EndNumber" then
						dosumsql1 = "select sum(endmon) " & dosumsql
					end if
					t1.open dosumsql1, conn, 1, 1
					f_zero1 = t1.fields(0).value
					if isnull(f_zero1) then
			  			f_zero1 = FormatNumber(0, cint(dotmoney), -1,false,false)
			  		else
			  			f_zero1 = FormatNumber(f_zero1, cint(dotmoney), -1,false,false)
			  		end if
					t1.close
				end if
				
				strsum = strsum&"<td>"&f_zero&"</td>"
				if f_zero1<>"" then
					strsum = strsum&"<td>"&f_zero1&"</td>"
				end if
			end if

			if t("sumfield")=0 then
				strsum = strsum&"<td></td>"
			end if
			t.movenext
		wend
		set t1=nothing
	end if
	if replace(strsum,"<td></td>","")<>"" then
		response.write "<tr style=color:#ff0000;>"&strsum&"</tr>"
	end if
	chaetime = timer()-chaetime
if  request("ptype")<>"printd" then
Fieldcolspan=Fieldcolspan+4
if exceltable="" then
	if strwarning<>"" then
		response.write("<tr><td align=left colspan="&Fieldcolspan&">"&strwarning&"</td></tr>")
	end if
	response.write("<tr><th align=left colspan="&Fieldcolspan + 1&">")
	mypage.showpage()
	response.write "执行时间："&FormatNumber(chaetime, 4, -1,false,false)&"(秒)"
	response.write "&nbsp;&nbsp;"
	if instr(qxlist,"f_column")>0 or 1=1 then
		response.write "<a href=javascript: class=ulink "
		response.write "onclick=openwin('../public/set_table_n.asp?tablename="&tshow&"&dtitle="&dtitle&"',480,360) >设置列显示</a>"
		%>
<form name=formexport action="../unit/stock_count.asp" method=post target=_blank>
<input type="hidden" name="tshow" value="<%=tshow%>">
<input type="hidden" name="sql" value="<%=sqlexcel%>">
<input type="hidden" name="title" value="<%=dTitle%>">
<input type="hidden" name="ptype" value="printd">
<a href="javascript:" onClick="javascript:document.formexport.submit();" class="ulink">导出Excel</a>
</form>        
        <%
	end if 
	response.write("</th></tr>")
end if
end if
response.write("</table>")
response.write("</div>")
response.write "<script>"
response.write "var d = new Array(document.getElementById('table1').rows.length);"
response.write "for(i=0;i<d.length;i++)d[i]=0"
response.write "</script>"
%>
</body>
</html>