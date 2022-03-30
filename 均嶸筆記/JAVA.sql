--能記錄寫進去的完整SQL
System.out.println(dbo1.getAssembledSQL());
----WL1101103----SendGPA01.java----加了這段可以在網址執行時輸入特定日期
String tdate = request.getParameter("tdate") != null ? request.getParameter("tdate") : "";//傳入特定日期
		if(!tdate.equals(""))
			sysdate = tdate;
			
================================================================================
----RG1M010.java----信箱隱碼，但要隱第四個到@以前的字串
private String getHiddenMail(String mail){
 -- 新增一個容器  	
		String hiddenMail="";   		
		--split的用法為-->echino.lin@gmail.com切完後丟到陣列號長這樣
		--[echino.lin] [gmail.com]  以@為基準切分，且@會不見不會放入    	
		String[] token = mail.split("@");        			
		String firsttxt="";
    	for(int i=0;i<token[0].length();i++){
    		if(i==0 || i==1 ||i==2){
--前123位不隱碼並放進容器，寫成(i)會放進i到最後一位，所以要寫成(i,i+1)一個一個丟
    			firsttxt+=token[0].substring(i,i+1);
    		}
    		else{
    			firsttxt+="*";
    		}
    	}
    	String secondttxt="@"+token[1];   	
    	hiddenMail+=firsttxt+secondttxt;
		
--如果隱碼原則是要變成隱最後面三位
--全長總數減一就是倒數第一位，依此類推
for(int i=0;i<token[0].length();i++){
    		if(i==(token[0].length-1) || i==(token[0].length-2) ||i==(token[0].length-3)){

================================================================================
----SendLineMessage.java----CALL  API的程式
----取得API回傳的訊息
			String str = postmethod.getResponseBodyAsString();
			str=str.replace("[", "");
			str=str.replace("]", "");
----JSONObject在解析單筆jason資料時頭尾有 [   ]  會解析失敗，所以上面兩行在去除框框，回傳的值會自動加上框框
----如果是回傳多筆就使用JSONArray，
----JSONArray裡面是包著一筆筆JSONObject，很像Map包List的概念
			JSONObject jsonObject = JSONObject.fromObject(str);