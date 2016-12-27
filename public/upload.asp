<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<body>
<h3><%=f_title%>Excel导入</h3><br>
	<div style="font-size:15px;font-weight:bold;">
		第一步：向要添加Excel中添加数据。<br><br><br>
		第二步：点击“浏览”，打开添加好数据的<font color=#800040>Excel文件</font>，点击下一步。<br><br><br>
	</div>
<form action="import.asp" method="post" enctype="multipart/form-data" target="_self"> 
<input type="file" name="src" size="50" value="浏览"><br><br>
<input type="submit" value="下一步" name="B1" IsShowProcessBar="True"> 
</form>
</body>