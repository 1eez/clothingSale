<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
if trim(request.querystring("action"))="increase" then
  call increase()
end if
%>
<html>
<title>������������</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<h1>������������</h1><hr>
<form action="operationInitAdd.asp?action=increase" align="center" method="post">	
<table style="font-size:10pt;" width="50%" align=center>
<tr><td align=right width="50%">�����飺</td>
	<td width="50%">
		<select name="group" style="width:70px;">
			<option value="rk">���</option>
			<option value="ck">����</option>
		</select>
	</td>
</tr>
<tr><td align=right>���ͼ�ƣ�</td><td><input type="text" name="code"></td></tr>
<tr><td align=right>�Ƿ�ɼ���</td><td><input type="checkbox" name="show" value="1"></td></tr>
<tr><td align=right>��ʾ˳��</td><td><input type="text" name="showid"></td></tr>
<tr><td align=right>�������ƣ�</td><td><input type="text" name="name"></td></tr>
<tr><td align=right>���ݶ���</td><td>
	<select name='utype' style="width:80px;">
		<option value='supply'>��Ӧ��</option>
		<option value='custom'>�ͻ�</option>
	  <option value='depart'>����</option>
	  <option value='other'>����</option>
	</select>
</td></tr>
</table>
<div style="padding:10px 0;width:100%;float:left" align="center">
<input class=dh type="submit" value="����" name="submit">
<input id=cz type="reset" value="����">
<input id=close type="button" value="�ر�" onclick=window.opener=null;window.close()>
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
    response.write "<script>alert('���ͼ���ظ������������룡');location.href='operationInitAdd.asp'</script>"
    response.end
  end if
  if trim(request.form("group"))="rk" then
  	inorout = "���"
  else
  	inorout = "����"
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