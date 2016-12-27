function settreename(el,streecode,streename,streecodename){

 var treecode,treename
	treecode=el.value.substr(0, el.value.indexOf("-"))
	treename=el.value.substr(el.value.indexOf("-")+1, 10000)
	if(streecode!=''){
		document.all(streecode).value=treecode;
	}
	if(streename!=''){
		document.all(streename).value=treename;
	}

	if(streecodename!=''){
		document.all(streecodename).value=el.value
	}else{
		if(typeof(eval("document.all.loginDIV_"))!= "undefined"){
			hidden("loginDIV_");
		}
		if(typeof(eval("document.all.mbDIV_"))!= "undefined"){
			hidden("mbDIV_");			
		}
		if(typeof(eval("document.all.loginDIV"))!= "undefined"){
			hidden("loginDIV");
		}
		if(typeof(eval("document.all.mbDIV"))!= "undefined"){
			hidden("mbDIV");			
		}
		 for (var i = 0; i < document.all.tags('SELECT').length; i++)
		{
			var obj = document.all.tags('SELECT')[i];
			obj.style.visibility = "visible";
		}		
	}
	
}
function show(ele)
{
  eval(ele + ".style.display = ''");
}
function hidden(ele)
{
  eval(ele + ".style.display = 'none'");
}

function changevalue(){
document.all('moneyx').innerHTML=0
document.all('numbera').innerHTML=0
for(j=1;j<parseInt(document.all.intK.value)+1;j++){
	document.all('numbera').innerHTML=parseFloat(document.all('numbera').innerHTML)+parseFloat(document.all('number_'+j).value);
}
for(j=1;j<parseInt(document.all.intK.value)+1;j++){
	document.all('moneyx').innerHTML=parseFloat(document.all('moneyx').innerHTML)+parseFloat(document.all('money_'+j).value);
}
document.all('moneyx').innerHTML=parseFloat((document.all('moneyx').innerHTML)).toFixed(2)
document.all('moneyd').innerHTML=number2num1(document.all('moneyx').innerHTML)
}

function changeprice(num){
  if(event.keyCode==40){
  	num=num+1
  	document.all('price_'+num).focus();
  	document.all('price_'+num).select();
 }
 if(event.keyCode==38){
  	num=num-1
  	document.all('price_'+num).focus();
  	document.all('price_'+num).select();
 }
 if(event.keyCode==37){
  	document.all('number_'+num).focus();
  	document.all('number_'+num).select();
 }
 if(event.keyCode==39){
  	document.all('money_'+num).focus();
  	document.all('money_'+num).select();
 }
	document.all('money_'+num).value=document.all('price_'+num).value*document.all('number_'+num).value

document.all('moneyx').innerHTML=0
for(j=1;j<parseInt(document.all.intK.value)+1;j++){
	document.all('moneyx').innerHTML=parseFloat(document.all('moneyx').innerHTML)+parseFloat(document.all('money_'+j).value);
}
document.all('moneyx').innerHTML=parseFloat((document.all('moneyx').innerHTML)).toFixed(2)
document.all('moneyd').innerHTML=number2num1(document.all('moneyx').innerHTML)
}

function changenumber(num){
  if(event.keyCode==40){
  	num=num+1
  	document.all('number_'+num).focus();
  	document.all('number_'+num).select();
 }
 if(event.keyCode==38){
  	num=num-1
  	document.all('number_'+num).focus();
  	document.all('number_'+num).select();
 }
 if(event.keyCode==39){
  	document.all('price_'+num).focus();
  	document.all('price_'+num).select();
 }
document.all('money_'+num).value=document.all('price_'+num).value*document.all('number_'+num).value

document.all('moneyx').innerHTML=0
document.all('numbera').innerHTML=0
for(j=1;j<parseInt(document.all.intK.value)+1;j++){
	document.all('numbera').innerHTML=parseFloat(document.all('numbera').innerHTML)+parseFloat(document.all('number_'+j).value);
}
for(j=1;j<parseInt(document.all.intK.value)+1;j++){
	document.all('moneyx').innerHTML=parseFloat(document.all('moneyx').innerHTML)+parseFloat(document.all('money_'+j).value);
}
document.all('moneyx').innerHTML=parseFloat((document.all('moneyx').innerHTML)).toFixed(2)
document.all('moneyd').innerHTML=number2num1(document.all('moneyx').innerHTML)
}

function changemoney(num){
  if(event.keyCode==40){
  	num=num+1
  	document.all('money_'+num).focus();
  	document.all('money_'+num).select();
 }
 if(event.keyCode==38){
  	num=num-1
  	document.all('money_'+num).focus();
  	document.all('money_'+num).select();
 }
 if(event.keyCode==37){
  	document.all('price_'+num).focus();
  	document.all('price_'+num).select();
 }
document.all('moneyx').innerHTML=0
for(j=1;j<parseInt(document.all.intK.value)+1;j++){
	document.all('moneyx').innerHTML=parseFloat(document.all('moneyx').innerHTML)+parseFloat(document.all('money_'+j).value);
}
document.all('moneyx').innerHTML=parseFloat((document.all('moneyx').innerHTML)).toFixed(2)
document.all('moneyd').innerHTML=number2num1(document.all('moneyx').innerHTML)
}

function openwin(URL,x,y){
var URL;
var x1=window.screen.width;   
var y1=window.screen.height;   
x2=(x1-x)/2;   
y2=(y1-y)/2;
window.open(URL,'','top='+y2+',left='+x2+',width='+x+',height='+y+',status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes')   
}
function openwin1(URL,x,y){
var URL;
var x1=window.screen.width;   
var y1=window.screen.height;   
x2=(x1-x)/2;   
y2=(y1-y)/2;
window.open(URL,'','top='+y2+',left='+x2+',width='+x+',height='+y+',status=yes,toolbar=no,menubar=yes,location=yes,resizable=yes,scrollbars=yes')   
}

function findObj(theObj, theDoc)
{
var p, i, foundObj;

if(!theDoc) theDoc = document;
if( (p = theObj.indexOf("?")) > 0 && parent.frames.length)
{
theDoc = parent.frames[theObj.substring(p+1)].document;
theObj = theObj.substring(0,p);
}
if(!(foundObj = theDoc[theObj]) && theDoc.all) foundObj = theDoc.all[theObj];
for (i=0; !foundObj && i < theDoc.forms.length; i++) 
foundObj = theDoc.forms[i][theObj];
for(i=0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++) 
foundObj = findObj(theObj,theDoc.layers[i].document);
if(!foundObj && document.getElementById) foundObj = document.getElementById(theObj);

return foundObj;
}

function godelete(){
	if (document.all.treecode.value != ""){
		if(confirm('如果您选择的是父节点，此操作将会删除它自身所有的子节点，确定以继续！')){
			location.href = 'basic_save.asp?catetype=删除&tablename='+document.all.tablename.value+'&treecode='+document.all.treecode.value;
		}else{
		}
	}else{
		if(document.all.treename.value!=""){
			alert('父节点不能删除！')
		}else{
			alert('请您选择要删除的节点！')
		}
	}
}
function goedit(){
	if (document.all.treecode.value != ""){
		if(document.all.edittreename.value!=""){
			location.href = 'basic_save.asp?catetype=修改&tablename='+document.all.tablename.value+'&treecode='+document.all.treecode.value+'&edittreename='+document.all.edittreename.value;
		}else{
			alert('请您输入编辑后的名称！')
		}
	}else{
		if(document.all.treename.value!=""){
			alert('父节点不能修改！')
		}else{
			alert('请您选择要修改的节点！')
		}
	}
}

function gocombodelete(){
	if (document.all.treecode.value != ""){
		if(confirm('如果您选择的是父节点，此操作将会删除它自身所有的子节点，确定以继续！')){
			location.href = 'combo_save.asp?catetype=删除&tablename='+document.all.tablename.value+'&treecode='+document.all.treecode.value;
		}else{
		}
	}else{
		if(document.all.treename.value!=""){
			alert('父节点不能删除！')
		}else{
			alert('请您选择要删除的节点！')
		}
	}
}
function gocomboedit(){
	if (document.all.treecode.value != ""){
		if(document.all.edittreename.value!=""){
			location.href = 'combo_save.asp?catetype=修改&tablename='+document.all.tablename.value+'&treecode='+document.all.treecode.value+'&edittreename='+document.all.edittreename.value;
		}else{
			alert('请您输入编辑后的名称！')
		}
	}else{
		if(document.all.treename.value!=""){
			alert('父节点不能修改！')
		}else{
			alert('请您选择要修改的节点！')
		}
	}
}

function order(el){
	if(el.value==document.all.orderf.value){
		if(document.all.ordero.value=='asc'){
			document.all.ordero.value='desc';
		}
		else{
			document.all.ordero.value='asc';
		}
	}
	else{
		document.all.orderf.value=el.value;
		document.all.ordero.value='desc';
	}
document.form.submit();
}

 Validator = {
	Require : /.+/,
	Email : /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/,
	Phone : /^((\(\d{3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}$/,
	Mobile : /^((\(\d{3}\))|(\d{3}\-))?13\d{9}$/,
	Url : /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/,
	IdCard : /^\d{15}(\d{2}[A-Za-z0-9])?$/,
	Currency : /^\d+(\.\d+)?$/,
	Number : /^\d+$/,
	Zip : /^[1-9]\d{5}$/,
	QQ : /^[1-9]\d{4,8}$/,
	Integer : /^[-\+]?\d+$/,
	Double : /^[-\+]?\d+(\.\d+)?$/,
	English : /^[A-Za-z]+$/,
	Chinese :  /^[\u0391-\uFFE5]+$/,
	UnSafe : /^(([A-Z]*|[a-z]*|\d*|[-_\~!@#\$%\^&\*\.\(\)\[\]\{\}<>\?\\\/\'\"]*)|.{0,5})$|\s/,
	IsSafe : function(str){return !this.UnSafe.test(str);},
	SafeString : "this.IsSafe(value)",
	Limit : "this.limit(value.length,getAttribute('min'),  getAttribute('max'))",
	LimitB : "this.limit(this.LenB(value), getAttribute('min'), getAttribute('max'))",
	Date : "this.IsDate(value, getAttribute('min'), getAttribute('format'))",
	Repeat : "value == document.getElementsByName(getAttribute('to'))[0].value",
	Range : "getAttribute('min') < value && value < getAttribute('max')",
	Compare : "this.compare(value,getAttribute('operator'),getAttribute('to'))",
	Custom : "this.Exec(value, getAttribute('regexp'))",
	Group : "this.MustChecked(getAttribute('name'), getAttribute('min'), getAttribute('max'))",
	ErrorItem : [document.forms[0]],
	ErrorMessage : ["以下原因导致提交失败：\t\t\t\t"],
	Validate : function(theForm, mode){
		var obj = theForm || event.srcElement;
		var count = obj.elements.length;
		this.ErrorMessage.length = 1;
		this.ErrorItem.length = 1;
		this.ErrorItem[0] = obj;
		for(var i=0;i<count;i++){
			with(obj.elements[i]){
				var _dataType = getAttribute("dataType");
				if(typeof(_dataType) == "object" || typeof(this[_dataType]) == "undefined")  continue;
				this.ClearState(obj.elements[i]);
				if(getAttribute("require") == "false" && value == "") continue;
				switch(_dataType){
					case "Date" :
					case "Repeat" :
					case "Range" :
					case "Compare" :
					case "Custom" :
					case "Group" : 
					case "Limit" :
					case "LimitB" :
					case "SafeString" :
						if(!eval(this[_dataType]))	{
							this.AddError(i, getAttribute("msg"));
						}
						break;
					default :
						if(!this[_dataType].test(value)){
							this.AddError(i, getAttribute("msg"));
						}
						break;
				}
			}
		}
		if(this.ErrorMessage.length > 1){
			mode = mode || 1;
			var errCount = this.ErrorItem.length;
			switch(mode){
			case 2 :
				for(var i=1;i<errCount;i++)
					this.ErrorItem[i].style.color = "red";
			case 1 :
				alert(this.ErrorMessage.join("\n"));
				this.ErrorItem[1].focus();
				break;
			case 3 :
				for(var i=1;i<errCount;i++){
				try{
					var span = document.createElement("SPAN");
					span.id = "__ErrorMessagePanel";
					span.style.color = "red";
					this.ErrorItem[i].parentNode.appendChild(span);
					span.innerHTML = this.ErrorMessage[i].replace(/\d+:/,"*");
					}
					catch(e){alert(e.description);}
				}
				this.ErrorItem[1].focus();
				break;
			default :
				alert(this.ErrorMessage.join("\n"));
				break;
			}
			return false;
		}
		return true;
	},
	limit : function(len,min, max){
		min = min || 0;
		max = max || Number.MAX_VALUE;
		return min <= len && len <= max;
	},
	LenB : function(str){
		return str.replace(/[^\x00-\xff]/g,"**").length;
	},
	ClearState : function(elem){
		with(elem){
			if(style.color == "red")
				style.color = "";
			var lastNode = parentNode.childNodes[parentNode.childNodes.length-1];
			if(lastNode.id == "__ErrorMessagePanel")
				parentNode.removeChild(lastNode);
		}
	},
	AddError : function(index, str){
		this.ErrorItem[this.ErrorItem.length] = this.ErrorItem[0].elements[index];
		this.ErrorMessage[this.ErrorMessage.length] = this.ErrorMessage.length + ":" + str;
	},
	Exec : function(op, reg){
		return new RegExp(reg,"g").test(op);
	},
	compare : function(op1,operator,op2){
		switch (operator) {
			case "NotEqual":
				return (op1 != op2);
			case "GreaterThan":
				return (op1 > op2);
			case "GreaterThanEqual":
				return (op1 >= op2);
			case "LessThan":
				return (op1 < op2);
			case "LessThanEqual":
				return (op1 <= op2);
			default:
				return (op1 == op2);            
		}
	},
	MustChecked : function(name, min, max){
		var groups = document.getElementsByName(name);
		var hasChecked = 0;
		min = min || 1;
		max = max || groups.length;
		for(var i=groups.length-1;i>=0;i--)
			if(groups[i].checked) hasChecked++;
		return min <= hasChecked && hasChecked <= max;
	},
	IsDate : function(op, formatString){
		formatString = formatString || "ymd";
		var m, year, month, day;
		switch(formatString){
			case "ymd" :
				m = op.match(new RegExp("^((\\d{4})|(\\d{2}))([-./])(\\d{1,2})\\4(\\d{1,2})$"));
				if(m == null ) return false;
				day = m[6];
				month = m[5]--;
				year =  (m[2].length == 4) ? m[2] : GetFullYear(parseInt(m[3], 10));
				break;
			case "dmy" :
				m = op.match(new RegExp("^(\\d{1,2})([-./])(\\d{1,2})\\2((\\d{4})|(\\d{2}))$"));
				if(m == null ) return false;
				day = m[1];
				month = m[3]--;
				year = (m[5].length == 4) ? m[5] : GetFullYear(parseInt(m[6], 10));
				break;
			default :
				break;
		}
		if(!parseInt(month)) return false;
		month = month==12 ?0:month;
		var date = new Date(year, month, day);
        return (typeof(date) == "object" && year == date.getFullYear() && month == date.getMonth() && day == date.getDate());
		function GetFullYear(y){return ((y<30 ? "20" : "19") + y)|0;}
	}
 }