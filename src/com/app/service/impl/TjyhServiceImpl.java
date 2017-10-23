package com.app.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.service.TjyhService;
import com.dm.ais.dao.CommDAO;

@Service
public class TjyhServiceImpl implements TjyhService {
	@Autowired
	private CommDAO commDao;
	private static final String TRUE="1";
	private static final String FALSE="0";
	
	@Override
	public Long countUserTJ(String systemId) {
		//String systemId="动物标识及动物产品追溯系统";
		String isDelete=FALSE;
		String type=" count(t.`NAME`) ";
		return this.count(systemId,isDelete,type);
	}

	@Override
	public List<Map> ListUserTJ(String systemId, Integer thispage,
			Integer pagesize) {
		
		String isDelete=FALSE;
		String type=" count(t.`NAME`) ";
		return this.list(systemId,isDelete,type, thispage, pagesize);
	}
	@Override
	public Long countLoginCountTJ(String systemId) {
		//String systemId="动物标识及动物产品追溯系统";
		String isDelete=FALSE;
		String type=" sum(t.`LOGINCOUNT`) ";
		return this.count(systemId,isDelete,type);
	}

	@Override
	public List<Map> ListLoginCountTJ(String systemId, Integer thispage,
			Integer pagesize) {
		
		String isDelete=FALSE;
		String type=" sum(t.`LOGINCOUNT`) ";
		return this.list(systemId,isDelete,type, thispage, pagesize);
	}
	@Override
	public Long countDeleteUserTJ(String systemId) {
		//String systemId="动物标识及动物产品追溯系统";
		String isDelete=TRUE;
		String type=" count(t.`NAME`) ";
		return this.count(systemId,isDelete,type);
	}

	@Override
	public List<Map> ListDeleteUserTJ(String systemId, Integer thispage,
			Integer pagesize) {
		
		String isDelete=TRUE;
		String type=" count(t.`NAME`) ";
		return this.list(systemId,isDelete,type, thispage, pagesize);
	}

	private List<Map> list(String systemId,String isDelete,String type, Integer thispage, Integer pagesize) {
		String queryString = getQueryString(systemId,isDelete,type);
		return this.commDao.findByPageToMap(queryString, thispage, pagesize);
	}
	private Long count(String systemId, String isDelete, String type) {
		String queryString = getCountQueryString(systemId,isDelete,type);
		return this.commDao.count(queryString);
	}

	private String getCountQueryString(String systemId, String isDelete,
			String type) {
		return  "select count(*) from ("+getQueryString(systemId, isDelete, type)+ ") as t";
	}

	private String getQueryString(String systemId, String isDelete, String type) {
		//systemId="动物标识及动物产品追溯系统";
		String sql = "select t.`NAME` `divisionName`,IFNULL(sheng.cc,0) shengcount,IFNULL(shi.cc,0) shicount,IFNULL(xian.cc,0) xiancount,IFNULL(xiang.cc,0) xiangcount,IFNULL(cun.cc,0) cuncount FROM "
				+" (SELECT c.`NAME` FROM (SELECT `NAME` FROM t_division WHERE `level`=1) c) t LEFT JOIN"
				+"(select "+type+" as cc,d.`NAME` "
				+"from t_user_account t left join t_org o  on t.org_id = o.id  "
				+"left join t_division d on d.ID = o.division_id where d.`level`=1 and t.system_id = '"+systemId+"' "
				+"and t.is_delete = '"+isDelete+"' "
				+"GROUP BY d.id ORDER BY cc asc) "
				+"as sheng ON t.`NAME` = sheng.`NAME` "
				+"LEFT JOIN "
				+"(select sum(cc) cc,d.`NAME` from "
				+"(select SUM(cc) as cc,d.PARENT_ID  from "
				+"(select "+type+" as cc,d.PARENT_ID as PARENT_ID from t_user_account t left join t_org o  on t.org_id = o.id  "
				+"left join t_division d on d.ID = o.division_id where d.`level`=3 and t.system_id = '"+systemId+"' "
				+"and t.is_delete = '"+isDelete+"' "
				+"GROUP BY d.PARENT_ID) "
				+"a left join t_division d on d.ID = a.PARENT_ID GROUP BY d.PARENT_ID) "
				+"a left join t_division d on d.ID = a.PARENT_ID GROUP BY d.`NAME` "
				+"order by d.`NAME`) as xian ON t.`name` = xian.`name` LEFT JOIN "
				+"(select sum(cc) cc,d.`NAME` from "
				+"(select sum(cc) as cc,d.PARENT_ID from "
				+"(select SUM(cc) as cc,d.PARENT_ID  from "
				+"(select "+type+" as cc,d.PARENT_ID as PARENT_ID from t_user_account t left join t_org o  on t.org_id = o.id  "
				+"left join t_division d on d.ID = o.division_id where d.`level`=4 and t.system_id = '"+systemId+"' "
				+"and t.is_delete = '"+isDelete+"' "
				+"GROUP BY d.PARENT_ID) "
				+"a left join t_division d on d.ID = a.PARENT_ID GROUP BY d.PARENT_ID) "
				+"a left join t_division d on d.ID = a.PARENT_ID GROUP BY d.PARENT_ID) "
				+"a left join t_division d on d.ID = a.PARENT_ID GROUP BY d.`NAME` "
				+"order by d.`NAME`) as xiang ON xiang.`NAME`=t.`NAME` "
				+"LEFT JOIN "
				+"(select sum(cc) cc,d.`NAME` from "
				+"(select sum(cc) as cc,d.PARENT_ID from "
				+"(select sum(cc) as cc,d.PARENT_ID from "
				+"(select SUM(cc) as cc,d.PARENT_ID  from "
				+"(select "+type+" as cc,d.PARENT_ID as PARENT_ID from t_user_account t left join t_org o  on t.org_id = o.id  "
				+"left join t_division d on d.ID = o.division_id where d.`level`=5 and t.system_id = '"+systemId+"' "
				+"and t.is_delete = '"+isDelete+"' "
				+"GROUP BY d.PARENT_ID) "
				+"a left join t_division d on d.ID = a.PARENT_ID GROUP BY d.PARENT_ID) "
				+"a left join t_division d on d.ID = a.PARENT_ID GROUP BY d.PARENT_ID) "
				+"a left join t_division d on d.ID = a.PARENT_ID GROUP BY d.PARENT_ID) "
				+"a left join t_division d on d.ID = a.PARENT_ID GROUP BY d.`NAME` "
				+"order by d.`NAME`) as cun ON cun.`NAME`=t.`NAME` "
				+"LEFT JOIN "
				+"(select sum(cc) cc,d.`NAME` from "
				+"(select "+type+" as cc,d.PARENT_ID as PARENT_ID from t_user_account t left join t_org o  on t.org_id = o.id  "
				+"left join t_division d on d.ID = o.division_id where d.`level`=2 and t.system_id = '"+systemId+"' "
				+"and t.is_delete = '"+isDelete+"' "
				+"GROUP BY d.PARENT_ID) "
				+"a left join t_division d on d.ID = a.PARENT_ID GROUP BY d.`NAME` "
				+"order by d.`NAME`) as shi ON t.`NAME`=shi.`NAME` order by shengcount desc";
//System.out.println(sql);
		return sql;
	}

	
	

	
	
}
