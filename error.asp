<html>
<title>系统错误</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style>
<!--
TD {
	FONT-SIZE: 9pt; COLOR: #666666; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif, 宋体
}
.red {
	COLOR: #40bde8
}
A:hover {
	LEFT: 1px; COLOR: #40bde8; POSITION: relative; TOP: 1px; TEXT-DECORATION: none
}
A {
	COLOR: #7b7b7b; TEXT-DECORATION: none
}
A.menu {
	COLOR: #ffffff; TEXT-DECORATION: none
}
A.menu:hover {
	COLOR: #666666; TEXT-DECORATION: none
}
.htd {
	LINE-HEIGHT: 150%
}
-->
</style>
</head>
<body>
<table cellspacing=0 cellpadding=0 width=590 border=0 align="center">
  <tbody> 
  <tr> 
    <td align=right>
	<img src="helpimage/errorpage1.gif" border=0></td>
  </tr>
  <tr> 
    <td align=middle height=350> 
      <table cellspacing=0 cellpadding=0 width=534 border=0>
        <tbody> 
        <tr> 
          <td colspan=3>
		  <img height=42 src="helpimage/errorpage3.gif" width=534 border=0></td>
          <td><img height=42 src="" width=1 border=0></td>
        </tr>
        <tr> 
          <td rowspan=2>
		  <img height=239 src="helpimage/errorpage4.gif" width=43 border=0></td>
          <td class=htd align=middle width=479 bgcolor=#f7f7f7 height=228> 
		  <font class=red>系统错误由于以下原因：<br>
		  <%if request("reason")<>"" then
		  response.write request("reason")&"<br><br><br><br>"
		  else
		  %>
		  您所查看或发表内容不符合有关规则或不存在.<br>
            可能该内容已经被删除<br>
			没有访问页面的权限
			</font><br>
            <br>
            请勿乱给本站的程序提交非法参数.<br>
            <br>
			
            <br>
			<%end if %>
            <a 
                        href="#" onClick="javascript:history.go(-1)">点击此处可返回出错页的前一页</a></td>
          <td rowspan=2>
		  <img height=239 src="helpimage/errorpage5.gif" width=12 border=0></td>
          <td><img height=228 src="helpimage/spacer.gif" width=1 border=0></td>
        </tr>
        <tr> 
        <td><img height=11 src="helpimage/errorpage2.gif" width=479 border=0></td>
          <td><img height=11 src="helpimage/spacer.gif" width=1 border=0></td>
        </tr>
        </tbody>
      </table>
      <br>
    </td>
  </tr>
  </tbody>
</table>
<div align="center"></div>
</body>
</html>