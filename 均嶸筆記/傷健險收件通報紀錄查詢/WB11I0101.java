/**
 * 
 */
package com.asi.kyc.wb11.actions;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.struts.action.ActionMapping;
import com.asi.common.exception.AsiException;
import com.asi.common.struts.AsiActionForm;
import com.asi.common.util.DateUtil;
import com.asi.common.util.FormatUtil;
import com.kyc.sec.actions.WebAction;
import com.asi.kyc.wb11.forms.WB11I010f;

/**
 * @author carter
 * @Create Date：2011/5/27
 */
public class WB11I0101 extends WebAction
{

	@Override
	public void doProcess(ActionMapping mapping, AsiActionForm form, HttpServletRequest request, HttpServletResponse response) throws AsiException
	{
		WB11I010f form1 = (WB11I010f) form;
		List selectData=null;
		
		if(form1.getActionCode() == 1){
			
			try
			{
				tx_controller.begin(1);
				String reqId2 = form1.getReqId();
				selectData = selectData(reqId2);
			}
			catch (Throwable e)
			{
				e.printStackTrace();
			}			
			
			request.setAttribute("selectData", selectData);
			form1.setNextPage(1);
		}
	}
	
	public List selectData(String reqId2) throws AsiException,SQLException
	{		
		String sysdate = DateUtil.getSysDate(DateUtil.ChType, DateUtil.Format_YYYYMMDD, false);
		sysdate = DateUtil.getOffsetDate(DateUtil.ChType, DateUtil.Format_YYYYMMDD, sysdate, -90, false);				
		QueryRunner runner = new QueryRunner();
		StringBuffer sql = new StringBuffer();
		List<?> result1 =null;
		
		try
		{	
		sql.append("SELECT PF19,PF01,PF02,PF13,PF14,PF06,PF70,PF24,PF84 ");
		sql.append("FROM EPB501PF ");
		sql.append("WHERE PF06>=").append(sysdate).append(" ");
		sql.append("AND PF14= ? " );
		Object[] params = {reqId2};
		System.out.println(sql);
		
		result1 = (List<?>) runner.query(tx_controller.getConnection(1), sql.toString(),params, new MapListHandler());
		
			for (int j = 0; j<result1.size(); j++)
			{
				Map row = (Map) result1.get(j);
				String notifyKind = String.valueOf(row.get("PF19"));//通報險種
				String notifyno01 = String.valueOf(row.get("PF01"));//通報號碼			
				String notifyno02 = String.valueOf(row.get("PF02"));			
				String insName = String.valueOf(row.get("PF13"));//被保險人姓名			
				String insNo = String.valueOf(row.get("PF14"));
				String insNo2 = insNo.replaceAll("^(.*)(\\d{4})$", "$1****");//被保險人ID
				String reqdate = FormatUtil.getDateFormat(DateUtil.Format_YYYYMMDD,String.valueOf(row.get("PF06")));//要保日期		
				String notifydate = FormatUtil.getDateFormat(DateUtil.Format_YYYYMMDD,String.valueOf(row.get("PF70")));//通報日期		
				String insAgentkind = String.valueOf(row.get("PF24")); //保經代分類								
								
				if(notifyKind.equals("1")){
					row.put("PF19","個人傷害險");
				}else if(notifyKind.equals("2")) {
					row.put("PF19","團體傷害險");	
				}else if(notifyKind.equals("3")) {
					row.put("PF19","旅平險");	
				}else if(notifyKind.equals("4")) {
					row.put("PF19","健康險");	
				}else if(notifyKind.equals("5")) {
					row.put("PF19","微型保險");	
				}else if(notifyKind.equals("6")) {
					row.put("PF19","海域活動險");	
				}else if(notifyKind.equals("7")) {
					row.put("PF19","疫苗險");	
				}
				
				row.put("PF01",notifyno01+"-"+notifyno02);
				row.put("PF13",insName+"/"+insNo2);
				row.put("PF06",reqdate);
				row.put("PF70",notifydate);
				
				if(insAgentkind.equals("97")) {
				row.put("PF24",insAgentkind+" 待通報");
				}else if(insAgentkind.equals("98")) {
					row.put("PF24",insAgentkind+" 補醫療");	
				}else if(insAgentkind.equals("99")) {
					row.put("PF24",insAgentkind+" 自行通報件");	
				}
			}
		}	
		catch (Exception e)
		{
			e.printStackTrace();
		}
			return result1;
		}		
	}				

