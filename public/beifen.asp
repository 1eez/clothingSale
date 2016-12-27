<!-- #include file="../public/conn.asp" -->
<!-- #include file="public.asp" -->
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<%
q = "select * from tappinfo"
set t = server.createobject("adodb.recordset")

Call BackData()
Sub BackData()
  If Not IsObject(Conn) Then
      CheckData Conn,GetConnstr
  End If
  Dim DBPath
  Dim BackDBPath,Fso
  BackDBPath = "BackUp-"
  DBPath = Server.Mappath("../data/shopdata.asp")
  BackDBPath = BackDBPath & year(now) & "-" & month(now) & "-" & day(now) & "-" &  hour(now)  & "-" &  minute(now) &".rar"
  BackDBPath1 = BackDBPath
  BackDBPath = Server.MapPath("../backup/"&BackDBPath)
  On Error Resume Next
  Set Fso = Server.createobject("scripting.filesystemobject")
  If Err.Number <> 0 Then
      Err.Clear()
      response.write "<b>出错原因" & Err.Description & "，当前站点可能不支持FSO组件，备份操作跳过。</b>"
      Exit Sub
  End If
  If Fso.Fileexists(DBPath) then
      Fso.Copyfile DBPath,BackDBPath
      manageLog "数据库备份完成，备份路径：" & BackDBPath
      response.write "<br><a href='../backup/"&BackDBPath1&"' class=xdownpage>DBBackUp</a>，点击下载到本地。"
  Else
      response.write "找不到您所需要备份的文件。"
  End if
  If Err.Number <> 0 Then
      Err.Clear()
      response.write "<b>出错原因" & Err.Description & "操作,备份操作跳过。</b>"
      Exit Sub
  End If
  Set Fso = Nothing
End Sub
%>