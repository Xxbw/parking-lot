package xbw.controller;

import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import xbw.pojo.User;
import xbw.service.UserService;
import xbw.utils.ControllerUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;


@Controller
@RequestMapping({"/admin" })
public class UserControllerComp {

	@Resource
	private UserService userService;

	@RequestMapping(value = "/doLogin")
	public Object doLogin(@RequestParam("userName") String userName,
                          @RequestParam("password") String password,HttpServletRequest request) {
		User adminUser = userService.getAdminUser(userName, password);
		if (adminUser != null){
			request.getSession().setAttribute("user",
					adminUser);
			return "main";
		}
		request.setAttribute("mgs", "用户名或密码错误");
		return "index";
	}

	@ResponseBody
	@RequestMapping(value = "/register" ,produces = "application/json; charset=utf-8")
	public Object register(@RequestBody User adminUser,
						   HttpServletRequest request){
		String message = "";
		User user = new User();
		user.setUserName(adminUser.getUserName());
		user.setPassword(adminUser.getPassword());
		user.setPhone(adminUser.getPhone());
		if (adminUser.getEmail() != null){
			user.setEmail(adminUser.getEmail());
		}
		try {
			User temp = userService.getAdminUserByName(user.getUserName());
			if (temp == null || temp.equals("")){
				Integer result = userService.insertAdminUser(user);
				if (result > 0){
					request.getSession().setAttribute("registerUser",
							user);
//					request.setAttribute("mgs1", "注册成功");
					message = "注册成功";
				}else {
//					request.setAttribute("mgs1", "注册失败");
					message = "注册失败";
				}
			} else {
//				request.setAttribute("mgs1", "已经存在该用户");
				message = "已经存在该用户";
				System.out.println("已经存在该用户");
			}
		}catch (Exception ex){
//			request.setAttribute("mgs1", ex);
			message = ex.toString();
		}
//		return "index";
		return message;
	}

	@RequestMapping("/exit")
	public Object exit(HttpServletRequest request){
		request.getSession().removeAttribute("user");
		User temp = (User) request.getSession().getAttribute("registerUser");
		if (temp != null && !(temp.equals(""))){
			request.getSession().removeAttribute("registerUser");
		}
		return "index";
	}

	@RequestMapping("/updateInfo")
	public Object updateInfo(@RequestParam("phone") String phone,@RequestParam("userName") String userName,
							 @RequestParam("id") String thisName,
							 @RequestParam("email") String email,HttpServletRequest request){
		User adminUser = (User) request.getSession().getAttribute("user");
		adminUser.setUserName(userName);
		adminUser.setPhone(phone);
		adminUser.setEmail(email);
		try {
			if (thisName != adminUser.getUserName()){
				User temp = userService.getAdminUserByName(adminUser.getUserName());
				if (temp != null || !(temp.equals(""))){
					request.setAttribute("mgs4","用户名已存在");
				}
			}

			Integer result = userService.updateAdminUser(adminUser);
			if (result > 0){
				request.getSession().setAttribute("user",adminUser);
				request.setAttribute("mgs4","修改成功");
				return "/person/person_info";
			} else {
				request.setAttribute("mgs4","修改失败");
			}

		}catch (Exception ex){
			request.setAttribute("mgs4",ex);
		}

		return "/person/person_info";
	}

	@RequestMapping(value = "/doUpdate")
	public Object doUpdate(@RequestParam("oldpwd") String oldpwd,@RequestParam("userName") String userName,
						   @RequestParam("newpwd") String password,
						   @RequestParam("id") Integer id,HttpServletRequest request){

		User user = userService.getAdminUser(userName,oldpwd);

		if (user != null){

			User adminUser = (User) request.getSession().getAttribute("user");
			adminUser.setPassword(password);
			Integer result = userService.updatePwdById(id,password);
			if (result > 0){
				request.getSession().setAttribute("user",
						adminUser);
				request.setAttribute("mgs3","修改密码成功");
			}

		}else {
			request.setAttribute("mgs3","输入原始密码不对");
		}
		return "person/updatepwd";
	}
}
