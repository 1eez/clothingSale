function getonevalue(fonevalue, fallvalue){
	fonevalue = fallvalue.substr(fallvalue.indexOf(fonevalue) + fonevalue.length,10000)
	fonevalue = fonevalue.substr(0,fonevalue.indexOf("|-;"))
	return fonevalue
}

function xsgoodsselect(){
	
	var obj = event.srcElement
	var tab=document.getElementById('table1');
	if(obj.tagName != "TR")
	obj = obj.parentElement;
	allvalue=tab.rows[obj.rowIndex].cells[0].innerHTML
	
	j = self.opener.document.all.intK.value
	tr=self.opener.document.all.t136.insertRow()
	tr.style.height=25
	tr.insertCell().innerHTML='<a class=delete href=javascript:void(0) onclick=del()>删除</a>' 
	tr.insertCell().innerText=++j
	self.opener.document.all.intK.value=j


	tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=goodsstyle_'+j+' value="'+getonevalue("goodsstyle:", allvalue)+'">' 
	tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=goodsname_'+j+' value="'+getonevalue("goodsname:", allvalue)+'">' 
	tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=units_'+j+' value="'+getonevalue("units:", allvalue)+'">' 
	tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=sizename_'+j+' value="'+getonevalue("sizename:", allvalue)+'">' 
	tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=colorname_'+j+' value="'+getonevalue("colorname:", allvalue)+'">' 
	tr.insertCell().innerHTML='<input onFocus="this.select()" onkeyup=changenumber('+j+') class=number style=width:100%; type=text name=number_'+j+' value="0">' 
	if(self.opener.document.all.billtype.value=='店铺调拨'){
	tr.insertCell().innerHTML='<input onFocus="this.select()" onkeyup=changeprice('+j+') class=number style=width:100%; type=text name=price_'+j+' value="'+getonevalue("tprice:", allvalue)+'">' 
	}else{
	tr.insertCell().innerHTML='<input onFocus="this.select()" onkeyup=changeprice('+j+') class=number style=width:100%; type=text name=price_'+j+' value="'+getonevalue("xsprice:", allvalue)+'">' 	
	}
	alert("操作成功!")
	tr.insertCell().innerHTML='<input onFocus="this.select()" onkeyup=changemoney('+j+') class=number style=width:100%; type=text name=money_'+j+' value="0">' 
	tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=barcode_'+j+' value="'+getonevalue("barcode:", allvalue)+'">' 
	tr.insertCell().innerHTML='<input style=width:100%; type=text name=dremark_'+j+' value=><input style=width:100%;border:0px; readonly type=hidden name=inprice_'+j+' value="'+getonevalue("tprice:", allvalue)+'">' 	
	tab.deleteRow(obj.rowIndex);

}