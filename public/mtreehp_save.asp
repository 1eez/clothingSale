<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
	'��ӿ�ʼ
	atype = request("type")
	f_table = Request("table")
	if atype = "" then
		on error resume next
		conn.BeginTrans
			dim c_id, caption, c_type, c_depth, c_childnum, c_parentid, c_select
			c_id=Request.Form("change_id")
			name=trim(Request.Form("name"))
			c_type=Request.Form("type1")
			set rs = server.createobject("adodb.recordset")
		    sql = "select * from dict_cate where c_ID="&c_id&" and table='"&f_table&"'"
			rs.open sql, conn, 1, 1
			c_select=rs("c_select")
			rs.close
			set rs=nothing

			if (c_select="001") and (c_type="1") then
			  response.write "<script> alert('������ӻ�Ʒ����ͬ���ڵ㣬��������ѡ��');history.go(-1);</script>"
			else

			set rs = server.createobject("adodb.recordset")
		    sql = "select * from dict_cate where c_ID="&c_id&" and table='"&f_table&"'"
			rs.open sql, conn, 1, 1
			c_depth = rs("c_depth")
			c_childnum = rs("c_childnum")
			c_parentid = rs("c_parentid")
			c_select = rs("c_select")
			if c_type="2" then
				c_depth = c_depth + 1
				c_childnum = c_childnum + 1
				c_parentid = c_id
			end if
		  rs.Close
		  set rs = nothing

		  if c_type="2" then
				set rs = server.createobject("adodb.recordset")
			    sql = "select max(c_select) as c_select1 from dict_cate where c_ParentID="&c_id&" and table='"&f_table&"'"
				rs.open sql, conn, 1, 1
				if rs("c_select1")<>"" then
					k = right(rs("c_select1"), 3) + 1
					if len(k)=1 then
						c_select = c_select&"00"&k
					end if
					if len(k)=2 then
						c_select = c_select&"0"&k
					end if
					if len(k)=3 then
						c_select = c_select&k
					end if
				else
					c_select = c_select&"001"
				end if
		  else
				set rs = server.createobject("adodb.recordset")
			    sql = "select max(c_select) as c_select1 from dict_cate where c_ParentID="&c_parentid&" and table='"&f_table&"'"
				rs.open sql, conn, 1, 1
					c_select = left(c_select, len(c_select) - 3)
					k = right(rs("c_select1"), 3) + 1
					if len(k)=1 then
						c_select = c_select&"00"&k
					end if
					if len(k)=2 then
						c_select = c_select&"0"&k
					end if
					if len(k)=3 then
						c_select = c_select&k
					end if
			end if

			set rs = server.createobject("adodb.recordset")
		    sql = "select * from dict_cate where c_ID is null "
			rs.open sql,conn,1,3
		    rs.AddNew
		 '--------------------------------------------------------
				rs("c_ParentID") = c_parentid
				rs("c_Name") = name
				rs("c_Depth") = c_depth
				rs("c_ChildNum") = "0"
				rs("c_Select") = c_select
				rs("table") = f_table
		    rs.Update
		    rs.Close
		    set rs = nothing

			set rs=server.createobject("adodb.recordset")
			sql="select * from dict_cate where c_ID="&c_id&""
			rs.open sql,conn,1,3
			'--------------------------------------------------------

			rs("c_ChildNum")=c_childnum

			'--------------------------------------------------------
		  rs.Update
		  rs.Close
		  end if
		if err.number=0 then
			manageLog "���������" & name
			conn.CommitTrans
			conn.close
			set conn=nothing
			if f_table="goods" then
				f_table="goodstype"
			end if
			Response.Write"<script>location.href='mtreehp.asp?table="&f_table&"'</SCRIPT>"
		else
			conn.RollbackTrans '����ع�
			Response.Write"<script>alert('����ʧ�ܣ�����ϸ��д�����Ϣ��');location.href='mtreehp.asp?table="&f_table&"'</SCRIPT>"
		end if
	end if
	if atype = "de_lete" then
		conn.BeginTrans
		on error resume next
			cid = request("cid")
			set t = server.createobject("adodb.recordset")
		    sql = "select * from dict_cate where c_ID="&cid&" and table='"&f_table&"'"
			t.open sql, conn, 1, 1
			if t("c_Select") <> "001" then
				sql = "delete from dict_cate where c_Select like '"&t("c_Select")&"%' and table='"&f_table&"'"
				conn.execute sql
				sql = "update dict_cate set c_childnum=c_childnum-1 where c_id=" & t("c_parentId")
				conn.execute sql
			else
				Response.Write"<script>alert('���ڵ㲻��ɾ����');location.href='mtreehp.asp?table="&f_table&"'</script>"
			end if
		if err.number=0 then
			manageLog "ɾ�������" & t("c_name")
			Response.Write"<script>alert('��ϲ��,ɾ���ɹ���');location.href='mtreehp.asp?table="&f_table&"'</script>"
			conn.CommitTrans
		else
			Response.Write"<script>alert('ɾ��ʧ�ܣ�����ϸ��д�����Ϣ��');location.href='mtreehp.asp?table="&f_table&"'</script>"
			conn.RollbackTrans '����ع�
		end if
		t.close
		set t = nothing
	end if
	if atype = "save" then
		conn.BeginTrans
		on error resume next
			cid = request("cid")
			cname = trim(request("cname"))
			if cname="" then
				response.Write"<script>alert('û������༭������ƣ�');history.go(-1)</script>"
				response.end
			end if
			sql = "update dict_cate set c_Name='"&cname&"' where c_ID="&cid
			conn.execute sql
		if err.number=0 then
			manageLog "�޸������" & cname
			conn.CommitTrans
			conn.close
			set conn=nothing
			Response.Write"<script>alert('��ϲ��,�޸ĳɹ���');location.href='mtreehp.asp?table="&f_table&"'</script>"
		else
			conn.RollbackTrans '����ع�
			Response.Write"<script>alert('�޸�ʧ�ܣ�����ϸ��д�����Ϣ��');location.href='mtreehp.asp?table="&f_table&"'</script>"
		end if
	end if
%>