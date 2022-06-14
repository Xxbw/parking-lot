package xbw.service;

import org.springframework.stereotype.Service;
import xbw.dao.UserMapper;
import xbw.pojo.User;

import javax.annotation.Resource;

@Service
public class UserServiceImpl implements UserService {

	@Resource
	private UserMapper usermapper;
	
	@Override
	public User getAdminUser(String userName, String password) {
		return usermapper.getAdminUser(userName, password);
	}

	@Override
	public User getAdminUserByName(String userName) {
		return usermapper.getAdminUserByName(userName);
	}

	@Override
	public int insertAdminUser(User user){return usermapper.insertAdminUser(user);}

	@Override
	public int updateAdminUser(User user) {
		return usermapper.updateAdminUser(user);
	}

	@Override
	public int updatePwdById(Integer id, String password) {
		return usermapper.updatePwdById(id,password);
	}

}
