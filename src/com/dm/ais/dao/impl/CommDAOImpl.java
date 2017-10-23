package com.dm.ais.dao.impl;

import java.math.BigInteger;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.Transformers;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import com.dm.ais.dao.CommDAO;

@Repository
public class CommDAOImpl extends HibernateDaoSupport implements CommDAO {

	private SessionFactory sessionFacotry;

	@Resource
	public void setSessionFacotry(SessionFactory sessionFacotry) {
		super.setSessionFactory(sessionFacotry);
	}

	public <T> List<T> findByPropertyName(Class<T> entityClass, String name,
			Object value) {
		String queryString;
		try {
			queryString = "from " + entityClass.getName() + " t where t."
					+ name + " = ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public <T> List<T> findByPropertyName(Class<T> entityClass, String[] names, Object[] values) {
		String queryString;
		try {
			String[] arrayOfString;
			queryString = "from " + entityClass.getName() + " t where 1=1";
			int j = (arrayOfString = names).length;
			for (int i = 0; i < j; ++i) {
				String name = arrayOfString[i];
				queryString = queryString + " and t." + name + " = ?";
			}
			return getHibernateTemplate().find(queryString, values);
		} catch (RuntimeException re) {
			throw re;
		}
	}
	/**
	 * 传递sql语句查询
	 */
	public List getListbySql(final String queryString){
		return getHibernateTemplate().executeFind(new HibernateCallback() {
		      public Object doInHibernate(Session session) throws HibernateException, SQLException {
		        Query query = session.createSQLQuery(queryString);
		        List list = query.list();
		        return list;
		      }
		    });
	}
	/**
	 * 传递sql语句查询
	 * @param queryString
	 * @param thispage
	 * @param pagesize
	 * @return
	 */
	public  List findByPage(final String queryString, final int thispage, final int pagesize)
	  {
	    return getHibernateTemplate().executeFind(new HibernateCallback() {
	      public Object doInHibernate(Session session) throws HibernateException, SQLException {
	        Query query = session.createSQLQuery(queryString);
	        query.setFirstResult(thispage * pagesize);
	        query.setMaxResults(pagesize);
	        List list = query.list();
	        return list;
	      }
	    });
	  }
	  public <T> Long count(final String queryString)
	  {
	    return (Long)getHibernateTemplate().execute(new HibernateCallback() {
	      public Object doInHibernate(Session session) throws HibernateException, SQLException {
	        Query query = session.createSQLQuery(queryString);
	        BigInteger  count = (BigInteger )query.uniqueResult();
	        long longValue = count.longValue();
	        return longValue;
	      }
	    });
	  }

	@Override
	public <T> List<T> getListbySql(final Class<T> paramClass,final String queryString) {
			return getHibernateTemplate().executeFind(new HibernateCallback() {
			      public Object doInHibernate(Session session) throws HibernateException, SQLException {
			        Query query = session.createSQLQuery(queryString).addEntity(paramClass);
			        List list = query.list();
			        return list;
			      }
			    });
	}

	@Override
	public <T> List<T> findByPage(final Class<T> paramClass, final String queryString,
			final Integer thispage, final Integer pagesize) {
		{
		    return getHibernateTemplate().executeFind(new HibernateCallback() {
		      public Object doInHibernate(Session session) throws HibernateException, SQLException {
		        Query query = session.createSQLQuery(queryString).addEntity(paramClass);
		        query.setFirstResult(thispage * pagesize);
		        query.setMaxResults(pagesize);
		        List list = query.list();
		        return list;
		      }
		    });
		  }
	}
	@Override
	public List<Map> findByPageToMap( final String queryString,
			final Integer thispage, final Integer pagesize) {
		{
		    return getHibernateTemplate().executeFind(new HibernateCallback() {
		      public Object doInHibernate(Session session) throws HibernateException, SQLException {
		        Query query = session.createSQLQuery(queryString).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
		        query.setFirstResult(thispage * pagesize);
		        query.setMaxResults(pagesize);
		        List list = query.list();
		        return list;
		      }
		    });
		  }
	}
	  
}
