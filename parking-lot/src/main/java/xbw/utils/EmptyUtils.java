
package xbw.utils;

import java.util.Collection;
import java.util.Map;

/**
 * <p>
 * 判断是否是空的 工具类
 * </p>
 * 
 * @author null
 * @version v1.0
 * @since 2015/5/5
 */
public class EmptyUtils {
	// 判空
	public static boolean isEmpty(Object obj) {
		if (obj == null)
			return true;
		if (obj instanceof String)
			return ((String) obj).length() == 0;
		if (obj instanceof Collection)
			return ((Collection) obj).isEmpty();
		if (obj instanceof Map)
			return ((Map) obj).isEmpty();
		if (obj instanceof Object[]) {
			Object[] object = (Object[]) obj;
			if (object.length == 0) {
				return true;
			}
			boolean empty = true;
			for (int i = 0; i < object.length; i++) {
				if (!isEmpty(object[i])) {
					empty = false;
					break;
				}
			}
			return empty;
		}
		return false;
	}

	public static boolean isNotEmpty(Object obj) {
		return !isEmpty(obj);
	}

	private boolean validPropertyEmpty(Object... args) {
		for (int i = 0; i < args.length; i++) {
			if (EmptyUtils.isEmpty(args[i])) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 判断是否是数字,是的话返回true
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNumber(String str) {
		boolean result = false;
		// 如果不是空字符串
		if (!isEmpty(str)) {
			str = str.trim();// 去空格
			result = str.matches("[0-9]+");
		}
		return result;
	}

	/**
	 * 如果都是数字返回true
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNumber(String... strs) {
		boolean result = true;
		for (String s : strs) {
			if (!EmptyUtils.isNumber(s)) {
				result = false;
				break;
			}
		}
		return result;
	}
}
