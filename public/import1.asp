<!-- #include file="../public/conn.asp" -->
<!--#include FILE="upload.inc"--> 
<%
dim upload,file,formName,formPath,iCount,fileformat 
set upload=new upload_F 
function MakedownName() 
dim fname
fname = now()
fname = replace(fname,"-","") 
fname = replace(fname," ","") 
fname = replace(fname,":","") 
fname = replace(fname,"PM","") 
fname = replace(fname,"AM","") 
fname = replace(fname,"����","") 
fname = replace(fname,"����","") 
fname = int(fname) + int((10-1+1)*Rnd + 1)
MakedownName=fname
end function
formPath="../upload/"
iCount=0
for each formName in upload.file ''�г������ϴ��˵��ļ� 
set file=upload.file(formName) ''����һ���ļ����� 

fileformat=lcase(right(file.filename,4))

if fileformat<>".xls" then 
response.write"<script>alert('û��ѡ���ļ����ļ���ʽ���ԣ��������ϴ���');location='"&request.ServerVariables("HTTP_REFERER")&"'</script>" 
response.end
end if

if file.FileSize>0 then ''��� FileSize > 0 ˵�����ļ����� 
newname=MakedownName()&"."&mid(file.FileName,InStrRev(file.FileName, ".")+1) 
newname=newname

session("ccc")=newname
response.write file.filename
file.SaveAs Server.mappath(formPath&file.filename) ''�����ļ� 
iCount=iCount+1 
else
response.write "<font style=FONT-SIZE:9pt>δ�ҵ��ļ�   <A HREF=javascript:history.back(1)>�����ϴ�</A><font style=FONT-SIZE:9pt>" 
end if
next
set file=nothing 
set upload=nothing ''ɾ���˶���
response.end
%>
<STYLE>
table{
	border-collapse:collapse;
	border:solid 1px #000;
}
td{
	border:solid 1px #000;
	height:23px;
}
</STYLE>
<html>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<body>
	<form action="import_save.asp?table=<%=table%>" method="post" onSubmit="return validate_form()">
		<div style="font-size:15px;font-weight:bold;">
			��������ѡ��Excel����������������ݿ���е��ֶ���һһ��Ӧ��
		</div>
		<input type="hidden" name=table value=<%=table%>>
	<div style="padding:0 0 20px 0;float:left;width:100%;overflow-x:auto;">
		<table border=1 style="text-align:center;table-layout:fixed;font-size:10pt;max-height:200px" width=760 height=20>
			<tr>
				<td style=background:#B3B498;>���ݿ�����</td>
					<%
					set rs = server.createobject("adodb.recordset")
					sql = "select * from T_Import where tablename='"&table&"'"
					rs.open sql, conn, 1, 3
					while not rs.eof
						response.write "<td style=background:#7D7DFF>"
						response.write rs("FieldName")
						response.write "</td>"
						rs.movenext
					wend
					%>
			</tr>
			<tr>
				<td style=background:#B3B498>Excel����</td>
					<%
					dim strField
					strField=""
					set rs1 = server.createobject("adodb.recordset")
					sql = "select top 1 * from temp"
					rs1.open sql, conn, 1, 1
					for i = 0 to rs1.fields.count - 1
						strField = strField&rs1(i).Name&"-|-"
						rs1.movenext
					next
					rs1.close
					set rs1 = nothing
					set rs = server.createobject("adodb.recordset")
					sql = "select * from T_Import where tablename='"&table&"'"
					rs.open sql, conn, 1, 3
					k = 1
					while not rs.eof
						response.write "<td>"
						response.write "<select name=import"&k&">"
						response.write "<option value=''>"
						esponse.write "</option>"
						sField = strField
						while Instr(sField, "-|-")>0
							j = Instr(sField, "-|-")
							s = Left(sField, j - 1)
							if s = rs("FieldName") then
								strSelect = "Selected"
							else
								strSelect = ""
							end if 
							response.write "<option value="&s&" "&strSelect&">"
							response.write s
							sField = Right(sField, len(sField) - j - 2)
							response.write "</option>"
						wend		
						response.write "<select name='depot'>"
						response.write "</td>"
						k = k + 1
						rs.movenext
					wend
					response.write "<input type=hidden value="&k&" name=importcount>"
					%>
			</tr>
		</table>
	</div><br><br>
	<%
		if table = "goods" then
	%>
		<div style="font-size:15px;font-weight:bold;">
			���Ĳ���ѡ��ֿ�
		</div>
		�ֿ⣺<select name="depot">
				<%
					set t=server.createobject("adodb.recordset")
					sql="select * from dict_depot"
					t.open sql,conn,1,1
					do while not t.eof
					response.write"<option value="&t("name")&">"&t("name")&"</option>"
					t.movenext
					loop
					t.close
					set t=nothing
				%>
			</select><br><br><br>
			<div style="font-size:15px;font-weight:bold;">
				���岽��ѡ�������
			</div>
			<input type="radio" name="type" value=update checked>�������µ���
			<input type="radio" name="type" value=add checked>������������<br>
			<font color=#FF0000>���������¡����滻ԭ�������������ݡ�����������������ԭ��������������ݡ�</font><br><br><br>
		<%
			else
		%>
			<div style="font-size:15px;font-weight:bold;">
				���Ĳ���ѡ�������
			</div>
			<input type="radio" name="type" value=update checked>�������µ���
			<input type="radio" name="type" value=add checked>������������<br>
			<font color=#FF0000>���������¡����滻ԭ�������������ݡ�����������������ԭ��������������ݡ�</font><br><br><br>		
		<%
			end if
		%>	
		<input type="submit" value="��ʼ����">
	</form>
</body>	
</html>