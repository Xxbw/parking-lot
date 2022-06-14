package xbw.pojo;

import lombok.Data;

@Data
public class User {
	private int id;
	private String userName;
	private String password;
	private String phone;
	private String email;

	public User() {
	}

	public User(int id, String userName, String password, String phone, String email) {
		this.id = id;
		this.userName = userName;
		this.password = password;
		this.phone = phone;
		this.email = email;
	}
}
