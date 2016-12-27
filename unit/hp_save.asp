<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
fGoodsStyle = request.form("GoodsStyle")
qGoodsStyle = request.querystring("GoodsStyle")
DepotDown = request("DepotDown")
DepotUp = request("DepotUp")
Discount = request("Discount")
dpPrice = request("dpPrice")
GoodsBrand = request("GoodsBrand")
GoodsID = request("GoodsID")
GoodsName = request("GoodsName")
GoodsSeason = request("GoodsSeason")
GoodsType = request("GoodsType")
ifDisCount = request("ifDisCount")
InDiscount = request("InDiscount")
Remark = request("Remark")
SizeGroup = request("SizeGroup")
Supply = request("Supply")
TypeCode = request("TypeCode")
Units = request("Units")
xsPrice = request("xsPrice")
ColorGroup = request("ColorGroup")
if qGoodsStyle = "" then
	conn.BeginTrans
	on error resume next
		if CheckRepeat("GoodsStyle", fGoodsStyle, "tGoods")=1 then
			response.write "<script>alert('商品款号重复，请您重新输入！');history.go(-1);</script>"
			response.end
		end if	
		sql="select * from tGoods where GoodsStyle = null"
		set Rs = server.createobject("adodb.recordset")
		Rs.open sql,conn,1,3
		Rs.addnew
			Rs("GoodsStyle") = fGoodsStyle
			Rs("DepotDown") = DepotDown
			Rs("DepotUp") = DepotUp
			Rs("Discount") = Discount
			Rs("dpPrice") = dpPrice
			Rs("GoodsBrand") = GoodsBrand
			Rs("GoodsName") = GoodsName
			Rs("GoodsSeason") = GoodsSeason
			Rs("GoodsType") = GoodsType
			Rs("ifDisCount") = ifDisCount
			Rs("InDiscount") = InDiscount
			Rs("Remark") = Remark
			Rs("SizeGroup") = SizeGroup
			Rs("Supply") = Supply
			Rs("TypeCode") = TypeCode
			Rs("Units") = Units
			Rs("xsPrice") = xsPrice
			Rs("ColorGroup") = ColorGroup

		Rs.update
		Rs.close
		set Rs = nothing
	if err.number=0 then
		manageLog "新增商品，商品款号：" &	fGoodsStyle
		conn.CommitTrans
		conn.close
		set conn=nothing
		Response.Write"<script>self.opener.location.href=self.opener.location.href;location.href='hp_add.asp'</SCRIPT>" 
	else
		conn.RollbackTrans
		Response.Write err.description
	end if
end if

if qGoodsStyle <> "" then
	conn.BeginTrans
	on error resume next
		if fGoodsStyle<>qGoodsStyle then
			if CheckRepeat("GoodsStyle", fGoodsStyle, "tGoods")=1 then
				response.write "<script>alert('商品款号重复，请您重新输入！');history.go(-1);</script>"
				response.end
			end if	
		end if
		sql="select * from tGoods where GoodsStyle = '"&qGoodsStyle&"'"
		set Rs = server.createobject("adodb.recordset")
		Rs.open sql,conn,1,3
			Rs("GoodsStyle") = fGoodsStyle
			Rs("DepotDown") = DepotDown
			Rs("DepotUp") = DepotUp
			Rs("Discount") = Discount
			Rs("dpPrice") = dpPrice
			Rs("GoodsBrand") = GoodsBrand
			Rs("GoodsName") = GoodsName
			Rs("GoodsSeason") = GoodsSeason
			Rs("GoodsType") = GoodsType
			Rs("ifDisCount") = ifDisCount
			Rs("InDiscount") = InDiscount
			Rs("Remark") = Remark
			Rs("SizeGroup") = SizeGroup
			Rs("Supply") = Supply
			Rs("TypeCode") = TypeCode
			Rs("Units") = Units
			Rs("xsPrice") = xsPrice
			Rs("ColorGroup") = ColorGroup
		Rs.update
		Rs.close
		set Rs = nothing
		if qGoodsStyle<>fGoodsStyle then
	      q = "update tbilldetail set GoodsStyle='"&fGoodsStyle&"' where GoodsStyle ='"&qGoodsStyle&"'"
		     conn.execute q
	  end if
	if err.number=0 then
		manageLog "修改商品，商品款号：" &	qGoodsStyle
		conn.CommitTrans
		conn.close
		set conn=nothing
		Response.Write"<script>self.opener.location.href=self.opener.location.href;window.opener=null;window.close();</SCRIPT>" 
	else
		conn.RollbackTrans
		Response.Write err.description
	end if
end if
%>