<%
Function SetDate1(Date)
	stryear=Year(Date)
	strMon=month(Date)
	strDay=day(date)
  If Len(strMon)<2 Then
      strMon =   "0"   &   strMon
  End   If
  If   Len(strDay)<2   Then
      strDay   =   "0"   &   strDay
  End   If
  SetDate1=stryear&"-"&strMon&"-"&strDay
End Function

Function SetTable(tablename,sqlexcel,f_do)
	chaetime = timer()
   	qxlist = request.cookies("qxlist")
  	on error resume next
		set t = server.createobject("adodb.recordset")
		sql = "select * from tSoftInfo"
		t.open sql, conn, 1, 1
		dotnum=t("number")
		dotprice=t("price")
		dotmoney=t("money")
		page1 = t("page1")
		page2 = t("page2")
		t.close
		set t=nothing
		pagesize = page2
		if exceltable = "1"  then
			pagesize = 100000
		end if
	if err.number<>0 then
		pagesize = 20
  	end if
	set t = server.createobject("adodb.recordset")
	sql = "select * from tFieldShow where [show]=true "&sqlshow&" and tablename="&"'"&tablename&"'"&" order by showid"
	t.open sql, conn, 1, 1
	rstField = t.RecordCount
	response.write "<script>var currentActiveRow;function change(el){var x = el.rowIndex;if(currentActiveRow)currentActiveRow.style.backgroundColor='';currentActiveRow=el;el.style.backgroundColor = ++d[x]%2 ? '#D5D5D5' : '#D5D5D5';}</script>"
	if fdiv="" then
		fdiv = "inner-table-hpzl"
	end if
	response.write "<div id='"&fdiv&"'>"
	if exceltable = "1" then
		response.write "<table id='table1' border=1 style=width:1px;height:1px;font-size:9pt>"
	else
		response.write "<table id='table1'>"
	end if
	response.write "<tr>"
	if f_do="1" then
		response.write "<th align=center width="&EditWidth&">操作</th>"
	end if
	response.write "<th align=center width=40>序号</th>"
	while not t.eof
		img = ""
		if orderf=t("field") then
			if ordero = "desc" then
				img = "<img src=../images/desc.gif>"
			end if
			if ordero = "asc" then
				img = "<img src=../images/asc.gif>"
			end if
		end if
		response.write "<th align=center valign=center width="&t("width")&">"
		if exceltable = "1" then
			response.write t("name")
		else
			response.write "<a href=# onclick=order(this) value='"&t("field")&"' class=thlink>"&t("name")&"</a>"&img
		end if
		response.write "</th>"
		fields=fields & "," & t("field")
		t.movenext
	wend
	response.write "</tr>"
	t.close
	set t=nothing
	result=fields
	
	Set mypage=new xdownpage
	mypage.getconn = conn
	mypage.getsql = sqlexcel
	mypage.pagesize = pagesize
	set rs=mypage.getrs()
	strwarning = ""
	if rs.eof then
		strwarning = "此查询没有记录"
	end if
	for i = 1 to mypage.pagesize
		if not rs.eof then
			if request("page")="" then
				recno = i
			else
				recno = i + (request("page")-1)*mypage.pagesize
			end if
			if f_do="1" then
				UrlEdit = EditUrl & "?" & KeyField & "=" & Server.UrlEnCode(rs(KeyField))
				UrlHp = HpUrl & "?" & KeyField & "=" & Server.UrlEnCode(rs(KeyField))
				UrlDelete = "value='" & Server.UrlEnCode(rs(KeyField))&"'"
				UrlDelete = UrlDelete+" showvalue='" & rs(KeyField) &"'"
				if KeyFieldId<>"" then
					 	UrlDelete = UrlDelete+" delid='" & rs(KeyFieldId)&"'"
			  end if
			  
				if InStr(EditTh, "Edit")>0 then
					DblClick1 = "openwin('"&UrlEdit&"',"&fWidth&","&fHeight&")"
				else
					DblClick1 = ""
				end if
				response.write("<tr onClick=""change(this)"" onDblClick="&DblClick1&">")
				response.write "<th align=center>"
				if InStr(EditTh, "Edit")>0 then
					Q = "<a href=javascript: onclick=openwin('"&UrlEdit&"',"&fWidth&","&fHeight&") class=operation>修改</a>&nbsp;"
					response.write Q
				end if
				if InStr(EditTh, "Delete")>0 then
					response.write "<a href=# onclick=firm(this) "&UrlDelete&" class=operation>删除</a>&nbsp;"
				end if
				if InStr(EditTh, "Detail")>0 then
					UrlEdit = UrlEdit&"&detail=detail"
					Q = "<a href=javascript: onclick=openwin('"&UrlEdit&"',"&fWidth&","&fHeight&") class=operation>详情</a>&nbsp;"
					response.write Q
				end if
				if InStr(EditTh, "SizeHp")>0 then
					UrlEdit = UrlEdit&"&detail=detail"
					Q = "<a href=javascript: onclick=openwin('"&UrlHp&"',"&fWidth&","&fHeight&") class=operation>尺码横排</a>&nbsp;"
					response.write Q
				end if
				response.write "</th>"
			else
				if SelectUrl="cgBill" then
					%>
                    <tr onClick="change(this)" onDblClick="location.href='Goods_Insert.asp?GoodsStyle=<%=rs(KeyField)%>'">
                    <%
				end if
				if SelectUrl="xsBill" then
					response.write("<tr onClick=""change(this)"" onDblClick='xsgoodsselect()'>")
					
					'response.write("<tr onClick=""change(this)"" onDblClick='xsgoodsselect()'>")
				end if
				if SelectUrl="cust_select" then
					response.write("<tr onClick=""change(this)"" onDblClick='custselect()'>")
				end if
			end if
			if instr("xsBill|cust_select",SelectUrl)>0 then
				allvalue=""
				set allfield = server.createobject("adodb.recordset")
				q = "select * from tFieldShow where tablename='"&tablename&"'"
				allfield.open q, conn, 1, 1
				while not allfield.eof
					allvalue=allfield("field")&":"&rs(""&allfield("field")&"")&"|-;"&allvalue
					allfield.movenext
				wend
				allfield.close
				set allfield=nothing
			end if
			response.write "<th align=center><font color=#800080>"&recno&"<input type=hidden value="""&allvalue&"""></font></th>"

			set t = server.createobject("adodb.recordset")
			set allfield = server.createobject("adodb.recordset")
			sql = "select * from tFieldShow where Show=True "&sqlshow&" and tablename="&"'"&tablename&"'"&" order by showid"
			sumsql = sql
			t.open sql, conn, 1, 1
			while not t.eof
				f_field=t("field")
			  	f_zero = rs(""&f_field&"")
				f_ztitle=""
				textalign = " style=text-align:left; "
		  		if t("dotsize")="1" then
		  			if isnull(f_zero) then
			  			f_zero = FormatNumber(0, cint(dotnum), -1,false,false)
			  		else
			  			f_zero = FormatNumber(f_zero, cint(dotnum), -1,false,false)
			  		end if
			  		textalign = " style=text-align:center; "
		  		end if
		  		if t("dotsize")="2" then
		  			if isnull(f_zero) then
			  			f_zero = FormatNumber(0, cint(dotprice), -1,false,false)
			  		else
			  			f_zero = FormatNumber(f_zero, cint(dotprice), -1,false,false)
			  		end if
			  		textalign = " style=text-align:center; "
		  		end if
		  		if t("dotsize")="3" then
		  			if isnull(f_zero) then
			  			f_zero = FormatNumber(0, cint(dotmoney), -1,false,false)
			  		else
			  			f_zero = FormatNumber(f_zero, cint(dotmoney), -1,false,false)
			  		end if
			  		textalign = " style=text-align:center; "
			  	end if
				if t("dotsize")="4" then
					if isnull(f_zero) then
			  			f_zero = ""
			  		else
			  			f_zero = SetDate1(f_zero)
			  		end if			  		
				end if
				if t("dotsize")="5" then
					f_zero = f_zero&"<br>"&rs("Maker")
					textalign = " style=text-align:center; "
				end if
				if t("dotsize")="6" then
					f_zero = f_zero&"<br>"&rs("editer")
					textalign = " style=text-align:center; "
				end if
				if instr("tBill_ShowtBillDetail_Show",tablename)>0 then
					if instr("销售出货销售退货",rs("billtype"))>0 then
						fcolor = "style=color:#ff0000;"
					end if
					if instr("采购进货采购退货",rs("billtype"))>0 then
						fcolor = "style=color:#00F;"
					end if
				end if
				if f_ztitle="" then
					f_ztitle = f_zero
				end if
				response.write("<td "&textalign&" "&fcolor&" title="""&f_ztitle&""">"&s_goodscode&f_zero&"</td>")
				fcolor=""
				t.movenext
			wend
			response.write("</tr>")
			if f_blue = 1 then
				response.write("<tr style=background:#CBDCE5><td colspan="&rstField+1&">---</td></tr>")
			end if
    else
      exit for
    end if
 		rs.movenext
	next

	Fieldcolspan = rstField
	if f_do="1" then
		Fieldcolspan = rstField + 1
	end if

	strsum = "<td></td>"
	if f_do="1" then
		strsum = strsum & "<td></td>"
	end if
	set t = server.createobject("adodb.recordset")
	set t1 = server.createobject("adodb.recordset")
	if ifdo<>1 then
		sumsql = sql
		dosumsql = " from ("&sqlexcel&")"
		t.open sql, conn, 1, 1
		while not t.eof
			if t("sumfield")=1 then
				dosumsql1 = "select sum(" & t("field") & ") " & dosumsql
				t1.open dosumsql1, conn, 1, 1
				f_zero = t1.fields(0).value
				
				if t("dotsize")="1" then
		  			if isnull(f_zero) then
			  			f_zero = FormatNumber(0, cint(dotnum), -1,false,false)
			  		else
			  			f_zero = FormatNumber(f_zero, cint(dotnum), -1,false,false)
			  		end if
				end if
				
				if t("dotsize")="3" then
		  			if isnull(f_zero) then
			  			f_zero = FormatNumber(0, cint(dotmoney), -1,false,false)
			  		else
			  			f_zero = FormatNumber(f_zero, cint(dotmoney), -1,false,false)
			  		end if
				end if
				
				strsum = strsum&"<td>"&f_zero&"</td>"
				t1.close
			end if

			if t("sumfield")=0 then
				strsum = strsum&"<td></td>"
			end if
			t.movenext
		wend
		set t1=nothing
	end if
	if replace(strsum,"<td></td>","")<>"" then
		response.write "<tr style=color:#ff0000;>"&strsum&"</tr>"
	end if
	chaetime = timer()-chaetime
	if exceltable<>"1" then
		if strwarning<>"" then
			response.write("<tr><td align=left colspan="&Fieldcolspan+1&">"&strwarning&"</td></tr>")
		end if
		response.write("<tr><th align=left colspan="&Fieldcolspan+1&">")
		mypage.showpage()
		response.write "执行时间："&FormatNumber(chaetime, 4, -1,false,false)&"(秒)"
		if instr(qxlist,"f_column")>0 or 1=1 then
			response.write "&nbsp;&nbsp;<a href=javascript: class=ulink onclick=openwin('../public/set_table_n.asp?tablename="&tshow&"&dtitle="&dtitle&"',480,360) >设置列显示</a>"&ExportExcel
		end if
		response.write("</th></tr>")
	end if

	response.write("</table>")
	response.write("</div>")
	response.write "<script>"
	response.write "var d = new Array(document.getElementById('table1').rows.length);"
	response.write "for(i=0;i<d.length;i++)d[i]=0"
	response.write "</script>"
	t.close
	set t=nothing
	rs.close
	set rs=nothing
	conn.close
	set conn=nothing
End Function
%>