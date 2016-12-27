<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
if trim(session("loginnameb"))="user" then
	Response.Write"<script>alert('试用用户没有该权限！');history.go(-1)</SCRIPT>" 
	response.end
end if
			   
			   
tablename=request("tablename")
conn.BeginTrans
on error resume next	
	if tablename="tGoods" then
		
		q = "delete from tGoods where GoodsStyle='"&request.querystring("GoodsStyle")&"'"
		conn.execute q
	end if
	
	if tablename="tCustom" then
		q = "delete from tCustom where custcode='"&request.querystring("custcode")&"'"
		conn.execute q
	end if
	
	if tablename="tEmp" then
		q = "delete from tEmp where empcode='"&request.querystring("empcode")&"'"
		conn.execute q
	end if
	
	if tablename="tVip" then
		q = "delete from tVip where vipcode='"&request.querystring("vipcode")&"'"
		conn.execute q
	end if
	
	if tablename="tColor" then
		q = "delete from tColor where colorcode='"&request.querystring("colorcode")&"'"
		conn.execute q
	end if
	
	if tablename="tSize" then
		q = "delete from tSize where sizecode='"&request.querystring("sizecode")&"'"
		conn.execute q
	end if
	
	if tablename="tDepot" then
		q = "delete from tDepot where DepotName='"&request.querystring("DepotName")&"'"
		conn.execute q
	end if
	
	if tablename="tUser" then
		if request.querystring("username")="admin" then
			Response.Write"<script>alert('admin帐号不能删除！');history.go(-1);</SCRIPT>" 
			response.end
		end if
		q = "delete from tUser where username='"&request.querystring("username")&"'"
		conn.execute q
	end if
	
	if tablename="tcgBill" then
		q = "delete from tBillDetail where DBillCode='"&trim(request("BillCode"))&"'"

		conn.execute q
		q = "delete from tBill where BillCode='"&trim(request("BillCode"))&"'"
		conn.execute q
	
	end if
	
		if tablename="tBillDetail" then
		q = "delete from tBillDetail where BillDetailId="&clng((request("delid")))
	'	response.write q
	'response.end

		conn.execute q
	  
	  q = "delete from tbill where billcode  in(select billcode  from tbill where billcode not in(SELECT dbillcode from tbilldetail group by dbillcode))"
		conn.execute q
	end if
	
	
if err.number=0 then
	if tablename="tGoods" then
		manageLog "商品资料删除，商品款号：" & request("GoodsStyle")
		linkurl="hp_find.asp"
	end if
	
	if tablename="tCustom" then
		manageLog "公司信息删除，公司编号：" & request("custcode")
	end if
	
	if tablename="tEmp" then
		manageLog "员工信息删除，员工编号：" & request("empcode")
	end if
	
	if tablename="tVip" then
		manageLog "VIP信息删除，VIP卡号：" & request("vipcode")
	end if
	
	if tablename="tColor" then
		manageLog "颜色信息删除，颜色编号：" & request("colorcode")
	end if
	
	if tablename="tSize" then
		manageLog "尺码信息删除，尺码编号：" & request("sizecode")
	end if
	
	if tablename="tDepot" then
		manageLog "店铺信息删除，店铺名称：" & request("DepotName")
	end if
	
	if tablename="tcgBill" then
		manageLog "单据信息删除，单号：" & request("BillCode")
		linkurl="bill_find.asp"
	end if
	
	if tablename="tBillDetail" then
		manageLog "库存信息删除，单号：" & request("BillDetailId")
		linkurl="bill_detail_find.asp"
	end if
	
	if tablename="tUser" then
		manageLog "用户信息删除，用户名称：" & request("BillCode")
	end if
	conn.CommitTrans 
	if linkurl<>"" then
		Response.Write"<script>alert('删除成功！');document.location.href='"&linkurl&"';</SCRIPT>" 
	else
	Response.Write"<script>alert('删除成功！');history.go(-1);</SCRIPT>" 
end if
else
	conn.RollbackTrans '否则回滚
	response.write err.description
end if
%>