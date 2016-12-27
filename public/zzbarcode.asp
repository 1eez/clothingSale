<!-- #include file="conn.asp" -->
<!-- #include file="public.asp" -->
<%
if Trim(Request.querystring("barcode"))<>"" then
	sqlwhere = sqlwhere&"and barcode='"&Request.querystring("barcode")&"' "
end if
depot = Request.querystring("depot")
id = request.querystring("id")
if depot<>"" then
	depotsql = " and depotname='"&depot&"'"
end if
getfields("SelectGoods")
q = "select a.*,b.t_num,b.avgprice "
q = q&" from t_goods a left join (select goodscode, "
q = q&" iif(isnull(Sum([sign]*[number])), 0, Sum([sign]*[number])) AS [t_num],"
q = q&" iif(Sum([sign]*[number])=0 or isnull(sum([sign]*[number])),0,Sum([sign]*[number]*[price])/Sum([sign]*[number])) AS Avgprice"	
q = q&" from S_GoodsNum where 1=1 "
q = q&depotsql
q = q&" group by goodscode) b on a.goodscode=b.goodscode "
q = q&" where 1=1 "&sqlwhere
set t = server.createobject("adodb.recordset")
t.open q, conn, 1, 1
if t.recordcount<>0 then
	response.write "<script>self.opener.document.all.goodscode"&id&".value='"&t("goodscode")&"'</script>"
	response.write "<script>self.opener.document.all.goodsname"&id&".value='"&t("goodsname")&"'</script>"
	response.write "<script>self.opener.document.all.goodsunit"&id&".value='"&t("goodsunit")&"'</script>"
	response.write "<script>self.opener.document.all.units"&id&".value='"&t("units")&"'</script>"
	response.write "<script>self.opener.document.all.price"&id&".value='"&t("Avgprice")&"'</script>"
	response.write "<script>self.opener.document.all.number"&id&".value='1'</script>"
	if id="" then
	response.write "<script>self.opener.document.all.money"&id&".value='"&t("Avgprice")&"'</script>"
	else
	response.write "<script>self.opener.document.all.cmoney"&id&".value='"&t("Avgprice")&"'</script>"
	end if
else
	response.write "<script>alert('数据库中没有此条形码，请重新录入')</script>"
end if
response.write "<script>window.opener=null;window.close()</script>"
%>