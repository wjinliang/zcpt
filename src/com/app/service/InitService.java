package com.app.service;

public interface InitService {
	public String InitOrg(String opType,String jsonStr);//初始化组织返回zcpt组织唯一标示
	public String InitUser(String opType,String jsonStr); //初始化用户返回zcpt用户唯一标示
}
