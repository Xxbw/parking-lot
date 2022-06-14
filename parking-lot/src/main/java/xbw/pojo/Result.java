package xbw.pojo;

import java.io.Serializable;

public class Result implements Serializable {
	/** 错误码. */
	private Integer errno;
	/** 具体的内容. */
	private String[] data;

	public Result() {
		super();
	}

	public Result(String[] data) {
		super();
		this.errno = 0;
		this.data = data;
	}

	public Integer getErrno() {
		return errno;
	}

	public void setErrno(Integer errno) {
		this.errno = errno;
	}

	public String[] getData() {
		return data;
	}

	public void setData(String[] data) {
		this.data = data;
	}

	@Override
	public String toString() {
		System.out.println(errno+"-------"+data);
		return "WangEditor [errno=" + errno + ", data="
				+ data + "]";
	}

}