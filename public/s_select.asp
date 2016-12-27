<script type="text/javascript">
  for(var i=1;i<=11;i++)
  {
    eval("var dt_" + i + " = document.getElementById('dt_" + i + "')");
  }
  var mbDIV = document.getElementById("mbDIV");
  var loginDIV = document.getElementById("loginDIV");
  var loginTopDIV = document.getElementById("loginTopDIV");
  
dt_3.onclick = function()
{
 loginDIV.style.top = "30px";
 loginDIV.style.left = "150px";
 show("loginDIV");
 mbDIV.style.width = document.body.scrollWidth;
 mbDIV.style.height = document.body.scrollHeight;
 show("mbDIV")

			for (var i = 0; i < document.all.tags('SELECT').length; i++)
			{
			var obj = document.all.tags('SELECT')[i];
			obj.style.visibility = "hidden";
			}
}
function closes(){
	hidden("loginDIV");
	hidden("mbDIV");
}

loginTopDIV.onmousedown = Down;
var tHeight,lWidth;
function Down(e)
{
var event = window.event || e;
tHeight = event.clientY  - parseInt(loginDIV.style.top.replace(/px/,""));
lWidth  = event.clientX - parseInt(loginDIV.style.left.replace(/px/,""));
document.onmousemove = Move;
document.onmouseup   = Up;
}
function Move(e) {
var event = window.event || e;
var top = event.clientY - tHeight;
var left = event.clientX - lWidth;
top = top < 0 ? 0 : top;
top = top > document.body.offsetHeight - 150 ? document.body.offsetHeight - 150 : top;
left = left < 0 ? 0 : left;
left = left > document.body.offsetWidth - 300 ? document.body.offsetWidth - 300 : left;
loginDIV.style.top  = top + "px";
loginDIV.style.left = left +"px";
}
function Up(){
    document.onmousemove = null;
}
function closeselect(){
	hidden("loginDIV");
	hidden("mbDIV");
	 for (var i = 0; i < document.all.tags('SELECT').length; i++)
	{
		var obj = document.all.tags('SELECT')[i];
		obj.style.visibility = "visible";
	}	
}
</script>