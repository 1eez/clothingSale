<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "【Excel导入】"
cklist = request.cookies("cklist")
tablename = trim(request("tablename"))
action = "excelin.asp?tablename="&tablename
	dim totalsql
if request("submit")="保存" then
	dim afieldtype()
	afield1 = ""
	if tablename<>"tGoods" then
	conn.BeginTrans
  end if
	totalsql=""
	'on error resume next
		set t = server.createobject("adodb.recordset")
		q = "select * from tImport where tablename='"&tablename&"' order by showid"
		t.open q, conn, 1, 1
		redim afieldtype(t.recordcount)
		for i = 0 to t.recordcount - 1
			sfield1 = sfield1&t("field")&","
			afieldtype(i) = t("fieldtype")
			t.movenext
		next
		t.close
		sfield1 = left(sfield1, len(sfield1)-1)
		text = trim(request("excelin"))
		text = myReplace(text)
		dedearr=split(text,chr(13))
		for dede=0 to ubound(dedearr)-1
			a1 = split(dedearr(dede)," ")
			sfield2 = ""		
			for i = 0 to ubound(a1)
				if afieldtype(i)="num" then
					if trim(a1(i))="" then
						sfield2=sfield2&"0,"
					else
						sfield2=sfield2&trim(a1(i))&","
					end if
				else
					sValue = replace(trim(a1(i)),chr(13),"")
					sValue = replace(sValue,chr(10),"")
					sValue = replace(sValue," ","")
					sValue = replace(sValue,Chr(13) & Chr(10)  ,"")				
					sfield2=sfield2&"'"&sValue&"',"
				end if
			next
			sfield2 = left(sfield2, len(sfield2)-1)
			
			    tgoodstyle=	replace(trim(a1(0)),chr(13),"")
					tgoodstyle = replace(tgoodstyle,chr(10),"")
					tgoodstyle = replace(tgoodstyle," ","")
					tgoodstyle = replace(tgoodstyle,Chr(13) & Chr(10)  ,"")			
			query="select GoodsID from tGoods where goodsstyle='"&tgoodstyle&"'"
		  set queryrs = server.createobject("adodb.recordset")
		  queryrs.open query, conn, 1, 1
		  response.write query&"count:"&queryrs.RecordCount &"<br>"
		  totalcount=0
		  if not queryrs.eof then
		     totalcount=cint(queryrs.RecordCount)
		  end if
      queryrs.close
   			
    
      'totalsql="(goodsstyle,goodsname,units,goodstype,goodsseason,goodsbrand,dpprice,discount,xsprice,indiscount,sizegroup,depotup,depotdown,supply,ifdiscount,remark) values('1810B006','1810B006','件','其它','四季','恒源祥',0,1,0,1,'衣服码',1000,0,'','0','无')"
      'response.write "instr:["&tgoodstyle&"]"&instr(totalsql,tgoodstyle)
			if cint(totalcount)=0 and instr(totalsql,tgoodstyle)=0 then
			q = "insert into "&tablename&"("&sfield1&") values("&sfield2&")"
			totalsql=""&totalsql&q
			'response.write q&"<br>"
			conn.execute q
	    end if
	    
		next 

	if err.number=0 then

		if tablename<>"tGoods" then
		conn.CommitTrans
	  end if
	  		manageLog "导入资料"
	  
		response.write "<script>self.opener.location.href=self.opener.location.href;alert('导入成功！');</script>"
	else
		conn.RollbackTrans
		Response.Write err.description
	response.end
	end if
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
	if (!check_empty(document.form.excelin.value)){
		validity = false; alert('导入内容不能为空!');
	}
	return validity;
}

function check_empty(text){
	return (text.length > 0); 
}
</script>
</head>
<body>
Excel导入操作步骤：<br>
1.制作excel表格，字段顺序按照下方表格的字段顺序，必须按照一 一对应规则，不可多也不可少。<br>
2.录入数据后，复制excel内所有的您录入好的数据，表头除外，然后在下方备注框中粘贴。<br>
3.点击保存，导入操作完成。<br>
<%
set t = server.createobject("adodb.recordset")
sql = "select * from tImport where tablename='"&tablename&"' order by showid"
t.open sql, conn, 1, 1
response.write "<div id=inner-table-hpzl><table><tr>"
while not t.eof
	response.write "<th align=center width="&t("width")&">"&t("name")&"</th>"
	t.movenext
wend
response.write "</tr></table></div>"
t.close
sql = "select sum(width) from tImport where tablename='"&tablename&"'"
t.open sql, conn, 1, 1
swidth = t.fields(0).value
t.close
set t=nothing
%>
<form name="form" method="post" action="<%=action%>" onSubmit="return validate_form()">
<textarea name="excelin" style="background-color:#CCC;width:<%=swidth%>px;overflow:scroll;" rows="30" wrap="VIRTUAL"><%=excelin%></textarea>
<center>
<% if request("detail")="" then %>
<input class=dh type="submit" value="保存" name=submit>
<input class=dh type="reset" value="重置" name=reset>
<% end if %>
<input class=dh type="button" value="关闭" onclick=window.opener=null;window.close()>
</center>
</form>
</body>
</html>