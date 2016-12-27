function validate_form(){
validity = true;

if (document.form.depot_out.value=='请选择')
{ validity = false; alert('请您选择调出仓库！'); }

if (document.form.depot_in.value=='请选择')
{ validity = false; alert('请您选择调入仓库！'); }

if (document.form.depot_out.value==document.form.depot_in.value)
{ validity = false; alert('调出调入仓库不能相等，请您重新选择！'); }

if (document.form.intK.value==0)
{ validity = false; alert('请录入货品资料！'); }

return validity;
}
function check_empty(text){
return (text.length > 0); 
}

function setbarcode(){
	if(event.keyCode==13){
		if(document.all.depot_out.value=='请选择'){alert('请选择仓库')}
		if(document.all.depot_out.value!='请选择'){
			addNew();
			openwin('../public/ckbarcode_select.asp?depot='+document.all.depot_out.value+'&id='+document.all.intK.value+'&barcode='+document.all.barcode.value,640,480)
			document.all.barcode.select();
		}
	}
}

function changeprice(num){
  if(event.keyCode==40){
  	num=num+1
  	document.all('price'+num).focus();
  	document.all('price'+num).select();
 }
 if(event.keyCode==38){
  	num=num-1
  	document.all('price'+num).focus();
  	document.all('price'+num).select();
 }
 if(event.keyCode==37){
  	document.all('number'+num).focus();
  	document.all('number'+num).select();
 }
 if(event.keyCode==39){
  	document.all('discount'+num).focus();
  	document.all('discount'+num).select();
 }	
document.all('cmoney'+num).value=(document.all('price'+num).value*document.all('number'+num).value).toFixed(2)

document.all('moneyx').innerHTML=0
for(j=1;j<parseInt(document.all.intK.value)+1;j++){
	document.all('moneyx').innerHTML=parseFloat(document.all('moneyx').innerHTML)+parseFloat(document.all('cmoney'+j).value);
}
document.all('moneyx').innerHTML=parseFloat((document.all('moneyx').innerHTML)).toFixed(2)
document.all('moneyd').innerHTML=number2num1(document.all('moneyx').innerHTML)
}

function changenumber(num){	
  if(event.keyCode==40){
  	num=num+1
  	document.all('number'+num).focus();
  	document.all('number'+num).select();
 }
 if(event.keyCode==38){
  	num=num-1
  	document.all('number'+num).focus();
  	document.all('number'+num).select();
 }
 if(event.keyCode==39){
  	document.all('price'+num).focus();
  	document.all('price'+num).select();
 }		
	document.all('cmoney'+num).value=(document.all('price'+num).value*document.all('number'+num).value).toFixed(2)

document.all('moneyx').innerHTML=0
document.all('numbera').innerHTML=0
for(j=1;j<parseInt(document.all.intK.value)+1;j++){
	document.all('numbera').innerHTML=parseFloat(document.all('numbera').innerHTML)+parseFloat(document.all('number'+j).value);
}
for(j=1;j<parseInt(document.all.intK.value)+1;j++){
	document.all('moneyx').innerHTML=parseFloat(document.all('moneyx').innerHTML)+parseFloat(document.all('cmoney'+j).value);
}
document.all('moneyx').innerHTML=parseFloat((document.all('moneyx').innerHTML)).toFixed(2)
document.all('moneyd').innerHTML=number2num1(document.all('moneyx').innerHTML)
}

function changecmoney(num){
  if(event.keyCode==40){
  	num=num+1
  	document.all('cmoney'+num).focus();
  	document.all('cmoney'+num).select();
 }
 if(event.keyCode==38){
  	num=num-1
  	document.all('cmoney'+num).focus();
  	document.all('cmoney'+num).select();
 }
 if(event.keyCode==37){
  	document.all('price'+num).focus();
  	document.all('price'+num).select();
 }	
document.all('moneyx').innerHTML=0
for(j=1;j<parseInt(document.all.intK.value)+1;j++){
	document.all('moneyx').innerHTML=parseFloat(document.all('moneyx').innerHTML)+parseFloat(document.all('cmoney'+j).value);
}
document.all('moneyx').innerHTML=parseFloat((document.all('moneyx').innerHTML)).toFixed(2)
document.all('moneyd').innerHTML=number2num1(document.all('moneyx').innerHTML)
}

function checkdepot(el){
	if(document.all.depot_out.value=='请选择'){alert('请选择调出仓库')}
	if(document.all.depot_out.value!='请选择')
	{openwin('../public/hpzl_select.asp?type=db&id='+el+'&depot='+document.all.depot_out.value,640,480)}
}
function addNew(){
	tr=document.all.t136.insertRow()
	tr.style.height=25
	tr.insertCell().innerHTML='<a class=delete href=javascript:void(0) onclick=del()>删除</a>' 
	tr.insertCell().innerText=++k
	document.all.intK.value=k
	tr.insertCell().innerHTML='<input title="双击选择货品编码" ondblclick=checkdepot('+k+') style=width:70%;border:0px readonly type=text name=goodscode'+k+'> <img style=padding-top:10px;cursor:hand onclick=checkdepot('+k+'); src=../images/find.gif>' 
	tr.insertCell().innerHTML='<input style=width:100%;border:0px readonly type=text name=goodsname'+k+'><input type=hidden name=xjxccode'+k+'>' 
	tr.insertCell().innerHTML='<input style=width:100%;border:0px readonly type=text name=goodsunit'+k+'>'
	tr.insertCell().innerHTML='<input style=width:100%;border:0px readonly type=text name=units'+k+'>' 
	tr.insertCell().innerHTML='<input onkeyup=changenumber('+k+') value=0 style=width:100%;text-align:right type=text name=number'+k+'>' 
	tr.insertCell().innerHTML='<input onkeyup=changeprice('+k+') value=0 style=width:100%;text-align:right type=text name=price'+k+'><input style=width:100%; type=hidden name=r_price'+k+'>' 
	tr.insertCell().innerHTML='<input onkeyup=changecmoney('+k+') value=0 style=width:100%;text-align:right type=text name=cmoney'+k+'>' 
	tr.insertCell().innerHTML='<input style=width:100%; type=text name=note'+k+'>' 
}
function del(){
	document.all.t136.deleteRow(window.event.srcElement.parentElement.parentElement.rowIndex);
	for(k=0;k<document.all.t136.rows.length-1;k++){
		document.all.t136.rows[k+1].cells[1].innerText=(k+1);
		document.all.t136.rows[k+1].cells[2].children[0].name="goodscode"+(k+1);
		document.all.t136.rows[k+1].cells[3].children[0].name="goodsname"+(k+1);
		document.all.t136.rows[k+1].cells[3].children[1].name="xjxccode"+(k+1);
		document.all.t136.rows[k+1].cells[4].children[0].name="goodsunit"+(k+1);
		document.all.t136.rows[k+1].cells[5].children[0].name="units"+(k+1);
		document.all.t136.rows[k+1].cells[6].children[0].name="number"+(k+1);
		document.all.t136.rows[k+1].cells[7].children[0].name="price"+(k+1);
		document.all.t136.rows[k+1].cells[7].children[1].name="r_price"+(k+1);
		document.all.t136.rows[k+1].cells[8].children[0].name="cmoney"+(k+1);
		document.all.t136.rows[k+1].cells[9].children[0].name="note"+(k+1);
	}
	document.all.intK.value=k
	document.all('moneyx').innerHTML=0
	document.all('numbera').innerHTML=0
	for(j=1;j<parseInt(document.all.intK.value)+1;j++){
		document.all('numbera').innerHTML=parseFloat(document.all('numbera').innerHTML)+parseFloat(document.all.t136.rows[j].cells[6].children[0].value);
	}
	for(j=1;j<parseInt(document.all.intK.value)+1;j++){
		document.all('moneyx').innerHTML=parseFloat(document.all('moneyx').innerHTML)+parseFloat(document.all.t136.rows[j].cells[8].children[0].value);
	}
	document.all('moneyx').innerHTML=parseFloat((document.all('moneyx').innerHTML)).toFixed(2)
	document.all('moneyd').innerHTML=number2num1(document.all('moneyx').innerHTML)
}
function number2num1(strg)
{
   var number = Math.round(strg*100)/100;
   number = number.toString(10).split(".");
   var a = number[0];
   if (a.length > 12)
     return "数值超出范围！支持的最大数值为 999999999999.99";
   var e = "零壹贰叁肆伍陆柒捌玖";
   var num1 = "";
   var len = a.length-1;
   for (var i=0 ; i<=len; i++)
    num1 += e.charAt(parseInt(a.charAt(i))) + [["圆","万","亿"][Math.floor((len-i)/4)],"拾","佰","仟"][(len-i)%4];
   if(number.length==2 && number[1]!="")
   {
     var a = number[1];
     for (var i=0 ; i<a.length; i++)
     num1 += e.charAt(parseInt(a.charAt(i))) + ["角","分"][i]; 
   }
   num1 = num1.replace(/零佰|零拾|零仟|零角/g,"零");
   num1 = num1.replace(/零{2,}/g,"零");
   num1 = num1.replace(/零(?=圆|万|亿)/g,"");
   num1 = num1.replace(/亿万/,"亿");
   num1 = num1.replace(/^圆零?/,"");

   if(num1!="" && !/分$/.test(num1))
     num1 += "整";
   return num1;
}