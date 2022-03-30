/*
 *
 * Copyrights (c) 2005 The First Insurance Co, Ltd. All Rights Reserved. 
 * 
 * This software is the confidential and proprietary information of  
 * The First Insurance Co, Ltd. ("Confidential Information").  
 * You shall not disclose such Confidential Information and shall use 
 * it only in accordance with the terms of the license agreement you 
 * entered into with The First Insurance Co, Ltd. 
 * 
 */
package com.asi.kyc.wb11.forms;

import org.apache.struts.upload.FormFile;

import com.asi.common.struts.AsiActionForm;

/**
 * 傷健險即時收件通報輸入作業
 * 
 * @author bevis
 * @Create Date：2022/2/11
 */
public class WB11I010f extends AsiActionForm
{
	
	/** 被保險人-ID(或統編) */
	private String reqId;

	public String getReqId() {
		return reqId;
	}

	public void setReqId(String reqId) {
		this.reqId = reqId;
	}
	
	
//	/** 系統日期 */
//	private String sysdate;	
//	/** 要保日期 */
//	private String reqdate;
//	/** 投保險種,1-個人傷害險,2-團體傷害險,3-旅平險,4-健康險,5-微型保險,6-海域活動保險,7-疫苗保險 */
//	private String notifyKind;
//	/** 通報號碼 */
//	private String notifyno;
//	/** 通報日期 */
//	private String notifydate;
//	/** 被保險人-姓名 */
//	private String insName ;
//	/** 被保險人-身份別,A-本國籍,C-外國籍 */
//	private String insNation;	
//	/** 保經代分類 */
//	private String insAgentkind;
//	/** 核保收件 */
//	private String mark;
//	/** 被保險人-ID(或統編) */
//	private String insId;
	
	
//	/**
//	 * @return 系統日期
//	 */
//	public String getSysdate() {
//		return sysdate;
//	}
//	
//	/**
//	 * @param sysdate 系統日期
//	 */
//	public void setSysdate(String sysdate) {
//		this.sysdate = sysdate;
//	}
//	
//	/**
//	 * @return 要保日期
//	 */
//	public String getReqdate() {
//		return reqdate;
//	}
//	
//	/**
//	 * @param reqdate 要保日期
//	 */
//	public void setReqdate(String reqdate) {
//		this.reqdate = reqdate;
//	}
//
//	/**
//	 * @return 投保險種,1-個人傷害險,2-團體傷害險,3-旅平險,4-健康險,5-微型保險,6-海域活動保險,7-疫苗保險
//	 */
//	public String getNotifyKind() {
//		return notifyKind;
//	}
//
//	/**
//	 * @param notifyKind 投保險種,1-個人傷害險,2-團體傷害險,3-旅平險,4-健康險,5-微型保險,6-海域活動保險,7-疫苗保險
//	 */
//	public void setNotifyKind(String notifyKind) {
//		this.notifyKind = notifyKind;
//	}
//
//	/**
//	 * @return 通報號碼
//	 */
//	public String getNotifyno() {
//		return notifyno;
//	}
//
//	/**
//	 * @param notifyno 通報號碼
//	 */
//	public void setNotifyno(String notifyno) {
//		this.notifyno = notifyno;
//	}
//
//	/**
//	 * @return 通報日期
//	 */
//	public String getNotifydate() {
//		return notifydate;
//	}
//
//	/**
//	 * @param notifydate 通報日期
//	 */
//	public void setNotifydate(String notifydate) {
//		this.notifydate = notifydate;
//	}
//
//	/**
//	 * @return 被保險人-姓名
//	 */
//	public String getInsName() {
//		return insName;
//	}
//
//	/**
//	 * @param insName 被保險人-姓名
//	 */
//	public void setInsName(String insName) {
//		this.insName = insName;
//	}
//
//	/**
//	 * @return 被保險人-ID(或統編)
//	 */
//	public String getInsId() {
//		return insId;
//	}
//
//	/**
//	 * @param insId 被保險人-ID(或統編)
//	 */
//	public void setInsId(String insId) {
//		this.insId = insId;
//	}
//
//	/**
//	 * @return 被保險人-身份別,A-本國籍,C-外國籍
//	 */
//	public String getInsNation() {
//		return insNation;
//	}
//
//	/**
//	 * @param insNation 被保險人-身份別,A-本國籍,C-外國籍
//	 */
//	public void setInsNation(String insNation) {
//		this.insNation = insNation;
//	}
//
//	/**
//	 * @return 保經代分類
//	 */
//	public String getInsAgentkind() {
//		return insAgentkind;
//	}
//
//	/**
//	 * @param insAgentkind 保經代分類
//	 */
//	public void setInsAgentkind(String insAgentkind) {
//		this.insAgentkind = insAgentkind;
//	}
//
//	/**
//	 * @return 保經代分類
//	 */
//	public String getMark() {
//		return mark;
//	}
//
//	/**
//	 * @param insAgentkind 保經代分類
//	 */
//	public void setMark(String mark) {
//		this.mark = mark;
//	}


	
}
