function setbarcode(){
	if(event.keyCode==13){
		if(document.all.cpdepot.value=='请选择'){alert('请选择仓库')}
		if(document.all.cpdepot.value!='请选择'){
			openwin('../public/zzbarcode.asp?depot='+document.all.cpdepot.value+'&barcode='+document.all('barcode').value,640,480)
		}
		document.all.barcode.select();
	}
}
function setbarcode1(){
	if(event.keyCode==13){
		if(document.all.lldepot.value=='请选择'){alert('请选择仓库')}
		if(document.all.lldepot.value!='请选择'){
			addNew();
			openwin('../public/zzbarcode.asp?id='+document.all.intK.value+'&depot='+document.all.lldepot.value+'&barcode='+document.all('barcode1').value,640,480)
			document.all.barcode.select();
		}
	}
}
function openzz(){
	if(document.all.cpdepot.value!='请选择'){
		openwin('../public/hpmb_select.asp?depot='+document.all.cpdepot.value,640,480)
	}else{
		alert('请选择组装完工仓');
		document.all.cpdepot.focus()
	}
}
function validate_form(){
validity = true;

if (!check_empty(document.form.rkdate.value))
{ validity = false; alert('组装日期不能为空，请您重新选择！'); }

if (document.form.cpdepot.value=='请选择')
{ validity = false; alert('请您选择成品仓库仓库！'); }

if (document.form.intK.value==0)
{ validity = false; alert('请录入货品资料！'); }

return validity;
}
function check_empty(text){
return (text.length > 0); 
}

function changeprice(num){
	document.all('money'+num).value=document.all('price'+num).value*document.all('number'+num).value
}

function changenumber(num){
	document.all('money'+num).value=document.all('price'+num).value*document.all('number'+num).value
}

function changemoney(num){
	k = num
	if(k==0){k=''};
	document.all('money'+k).value=document.all('price'+k).value*document.all('number'+k).value;
}

function setnum(){
	for(j=1;j<parseInt(document.all.intK.value)+1;j++){
		document.all('number'+j).value=document.all('number'+j).value*document.all('number').value;
		document.all('cmoney'+j).value=document.all('price'+j).value*document.all('number'+j).value;
	}	
}

function setmoney(){
	document.all('price').value=0;
	for(j=1;j<parseInt(document.all.intK.value)+1;j++){
		document.all('price').value=parseFloat(document.all('price').value)+parseFloat(document.all('cmoney'+j).value);
		document.all('money').value=document.all('price').value*document.all('number').value;
	}
	document.all('money').value=document.all('price').value
	document.all('price').value=parseFloat(document.all('money').value)/parseFloat(document.all('number').value)
}

function checkdepot(el){
	var k
	k=window.event.srcElement.parentElement.parentElement.rowIndex;
	if(document.all.lldepot.value=='请选择'){alert('请选择领料仓库');document.all.lldepot.focus();}
	if(document.all.lldepot.value!='请选择')
	{openwin('../public/zzhpzl_select.asp?id='+el+'&depot='+document.all.lldepot.value,640,480)}
}
function checkdepot1(el){
	if(document.all.cpdepot.value=='请选择'){alert('请选择成品仓库');document.all.cpdepot.focus();}
	if(document.all.cpdepot.value!='请选择')
	{openwin('../public/zzhpzl_select1.asp?depot='+document.all.cpdepot.value,640,480)}
}
function addNew(){
	tr=document.all.t136.insertRow()
	tr.style.height=25
	tr.insertCell().innerHTML='<a class=delete href=javascript:void(0) onclick=del()>删除</a>' 
	tr.insertCell().innerText=++k
	document.all.intK.value=k
	tr.insertCell().innerHTML='<input title="双击选择货品编码" ondblclick=checkdepot('+k+') style=width:70%; type=text name=goodscode'+k+'> <img style=padding-top:10px;cursor:hand onclick=checkdepot('+k+'); src=../images/find.gif>' 
	tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=goodsname'+k+'>' 
	tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=goodsunit'+k+'>' 
	tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=units'+k+'>' 
	tr.insertCell().innerHTML='<input onkeyup=changenumber('+k+') style=width:100%; type=text name=number'+k+'>' 
	tr.insertCell().innerHTML='<input onkeyup=changeprice('+k+') style=width:100%; type=text name=price'+k+'>' 
	tr.insertCell().innerHTML='<input onkeyup=changecmoney('+k+') style=width:100%; type=text name=cmoney'+k+'>' 
	tr.insertCell().innerHTML='<input style=width:100%; type=text name=note'+k+'>' 
}
function del(){
	document.all.t136.deleteRow(window.event.srcElement.parentElement.parentElement.rowIndex);
	for(k=0;k<document.all.t136.rows.length-1;k++){
		document.all.t136.rows[k+1].cells[1].innerText=(k+1);
		document.all.t136.rows[k+1].cells[2].children[0].name="goodscode"+(k+1);
		document.all.t136.rows[k+1].cells[3].children[0].name="goodsname"+(k+1);
		document.all.t136.rows[k+1].cells[4].children[0].name="goodstype"+(k+1);
		document.all.t136.rows[k+1].cells[5].children[0].name="units"+(k+1);
		document.all.t136.rows[k+1].cells[6].children[0].name="number"+(k+1);
		document.all.t136.rows[k+1].cells[7].children[0].name="price"+(k+1);
		document.all.t136.rows[k+1].cells[8].children[0].name="cmoney"+(k+1);
		document.all.t136.rows[k+1].cells[9].children[0].name="note"+(k+1);
	}
	document.all.intK.value=k
}