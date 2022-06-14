package xbw.service;

import xbw.pojo.User;

public interface UserService {
	User getAdminUser(String userName, String password);

	User getAdminUserByName(String userName);

	int insertAdminUser(User user);

	int updateAdminUser(User user);

	int updatePwdById(Integer id,String password);
}
