package xbw.config;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

import java.io.File;
import java.nio.file.Paths;

@Configuration
public class MvcConfig extends WebMvcConfigurationSupport implements InitializingBean {

    public static final String IMAGE_PATH = Paths.get(FilenameUtils.getFullPath(new File(StringUtils.EMPTY).getAbsolutePath()), "work", "parking-log-images").toAbsolutePath().toFile().getAbsolutePath();

    @Override
    protected void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/project-images/**").addResourceLocations(String.format("file:%s/",IMAGE_PATH ));
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        final File file = new File(IMAGE_PATH);
        if (!file.exists() && !file.mkdirs()) {
            throw new IllegalStateException("创建目录 " + IMAGE_PATH + " 失败");
        }
    }
}
