<!-- #include file="../public/xdownpage.asp" -->
<!-- #include file="../public/settable.asp" -->
<%
Function ExportExcel()
%>
<form name=formexport action="../public/export.asp" method=post target=_blank>
<input type="hidden" name="tshow" value="<%=tshow%>">
<input type="hidden" name="sql" value="<%=sqlexcel%>">
<input type="hidden" name="title" value="<%=dTitle%>">
<a href="javascript:" onclick="javascript:document.formexport.submit();" class="ulink">导出Excel</a>
</form>
<%
End Function

Function SetHpSql(colwhere)
	qHqSql = ""
	set thp=server.createobject("adodb.recordset")
	q = "select distinct colPosition from tSize where 1=1 "&colwhere
	thp.open q, conn, 1, 1
	q = thp("colPosition")
	if not thp.Eof then
		qHpSql = qHpSql + " sum(iif(colposition="&q&",number1*Sign,null)) as [a"&q&"]"
	end if
	thp.movenext
	while not thp.eof
		q = thp("colPosition")
		qHpSql = qHpSql + ", sum(iif(colposition="&q&",number1*Sign,null)) as [a"&q&"]"
		thp.movenext
	wend
	thp.close
	set thp=nothing
	if qHpSql<>"" then
		qHpSql = qHpSql&","
	end if
	SetHpSql = qHpSql
End Function

Function SetHpSqlCk(colwhere)
	qHqSql = ""
	set thp=server.createobject("adodb.recordset")
	q = "select distinct colPosition from tSize where 1=1 "&colwhere
	thp.open q, conn, 1, 1
	q = thp("colPosition")
	if not thp.Eof then
		qHpSql = qHpSql + " sum(iif(colposition="&q&",number1,null)) as [a"&q&"]"
	end if
	thp.movenext
	while not thp.eof
		q = thp("colPosition")
		qHpSql = qHpSql + ", sum(iif(colposition="&q&",number1,null)) as [a"&q&"]"
		thp.movenext
	wend
	thp.close
	set thp=nothing
	if qHpSql<>"" then
		qHpSql = qHpSql&","
	end if
	SetHpSqlCk = qHpSql
End Function

Function addsql(rfield,sfield,stype)
  if rfield="DepotName" and sfield="全部" then
  	addsql=" and 1=1"
  else
		  
			strsql = ""
			if stype="like" then
				if sfield<>"" then
					strsql = " and "&rfield &" like '%"&sfield&"%'"
				end if
			end if
			if stype="=" then
				if sfield<>"" then
					strsql = " and "&rfield &"='"&sfield&"'"
				end if
			end if
			if stype="likecate" then
				if sfield<>"" then
					strsql = " and "&rfield &" like '"&sfield&"%'"
				end if
			end if
			addsql = strsql
	end if
End Function

Function SetDetail(caption, streecode, streename, streecodename)
	response.write "<tr><td class=iefile><a class=tree href='javascript:' value="&caption&" onclick=settreename(this,'"&streecode&"','"&streename&"','"&streecodename&"')>"&caption&"</a></td></tr>"
End Function

Function RedPoint()
	response.write "<font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>"
End Function

Function SetBasic(tablename,streecode,streename,streecodename)
%>
<table style="width:358px;" border="0" cellspacing="0" cellpadding="0" onselectstart="return true">
<tr><td><span class="collapsedFolder2" style="width:20px;height:20px;" onMouseUp="with(findObj('a00').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
<%
response.write "<a class=tree href='javascript:' value="&tablename&" onclick=settreename(this,'"&streecode&"','"&streename&"','"&streecodename&"')>"&tablename&"</a>"
%>
<tr><td class="submenu" id="a00" style="">
<table border="0" cellspacing="0" cellpadding="0">
<%
set rs=server.createobject("adodb.recordset")
q = "select * from dict_cate where tablename='"&tablename&"' order by code asc"
rs.open q, conn, 1, 1
if not rs.eof then
node1 = len(rs("code"))
code1 = rs("code")
name1 = rs("name")
rs.movenext
if rs.eof then
	SetDetail code1&"-"&name1, streecode, streename, streecodename
	response.write "</table></td></tr>"
else
while not rs.eof	
	node2 = len(rs("code"))
	code2 = rs("code")
	name2 = rs("name")
	if node1=node2 then
		SetDetail code1&"-"&name1, streecode, streename, streecodename
	end if	
	if node2-node1=2 then
		%>
		<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onMouseUp="with(findObj('<%="a"&code1%>').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
        <%
response.write "<a class=tree href='javascript:' value="&code1&"-"&name1&" onclick=settreename(this,'"&streecode&"','"&streename&"','"&streecodename&"')>"&code1&"-"&name1&"</a>"
		%></td></tr>
<tr><td class="submenu" id="<%="a"&code1%>" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
		<%
	end if
	for i = 1 to (node1-node2)/2
		if i=1 then
			SetDetail code1&"-"&name1, streecode, streename, streecodename
		end if
		response.write "</table></td></tr>"
	next
	node3 = node1
	code3 = code1
	name3 = name1
	node1 = node2
	code1 = code2
	name1 = name2
	rs.movenext
wend
if node3=node2 then
	SetDetail code2&"-"&name2, streecode, streename, streecodename
	for i = 1 to node2/2
		response.write "</table></td></tr>"
	next
end if	
if node3-node2=2 then
	
end if	
if node2-node3=2 then
	SetDetail code2&"-"&name2, streecode, streename, streecodename
	for i = 1 to node2/2
		response.write "</table></td></tr>"
	next
end if
if node3>node2 then
	SetDetail code2&"-"&name2, streecode, streename, streecodename
	response.write "</table></td></tr>"
end if	
end if
else
	response.write "</table></td></tr>"
end if
%>
</table>
<%
End Function

Function SetDetailCheckBox(caption, streecode, streename, streecodename,qxname)
	scheck = ""
	if instr(qxlist,qxname)>0 then
		scheck = "checked"
	end if
	response.write "<tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="""&qxname&""" "&scheck&"><a class=tree href='javascript:' value="&caption&" onclick=settreename(this,'"&streecode&"','"&streename&"','"&streecodename&"')>"&caption&"</a></td></tr>"
End Function

Function SetBasicCheckBox(tablename,streecode,streename,streecodename)
%>
<table style="width:358px;" border="0" cellspacing="0" cellpadding="0" onselectstart="return true">
<tr><td><span class="collapsedFolder2" style="width:20px;height:20px;" onMouseUp="with(findObj('a_0').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
<%
response.write "<input onclick=checkall() id=allcheck type=checkbox name=qxname value=-|><a class=tree href='javascript:' value="&tablename&" onclick=settreename(this,'"&streecode&"','"&streename&"','"&streecodename&"')>"&tablename&"</a>"
%>
<tr><td class="submenu" id="a_0" style="">
<table border="0" cellspacing="0" cellpadding="0">
<%
set rs=server.createobject("adodb.recordset")
if tablename="用户权限" then
	q = "select distinct '店铺管理权限' as name,'00' as code,'用户权限' as tablename,'2;' as qxname from tDepot union all "
	q = q&"select depotname,'0001','用户权限',depotname+';' from tDepot union all "
	q = q&"select name,code,tablename,qxname from dict_cate where tablename='"&tablename&"' order by code asc"
else
	q = "select name,code,tablename,qxname from dict_cate where tablename='"&tablename&"' order by code asc"
end if
rs.open q, conn, 1, 1
if not rs.eof then
node1 = len(rs("code"))
code1 = rs("code")
name1 = rs("name")
qxname1 = rs("qxname")
rs.movenext
if rs.eof then
	SetDetailCheckBox name1, streecode, streename, streecodename,qxname1
	response.write "</table></td></tr>"
else
while not rs.eof	
	node2 = len(rs("code"))
	code2 = rs("code")
	name2 = rs("name")
	qxname2 = rs("qxname")
	if node1=node2 then
		SetDetailCheckBox name1, streecode, streename, streecodename,qxname1
	end if	
	if node2-node1=2 then
		%>
		<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onMouseUp="with(findObj('<%="a"&code1%>').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
        <%
scheck = ""
if instr(qxlist, qxname1)>0 then
	scheck = "checked"
end if		
response.write "<input id=allcheck1 type=checkbox name=qxname value='"&qxname1&"' "&scheck&"><a class=tree href='javascript:' value="&name1&" onclick=settreename(this,'"&streecode&"','"&streename&"','"&streecodename&"')>"&name1&"</a>"
		%></td></tr>
<tr><td class="submenu" id="<%="a"&code1%>" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
		<%
	end if
	for i = 1 to (node1-node2)/2
		if i=1 then
			SetDetailCheckBox name1, streecode, streename, streecodename,qxname1
		end if
		response.write "</table></td></tr>"
	next
	node3 = node1
	code3 = code1
	name3 = name1
	qxname3 = qxname1
	node1 = node2
	code1 = code2
	name1 = name2
	qxname1 = qxname2
	rs.movenext
wend
if node3=node2 then
	SetDetailCheckBox name2, streecode, streename, streecodename,qxname2
	for i = 1 to node2/2
		response.write "</table></td></tr>"
	next
end if	
if node3-node2=2 then
	
end if	
if node2-node3=2 then
	SetDetailCheckBox name2, streecode, streename, streecodename,qxname2
	for i = 1 to node2/2
		response.write "</table></td></tr>"
	next
end if
if node3>node2 then
	SetDetailCheckBox name2, streecode, streename, streecodename,qxname2
	response.write "</table></td></tr>"
end if	
end if
else
	response.write "</table></td></tr>"
end if
%>
</table>
<%
End Function

Function SetComboQuick(onchangefunc,cname, sqlcombo, blank, setselect, swidth)
	response.write "<select onchange='"&onchangefunc&"' name="&cname&" style=width:"&swidth&";>"
	set t=server.createobject("adodb.recordset")
	sql = sqlcombo
	t.open sql, conn, 1, 1

	if blank="" then
		response.write "<option value=''>请选择</option>"
	end if
	do while not t.eof
		f_select = ""
		if t.fields(0).value=setselect then
			f_select = "selected"
		end if
		response.write"<option value="""&t.fields(0).value&""" "&f_select&">"&t.fields(0).value&"</option>"
		t.movenext
	loop
	t.close
	set t=nothing
	response.write "</select>"
End Function

Function SetCombo(cname, sqlcombo, blank, setselect, swidth)
	response.write "<select name="&cname&" style=width:"&swidth&";>"
	set t=server.createobject("adodb.recordset")
	sql = sqlcombo
	t.open sql, conn, 1, 1
	if blank="" then
		response.write "<option></option>"
	elseif blank="all" then
		response.write "<option value=''>全部</option>"
	elseif blank="choose" then
		response.write "<option value=''>请选择</option>"
	end if
	do while not t.eof
		f_select = ""
		if t.fields(0).value=setselect then
			f_select = "selected"
		end if
		response.write"<option value="""&t.fields(0).value&""" "&f_select&">"&t.fields(0).value&"</option>"
		t.movenext
	loop
	t.close
	set t=nothing
	response.write "</select>"
End Function

Function ComboDepot(sDepotName,setselect,swidth,blank)
	strdepot=strdepot&"<select name="&sDepotName&" style=width:"&swidth&";>"
	set t=server.createobject("adodb.recordset")
	scklist = request.cookies("cklist")
	if blank="all" then
		  if setselect="全部"  then
		  	   firstcheck = "selected"
		   end if
	    	strdepot=strdepot&"<option value='全部' "&firstcheck&">全部</option>"
	end if
	'sql = "select DepotName from tDepot where 1=1 and DepotName in ("&scklist&")"
sql = "select DepotName from tDepot order by seqno"
	t.open sql, conn, 1, 1
	if blank="" then
		'strdepot=strdepot&"<option></option>"
	end if
	do while not t.eof
		f_select = ""
		if t.fields(0).value=setselect then
			f_select = "selected"
		end if
		strdepot=strdepot&"<option value="""&t.fields(0).value&""" "&f_select&">"&t.fields(0).value&"</option>"
		t.movenext
	loop
	t.close
	set t=nothing
	strdepot=strdepot&"</select>"
	response.write strdepot
End Function

dim fields
Function getfields(tablename)
	set t=server.createobject("adodb.recordset")
	sql="select * from tFieldShow where tablename="&"'"&tablename&"'"&" order by showid"
	t.open sql,conn,1,1
	fields=t("field")
	t.movenext
	do while not t.eof
		fields=fields&","&t("field")
		t.movenext
	loop
	t.close
	set t=nothing
	result=fields
End Function

Function SetCode(aCode, aDate, aTable)
	aBillCode = aCode&"-"&aDate
	set at = server.createobject("adodb.recordset")
	sql = "select count(*) as BillCode1 from "&aTable&" where BillCode like '%"&aBillCode&"%'"
	at.open sql, conn, 1, 1
	if at("BillCode1") <> "0" then
		set at1 = server.createobject("adodb.recordset")
		sql = "select max(billcode) as BillCode1 from "&aTable&" where BillCode like '%"&aBillCode&"%'"
		at1.open sql, conn, 1, 1
		aintMax = Right(at1("BillCode1"), 4)
		aintMax = aintMax + 1
		if len(aintMax)=1 then
			aintMax = "000"&aintMax
		end if
		if len(aintMax)=2 then
			aintMax = "00"&aintMax
		end if
		if len(aintMax)=3 then
			aintMax = "0"&aintMax
		end if
		aBillCode = aBillCode&"-"&aintMax
		at1.close
		set at1 = nothing
	else
		aBillCode = aBillCode&"-0001"
	end if
	at.close
	set at = nothing
	SetCode = aBillCode
End Function

Function SetAutoCode(sKeyCode, sTableName, sTwo)
	set ft = server.createobject("adodb.recordset")
	q = "select max("&sKeyCode&") from "&sTableName&" where "&sKeyCode&" like '"&sTwo&"%'"
	ft.open q, conn, 1, 1
	if isnull(ft.fields(0).value) then
		sSetAutoCode = sTwo&"0001"
	else
		sAutoCode = right(ft.fields(0).value, 4) + 1
		for i = 1 to 4-len(sAutoCode)
			AutoCode = AutoCode&"0"
		next
		sAutoCode = AutoCode&sAutoCode
		sSetAutoCode = sTwo&sAutoCode
	end if
	SetAutoCode = sSetAutoCode
	ft.close
	set ft = nothing
End Function

Function SetAutoCode3(sKeyCode, sTableName, sTwo)
	set ft = server.createobject("adodb.recordset")
	q = "select max("&sKeyCode&") from "&sTableName&" where "&sKeyCode&" like '"&sTwo&"%'"
	ft.open q, conn, 1, 1
	if isnull(ft.fields(0).value) then
		sSetAutoCode = sTwo&"001"
	else
		sAutoCode = right(ft.fields(0).value, 3) + 1
		for i = 1 to 3-len(sAutoCode)
			AutoCode = AutoCode&"0"
		next
		sAutoCode = AutoCode&sAutoCode
		sSetAutoCode = sTwo&sAutoCode
	end if
	SetAutoCode3 = sSetAutoCode
	ft.close
	set ft = nothing
End Function

Function CheckRepeat(sKeyCode, sKeyValue, sTableName)
	set ft = server.createobject("adodb.recordset")
	q = "select * from "&sTableName&" where "&sKeyCode&"='"&sKeyValue&"'"
	ft.open q, conn, 1, 1
	if ft.recordcount>0 then
		CheckRepeat="1"
	else
		CheckRepeat="0"
	end if
	ft.close
	set ft = nothing
End Function

Function SafeRequest(ParaName)
Dim ParaValue
ParaValue=Request(ParaName)
if IsNumeric(ParaValue) = True then
SafeRequest=ParaValue
exit Function
elseIf Instr(LCase(ParaValue),"select ") > 0 or Instr(LCase(ParaValue),"insert ") > 0 or Instr(LCase(ParaValue),"delete from") > 0 or Instr(LCase(ParaValue),"count(") > 0 or Instr(LCase(ParaValue),"drop table") > 0 or Instr(LCase(ParaValue),"update ") > 0 or Instr(LCase(ParaValue),"truncate ") > 0 or Instr(LCase(ParaValue),"asc(") > 0 or Instr(LCase(ParaValue),"mid(") > 0 or Instr(LCase(ParaValue),"char(") > 0 or Instr(LCase(ParaValue),"xp_cmdshell") > 0 or Instr(LCase(ParaValue),"exec master") > 0 or Instr(LCase(ParaValue),"net localgroup administrators") > 0 or Instr(LCase(ParaValue)," and ") > 0 or Instr(LCase(ParaValue),"net user") > 0 or Instr(LCase(ParaValue)," or ") > 0 Or InStr(LCase(ParaValue),"""")>0 Or InStr(LCase(ParaValue),"'")>0 then Response.Write "请不要在函数中加入非法字符！"
Response.end
else
SafeRequest=ParaValue 
End If
End function

Function existRecord(tableName,field,fieldOldValue,fieldValue)
  set rs = server.createObject("adodb.recordset")
  sql = "select * from " & tableName & " where " & field & " not in ('" & fieldOldValue & "')"
  sql = sql & " and " & field & "='" & fieldValue & "'"
  rs.open sql,conn,1,3
  if rs.recordcount<>0 then
    existRecord = true
  end if
  rs.close
  set rs = nothing
end function

Function reportConn()'打印报表中的数据库连接设置
	connstr="DBQ="&Server.Mappath("../data/shopdata.asp")&";DRIVER={Microsoft Access Driver (*.mdb)};"
	conn.Open connstr 
End function

Function SetSmallInt(DataValue)
	if DataValue<1 then
	  if left(DataValue,1)<>"0" then
	    DataValue="0"&DataValue
	  end if
	end if
	SetSmallInt = DataValue
End Function

Function SetCate(tablename, kjname, zname, vname)
	response.write "<div id=shit style=display:inline><div id="""&kjname&""" style=display:inline></div></div>"
	response.write "<script type=""text/javascript"">"
	response.write "var colObj = {""Items"":["
	sqldict = "select * from dict_cate where table='"&tablename&"' order by c_select"
	set t = server.createobject("adodb.recordset")
	t.open sqldict, conn, 1, 1
	str = ""
	while not t.eof
		if t("c_select")<>"001" then
			str = str & "{""name"":""" & t("c_name") & """,""topid"":""" & t("c_ParentId")&""",""colid"":"""&t("c_Id")&""",""value"":"""&t("c_select")&""",""fun"":function(){}},"
		else
			str = str & "{""name"":""" & "请选择" & """,""topid"":""" & t("c_ParentId")&""",""colid"":"""&t("c_Id")&""",""value"":"""&t("c_select")&""",""fun"":function(){}},"
		end if
		t.movenext
	wend
	t.close
	set t=nothing
	if str<>"" then
	  response.write left(str,len(str)-1)
	end if
	response.write "]};"
	response.write "$(""#" & kjname & """).mlnColsel(colObj,{"
	response.write "title:""" & zname&""","
	response.write "value:"""&vname&""","
	response.write "width:60"
	response.write "});</script>"
End Function

Function SetComboo(cname, table, setselect)
	response.write "<select name="&cname&">"
	set t=server.createobject("adodb.recordset")
	sql = "select * from dict_combo where table='"&table&"' order by showid"
	t.open sql, conn, 1, 1
	while not t.eof
		f_select = ""
		if t("value")=setselect then
			f_select = "selected"
		end if
		response.write"<option value="""&t("value")&""" "&f_select&">"&t("name")&"</option>"
		t.movenext
	wend
	t.close
	set t=nothing
	response.write "</select>"
End Function

Function SetComboy(cname, table, setselect)
	response.write "<select name="&cname&" onchange=changecaption()>"
	set t=server.createobject("adodb.recordset")
	if table="rk1" or table="ck1" then
		sql = "select * from dict_bill where [group]='"&replace(table,"1","")&"' order by showid"
	else
		sql = "select * from dict_bill where [group]='"&table&"' order by showid"
	end if

	t.open sql, conn, 1, 1
	while not t.eof
		f_select = ""
		if t("name")=setselect then
			f_select = "selected"
		end if
		if table="rk1" or table="ck1" then
			response.write"<option value="""&t("name")&""" "&f_select&">"&t("name")&"</option>"
		else
			response.write"<option value="""&t("code")&"-|-"&t("utype")&""" "&f_select&">"&t("name")&"</option>"
		end if
		t.movenext
	wend
	t.close
	set t=nothing
	response.write "</select>"
End Function

Function GetType(table, cvalue)
	set t=server.createobject("adodb.recordset")
	sql = "select * from dict_cate where table='"&table&"' and c_select='"&cvalue&"'"
	t.open sql, conn, 1, 1
	if t.eof or cvalue="001" then
		GetType = ""
	else
	  GetType = t("c_name")
	end if
	t.close
	set t=nothing
End Function

Function GetLongname(table, cvalue)
	set t=server.createobject("adodb.recordset")
	sql = "select * from dict_cate where table='"&table&"' and c_select='"&cvalue&"'"
	t.open sql, conn, 1, 1
	if t.eof or cvalue="001" then
		GetLongname = ""
	else
	  GetLongname = t("longname")
	end if
	t.close
	set t=nothing
End Function

Function GetTypeCode(table, c_name)
	set t=server.createobject("adodb.recordset")
	sql = "select * from dict_cate where table='"&table&"' and c_name='"&c_name&"'"
	t.open sql, conn, 1, 1
	if t.eof then
		GetTypeCode = ""
	else
	  GetTypeCode = t("c_select")
	end if
	t.close
	set t=nothing
End Function

Function SetDate(Date)
	stryear=Year(Date)
	strMon=month(Date)
	strDay=day(date)
  If Len(strMon)<2 Then
      strMon =   "0"   &   strMon
  End   If
  If   Len(strDay)<2   Then
      strDay   =   "0"   &   strDay
  End   If
  SetDate=stryear&"-"&strMon&"-"&strDay
End Function

Function SetComboColorGroup(ColorGroup, setselect)
ColorGroup=""&ColorGroup
if ColorGroup="" then
  set t=server.createobject("adodb.recordset")
	sql = "select ColorName from tColor order by ColorCode"
	t.open sql, conn, 1, 1
	while not t.eof
                if ColorGroup="" then
                   ColorGroup=t("ColorName")
                 else
		   ColorGroup=ColorGroup& "^"& t("ColorName")
                 end if
		t.movenext
	wend
	t.close
	set t=nothing
end if
    
    ColorArray=split(ColorGroup,"^")
		for i=0 to ubound(ColorArray)
			f_select = ""
			if ColorArray(i)=setselect then
				f_select = "selected"
			end if
			response.write"<option value="&ColorArray(i)&" "&f_select&">"&ColorArray(i)&"</option>"
		next
		
	
End Function

Function SetCombojs(cname, sqlcombo, fname, vname, setselect)
	set temp=server.createobject("adodb.recordset")
	sql = sqlcombo
	temp.open sql, conn, 1, 1
	if fname="depotname" or cname="xbilltype" then
		response.write"<option value=请选择>请选择</option>"
	end if
	do while not temp.eof
		f_select = ""
		if temp(fname)=setselect then
			f_select = "selected"
		end if
		response.write"<option value="&temp(vname)&" "&f_select&">"&temp(fname)&"</option>"
		temp.movenext
	loop
	temp.close
	set temp=nothing
End Function

Function rmb(num)
num = FormatNumber(num, 2)
Dim numList
Dim rmbList
Dim numLen
Dim numChar
Dim numstr
Dim n
Dim n1, n2
Dim hz
numList = "零壹贰叁肆伍陆柒捌玖"
rmbList = "分角元拾佰仟万拾佰仟亿拾佰仟万"

If num > 9999999999999.99 Then
     rmb = "超出范围的人民币值"
     Exit Function
End If

numstr = CStr(num * 100)
numLen = Len(numstr)
n = 1
Do While n <= numLen
     numChar = CInt(Mid(numstr, n, 1))
     n1 = Mid(numList, numChar + 1, 1)
     n2 = Mid(rmbList, numLen - n + 1, 1)
     If Not n1 = "零" Then
         hz = hz + CStr(n1) + CStr(n2)
     Else
         If n2 = "亿" Or n2 = "万" Or n2 = "元" Or n1 = "零" Then
             Do While Right(hz, 1) = "零"
             hz = Left(hz, Len(hz) - 1)
             Loop
         End If
         If (n2 = "亿" Or (n2 = "万" And Right(hz, 1) <> "亿") Or n2 = "元") Then
             hz = hz + CStr(n2)
         Else
             If Left(Right(hz, 2), 1) = "零" Or Right(hz, 1) <> "亿" Then
                 hz = hz + n1
             End If
         End If
     End If
     n = n + 1
Loop
Do While Right(hz, 1) = "零"
     hz = Left(hz, Len(hz) - 1)
Loop
If Right(hz, 1) = "元" Then
     hz = hz + "整"
End If
rmb = hz
End Function

Function strCount(strA,strB)
	lngA = Len(strA)
	lngB = Len(strB)
	lngC = Len(Replace(strA,strB,""))
	strCount = (lngA - lngC) / lngB
End Function

Function ssql(a,b,sqls)
if b<>"" then
	sqls=sqls & " and " & a & " like '%" & b & "%'"
end if
ssql=sqls
End Function

Function manageLog(info)
  connstring="DBQ=" & Server.Mappath("../data/shoplog.asp")&";DRIVER={Microsoft Access Driver (*.mdb)};"
  set connt = Server.CreateObject("ADODB.connection")

  connt.Open connstring
  url = Request.ServerVariables("URL")
	If Request.ServerVariables("QUERY_STRING")<>"" Then
		url=url & "?" & Request.ServerVariables("QUERY_STRING")
	end if
	ip = request.servervariables("remote_addr")
	sql = "insert into tinfo(userName,[addtime],info)values('"
	sql = sql & session("username") & "','" & now() & "','"&info&"')"

  connt.execute sql
  connt.close
  set connt = nothing
End Function

Function myReplace(myString)
    myString=Replace(myString,"&","&amp;")         '替换&为字符实体&amp;
    myString=Replace(myString,"<","&lt;")          '替换<为字符实体&lt;
    myString=Replace(myString,">","&gt;")          '替换>为字符实体&gt;
    myString=Replace(myString,chr(32),"&nbsp;")    '替换空格符为字符实体&nbsp;
    myString=Replace(myString,chr(9)," &nbsp;&nbsp;&nbsp;&nbsp;")     '替换Tab缩进符为
    myString=Replace(myString,chr(39),"&acute;")   '替换单引号为字符实体&acute;
    myString=Replace(myString,chr(34),"&quot;")    '替换双引号为字符实体&quot;
	myString=Replace(myString,"&nbsp;","")    '替换双引号为字符实体&quot;
    myReplace=myString 
End Function 

td1 = "style=width:30%;text-align:right;"
td2 = "style=width:70%;text-align:left;"
%>