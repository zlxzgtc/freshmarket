package util;

import java.beans.PropertyVetoException;
import java.sql.Connection;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class DBUtil {

	private static final String jdbcUrl="jdbc:mysql://localhost:3306/freshmarket?characterEncoding=gbk&useSSL=false";
	private static final String dbUser="root";
	private static final String dbPwd="zlx,159357";
	private static ComboPooledDataSource ds=null;
	static{
		ds=new ComboPooledDataSource();
		ds.setMaxPoolSize(15);
		ds.setUser(dbUser);
		ds.setPassword(dbPwd);
		ds.setJdbcUrl(jdbcUrl);
		try {
			ds.setDriverClass("com.mysql.jdbc.Driver");
		} catch (PropertyVetoException e) {
			e.printStackTrace();
		}
	}
	public static Connection getConnection() throws java.sql.SQLException{
		return ds.getConnection();
	}
}
