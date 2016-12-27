<!-- #include file="public.asp" -->
<!-- #include file="../public/conn.asp" -->
<html>
<title>基本信息设置</title>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type='text/javascript' src='../js/public.js'></script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body><br>
<input class=dh type="button" value="部门分类" onclick=openwin('mtreehp.asp?table=depart',340,300)>
<input class=dh type="button" value="公司分类" onclick=openwin('mtreehp.asp?table=cotype',340,300)>
<input class=dh type="button" value="地区分类" onclick=openwin('mtreehp.asp?table=zip',340,300)>
<input class=dh type="button" value="客户分类" onclick=openwin('mtreehp.asp?table=custom',340,300)>
<input class=dh type="button" value="供应商分类" onclick=openwin('mtreehp.asp?table=supply',340,300)>
<hr>
<input class=dh type="button" value="货品类别" onclick=openwin('mtreehp.asp?table=goodstype',340,300)>
<input class=dh type="button" value="货品规格" onclick=openwin('mtreehp.asp?table=goodsunit',340,300)>
<input class=dh type="button" value="货品单位" onclick=openwin('mtreehp.asp?table=units',340,300)>
<hr>
<input class=dh type="button" value="数据优化" onclick=location.href='youhua.asp'>
<hr>
部门分类和货品类别录入完毕后请您点击数据优化，此操作有利于您对数据的浏览。
</body>
</html>