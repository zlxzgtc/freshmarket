package control;

import util.BusinessException;

import java.sql.Connection;
import java.sql.SQLException;

import util.DBUtil;
import model.BeanSystemUser;

public class SystemUserManager {
	/*
	 * 1、添加系统用户addSystemUser
	 * 2、登录验证login
	 * 3、修改系统用户密码modifyPwd（oldPwd,newPwd,newPwd1）
	 * 4、修改姓名modifyName
	 */
	public BeanSystemUser addSystemUser(String userId,String userName,String userPwd1,String userPwd2) throws BusinessException {
		if( "".equals(userId) || userId.length()>20){
			throw new BusinessException("登陆账号必须是1-20个字");
		}
		if( "".equals(userName) || userName.length()>20){
			throw new BusinessException("登陆账号必须是1-20个字");
		}
		if( !userPwd1.equals(userPwd2) ) {
			throw new BusinessException("两次输入密码不同，请重输");
		}
		BeanSystemUser user = null;
		Connection conn=null;
		try {
			user = new BeanSystemUser();
			user.setSystemUserId(userId);
			user.setSystemUserName(userName);
			user.setUserPassword(userPwd1);
			conn=DBUtil.getConnection();
			String sql="select * from system_user where system_user_id=?";
			java.sql.PreparedStatement pst=conn.prepareStatement(sql);
			pst.setString(1,userId);
			java.sql.ResultSet rs=pst.executeQuery();
			if(rs.next()) throw new BusinessException("登陆账号已经存在");
			rs.close();
			pst.close();
			sql="INSERT INTO system_user(system_user_id, system_user_name, user_password ) VALUES (?,?,?)";
			pst=conn.prepareStatement(sql);
			pst.setString(1, userId);
			pst.setString(2, userName);
			pst.setString(3, userPwd1);
			pst.execute();
			pst.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			if(conn!=null)
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
		
		return user;
	}
	
	public BeanSystemUser login(String userId,String userPwd) throws BusinessException {
		BeanSystemUser user = null;
		Connection conn=null;
		try {
			user = new BeanSystemUser();
			conn=DBUtil.getConnection();
			String sql="select system_user_id,system_user_name,user_password from system_user where system_user_id=?";
			java.sql.PreparedStatement pst=conn.prepareStatement(sql);
			pst.setString(1,userId);
			java.sql.ResultSet rs=pst.executeQuery();
			if(rs.next()) {
				if(!rs.getString(3).equals(userPwd)) {
					throw new BusinessException("密码错误");
				}
			}
			user.setSystemUserId(rs.getString(1));
			user.setSystemUserName(rs.getString(2));
			user.setUserPassword(rs.getString(3));
			rs.close();
			pst.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			if(conn!=null)
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
		return user;
	}
	
	public void modifyPwd(BeanSystemUser currUser,String oldPwd,String newPwd1,String newPwd2) throws BusinessException {
		Connection conn=null;
		try {
		
			conn=DBUtil.getConnection();
			String sql="select system_user_id,system_user_name,user_password from system_user where system_user_id=?";
			java.sql.PreparedStatement pst=conn.prepareStatement(sql);
			pst.setString(1,currUser.getSystemUserId());
			java.sql.ResultSet rs=pst.executeQuery();
			if(rs.next()) {
				if(!rs.getString(3).equals(oldPwd)) {
					throw new BusinessException("原密码输入错误");
				}
				if(!newPwd1.equals(newPwd2)) {
					throw new BusinessException("两次输入不一致");
				}
			}
			sql="UPDATE system_user SET user_password = ? WHERE system_user_id = ?";
			pst=conn.prepareStatement(sql);
			pst.setString(1, newPwd1);
			pst.setString(2, currUser.getSystemUserId());
			pst.execute();
			rs.close();
			pst.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			if(conn!=null)
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
	}
	
	public void modifyName(BeanSystemUser currUser,String newName) {

		Connection conn=null;
		try {
			conn=DBUtil.getConnection();
			String sql="UPDATE system_user SET system_user_name = ? WHERE system_user_id = ?";
			java.sql.PreparedStatement pst=conn.prepareStatement(sql);
			pst.setString(1,newName);
			pst.setString(2,currUser.getSystemUserId());
			pst.execute();
			pst.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			if(conn!=null)
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
	}

	
	//	public static void main(String[] args) throws BusinessException {
//		
//		BeanSystemUser curruser =new BeanSystemUser();
//		curruser.setSystemUserId("1");
//		curruser.setSystemUserName("1");
//		curruser.setUserPassword("1");
//		new SystemUserManager().modifyName(curruser,"22");
//
//	}

}
