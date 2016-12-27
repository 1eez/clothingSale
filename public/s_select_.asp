<script type="text/javascript">
  for(var i=1;i<=11;i++)
  {
    eval("var dt__" + i + " = document.getElementById('dt__" + i + "')");
  }
  var mbDIV_ = document.getElementById("mbDIV_");
  var loginDIV_ = document.getElementById("loginDIV_");
  var loginTopDIV_ = document.getElementById("loginTopDIV_");
  
dt__3.onclick = function()
{
 loginDIV_.style.top = "30px";
 loginDIV_.style.left = "150px";
 show("loginDIV_");
 mbDIV_.style.width = document.body.scrollWidth;
 mbDIV_.style.height = document.body.scrollHeight;
 show("mbDIV_")

			for (var i = 0; i < document.all.tags('SELECT').length; i++)
			{
			var obj = document.all.tags('SELECT')[i];
			obj.style.visibility = "hidden";
			}
}
function closes(){
	hidden("loginDIV_");
	hidden("mbDIV_");
}

loginTopDIV_.onmousedown = Down;
var tHeight,lWidth;
function Down(e)
{
var event = window.event || e;
tHeight = event.clientY  - parseInt(loginDIV_.style.top.replace(/px/,""));
lWidth  = event.clientX - parseInt(loginDIV_.style.left.replace(/px/,""));
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
loginDIV_.style.top  = top + "px";
loginDIV_.style.left = left +"px";
}
function Up(){
    document.onmousemove = null;
}
function closeselect_(){
	hidden("loginDIV_");
	hidden("mbDIV_");
	 for (var i = 0; i < document.all.tags('SELECT').length; i++)
	{
		var obj = document.all.tags('SELECT')[i];
		obj.style.visibility = "visible";
	}	
}
</script>