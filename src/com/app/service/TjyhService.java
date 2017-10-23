package com.app.service;

import java.util.List;
import java.util.Map;

public interface TjyhService {

	Long countUserTJ(String systemId);

	List<Map> ListUserTJ(String systemId, Integer thispage, Integer pagesize);

	Long countLoginCountTJ(String systemId);

	List<Map> ListLoginCountTJ(String systemId, Integer thispage, Integer pagesize);

	Long countDeleteUserTJ(String systemId);

	List<Map> ListDeleteUserTJ(String systemId, Integer thispage, Integer pagesize);

}
