<!-- #include file="../public/conn.asp" -->
<%
billcode = request("billcode")
detail = request("detail")
q = "select * from tBill where billcode='"&billcode&"'"
set t = server.createobject("adodb.recordset")
t.open q, conn, 1, 1
if instr("采购进货采购退货",t("billtype"))>0 then
	Response.Write"<script>location.href='cgBill_add.asp?detail="&detail&"&billcode="&billcode&"'</SCRIPT>" 	
end if
if instr("期初录入",t("billtype"))>0 then
	Response.Write"<script>location.href='qcBill_add.asp?detail="&detail&"&billcode="&billcode&"'</SCRIPT>" 	
end if
if instr("销售出货销售退货店铺调拨",t("billtype"))>0 then
	Response.Write"<script>location.href='xsBill_add.asp?detail="&detail&"&billcode="&billcode&"'</SCRIPT>" 	
end if
t.close
set t=nothing
conn.close
set conn=nothing
%>