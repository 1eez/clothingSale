<%
response.write request.cookies("backup")
response.write request.cookies("kcwarning")
response.cookies("backup")=""
response.cookies("kcwarning")=""
qxlist2 = request.cookies("qxlist")
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>服装进销存管理系统（B/S）版</title>

<style type="text/css">
<!--
body { background:#f7f7f7;}
a.a1{
	display: block;
}
a.a1:hover{
	background-image: url(images/index_01.gif);
	background-repeat: no-repeat;
}
-->
</style>
<script type='text/javascript' src='js/public.js'></script>
<script type="text/JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
</head>
<body onload="MM_preloadImages('images/index_01.gif','images/index_1.gif','images/index_3.gif','images/index_2.gif','images/index_4.gif','images/index_5.gif','images/index_6.gif','images/index_17.gif','images/index_18.gif','images/index_19.gif')">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center"><table width="400" height="294" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td>
		<% if instr(qxlist2,"rk_add")>0 then %>
		<a href="javascript:" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image15','','images/index_1.gif',1)"><img src="images/index_01.gif" name="Image15" width="92" height="103" border="0" id="Image15" onclick=openwin('unit/rk_add.asp',680,480);></a>
		<% end if %>
		</td>
        <td valign="middle"><% if instr(qxlist2,"rk_add")>0 then %><img src="images/index_7.gif" width="97" height="57" /><% end if %></td>
        <td height="200" rowspan="2" valign="bottom">
		<% if instr(qxlist2,"kc_find")>0 then %>
		<a href="report/kc_find.asp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image16','','images/index_3.gif',1)"><img src="images/index_33.gif" name="Image16" width="92" height="103" border="0" id="Image16" /></a>
		<% end if %>
		</td>
        <td valign="middle"><% if instr(qxlist2,"ck_add")>0 then %><img src="images/index_8.gif" width="94" height="57" /><% end if %></td>
        <td><% if instr(qxlist2,"ck_add")>0 then %><a href="javascript:" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image17','','images/index_2.gif',1)"><img src="images/index_22.gif" name="Image17" width="92" height="103" border="0" id="Image17" onclick=openwin('unit/ck_add.asp',680,480);></a><% end if %></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><% if instr(qxlist2,"db_add")>0 then %><img src="images/index_9.gif" width="88" height="57" /><% end if %></td>
        <td><% if instr(qxlist2,"zz_add")>0 then %><img src="images/index_11.gif" width="95" height="57" /><% end if %></td>
        <td><% if instr(qxlist2,"pd_add")>0 then %><img src="images/index_10.gif" width="84" height="57" /><% end if %></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><% if instr(qxlist2,"db_add")>0 then %><a href="javascript:" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image18','','images/index_4.gif',1)"><img src="images/index_44.gif" name="Image18" width="92" height="103" border="0" id="Image18" onclick=openwin('unit/tb_add.asp',680,480);></a><% end if %></td>
        <td>&nbsp;</td>
        <td align="center"><% if instr(qxlist2,"zz_add")>0 then %><a href="javascript:" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image19','','images/index_5.gif',1)"><img src="images/index_55.gif" name="Image19" width="92" height="103" border="0" id="Image19" onclick=openwin('unit/zz_add.asp',680,480);></a><% end if %></td>
        <td>&nbsp;</td>
        <td><% if instr(qxlist2,"pd_add")>0 then %><a href="javascript:" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image20','','images/index_6.gif',1)"><img src="images/index_66.gif" name="Image20" width="92" height="103" border="0" id="Image20" onclick=openwin('unit/pd_add.asp',680,480);></a><% end if %></td>
      </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td><table width="410" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="20">&nbsp;</td>
        <td align="center">&nbsp;</td>
        <td align="right">&nbsp;</td>
      </tr>
      <tr>
        <td><% if instr(qxlist2,"wldw_m")>0 then %><a href="unit/custom_find.asp?type=custom" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image21','','images/index_17.gif',1)"><img src="images/index_77.gif" name="Image21" width="92" height="103" border="0" id="Image21" /></a><% end if %></td>
        <td align="center"><% if instr(qxlist2,"emp_m")>0 then %><a href="unit/emp_find.asp?type=supply" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image22','','images/index_18.gif',1)"><img src="images/index_88.gif" name="Image22" width="92" height="103" border="0" id="Image22" /></a><% end if %></td>
        <td align="right"><% if instr(qxlist2,"hpzl_m")>0 then %><a href="unit/hp_find.asp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image23','','images/index_19.gif',1)"><img src="images/index_99.gif" name="Image23" width="92" height="103" border="0" id="Image23" /></a><% end if %></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
