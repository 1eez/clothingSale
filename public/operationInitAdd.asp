<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
if trim(request.querystring("action"))="increase" then
  call increase()
end if
%>
<html>
<title>新增单据类型</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<h1>新增单据类型</h1><hr>
<form action="operationInitAdd.asp?action=increase" align="center" method="post">	
<table style="font-size:10pt;" width="50%" align=center>
<tr><td align=right width="50%">单据组：</td>
	<td width="50%">
		<select name="group" style="width:70px;">
			<option value="rk">入库</option>
			<option value="ck">出库</option>
		</select>
	</td>
</tr>
<tr><td align=right>类型简称：</td><td><input type="text" name="code"></td></tr>
<tr><td align=right>是否可见：</td><td><input type="checkbox" name="show" value="1"></td></tr>
<tr><td align=right>显示顺序：</td><td><input type="text" name="showid"></td></tr>
<tr><td align=right>单据名称：</td><td><input type="text" name="name"></td></tr>
<tr><td align=right>单据对象：</td><td>
	<select name='utype' style="width:80px;">
		<option value='supply'>供应商</option>
		<option value='custom'>客户</option>
	  <option value='depart'>部门</option>
	  <option value='other'>其它</option>
	</select>
</td></tr>
</table>
<div style="padding:10px 0;width:100%;float:left" align="center">
<input class=dh type="submit" value="保存" name="submit">
<input id=cz type="reset" value="重置">
<input id=close type="button" value="关闭" onclick=window.opener=null;window.close()>
</div>
</form>
</body>
</html>
<%connClose()%>
<%
sub increase()
  if trim(request.form("show"))="1" then
    showOrNot = true
  else
  	showOrNot = false
  end if
  set rs = server.createObject("adodb.recordset")
  sql = "select * from dict_bill where [code]='" & trim(request.form("code")) & "'"
  rs.open sql,conn,1,3
  if rs.recordcount<>0 then
    response.write "<script>alert('类型简称重复，请重新输入！');location.href='operationInitAdd.asp'</script>"
    response.end
  end if
  if trim(request.form("group"))="rk" then
  	inorout = "入库"
  else
  	inorout = "出库"
  end if
  sql = "insert into dict_bill([group],[code],inorout,[show],showid,[name],utype) values("
  sql = sql & "'" & trim(request.form("group")) & "',"
  sql = sql & "'" & trim(request.form("code")) & "',"
  sql = sql & "'" & inorout & "',"
  sql = sql & showOrNot & ","
  sql = sql & "'" & trim(request.form("showid")) & "',"
  sql = sql & "'" & trim(request.form("name")) & "',"
  sql = sql & "'" & trim(request.form("utype")) & "')"
  on error resume next
	  conn.beginTrans
	  conn.execute sql
	  if err.number=0 then
	    conn.commitTrans
	    Response.Write "<script>self.opener.location.href=self.opener.location.href;location.href='operationInitAdd.asp'</script>" 
	  else
	  	conn.rollbackTrans
	  end if
end sub
%>