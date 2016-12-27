<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
Select Case trim(request("action"))
	Case "dete" : dete()
	Case "updt" : updt()
  case else
  	main()
End Select
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<title>配置单据</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<script src="../js/public.js" type="text/javascript"></script>
<script>
function selectall(a)
{
  var aa = document.getElementsByName("id");
  for (var j=0; j<aa.length; j++)
  aa[j].checked = !aa[j].checked;
}
function todel()
{
	var i = 0;
	var chkArr = document.getElementsByName("id");
	var param = "";
	for (i=0;i<chkArr.length;i++)
	 if (chkArr[i].checked)
	 param+=chkArr[i].value +",";
	if (param.length == 0)
	{
	   alert("请先选择要删除的条目！");
	}else{
	   if(window.confirm("确定要删除吗？删除将不能恢复！")){
	       location="?action=dete&id="+param;
	   }else return;
	}
}
</script>
</head>
<body>
<form action="operationInit.asp?action=updt" method="post">
<h1>配置单据</h1><hr>
<div id="inner-table-hpzl">
<table width="80%" align="center">
<tr>
<th align=center title="反选" style="cursor:pointer;" onclick='selectall()'>选择</th>
<th align=center>单据组</th>
<th align=center>类型简称</th>
<th align=center>是否可见</th>
<th align=center>显示顺序</th>
<th align=center>单据名称</th>
<th align=center>单据对象</th>
</tr>
<%
set t = server.createobject("adodb.recordset")
q = "select * from dict_bill where [group] in('ck','rk')"
t.open q, conn, 1, 1
response.write "<input type=hidden name=intk value="""&t.recordcount&""">"
response.write "<input type=hidden name=tablename value="""&request("tablename")&""">"
for i=1 to t.recordcount
	f_checked=""
	if t("show")=True then
		f_checked="checked"
	end if
	select case t("utype")
    case "depart" : utype = "部门"
    case "supply" : utype = "供应商"
    case "custom" : utype = "客户"
    case "other" : utype = "其它"
    case else
    	utype = ""
  end select
	response.write "<tr>"
	response.write "<td><input type=""checkbox""  name=id value="""&t("id")&"""><input type=hidden name=h_id value="""&t("id")&""" ></td>"
	response.write "<td style=""text-align:left;"">" & t("group") & "</td>"
	response.write "<td><input type=text name=code value="""&t("code")&"""></td>"
	response.write "<td><input type=checkbox name=show value="""&t("id")&""" "&f_checked&"></td>"
	response.write "<td><input type=text name=showid value="""&t("showid")&"""></td>"
	response.write "<td><input type=text name=name value="""&t("name")&"""></td>"
	response.write "<td style=text-align:left;><select name='utype'>"
	response.write "<option value='supply'" & elect("供应商",utype) & ">供应商</option>"
	response.write "<option value='custom'" & elect("客户",utype) & ">客户</option>"
	response.write "<option value='depart'" & elect("部门",utype) & ">部门</option>"
	response.write "<option value='other'" & elect("其它",utype) & ">其它</option>"
	response.write "</select></td>"
	response.write "</tr>"
	t.movenext
next
%>
</table>
<center>
<br>
<input id=delt type="button" value="删除" onClick="todel()">
<input id=save type="submit" value="保存">
<input id=reset type="reset" value="重置">
<input id=delt type="button" value="新增单据类型" onClick=openwin("operationInitAdd.asp",450,300)>
</center>
</div>
</form>
</body>
</html>
<%
function elect(optValue,utype)
  if optValue=utype then
    elect = "selected"
  end if 
end function

Sub dete()
	if trim(session("loginnameb"))="user" then
		Response.Write"<script>alert('试用用户没有该权限！');history.go(-1)</SCRIPT>"
		response.end
	end if
  del_id= Replace(safereplace(Trim(request("id"))),"，",",")
	If Right(del_id,1) = "," Then del_id = Left(del_id,Len(del_id)-1)
  if del_id="" then
    response.write"<SCRIPT language=JavaScript>alert('请选择您要删除的条目！');javascript:history.go(-1)</SCRIPT>"
    response.end
  end if
on error resume next
  conn.execute "delete from dict_bill where id in("&del_id&")"
  if err.number=0 then
  	conn.commitTrans
  else
  	conn.rollbackTrans
  end if
End Sub

sub updt
	if trim(session("loginnameb"))="user" then
		Response.Write"<script>alert('试用用户没有该权限！');history.go(-1)</SCRIPT>"
		response.end
	end if
	id = replace(safereplace(trim(request.form("h_id")))," ","")
	code = replace(safereplace(trim(request.form("code")))," ","")
	show = replace(safereplace(trim(request.form("show")))," ","")
	showid = replace(safereplace(trim(request.form("showid")))," ","")
	name = replace(safereplace(trim(request.form("name")))," ","")
	utype = replace(safereplace(trim(request.form("utype")))," ","")
	if ubound(split(id,",")) = 0 then
    set rs=server.createobject("adodb.recordset")
    rs.open "select * from dict_bill where id=" &id, conn, 1, 3
    rs("c_paixu")=c_paixu
    rs.update
    rs.close:set rs=nothing
	else
		for i = 0 to ubound(split(id,","))
		  if instr(Lcase(code),Lcase(split(code,",")(i)))<>instrrev(Lcase(code),Lcase(split(code,",")(i))) then
		    response.write "<script>alert('类型简称重复，请重新输入！');location.href='operationInit.asp';</script>"
		    response.end
		  end if
	    set rs=server.createobject("adodb.recordset")
	    rs.open "select * from dict_bill where id=" &split(id,",")(i), conn, 1, 3
	    rs("code")=split(code,",")(i)
	    if instr(show,split(id,",")(i))>0 then
	      rs("show") = true
	    else
	    	rs("show") = false
	    end if
	    rs("showid")=split(showid,",")(i)
	    rs("name")=split(name,",")(i)
	    rs("utype")=split(utype,",")(i)
	    rs.update
	    rs.close:set rs=nothing
		next
	end if
end sub

public function safereplace(str)
  if isnull(str) then
    safereplace = ""
    exit function
  end if
  str = replace(str,"'","&#180;")
  str = replace(str,"""","&#34;")
  str = replace(str,"<","&lt;")
  str = replace(str,">","&gt;")
  str = replace(str,"$","")
  safereplace = str
end function
%>