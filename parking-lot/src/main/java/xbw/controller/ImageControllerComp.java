package xbw.controller;

import com.alibaba.fastjson.JSONObject;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import xbw.config.MvcConfig;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.Collections;
import java.util.Objects;
import java.util.UUID;

@Controller
@RequestMapping("/images")
public class ImageControllerComp {

    @Autowired
    private HttpServletRequest request;

    @RequestMapping(method = RequestMethod.POST, value = "/upload")
    @ResponseBody
    public Object upload(MultipartFile file) throws IOException {

        System.out.println(Paths.get("..").toAbsolutePath().toFile().getAbsolutePath());

        if (Objects.isNull(file) || file.isEmpty()) {
            throw new IllegalArgumentException("file 不能为空");
        }

        final String extension = FilenameUtils.getExtension(file.getOriginalFilename());
        if (StringUtils.isBlank(extension)) {
            throw new IllegalArgumentException("文件没有后缀");
        }

        final LocalDate now = LocalDate.now();
        final String filePath = String.format("/%s/%s/%s/%s.%s", now.getYear(), now.getMonthValue(), now.getDayOfMonth(), UUID.randomUUID(), extension);

        final File fl = new File(MvcConfig.IMAGE_PATH + filePath);
        final File pf = fl.getParentFile();
        if (!pf.exists()) {
            synchronized (this) {
                if (!pf.exists() && !pf.mkdirs()) {
                    throw new IllegalStateException("创建目录 " + fl.getParentFile() + " 失败");
                }
            }
        }

        try (OutputStream os = new FileOutputStream(fl)) {
            IOUtils.copy(file.getInputStream(), os);
        }
        JSONObject jsonObject = new JSONObject();
//        jsonObject.put("localUrl",MvcConfig.IMAGE_PATH);
        jsonObject.put("url", filePath);
        return jsonObject;
    }

}
