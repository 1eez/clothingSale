<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "【商品资料设置】"
cklist = request.cookies("cklist")
GoodsStyle = request("GoodsStyle")
action = "hp_save.asp"
if GoodsStyle <> "" then
	action = action&"?GoodsStyle="&server.urlencode(GoodsStyle)
	set t = server.createobject("adodb.recordset")
	sql = "select * from tGoods where GoodsStyle='"&GoodsStyle&"'"
	t.open sql, conn, 1, 1
	GoodsStyle = t("GoodsStyle")
	DepotDown = t("DepotDown")
    DepotUp = t("DepotUp")
    Discount = FormatNumber(t("Discount"), 2, -1,false,false)
    dpPrice = t("dpPrice")
    GoodsBrand = t("GoodsBrand")
    GoodsName = t("GoodsName")
    GoodsSeason = t("GoodsSeason")
    GoodsType = t("GoodsType")
    ifDisCount = t("ifDisCount")
	if ifDiscount="1" then
		ifDiscountCheck = "checked"
	end if
    InDiscount = FormatNumber(t("InDiscount"), 2, -1,false,false)
    Remark = t("Remark")
    SizeGroup = t("SizeGroup")
    Supply = t("Supply")
    TypeCode = t("TypeCode")
    Units = t("Units")
    xsPrice = t("xsPrice")
    ColorGroup = t("ColorGroup")
	t.close
	set t=nothing
else
	'GoodsStyle=SetAutoCode("GoodsStyle", "tGoods", "SP")
	GoodsStyle=""
	DepotDown = 10
    DepotUp = 1000
    'Discount = 0
    Discount = 1
    dpPrice = 0
    'ifDisCount = 0
     ifDisCount = 1
    'InDiscount = 0
    InDiscount = 1
    xsPrice = 0
	ifDiscountCheck = "checked"
end if
st1="width='17%' align=right"
st2="width='27%'"

if Discount="" then
	Discount="1"
end if
if InDiscount="" then
	 InDiscount="1"
end if
%>
<html>
<title><%=dTitle%></title>
<head><meta http-equiv="Content-Type" content="text/html; charset=<%=scharser%>">
<script type='text/javascript' src='../js/public.js'></script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<script language="JavaScript">
function validate_form(){
	validity = true;
	if (!check_empty(document.form.GoodsStyle.value)){
		validity = false; alert('商品款号不能为空!');
	}
	if (!check_empty(document.form.GoodsName.value)){ 
		validity = false; alert('商品名称不能为空!'); 
	}
	if (!check_empty(document.form.ColorGroup.value)){ 
		validity = false; alert('商品颜色不能为空!'); 
	}
	return validity;
}

function check_empty(text){
	return (text.length > 0); 
}
</script>
</head>
<body>
<form name="form" method="post" action="<%=action%>" onSubmit="return validate_form()">
<fieldset style="width:auto;"><legend>【商品资料设置】</legend>
<table align="center" valign="center" width="100%">
<tr><td width='17%' align=right>商品类别：</td>
<td width='27%' colspan="4" >
<input type="text" class="catetree" name="GoodsType" value="<%=GoodsType%>" readonly>
<input type="hidden" name="TypeCode" value="">
<img id="dt_3" style="cursor:hand" src="../images/f.gif">
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
<script type="text/javascript">
  for(var i=1;i<=11;i++)
  {
    eval("var dt_" + i + " = document.getElementById('dt_" + i + "')");
  }
  var mbDIV = document.getElementById("mbDIV");
  var loginDIV = document.getElementById("loginDIV");
  var loginTopDIV = document.getElementById("loginTopDIV");
  
dt_3.onclick = function()
{
 loginDIV.style.top = "30px";
 loginDIV.style.left = "150px";
 show("loginDIV");
 mbDIV.style.width = document.body.scrollWidth;
 mbDIV.style.height = document.body.scrollHeight;
 show("mbDIV")

			for (var i = 0; i < document.all.tags('SELECT').length; i++)
			{
			var obj = document.all.tags('SELECT')[i];
			obj.style.visibility = "hidden";
			}
}
function closes(){
	hidden("loginDIV");
	hidden("mbDIV");
}

loginTopDIV.onmousedown = Down;
var tHeight,lWidth;
function Down(e)
{
var event = window.event || e;
tHeight = event.clientY  - parseInt(loginDIV.style.top.replace(/px/,""));
lWidth  = event.clientX - parseInt(loginDIV.style.left.replace(/px/,""));
document.onmousemove = Move;
document.onmouseup   = Up;
}
function Move(e) {
var event = window.event || e;
var top = event.clientY - tHeight;
var left = event.clientX - lWidth;
top = top < 0 ? 0 : top;
top = top > document.body.offsetHeight - 150 ? document.body.offsetHeight - 150 : top;
left = left < 0 ? 0 : left;
left = left > document.body.offsetWidth - 300 ? document.body.offsetWidth - 300 : left;
loginDIV.style.top  = top + "px";
loginDIV.style.left = left +"px";
}
function Up(){
    document.onmousemove = null;
}
function closeselect(){
	hidden("loginDIV");
	hidden("mbDIV");
	 for (var i = 0; i < document.all.tags('SELECT').length; i++)
	{
		var obj = document.all.tags('SELECT')[i];
		obj.style.visibility = "visible";
	}	
}

function SetGoodsName(obj){
   var tempvalue=obj.value;
   if(tempvalue!=""){
   	  document.form.GoodsName.value=tempvalue;
   	}	
}
function SetColorName(obj){
   var tempvalue=obj.value;
   var sourcecolor=document.form.ColorGroup.value;
   if(tempvalue!=""){
   	   if(sourcecolor==""){
   	   	   document.form.ColorGroup.value=tempvalue;
   	   }
   	   else{	
   	     document.form.ColorGroup.value=sourcecolor+"^"+tempvalue;
   	  }
   	}	
}

function ClearColor(){
	 document.form.ColorGroup.value="";
}
</script>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;商品款号：<input type="text" name="GoodsStyle" value="<%=GoodsStyle%>"><%=RedPoint%>
</td>
</tr>
<tr><td width='17%' align=right>商品名称：</td>
<td width='27%' colspan=3>
<input type="text" name="GoodsName" value="<%=GoodsName%>" size=40><%=RedPoint%> 
&nbsp;&nbsp;&nbsp;&nbsp;<%
	SetComboQuick "SetGoodsName(this)","GoodsNameQuick","select name from dict_cate where tablename='款式'", "", GoodsNameQuick, "auto"
	%>
&nbsp;&nbsp;&nbsp;&nbsp; <a href="../public/combo.asp?tablename=款式" class="ulink">款式维护</a>
</td>
</tr>
<tr><td width='17%' align=right>商品颜色： 	</td>
<td width='27%' colspan=3>
<input type="text" name="ColorGroup" value="<%=ColorGroup%>" size=40><%=RedPoint%>
&nbsp;&nbsp;&nbsp;&nbsp;<%
	SetComboQuick "SetColorName(this)","ColorNameQuick","select name from dict_cate where tablename='颜色'", "", ColorNameQuick, "auto"
	%>
&nbsp;&nbsp;&nbsp;&nbsp; <a href="../public/combo.asp?tablename=颜色" class="ulink">颜色维护</a>  
&nbsp;&nbsp;&nbsp;&nbsp; <a href="###" onclick="javascript:ClearColor()" class="ulink">清空颜色</a>  
&nbsp;&nbsp; 例子  红色^青色^黑色
</td>
</tr>
<tr><td width='17%' align=right>商品供应商：</td>
<td width='27%' colspan=3>
	<%
	SetCombo "Supply","select name from dict_cate where tablename='供应商' order by code", "no", Supply, "auto"
	%>

</td>
</tr>

<tr><td width='17%' align=right>商品品牌：</td>
<td width='27%' colspan=3>
	<%
	SetCombo "goodsbrand","select name from dict_cate where tablename='品牌'", "no", GoodsBrand, "auto"
	%>
&nbsp;&nbsp;&nbsp;&nbsp;商品季节：<%
	SetCombo "goodsseason","select name from dict_cate where tablename='季节管理'", "no", goodsseason, "auto"
	%>

</td>
</tr>

<tr><td width='17%' align=right>吊牌价：</td>
<td colspan="3">
<input class=number type="text" name="dpPrice" value="<%=dpPrice%>" size=8>
&nbsp;&nbsp;&nbsp;&nbsp;售价：<input class=number type="xsPrice" name="xsPrice" value="<%=xsPrice%>" size=8>

	
</td>
</tr>


<tr><td width='17%' align=right>尺码组：</td>
<td colspan="3">
<%
	SetCombo "sizegroup","select distinct(SizeGroup) from tSize", "no", sizegroup, "auto"
	%>
	&nbsp;&nbsp;&nbsp;&nbsp;单位：	<%
	SetCombo "units","select name from dict_cate where tablename='商品单位'", "no", units, "auto"
	%>
	<input class=number type="hidden" name="InDiscount" value="<%=InDiscount%>" size=4>
  <input class=number type="hidden" name="Discount" value="<%=Discount%>" size=4>
  <input type="hidden" name="ifDiscount" value="<%=ifDiscount%>" >
</td>
</tr>
<!--
<td width='17%' align=right>进价折扣：</td>
<td width='27%'>


</td>

</tr>
<tr><td width='17%' align=right>尺码组：</td>
<td width='27%'>
		

</td>
<td width='17%' align=right>打折选项：</td>
<td width='27%'>
不参与VIP打折
</td></tr>
-->
<tr><td width='17%' align=right>库存上限：</td>
<td colspan="3">
<input class=number type="text" name="depotup" value="<%=depotup%>" size=8>
&nbsp;&nbsp;&nbsp;&nbsp;库存下限：<input class=number type="text" name="depotdown" value="<%=depotdown%>" size=8>
</td>
</tr>
<tr><td width='17%' align=right>备注：</td>
<td colspan="3">
<textarea name="Remark" cols="60" rows="2" wrap="VIRTUAL"><%=Remark%></textarea>
</td></tr>
</table>
</fieldset><br>
<center>
<% if request("detail")<>"detail" then%>
<input class=dh type="submit" value="保存" name=submit>
<input class=dh type="reset" value="重置" name=reset>
<%end if%>
<input class=dh type="button" value="关闭" onclick=window.opener=null;window.close()>
</center>
</form>
</body>
</html>