<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0018)http://soi.zh.abc/ -->
<HTML>
<title>BZWB服装进销存WEB版</title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<SCRIPT language=JavaScript type=text/javascript>
<!-- 
function setFormFocus() {
	document.forms[0].username.focus(); 
	document.forms[0].username.select();
}
function enonclick(){
  if (window.event.keyCode==13){
             login();
    }
}

//设置Cookie的函数 
function setCookie(name,value){
	var Days = 30; 	    //此cookie将被保存 30天   
	var exp = new Date();   //new   Date("December   31,   9998");   
     exp.setTime(exp.getTime() + Days*24*60*60*1000);   
     document.cookie = name +"="+ escape(value)+";expires="+exp.toGMTString();   
  }   
function getCookie(objName){
    var arrStr = document.cookie.split("; ");
    for(var i = 0;i < arrStr.length;i ++){
    var temp = arrStr[i].split("=");
    if(temp[0] == objName) return unescape(temp[1]);
   } 
} 
function delCookie(name){   
	var exp = new Date();   
	exp.setTime(exp.getTime()-1);   
	var cval=getCookie(name);   
     if(cval!=null) document.cookie=name+"="+cval+";expires="+exp.toGMTString();   
  }
  
  function saveusername(){
  
     var uname = document.form.username.value;
      setCookie("username",uname);
  
  }
  
  function getusername(){
      setFormFocus();
	  var uname =getCookie("username");
	  if(uname){
	    if(uname!="undefined"){
	     document.form.username.value = uname;
	    }
	  }

  }
// -->
</SCRIPT>

<script language=javascript>
function login() {
if (document.form.username.value=="") {
alert("请输入用户名")
document.form.username.focus()
return false;
}

document.form.submit();


}
</script>

<META name=GENERATOR content="MSHTML 8.00.7600.16385">
<link rel="stylesheet" href="lawimages/nonghang.css" type="text/css">
</HEAD>
<body  onkeydown=enonclick(); onload='getusername()' leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<style type="text/css"> 
<!--
@import url("lawimage/nonghang.css");
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-image: url();
	background-repeat: no-repeat;
	background-color: #3D59A3;
}
-->
</style>

<FORM name=form action="public/check_login.asp" method=post onSubmit="return login()">


 
<TABLE border=0 cellSpacing=0 cellPadding=0 width=1000 align=center>
  <TBODY>
  <TR>
    <TD height=550 vAlign=top background=lawimage/login1.jpg>
      <TABLE border=0 cellSpacing=0 cellPadding=0 width=900 align=center>
        <TBODY>
        <TR>
          <TD height=100>&nbsp;</TD>
        </TR>
        <TR>
          <TD>
            <TABLE border=0 cellSpacing=0 cellPadding=0 width=900>
              <TBODY>
              <TR>
                <TD width=185><IMG src="lawimage/login2.jpg" width=185 
                  height=371></TD>
                <TD vAlign=top>
                  <TABLE border=0 cellSpacing=0 cellPadding=0 width="100%">
                    <TBODY>
                    <TR>
                      <TD><IMG src="lawimage/jxclogo.jpg" width=533 
                        height=105></TD>
                    </TR>
                    <TR>
                      <TD height=266 vAlign=top 
                      background=lawimage/login5.jpg>
                        <TABLE border=0 cellSpacing=0 cellPadding=0 width=320>
                          <TBODY>
                          <TR>
                            <TD height=74 vAlign=bottom>
                              <TABLE border=0 cellSpacing=0 cellPadding=0 
                              width=240 align=center>
                                <TBODY>
                                <TR>
                                <TD class=loginfont1 width=74>用户名：</TD>
                                <TD><LABEL><font size=2>
								<input name="username" id="username" class=inputPWD onchange="saveusername()" value="admin"></font> 
                                </LABEL></TD></TR></TBODY></TABLE></TD></TR>
                          <TR>
                            <TD height=60>
                              <TABLE border=0 cellSpacing=0 cellPadding=0 
                              width=240 align=center>
                                <TBODY>
                                <TR>
                                <TD class=loginfont1 
                                width=74>密&nbsp;&nbsp;码：</TD>
                                <TD><LABEL><input id=password class=inputPWD type=password name=password value="admin"> 
                                </LABEL></TD></TR></TBODY></TABLE></TD></TR>
                          <TR>
                            <TD>
                              <TABLE border=0 cellSpacing=0 cellPadding=0 
                              width=291>
                                <TBODY>
                                <TR>
                                <TD width=113>&nbsp;</TD>
                                <TD>
                                <TABLE border=0 cellSpacing=0 cellPadding=0 
                                width=180>
                                <TBODY>
                                <TR>
                                <TD width=90><IMG 
                                onclick=login() 
                                src="lawimage/login6.jpg" width=83 
                                height=23></TD>
                                <TD>
                                <DIV align=center><IMG onclick=window.close() 
                                src="lawimage/login7.jpg" width=83 
                                height=23></DIV></TD></TR>
                                <TR>
                                <P></P></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD>
                <TD width=183><IMG src="lawimage/login3.jpg" width=183 
                  height=371></TD></TR></TBODY></TABLE></TD></TR>
        <TR>
          <TD align="center">
          	<!--
		  <font color="ffffff">[管 理 员]  用户名：admin  密码：admin&nbsp;&nbsp;<br>
      -->
		  </font>
		  <br><br>
		  <font color="ffffff">
		 
技术支持：北京表正万邦科技 &nbsp;&nbsp;热线：400-616-1170 <br>
</font>
 <a href="http://www.bzwb.net" target="_blank">  <font color="ffffff"> http://www.bzwb.net</font></a>
</TD>
        </TR></TBODY></TABLE></TD></TR></TBODY></TABLE><!--
<input type="submit" value="">--></FORM></BODY></HTML>
