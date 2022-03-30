<%
   /*
   *
   * 開發人員	： BEVIS
   * 建立日期	： 2022/02/09
   * 異動註記	： 
   *
   * 程式說明	：傷件險作業系統-傷件險收件通報紀錄查詢
   *
   */
%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false"%>
<%@ taglib uri="/WEB-INF/tlds/asi/asi.tld" prefix="asi"%>
<%@ page import="com.asi.common.util.JspUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.asi.common.struts.AsiActionForm" %>
<%@ page import="com.asi.common.util.JspUtil"%>
<%@ page import="com.asi.common.GlobalKey"%>
<%@ page import="com.asi.kyc.common.KycGlobal"%>
<%@ page import="com.asi.common.security.UserInfo"%>
<%@ page import="com.asi.common.util.MathUtil"%>
<%@ page import="com.asi.common.util.DateUtil"%>
<%@ page import="java.util.List" %>
<%@page import="java.util.Map"%>


<%/** 此區塊一定要寫在asi:form的外面 **/%>
<%
	//設定此畫面主要的action 
	String mainAction = "/WB11I0101";
	
	//取得action的form name
	String formName = JspUtil.getFormName(pageContext, mainAction);
	
	//目前畫面名稱
	String source = "WB11I0101p1";
	
	List list = null;
	if(request.getAttribute("selectData")!=null)
	{
		list = (List)request.getAttribute("selectData");
	}
%>

<%//程式標頭區塊%>
<script language="JavaScript" type="text/javascript">

</script>
<%/** 主要編輯區塊 begin **/%>
<asi:form action="<%= mainAction %>">
	
	
	<h4>傷健險收件通報紀錄查詢</h4>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">	
		<tr>
			<td>
				<table border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF">
					<table width="40%" align="center" >
				        <tr class="NormalText">
							<td bgcolor="#D7E3F0" align="right" width="20%">被保險人ID：</td>
							<td bgcolor="#F1F5FA" align="left" width="50%">
								<input name="reqId" type="text" id="reqId" value="" size="10" >
								<input type="radio" name="reqNation1" value="A" checked="checked" "/>本國籍
					 			<input type="radio" name="reqNation1" value="B" "/>外國籍(居留證)
							</td>		
						</tr>
					</table>
					<table align="center" >	
						<tr>
							<td>
								<span style="color:red;text-align:center;font-size:16px;">
								僅限查詢三個月內收件通報資料
								</span>
							</td>
						</tr>
					</table>

					<tr>
			    		<td align="center" colspan="2">
			    		<p>      			
			      			<input type="button" name="btn6" value="通報查詢" onclick="process('1');" style='cursor:hand;cursor:pointer'>
			      			<input type="reset"  name="btn_Reset" value="重設" onclick="resetform();" style='cursor:hand;cursor:pointer'>
			    		</p>
			    		</td>
			    	</tr>
				</table>
			</td>
	  	</tr>
	</table>
	
</asi:form>
<%
if(list!=null)
{
%>
	<table height="80%" width="80%" border="0" align="center" cellpadding="0" cellspacing="1" class="kycTable">
	<%
	int size = list!=null?list.size():0;
	if(size != 0)
	{	
	%>	
		<tr >
			<th><div align="center">通報險種</div></th>
			<th><div align="center">通報號碼</div></th>
			<th><div align="center">被保險人</div></th>
			<th><div align="center">要保日期</div></th>
			<th><div align="center">通報日期</div></th>
			<th><div align="center">保經代分類</div></th>
			<th><div align="center">核保收件</div></th>
		</tr>
    <%
	}
	else
	{
		%>
		此條件範圍，查無資料!!
		<% 
	}
	
	for (int i = 0; i < size; i++) 
	{
		Map map = (Map) list.get(i);
	%>
		 
	        <tr >								
				<td ><%=map.get("PF19")== null ? "" : map.get("PF19").toString()%></td>
				<td><%=map.get("PF01")== null ? "" : map.get("PF01").toString()%></td>
				<td><%=map.get("PF13")== null ? "" : map.get("PF13").toString()%></td>
				<td><%=map.get("PF06")== null ? "" : map.get("PF06").toString()%></td>
				<td><%=map.get("PF70")== null ? "" : map.get("PF70").toString()%></td>
				<td><%=map.get("PF24")== null ? "" : map.get("PF24").toString()%></td>				
				<td align="center"><%=map.get("PF84")== null ? "" : map.get("PF84").toString() %></td>				
			</tr>		        		    
	<%
	}
	%>
	</table>
	<%
}

%>

<%/** 主要編輯區塊 end **/%>

<script language="JavaScript" type="text/javascript">

<%//處理按鈕動作%>
 	
    function process(arg1) 
    {
    	with(document.<%=formName%>) 
    	{
    		setformname('<%=formName%>');
    		source.value = "<%=source%>";
			actionCode.value = arg1;
			alias.value = arg1;
    		if ( checkform(arg1) == false)  return false;
			submit();
    	}
    }
    function checkform(arg1)
    {    	
    	with(document.<%=formName%>) 
    	{
    		if (arg1 == 1) {
				if (!isEmpty('reqId', '請輸入被保險人ID')) {
					reqId.focus();
					return false;					
				}
				if(reqNation1.value =='A'){
					if (!isAllIdNumber('reqId','<asi:message key="errors.UFC0018"/>'))
			        {	reqId.focus();               
			            return false;
			        }
				}
				if(reqNation1.value =='B'){				
					if(!isAlphaNumberReal('reqId', '居留證號碼格式錯誤')){
						reqId.focus();
						return false;
					}
					if(!isForeignIdNumber('reqId', '居留證號碼格式錯誤')){
						reqId.focus();
						return false;
					}            
				}         	
			}
		}
    }
   
</script>