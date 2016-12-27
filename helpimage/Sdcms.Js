function getOs()
{ 
    var OsObject = ""; 
   if(navigator.userAgent.indexOf("MSIE")>0) { 
        return "MSIE"; 
   } 
   if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){ 
        return "Firefox"; 
   } 
   if(isSafari=navigator.userAgent.indexOf("Safari")>0) { 
        return "Safari"; 
   } 
   if(isCamino=navigator.userAgent.indexOf("Camino")>0){ 
        return "Camino"; 
   } 
   if(isMozilla=navigator.userAgent.indexOf("Gecko")>0){ 
        return "Gecko"; 
   }
}

function setTab(name,cursel,n){
	for(i=1;i<=n;i++){
		var menu=$('#'+name+i);
		var con=$("#con_"+name+"_"+i);
		menu[0].className=i==cursel?"submenu_over":"submenu";
		con[0].style.display=i==cursel?"block":"none";
	}
}

function killErrors() {return true;}
window.onerror = killErrors;

var Ajax_msg="获取失败";

$(pageInit);
var editor;
function pageInit()
{
	editor=$('#content').xheditor(true)[0].xheditor;
}
//代码运行	
function runcode(codeBtn)
{
	var codeText=codeBtn.parentNode.firstChild;
	var codeValue=codeText.value;
	var rng=window.open('','','');
		rng.opener=null;
		rng.document.write(codeValue);
		rng.document.close();
}

//复制代码
function copycode(codeBtn)
{
	var codeText=codeBtn.parentNode.firstChild;
	var rng=codeText.createTextRange();
		rng.moveToElementText(codeText);
		rng.scrollIntoView();
		rng.select();
		rng.execCommand("Copy");
		rng.collapse(false);
}

//保存代码
function savecode(codeBtn)
{	
	var winname=window.open('about:blank', '_blank', 'top=100');
		winname.document.open();
		winname.document.write(codeBtn.parentNode.firstChild.value);
		winname.document.execCommand('saveas','','runcode.htm');
		winname.close();		
}

function trim(s){return  s.replace(/(^\s*)|(\s*$)/g,  "");} 
function load_menu(t0,t1,t2)
{
	var t3=location.href;
	//alert(t3);
	if(t3.indexOf(t0)!="-1"){$("#"+t2).addClass(t1);}
}

function Get_Spider()
{
	$.ajax({
	type: "get",
	cache:false,
	url: webdir+"inc/Spider.asp",
	timeout: 20000,
	error: function(){},
	success: function(){}
	});
}

function Get_Down_Count(t0)
{
	$('#'+t0).html("<img src="+webdir+"skins/sdcms/images/loading.gif>");
	$.ajax({
	type: "get",
	cache:false,
	url: webdir+"plug/down.asp?action=load",
	timeout: 20000,
	error: function(){},
	success: function(t1){$('#'+t0).html(t1+" ");}
	});
}

function gourl(t0,t1,t2,t3)
{
	var t4=$("#gopage")[0].value;
	t4=parseInt(t4);
	if (isNaN(t4)){t4=1;}
	if (t4<=1){t4=1;}
	if (t4>=t0){t4=t0;}
	if (t3==1)
	{
		if (t4<=1){t5=t1+t2;}else{t4=t4-1;t5=t1+"_"+t4+t2;}
	}
	else{
		if (t4<=1){t5=t1+t2;}else{t5=t1+t4+t2;}
		}
	location.href=t5;
}

function get_hits(t0,t1,t2,t3)
{
	$('#'+t3).html("<img src="+webdir+"skins/sdcms/images/loading.gif>");
	$.ajax({
	type: "get",
	cache:false,
	url: webdir+"inc/gethits.asp?id="+t0+"&action="+t1+"&t="+t2+"",
	timeout: 20000,
	error: function(){$('#'+t3).html(Ajax_msg);},
	success: function(t0){$('#'+t3).html(t0);}
	});
}

function Get_Digg(t0,t1)
{
	$('#'+t1).html("<img src="+webdir+"skins/sdcms/images/loading.gif>");
	$.ajax({
	type: "get",
	cache:false,
	url: webdir+"inc/Digg.asp?id="+t0+"",
	timeout: 20000,
	error: function(){$('#'+t1).html(Ajax_msg);},
	success: function(t0){$('#'+t1).html(t0);}
	});
}

function Digg(t0,t1,t2)
{
	$('#'+t2).html("<img src="+webdir+"skins/sdcms/images/loading.gif>");
	$.ajax({
	type: "get",
	cache:false,
	url: webdir+"inc/Digg.asp?id="+t0+"&action=Digg",
	timeout: 20000,
	error: function(){$('#'+t2).html(Ajax_msg);},
	success: function(t3){$('#'+t2).html(t3.substring(1));if(t3.substring(0,1)==0){Get_Digg(t0,t1)}}
	});
}

function Digg_Action(t0,t1,t2,t3,t4,t5)
{
	$.ajax({
	type: "get",
	cache:false,
	url: webdir+"Plug/Digg.asp?id="+t0+"&action="+t1+"",
	timeout: 20000,
	error: function(){alert(Ajax_msg);},
	success: function(t6){
		var t7=t6.split(':');
		var sUp=parseInt(t7[0]);
		var sDown=parseInt(t7[1]);
		var sTotal=sUp+sDown;
		if(sTotal==0)
		{
			var spUp=0;var spDown=0;
		}
		else
		{
		var spUp=(sUp/sTotal)*100;
		spUp=Math.round(spUp*10)/10;
		var spDown=100-spUp;
		spDown=Math.round(spDown*10)/10;
		}
		var t8=t7[2];
		if (t8==1)
		{
			$('#'+t2).html(spUp+"%("+sUp+")");
			$('#'+t3).html(spDown+"%("+sDown+")")
			$('#'+t4)[0].style.width=spUp+'%';
			$('#'+t5)[0].style.width=spDown+'%';
		}
		else{alert('您不是已表过态了嘛！');}
		}
	});
}

function get_comment(t0,t1)
{
	$('#'+t1).html("<img src="+webdir+"skins/sdcms/images/loading.gif>");
	$.ajax({
	type: "get",
	cache:false,
	url: webdir+"inc/gethits.asp?id="+t0+"&action=2",
	timeout: 20000,
	error: function(){$('#'+t1).html(Ajax_msg)},
	success: function(t0){$('#'+t1).html(t0);}
	})
}


function checksearch(theform)
{
	if (trim(theform.key.value)=='')
	{alert('关键字不能为空');
	theform.key.focus();
	theform.key.value='';
	return false
	}
	if (theform.key.value=='请输入关键字')
	{alert('关键字不能为空');
	theform.key.focus();
	theform.key.value='';
	return false
	}
	window.location.href=webdir+"search/?/"+theform.key.value+"/";
	return false
}
function checkcomment(theform)
{
	if (trim(theform.username.value)=='')
	{alert('姓名不能为空');
		theform.username.focus();
		theform.username.value='';
		return false
	}
	if (trim(editor.getSource())=='')
	{alert('内容不能为空');
		editor.focus();
		theform.content.value='';
		return false
	}
	if (trim(theform.yzm.value)=='')
	{   alert('验证码不能为空');
		theform.yzm.focus();
		theform.yzm.value='';
		return false
	}
	var param;
	param=webdir+"plug/comment.asp?action=save";
	param+="&username="+escape(trim(theform.username.value));
	param+="&content="+escape(trim(theform.content.value));
	param+="&yzm="+escape(trim(theform.yzm.value));
	param+="&id="+escape(trim(theform.id.value));
	$('#showmsg').html("<img src="+webdir+"skins/sdcms/images/loading.gif>");
	$.ajax({
	type:"get",
	cache:false,
	url:param,
	timeout:20000,
	error:function(){$('#showmsg').html(Ajax_msg);},
	success:function(t0)
	{
		$('#showmsg').html(t0.substring(1));
		if(t0.substring(0,1)==0){theform.username.value='';theform.yzm.value='';editor.setSource('');$("#yzm_num")[0].src = $("#yzm_num")[0].src+"&"+Math.random();get_comment(theform.id.value,'show_i_commentnum');load_comment(theform.id.value,'comment_list');}
		}
	});
	return false
}


function load_comment(t0,t1)
{
	$('#'+t1).html("<img src="+webdir+"skins/sdcms/images/loading.gif>");
	$.ajax({
	type: "get",
	cache:false,
	url:webdir+"plug/comment.asp?id="+t0+"&t0="+t1+"",
	timeout: 20000,
	error:function(){$('#'+t1).html(Ajax_msg)},
	success:function(t0){$('#'+t1).html(t0.substring(1));}
	})
}

function get_comment_page(t0,t1,t2)
{
	$('#'+t2).html("<img src="+webdir+"skins/sdcms/images/loading.gif>");
	$.ajax({
	type: "get",
	cache:false,
	url:webdir+"plug/comment.asp?id="+t1+"&page="+t0+"&t0="+t2+"",
	timeout:20000,
	error:function(){$('#'+t2).html(Ajax_msg)},
	success:function(t0){$('#'+t2).html(t0);}
	})
}

function checkbook(theform)
{  
	if (trim(theform.username.value)=='')
	{   alert('姓名不能为空');
		theform.username.focus();
		theform.username.value='';
		return false
	}
	if (trim(editor.getSource())=='')
	{   alert('内容不能为空');
		editor.focus();
		theform.content.value='';
		return false
	}
	if (trim(theform.yzm.value)=='')
	{   alert('验证码不能为空');
		theform.yzm.focus();
		theform.yzm.value='';
		return false
	}
	var param;
	param=webdir+"plug/book.asp?action=save";
	param+="&username="+escape(trim(theform.username.value));
	param+="&content="+escape(trim(theform.content.value));
	param+="&yzm="+escape(trim(theform.yzm.value));
	$('#showmsg').html("<img src="+webdir+"skins/sdcms/images/loading.gif>");
	$.ajax({
	type:"post",
	cache:false,
	url:param,
	timeout:20000,
	error:function(){$('#showmsg').html(Ajax_msg);},
	success:function(t0)
	{
		$('#showmsg').html(t0.substring(1));
		if(t0.substring(0,1)==0){theform.username.value='';editor.setSource('');$('#showmsg').html("<img src="+webdir+"skins/sdcms/images/loading.gif>发布成功");setTimeout("window.location.href='?';","1000");}
		}
	});
	return false
}
function checkLink(theform)
{  
	if (trim(theform.t0.value)=='')
	{   alert('网站不能为空');
		theform.t0.focus();
		theform.t0.value='';
		return false
	}
	if (trim(theform.t1.value)=='')
	{   alert('网址不能为空');
		theform.t1.focus();
		theform.t1.value='';
		return false
	}
	if (trim(theform.t3.value)=='')
	{   alert('验证码不能为空');
		theform.t3.focus();
		theform.t3.value='';
		return false
	}
	var param;
	param=webdir+"plug/link.asp?action=save";
	param+="&t0="+escape(trim(theform.t0.value));
	param+="&t1="+escape(trim(theform.t1.value));
	param+="&t2="+escape(trim(theform.t2.value));
	param+="&t3="+escape(trim(theform.t3.value));
	$('#showmsg').html("<img src="+webdir+"skins/sdcms/images/loading.gif>");
	$.ajax({
	type:"post",
	cache:false,
	url:param,
	timeout:20000,
	error:function(){$('#showmsg').html(Ajax_msg);},
	success:function(t0)
	{
		$('#showmsg').html(t0.substring(1));
		if(t0.substring(0,1)==0){theform.t0.value='';theform.t1.value='';theform.t2.value='';theform.t3.value='';$("#yzm_num")[0].src = $("#yzm_num")[0].src+"&"+Math.random();$('#showmsg').html(t0.substring(1));}
		}
	});
	return false
}

function checkvote(theform,t1)
{  
	var temp=""; 
	for(var i=0;i<theform.vote.length;i++) 
	{ 
	if(theform.vote[i].checked) 
	temp+=theform.vote[i].value+","; 
	}
	if(temp==""){
		$("#showvote").html("至少选择一个选项");
	return false
	}
	var param;
	param=webdir+"plug/vote.asp?action=save";
	param+="&t0="+escape(trim(temp));
	param+="&id="+escape(trim(theform.vote_id.value));
	$('#showvote').html("<img src="+webdir+"skins/sdcms/images/loading.gif>");
	$.ajax({
	type:"post",
	cache:false,
	url:param,
	timeout:20000,
	error:function(){$('#showvote').html(Ajax_msg);},
	success:function(t0)
	{
		$('#showvote').html(t0.substring(1));
		if(t0.substring(0,1)==0){$('#showvote').html(t0.substring(1));if(t1==1){window.location.href='?id='+theform.vote_id.value+'';}}
		}
	});
	return false
}

function checkPublish(theform)
{  
	if (trim(theform.t0.value)=='')
	{   alert('标题不能为空');
		theform.t0.focus();
		theform.t0.value='';
		return false
	}
	if (trim(theform.t1.value)=='')
	{   alert('作者不能为空');
		theform.t1.focus();
		theform.t1.value='';
		return false
	}
	if (trim(theform.t2.value)=='')
	{   alert('来源不能为空');
		theform.t2.focus();
		theform.t2.value='';
		return false
	}
	if (trim(theform.t3.value)=='0')
	{   alert('请选择栏目');
		theform.t3.focus();
		return false
	}
	if (trim(editor.getSource())=='')
	{   alert('内容不能为空');
		editor.focus();
		theform.content.value='';
		return false
	}
	if (trim(theform.yzm.value)=='')
	{   alert('验证码不能为空');
		theform.yzm.focus();
		theform.yzm.value='';
		return false
	}
}
function checkPublish_website(theform)
{  
	if (trim(theform.t0.value)=='')
	{   
		$("#showmsg")[0].style.display='block';
		$("#showmsg").html('网站名称不能为空');
		theform.t0.focus();
		theform.t0.value='';
		return false
	}
	if (trim(theform.t1.value)=='')
	{   
		$("#showmsg")[0].style.display='block';
		$("#showmsg").html('网站域名不能为空');
		theform.t1.focus();
		theform.t1.value='';
		return false
	}
	if (trim(theform.t1.value)=='http://')
	{   
		$("#showmsg")[0].style.display='block';
		$("#showmsg").html('网站域名不能为空');
		theform.t1.focus();
		return false
	}
	if (trim(theform.t2.value)=='0')
	{   
		$("#showmsg")[0].style.display='block';
		$("#showmsg").html('请选择要加入的类别');
		theform.t2.focus();
		return false
	}
	if (trim(theform.t3.value)=='')
	{   
		$("#showmsg")[0].style.display='block';
		$("#showmsg").html('网站介绍不能为空');
		theform.t3.focus();
		theform.t3.value='';
		return false
	}
}