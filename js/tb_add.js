function validate_form(){
validity = true;

if (document.form.depot_out.value=='��ѡ��')
{ validity = false; alert('����ѡ������ֿ⣡'); }

if (document.form.depot_in.value=='��ѡ��')
{ validity = false; alert('����ѡ�����ֿ⣡'); }

if (document.form.depot_out.value==document.form.depot_in.value)
{ validity = false; alert('��������ֿⲻ����ȣ���������ѡ��'); }

if (document.form.intK.value==0)
{ validity = false; alert('��¼���Ʒ���ϣ�'); }

return validity;
}
function check_empty(text){
return (text.length > 0); 
}

function setbarcode(){
	if(event.keyCode==13){
		if(document.all.depot_out.value=='��ѡ��'){alert('��ѡ��ֿ�')}
		if(document.all.depot_out.value!='��ѡ��'){
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
	if(document.all.depot_out.value=='��ѡ��'){alert('��ѡ������ֿ�')}
	if(document.all.depot_out.value!='��ѡ��')
	{openwin('../public/hpzl_select.asp?type=db&id='+el+'&depot='+document.all.depot_out.value,640,480)}
}
function addNew(){
	tr=document.all.t136.insertRow()
	tr.style.height=25
	tr.insertCell().innerHTML='<a class=delete href=javascript:void(0) onclick=del()>ɾ��</a>' 
	tr.insertCell().innerText=++k
	document.all.intK.value=k
	tr.insertCell().innerHTML='<input title="˫��ѡ���Ʒ����" ondblclick=checkdepot('+k+') style=width:70%;border:0px readonly type=text name=goodscode'+k+'> <img style=padding-top:10px;cursor:hand onclick=checkdepot('+k+'); src=../images/find.gif>' 
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
     return "��ֵ������Χ��֧�ֵ������ֵΪ 999999999999.99";
   var e = "��Ҽ��������½��ƾ�";
   var num1 = "";
   var len = a.length-1;
   for (var i=0 ; i<=len; i++)
    num1 += e.charAt(parseInt(a.charAt(i))) + [["Բ","��","��"][Math.floor((len-i)/4)],"ʰ","��","Ǫ"][(len-i)%4];
   if(number.length==2 && number[1]!="")
   {
     var a = number[1];
     for (var i=0 ; i<a.length; i++)
     num1 += e.charAt(parseInt(a.charAt(i))) + ["��","��"][i]; 
   }
   num1 = num1.replace(/���|��ʰ|��Ǫ|���/g,"��");
   num1 = num1.replace(/��{2,}/g,"��");
   num1 = num1.replace(/��(?=Բ|��|��)/g,"");
   num1 = num1.replace(/����/,"��");
   num1 = num1.replace(/^Բ��?/,"");

   if(num1!="" && !/��$/.test(num1))
     num1 += "��";
   return num1;
}