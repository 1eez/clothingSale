<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
tablename=trim(request("tablename"))
if tablename="" then
  response.write "��Ч����"
response.end
end if
conn.BeginTrans
'on error resume next	
	if tablename="tbilldetail" then
		q = "update tbilldetail,tgoods set tbilldetail.goodsname=tgoods.goodsname where tbilldetail.goodsstyle=tgoods.goodsstyle"
		conn.execute q
	end if

	if tablename="stockupdate" then
		q = "delete from tbill where billcode  in(select billcode  from tbill where billcode not in(SELECT dbillcode from tbilldetail group by dbillcode))"
		conn.execute q
	end if
	
if err.number=0 then
	if tablename="tbilldetail" then
		manageLog "���±�tbilldetail" 
	end if
	
	conn.CommitTrans 
	Response.Write"���³ɹ�"&tablename 

else
	conn.RollbackTrans '����ع�
	response.write err.description
end if
%>