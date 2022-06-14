package xbw.dao;

import org.apache.ibatis.annotations.Param;
import xbw.pojo.User;


public interface UserMapper {
	 User getAdminUser(@Param("userName") String userName,
                       @Param("password") String password);

	 User getAdminUserByName(@Param("userName") String userName);

	 int insertAdminUser(User user);

	 int updateAdminUser(User user);

	 int updatePwdById(@Param("id") Integer id,@Param("password") String password);

}
