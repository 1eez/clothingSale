<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
if trim(session("loginnameb"))="user" then
	Response.Write"<script>alert('�����û�û�и�Ȩ�ޣ�');history.go(-1)</SCRIPT>" 
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
			Response.Write"<script>alert('admin�ʺŲ���ɾ����');history.go(-1);</SCRIPT>" 
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
		manageLog "��Ʒ����ɾ������Ʒ��ţ�" & request("GoodsStyle")
		linkurl="hp_find.asp"
	end if
	
	if tablename="tCustom" then
		manageLog "��˾��Ϣɾ������˾��ţ�" & request("custcode")
	end if
	
	if tablename="tEmp" then
		manageLog "Ա����Ϣɾ����Ա����ţ�" & request("empcode")
	end if
	
	if tablename="tVip" then
		manageLog "VIP��Ϣɾ����VIP���ţ�" & request("vipcode")
	end if
	
	if tablename="tColor" then
		manageLog "��ɫ��Ϣɾ������ɫ��ţ�" & request("colorcode")
	end if
	
	if tablename="tSize" then
		manageLog "������Ϣɾ���������ţ�" & request("sizecode")
	end if
	
	if tablename="tDepot" then
		manageLog "������Ϣɾ�����������ƣ�" & request("DepotName")
	end if
	
	if tablename="tcgBill" then
		manageLog "������Ϣɾ�������ţ�" & request("BillCode")
		linkurl="bill_find.asp"
	end if
	
	if tablename="tBillDetail" then
		manageLog "�����Ϣɾ�������ţ�" & request("BillDetailId")
		linkurl="bill_detail_find.asp"
	end if
	
	if tablename="tUser" then
		manageLog "�û���Ϣɾ�����û����ƣ�" & request("BillCode")
	end if
	conn.CommitTrans 
	if linkurl<>"" then
		Response.Write"<script>alert('ɾ���ɹ���');document.location.href='"&linkurl&"';</SCRIPT>" 
	else
	Response.Write"<script>alert('ɾ���ɹ���');history.go(-1);</SCRIPT>" 
end if
else
	conn.RollbackTrans '����ع�
	response.write err.description
end if
%>