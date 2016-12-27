function validate_form(){
	validity = true;
	if (!check_empty(document.form.CustName.value)){
		validity = false; alert('供应商不能为空!');
	}
	if (!check_empty(document.form.DepotName.value)){ 
		validity = false; alert('店铺名称不能为空!'); 
	}
	if (document.form.intK.value==0){ 
		validity = false; alert('请您录入商品明细信息！'); 
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
		if(document.all.depot.value=='请选择'){alert('请选择仓库')}
		if(document.all.depot.value!='请选择'){
			openwin('../public/rkbarcode_select.asp?id='+document.all.intK.value+'&barcode='+document.all.barcode.value,120,80)
		}
		document.all.barcode.select();
	}
}

function checkdepot(el){
	var k
	k=window.event.srcElement.parentElement.parentElement.rowIndex;
	if(document.all.DepotName.value=='请选择'){alert('请选择仓库')}
	if(document.all.DepotName.value!='请选择')
	{
		openwin('../unit/goods_select.asp?type=rk&id='+el+'&depot='+document.all.DepotName.value,640,480)
	}
}
function addNew(){
	tr=document.all.t136.insertRow()
	tr.style.height=25
	tr.insertCell().innerHTML='<a class=delete href=javascript:void(0) onclick=del()>删除</a>'
	tr.insertCell().innerText=++k
	document.all.intK.value=k
	tr.insertCell().innerHTML='<input title="双击选择货品编码" style=width:70%;border:0px; readonly type=text name=goodscode'+k+'> <img style=padding-top:10px;cursor:hand onclick=checkdepot('+k+'); src=../images/find.gif>'
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