function validate_form(){
	validity = true;
	if (!check_empty(document.form.CustName.value)){
		validity = false; alert('��Ӧ�̲���Ϊ��!');
	}
	if (!check_empty(document.form.DepotName.value)){ 
		validity = false; alert('�������Ʋ���Ϊ��!'); 
	}
	if (document.form.intK.value==0){ 
		validity = false; alert('����¼����Ʒ��ϸ��Ϣ��'); 
	}
	return validity;
}

function check_empty(text){
	return (text.length > 0); 
}

function showbarcode(){
	if(	document.all.divbarcode.style.display=="none"){
		document.all.divbarcode.style.display="inline";
		document.all.barcode.focus();
		document.all.barcode.select();
	}else{
		document.all.divbarcode.style.display="none"
	}
}

function setbarcode(){
	if(event.keyCode==13){
		if(document.all.depot.value=='��ѡ��'){alert('��ѡ��ֿ�')}
		if(document.all.depot.value!='��ѡ��'){
			openwin('../public/rkbarcode_select.asp?id='+document.all.intK.value+'&barcode='+document.all.barcode.value,120,80)
		}
		document.all.barcode.select();
	}
}

function checkdepot(el){
	var k
	k=window.event.srcElement.parentElement.parentElement.rowIndex;
	if(document.all.DepotName.value=='��ѡ��'){alert('��ѡ��ֿ�')}
	if(document.all.DepotName.value!='��ѡ��')
	{
		openwin('../unit/goods_select.asp?type=rk&id='+el+'&depot='+document.all.DepotName.value,640,480)
	}
}
function addNew(){
	tr=document.all.t136.insertRow()
	tr.style.height=25
	tr.insertCell().innerHTML='<a class=delete href=javascript:void(0) onclick=del()>ɾ��</a>'
	tr.insertCell().innerText=++k
	document.all.intK.value=k
	tr.insertCell().innerHTML='<input title="˫��ѡ���Ʒ����" style=width:70%;border:0px; readonly type=text name=goodscode'+k+'> <img style=padding-top:10px;cursor:hand onclick=checkdepot('+k+'); src=../images/find.gif>'
	tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=goodsname'+k+'>'
	tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=goodsunit'+k+'>'
	tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=units'+k+'>'
	tr.insertCell().innerHTML='<input onkeyup=changenumber('+k+') style=width:100%;text-align:right value=0 type=text name=number'+k+'>'
	tr.insertCell().innerHTML='<input onkeyup=changeprice('+k+') style=width:100%;text-align:right value=0 type=text name=price'+k+'>'
	tr.insertCell().innerHTML='<input onkeyup=changemoney('+k+') style=width:100%;text-align:right value=0 type=text name=money'+k+'>'
	tr.insertCell().innerHTML='<input style=width:100%; type=text name=note'+k+'>'
}
function del(){
	i=window.event.srcElement.parentElement.parentElement.rowIndex;
	document.all.t136.deleteRow(i);
	for(k=0;k<document.all.t136.rows.length-1;k++){
		document.all.t136.rows[k+1].cells[1].innerText=(k+1);
		document.all.t136.rows[k+1].cells[2].children[0].name='goodsstyle_'+(k+1);
		document.all.t136.rows[k+1].cells[3].children[0].name="goodsname_"+(k+1);
		document.all.t136.rows[k+1].cells[4].children[0].name="units_"+(k+1);
		document.all.t136.rows[k+1].cells[5].children[0].name="sizename_"+(k+1);
		document.all.t136.rows[k+1].cells[6].children[0].name="colorname_"+(k+1);
		document.all.t136.rows[k+1].cells[7].children[0].name="number_"+(k+1);
		document.all.t136.rows[k+1].cells[8].children[0].name="price_"+(k+1);
		document.all.t136.rows[k+1].cells[9].children[0].name="money_"+(k+1);
		document.all.t136.rows[k+1].cells[10].children[0].name="barcode_"+(k+1);
		document.all.t136.rows[k+1].cells[11].children[0].name="dremark_"+(k+1);
	}
	document.all.intK.value=k
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