--1.這個需求是要再保單管理系統的續保單報表列印裡面，新增五個通路別，讓EXCEL能匯出保單報表列印裡面，新增五個通路別，讓EXCEL能匯出
--原本想要用舊有的SQL找出特例通路別(S001、Z001、Z002)的業務來源，但應該是程式上自己定義的代號，所以IC02PF沒有
--而且我從程式上的複製SQL時理解錯誤了，19行 OR不僅僅只是 
--C210='M8351' OR C210='M8352' OR C210='Z0874' OR C210='Z0875'
--而是OR全部的WHERE條件式，例如:如果有C210='M8352'，那前面的C213='32441' AND C206>='1101201'AND C206<='1101231'AND C233='S001'AND C210='M8351' 都可以不用一定要有

SELECT C240A,C240,C201,C230,C107,C202,C203,C204,C206,C208,
C213,C207,C210,C233,T2209,T2109,T2110,T2160,T6103,T5803,T6102,T5802
,T7745,T7746,T7747,T7748,T7749,T7750
FROM IC02PF
LEFT JOIN PT22PF ON C202=T2201 AND T2203=1
LEFT JOIN IC01PF ON C201=C101
LEFT JOIN PT21PF ON T2101=C202 AND T2102=C203
LEFT JOIN PT61PF ON T6102=C240 AND T6104=C240A
LEFT JOIN PT58PF ON T5801=SUBSTR(C210,1,4) AND T5802=C240A
LEFT JOIN PT77PF ON C202=T7701 AND T7703=C203 AND T7702=''
WHERE C213='32441' 
AND C206>='1101201'
AND C206<='1101231'
AND C233='S001'
AND C210='M8351' OR C210='M8352' OR C210='Z0874' OR C210='Z0875'

--在想要大範圍搜尋時不應該一直想要留著
WHERE C213='32441' 
AND C206>='1101201'
AND C206<='1101231'
--如果真的搜尋不到就應該一直刪條件
--像如果知道S001只是代號那應該就要連AND C233='S001'一起刪掉，剩下這樣
WHERE C210='M8351' OR C210='M8352' OR C210='Z0874' OR C210='Z0875'

--所以現在要做的事就是把SQL搜尋出來的業務來源拿去問USER那些是他們需要的
select distinct C210 from IC02PF WHERE  C233='A252'
select distinct C210 from IC02PF WHERE  C233='A230'
select distinct C210 from IC02PF WHERE  C233='A219'
select distinct C210 from IC02PF WHERE  C233='A153'

--如果USER沒有要求那就直接添加通路別進去就好，因為這次要增加的五個通路別IC02PF都有資料，
--直接照著WB4M1501.JAVA的344行~346行去寫就好。
---------------------------------------------------------------------------------------------------
--WB4M1501.JAVA在匯出EXCEL的部分
createCell(row0, (short) 0, "第一產物保險股份有限公司", style01);
createCell(row0, (short) 4, "通路代碼/業務來源：", style03);
--ROW0 代表第一行，0是第一格
--ROW0 代表第一行，4就是第五格
--第二個營業處需求的部分一開始不知道要去哪裡找TABLE，就先從他是在哪裡出現，是在EXCEL的左上角出現，
--表示匯出EXCEL的程式碼有寫，不然也抓不到，最後找到營業處是PT77PF
--最後將前端欄位寫好，後端到368行附近的業務來源那邊寫一下判斷就完成了。
---------------------------------------------------------------------------------------------------
--原本營業處是抓PT77PF的T7747、T7748，但後來測試發現同樣的兩種東西有可能會寫到PT58PF的T5802、T5803
--下面的寫法是前端欄位的判斷
--AND (T5802 LIKE '17530%' OR T7747 LIKE '17530%')
--這個效果就是當17530(營業處)不在T5802時再繼續搜尋T7747
			if (!f.getText3().equals("")) {
				sql.append("AND (T5802 LIKE '")
				   .append(f.getText3())
				   .append("%' ")
				   .append("OR T7747 LIKE '")
				   .append(f.getText3())
				   .append("%') ")
				   ;				
			}
			
--下面是針對產生EXCEL的部分
--原本是用1.2.寫法後來發現如果資料庫是NULL就會報錯
--換成3.4.後問號的true或false有可能也會丟回null 要改寫會太長
--所以改為if  else判斷式
				1.String codename1 = (String) (currentRowData.get("t5802").equals("")?currentRowData.get("t7747"):currentRowData.get("t5802")); //營業處代碼
				2.String codename2 = (String) (currentRowData.get("t5803").equals("")?currentRowData.get("t7748"):currentRowData.get("t5803")); //營業處說明
				3.String codename1 = (String) (currentRowData.get("t5802")==null || "".equals("t5802")?currentRowData.get("t7747"):currentRowData.get("t5802")); //營業處代碼
				4.String codename2 = (String) (currentRowData.get("t5803")==null || "".equals("t5803")?currentRowData.get("t7748"):currentRowData.get("t5803")); //營業處代碼
					
					String codename1 = "";
					String codename2 = "";

--如果T5802為NULL或空值就進去判斷T7747，否則就丟值進去
--如果T7747不為NULL就丟值進去，否則維持""空值					
					5.if(currentRowData.get("t5802")==null || "".equals("t5802")) {						
						if(currentRowData.get("t7747")!=null) {
							codename1 = currentRowData.get("t7747").toString();
						}
					}else {
						codename1 = currentRowData.get("t5802").toString();
					}										
					6.if(currentRowData.get("t5803")==null || "".equals("t5803")) {						
						if(currentRowData.get("t7748")!=null) {
							codename2 = currentRowData.get("t7748").toString();
						}
					}else {
						codename2 = currentRowData.get("t5803").toString();
					}

--後來還有一個匯出pdf的功能沒做，會沒發現是因為只去看String mainAction = "/WB4M1501";  就以為後端的所有功能都寫在WB4M1501.java
--其實要看WB4M150p1.jsp 裡面的
action = '<asi:ReportAction url="/WB4R1501"/>';
--是寫在kycReport裡。
--拉完分支把WB4R1501.java、WB4R150f.java照著匯出EXCEL的方式修改
--修改完發現大部分資料PDF都可以正常匯出，沒有打業務來源時才會發生匯出失敗的問題
--DEBUG發現是某些保單的陣列是NULL導致合併PDF發生錯誤，
--PDF檔在產製時沒辦法像EXCEL那樣如果NULL就在分頁留空白換下一個分頁，當發生NULL這張PDF就無法產製與合併，導致接下去的程式無法繼續，
--所以之後又多增加了try catch讓console 能顯示錯誤
try
			{
				pdf = mergePdf(report);	
			}
			catch (Exception ioe)
			{
				ioe.printStackTrace();
			}
--以及增加null的判斷，讓發生null時能跳過，	
				if(report[i]!=null) {
				copyPdf(pdfcopy, report[i]);
				}