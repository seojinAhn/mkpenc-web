package com.mkpenc;
   
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

@ServletComponentScan
@SpringBootApplication(scanBasePackages = "com.mkpenc")
@EnableCaching
@EnableAspectJAutoProxy
public class MkpencApplication extends SpringBootServletInitializer {
    private static Logger logger = LoggerFactory.getLogger(MkpencApplication.class);

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(MkpencApplication.class);
    }

    public static void main(String[] args) throws Exception {
        ApplicationContext applicationContext = SpringApplication.run(MkpencApplication.class, args);

        for (String beanName : applicationContext.getBeanDefinitionNames()) {
            logger.debug("### beanName : {}", beanName);
        }
    }

}
