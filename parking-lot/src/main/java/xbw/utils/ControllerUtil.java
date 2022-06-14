package xbw.utils;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author
 * 
 */
public class ControllerUtil {
	public static final String LOGIN_USER_SESSION = "userSession";
	public final static int pageSize = 10;

	/**
	 * 处理上传的文件
	 * 
	 * @param attach
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static String fileSave(MultipartFile attach,
			HttpServletRequest request, String filePath) throws Exception {
		Date date = new Date();
		String idPicPath = null;
		if (!attach.isEmpty()) {
			File f = new File(request.getSession().getServletContext()
					.getRealPath(filePath));
			if (!f.exists()) {
				f.mkdirs();
			}
			String oldFileName = attach.getOriginalFilename();// 原文件名
			String prefix = FilenameUtils.getExtension(oldFileName);// 原文件后缀
			long filesize = 5000000000L;
			if (attach.getSize() > filesize) {// 上传大小不得超过 50k
				request.setAttribute("fileUploadError", "上传大小不得超过 50k");
				return "user/banner/banneradd";
			} else if (prefix.equalsIgnoreCase("jpg")
					|| prefix.equalsIgnoreCase("png")
					|| prefix.equalsIgnoreCase("jepg")
					|| prefix.equalsIgnoreCase("pneg")) {// 上传图片格式
				String fileName = DigestUtils.md5Hex(System.currentTimeMillis()
						+ "" + date)
						+ "." + prefix;//
				File targetFile = new File(f, fileName);
				try {
					attach.transferTo(targetFile);
				} catch (Exception e) {
					e.printStackTrace();
					request.setAttribute("errorMsg", "上传图片异常");
					throw new Exception("上传图片异常");
				}

				idPicPath = "\\" + filePath + "\\" + fileName;
				// idPicPath = StringUtils.substringAfter(idPicPath, "statics");
				idPicPath = idPicPath.replaceAll("\\\\", "/");
				idPicPath = idPicPath.substring(9);
			} else {
				request.setAttribute("errorMsg", "上传图片格式不正确");
				throw new Exception("上传图片格式不正确");
			}
		}
		return idPicPath;
	}

	/**
	 * 字符串转时间
	 * 
	 * @param date
	 * @return
	 */
	public static Date stringToDate(String date) {
		try {
			return DateUtils.parseDate(date,"yyyy-MM-dd");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
}
