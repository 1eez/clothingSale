<script language="javascript">
var xmlHttp; 
function DivDisplay(id,rid,pid)
{
	if (GetId(id).style.display=='')
	{
		GetId(id).style.display='none';
		GetId(pid).src = '../images/closed.gif';
	}
	else
	{
		GetId(id).style.display='';
		GetId(pid).src = '../images/3.gif';
		if (GetId(id).innerHTML=='')
		{
			ShowChild(id,rid);
		}
	}
}

function CreateXMLHttpRequest()
{
	if (window.ActiveXObject)
	{
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	else
	{
		xmlHttp = new XMLHttpRequest();
	}
}

function ShowChild(id,rid)
{
	CreateXMLHttpRequest();
	if(xmlHttp)
	{
		xmlHttp.open('POST','columnAdmin.asp',true);
		xmlHttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
		var SendData = 'id='+rid;
		xmlHttp.send(SendData);
		xmlHttp.onreadystatechange=function()
		{
		   if(xmlHttp.readyState==4)
		   {
			 if(xmlHttp.status==200)
			 {
				GetId(id).innerHTML = xmlHttp.responseText;
			 }
			 else
			 {
				GetId(id).innerHTML='出错：'+xmlHttp.statusText;
			 }
		   }
		   else
		   {
				GetId(id).innerHTML="正在提交数据...";
			}
	  	}
		
	 }
	 else
	 {
	 	GetId(id).innerHTML='抱歉，您的浏览器不支持XMLHttpRequest，请使用IE6以上版本！';
	 }
}

//取得页面对象
//id,层id
function GetId(id)
{
	return document.getElementById(id);
} 
</script>
<%
set rs=server.createobject("adodb.recordset")
sql="select * from dict_cate where c_Depth=0 and table='"&f_table&"'"
rs.open sql,conn,1,1

do while not rs.eof
	if rs("c_childnum")>0 then
		response.Write("<img id='p"&rs("c_Id")&"' src=""../images/closed.gif"" width=""30"" height=""15"" onclick=""DivDisplay('c"&rs("c_id")&"','"&rs("c_id")&"','p"&rs("c_id")&"')"" style=""cursor : hand;"" align=""absmiddle"">")
	else
		response.Write("<img src=""../images/2.gif"" width=""30"" height=""15"" align=""absmiddle"" >")
	end if
	response.Write("<b>")
	response.Write("<a href=# onclick=change_name(this) value='"&rs("c_Name")&"!--"&rs("c_ID")&"~--"&rs("c_Select")&"'>"&rs("c_Name")&"</a>")
	response.Write("</b>")
	response.Write("<br>")
	if rs("c_childnum")>0 then
		response.Write("<div id='c"&rs("c_Id")&"' style='display:none;'></div>")
	end if
	rs.movenext
loop
rs.close
set rs=nothing
%>