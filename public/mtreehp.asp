<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
dim f_table,f_title
f_table = Request("table")
if f_table="goodstype" then
	f_table="goods"
	f_title = "��Ʒ������"
end if
if f_table="depart" then
	f_title = "����������"
end if
if f_table="units" then
	f_title = "��Ʒ��λ����"
end if
if f_table="de1part" then
	f_table="depart"
	f_title = "����������"
end if
if f_table="cotype" then
	f_title = "��˾������"
end if
if f_table="goodsunit" then
	f_title = "��Ʒ������"
end if
if f_table="zip" then
	f_title = "��λ��������"
end if
%>
<html>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><%=f_title%></title>
<script language="JavaScript">
<!--
function QueryString()
{
    var name,value,i;
    var str=location.href;
    var num=str.indexOf("?")
    str=str.substr(num+1);
    var arrtmp=str.split("&");
    for(i=0;i < arrtmp.length;i++)
    {
        num=arrtmp[i].indexOf("=");
        if(num>0)
        {
            name=arrtmp[i].substring(0,num);
            value=arrtmp[i].substr(num+1);
            this[name]=value;
        }
    }
}
function validate_form(){
	validity = true;
	if(!check_empty(document.form.change_name.value))
	{validity = false;alert('���������ѡ��һ����Ӧ�Ľڵ�!');}
	if(!check_empty(document.form.name.value))
	{validity = false;alert('�ڵ����Ʋ���Ϊ��!');}
	return validity;
}

function check_empty(text){
	return (text.length > 0);
}
// -->
</script>
<script>
function godelete(){
	if (document.all.change_id1.value != ""){
		if(confirm('�����ѡ����Ǹ��ڵ㣬�˲�������ɾ�����������е��ӽڵ㣬ȷ���Լ�����'))
		  {location.href = 'mtreehp_save.asp?type=de_lete&table=<%=f_table%>&cid='+document.all.change_id1.value;	}
		else
			{}
	}else{
		alert('����ѡ��Ҫɾ���Ľڵ㣡')
	}
}
function goedit(){
	if (document.all.change_id1.value != ""){
		location.href = 'mtreehp_save.asp?type=save&table=<%=f_table%>&cid='+document.all.change_id1.value+'&cname='+document.all.name1.value;
	}else{
		alert('����ѡ��Ҫ�޸ĵĽڵ㣡')
	}
}
function change_name(el){
	document.all.change_name.value=el.value.substr(0, el.value.indexOf("!--"))
	document.all.change_id.value=el.value.substr(el.value.indexOf("!--")+3,el.value.indexOf("~--")-el.value.indexOf("!--")-3)
	document.all.change_name1.value=document.all.change_name.value
	document.all.change_id1.value=document.all.change_id.value
	var Request=new QueryString();
	if(Request["table"].indexOf('goodstype')>-1){
		self.opener.document.all.goodstype.value = el.value.substr(0, el.value.indexOf("!--"))
		self.opener.document.all.typecode.value = el.value.substr(el.value.indexOf("~--")+3,100)	
	}
	if(Request["table"].indexOf('goodsunit')>-1){
		self.opener.document.all.goodsunit.value = el.value.substr(0, el.value.indexOf("!--"))
	}
	if(Request["table"].indexOf('depart')>-1){
		self.opener.document.all.depart.value = el.value.substr(0, el.value.indexOf("!--"))
		self.opener.document.all.departcode.value = el.value.substr(el.value.indexOf("~--")+3,100)	
	}
	if(Request["table"].indexOf('custom')>-1){
		self.opener.document.all.goodstype.value = el.value.substr(0, el.value.indexOf("!--"))
		self.opener.document.all.typetcode.value = el.value.substr(el.value.indexOf("~--")+3,100)	
	}
	if(Request["table"].indexOf('custom')>-1){
		self.opener.document.all.goodstype.value = el.value.substr(0, el.value.indexOf("!--"))
		self.opener.document.all.typetcode.value = el.value.substr(el.value.indexOf("~--")+3,100)	
	}
	if(Request["table"].indexOf('supply')>-1){
		self.opener.document.all.goodstype.value = el.value.substr(0, el.value.indexOf("!--"))
		self.opener.document.all.typetcode.value = el.value.substr(el.value.indexOf("~--")+3,100)	
	}
	if(Request["table"].indexOf('cotype')>-1){
		self.opener.document.all.type.value = el.value.substr(0, el.value.indexOf("!--"))
		self.opener.document.all.typecode.value = el.value.substr(el.value.indexOf("~--")+3,100)	
	}	
	if(Request["table"].indexOf('zip')>-1){
		self.opener.document.all.zip.value = el.value.substr(0, el.value.indexOf("!--"))
		self.opener.document.all.zipcode.value = el.value.substr(el.value.indexOf("~--")+3,100)	
	}	
	if(Request["table"].indexOf('de1part')>-1){
		self.opener.document.all.supply.value = el.value.substr(0, el.value.indexOf("!--"))
		self.opener.document.all.departcode.value = el.value.substr(el.value.indexOf("~--")+3,100)	
	}
}
</script>
</head>
<body style="margin:0px;padding:0px;font-size:10pt;">
<div style="font:bold 13px;float:left;padding:4px 0 0 4px;width:200px;height:300px;overflow:auto;">
<!-- #include file="tree.asp" -->
</div>
<div style="float:left;width:120px;height:300px;background:#ccc;over-flow:auto;text-align:center;">
	<form name="form" method="post" action="mtreehp_save.asp?table=<%=f_table%>" onSubmit="return validate_form()">
		<div style="text-align:left;margin-left:10pt;color:#0000FF;font:14px bold">����</div>
		<input style="background=#C9C9C9;" type="text" name="change_name" size="12" readonly><br>
		����ڵ����ƣ�<br>
		<input type="hidden" name="change_id" size="12">
		<input type="text" name="name" size="12"><br>
		<input type="radio" name="type1" value=1 checked>ͬ��
		<input type="radio" name="type1" value=2 checked>�¼�<br>
		<input class=dh type="submit" name="submit" value="����">
		<input class=dh type="button" name="close" value="�ر�" onclick=window.opener=null;window.close()>
	</form><br><br><br>
	<div style="text-align:left;margin-left:10pt;color:#0000FF;font:14px bold">�༭</div>
	<input style="background=#C9C9C9;" type="text" name="change_name1" size="12" readonly><br>
	�ڵ������ƣ�<br>
	<input type="hidden" name="change_id1" size="12">
	<input type="text" name="name1" size="12"><br>
	<input class=dh type="button" name="save" value="����" onclick=goedit()>
	<input class=dh type="button" name="delete" value="ɾ��" onclick=godelete()>
</div>
</body>
</html>