<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
set t = server.createobject("adodb.recordset")
barcode = request("barcode")
fnumber = request("number")
q = "select *,tNum-"&fnumber&" as sNum from vStock where barcode='"&barcode&"'"
t.open q, conn, 1, 1
if t.eof then
	response.end
end if
goodsstyle = t("goodsstyle")
goodsname = t("goodsname")
units = t("units")
sizename = t("sizename")
colorname = t("colorname")
xsprice = t("xsprice")
inprice = t("tprice")
%>
<script>
j = self.opener.document.all.intK.value
tr=self.opener.document.all.t136.insertRow()
tr.style.height=25
tr.insertCell().innerHTML='<a class=delete href=javascript:void(0) onclick=del()>É¾³ý</a>' 
tr.insertCell().innerText=++j
self.opener.document.all.intK.value=j
tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=goodsstyle_'+j+' value="<%=goodsstyle%>">' 
tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=goodsname_'+j+' value="<%=goodsname%>">' 
tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=units_'+j+' value="<%=units%>">' 
tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=sizename_'+j+' value="<%=sizename%>">' 
tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=colorname_'+j+' value="<%=colorname%>">' 
tr.insertCell().innerHTML='<input class=number style=width:100%; type=text name=number_'+j+' value="<%=fnumber%>">' 
tr.insertCell().innerHTML='<input class=number style=width:100%; type=text name=price_'+j+' value="<%=xsprice%>">' 
tr.insertCell().innerHTML='<input class=number style=width:100%; type=text name=money_'+j+' value="<%=fnumber*xsprice%>">' 
tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=barcode_'+j+' value="<%=barcode%>">' 
tr.insertCell().innerHTML='<input style=width:100%; type=text name=dremark_'+j+' value=><input type=hidden name=inprice_ vaule="<%=inprice%>">'
self.opener.document.all.barcode.value='';
self.opener.document.all.barcode.focus();
self.opener.document.all.barcode.select();
window.opener=null;window.close();
</script>