<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<body>
<h3><%=f_title%>Excel����</h3><br>
	<div style="font-size:15px;font-weight:bold;">
		��һ������Ҫ���Excel��������ݡ�<br><br><br>
		�ڶ���������������������Ӻ����ݵ�<font color=#800040>Excel�ļ�</font>�������һ����<br><br><br>
	</div>
<form action="import.asp" method="post" enctype="multipart/form-data" target="_self"> 
<input type="file" name="src" size="50" value="���"><br><br>
<input type="submit" value="��һ��" name="B1" IsShowProcessBar="True"> 
</form>
</body>