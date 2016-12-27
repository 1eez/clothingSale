<!-- #include file="../public/public.asp" -->
<%
set conn=Server.CreateObject("ADODB.connection")
reportConn()
	conn.BeginTrans
	on error resume next
		q = ""
		q = q & "0," & request("sjcx1")
		q = q & "0," & request("kcgl1")
		q = q & "0," & request("kcbb1")
		q = q & "0," & request("lybb1")
		q = q & "0," & request("cgbb1")
		q = q & "0," & request("screp1")
		q = q & "0," & request("zcrep1")
		q = q & "0," & request("xsbb1")
		q = q & "0," & request("jczl1")
		q = q & "0," & request("xtsz1") & "0"
		q1 = ""
		q1 = q1 & "0," & request("DepotWarn1")
		q1 = q1 & ",0," & request("TotalDepot_Branch21")
		q1 = q1 & ",0," & request("TotalDepot_Branch11")
		q1 = q1 & ",0," & request("DepotCount1")
		q1 = q1 & ",0," & request("R_DepotDetail1")
		q1 = q1 & ",0," & request("AllBill21")
		q1 = q1 & ",0," & request("rk_goods_find1")
		q1 = q1 & ",0," & request("AllBill11")
		q1 = q1 & ",0," & request("ck_goods_find1")
		q1 = q1 & ",0," & request("trac1")
		q1 = q1 & ",0," & request("DBGoods1")
		q1 = q1 & ",0," & request("check1")
		q1 = q1 & ",0," & request("pd_goods_find1")
		q1 = q1 & ",0," & request("AllGoods1")
		q1 = q1 & ",0," & request("depot_find1")
		q1 = q1 & ",0," & request("user_find1")
		q1 = q1 & ",0," & request("custom1") & "0"
		q2 = "'请选择',"&request("ftdepot1")
		q = replace(q, ",,", ",")
		q1 = replace(q1, ",,", ",")
		if request("type") = "" then
			set rs = server.createobject("adodb.recordset")
		    sql = "select * from t_user where loginname='" & request("loginname") & "'"
			rs.open sql, conn, 1, 3
				rs("qxlist") = q
				rs("tqxlist") = q1
				rs("cklist") = q2
		    rs.Update
		    rs.Close
		    set rs = nothing
		else
			set rs = server.createobject("adodb.recordset")
		    sql = "select * from t_guser where gusername='" & request("loginname") & "'"
			rs.open sql, conn, 1, 3
				rs("qxlist") = q
				rs("tqxlist") = q1
				rs("cklist") = q2
		    rs.Update
		    rs.Close
		    set rs = nothing
		end if
	if request("loginname")=session("loginnameb") then
		Response.cookies("qxlist") = q
		Response.cookies("tqxlist") = q1
		Response.cookies("cklist") = q2	
	end if
	if err.number=0 then
		manageLog "权限设置修改成功"
	  conn.CommitTrans
		conn.close
		set conn=nothing
		if request("type") = "" then
			Response.Write"<script>alert('恭喜您,保存成功！');history.go(-1)</SCRIPT>"
		else
			Response.Write"<script>alert('恭喜您,保存成功！');history.go(-1)</SCRIPT>"
		end if
	else
		conn.RollbackTrans '否则回滚
		Response.Write err.description
	end if
%>