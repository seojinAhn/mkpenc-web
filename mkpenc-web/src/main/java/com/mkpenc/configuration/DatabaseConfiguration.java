package com.mkpenc.configuration;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.BooleanTypeHandler;
import org.apache.ibatis.type.EnumTypeHandler;
import org.apache.ibatis.type.TypeHandler;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.mapper.MapperScannerConfigurer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ClassPathScanningCandidateComponentProvider;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.type.filter.AnnotationTypeFilter;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.mkpenc.common.annotaion.Mapper;
import com.mkpenc.common.annotaion.Model;

import javax.sql.DataSource;
import java.util.Set;

@Configuration
@EnableTransactionManagement
public class DatabaseConfiguration {
	private static Logger logger = LoggerFactory.getLogger(DatabaseConfiguration.class);
	private static final String BASE_PACKAGE = "com.mkpenc";

	@Bean
	@Primary
	@ConfigurationProperties(prefix = "datasource.mssql")
	public DataSource dataSource() {
		return DataSourceBuilder.create().build();
	}

    @Bean
    public PlatformTransactionManager txManager(@Qualifier("dataSource") DataSource dataSource) {
        DataSourceTransactionManager txManager = new DataSourceTransactionManager(dataSource);
        txManager.setGlobalRollbackOnParticipationFailure(true);
        txManager.setRollbackOnCommitFailure(true);

        return txManager;
    }
	
	@Bean
	@Primary
	public SqlSessionFactory sqlSessionFactory(DataSource dataSource,
			ApplicationContext applicationContext) throws Exception {

		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setDataSource(dataSource);
		sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath:sql/mssql/**/*.xml"));
		sqlSessionFactoryBean.setTypeAliases(findModel());
		sqlSessionFactoryBean.getObject().getConfiguration().setMapUnderscoreToCamelCase(true);
      /*
		sqlSessionFactoryBean.setTypeHandlers(new TypeHandler[] {
                new EnumTypeHandler(TestCdType.class)
        });
        */
		return sqlSessionFactoryBean.getObject();
	}

	@Bean
	public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) {
		return new SqlSessionTemplate(sqlSessionFactory);
	}

	@Bean
	public MapperScannerConfigurer mapperScanner() {
		MapperScannerConfigurer mapperScannerConfigurer = new MapperScannerConfigurer();
		mapperScannerConfigurer.setAnnotationClass(Mapper.class);
		mapperScannerConfigurer.setBasePackage(BASE_PACKAGE);
		mapperScannerConfigurer.setSqlSessionFactoryBeanName("sqlSessionFactory");

		return mapperScannerConfigurer;
	}

	private static Class<?>[] findModel() {
		ClassPathScanningCandidateComponentProvider provider = new ClassPathScanningCandidateComponentProvider(false);

		provider.addIncludeFilter(new AnnotationTypeFilter(Model.class));

		Set<BeanDefinition> beanDefinitions = provider.findCandidateComponents(BASE_PACKAGE);
		Class<?>[] classes = new Class[beanDefinitions.size()];

		int i = 0;
		for (BeanDefinition beanDef : beanDefinitions) {
			try {
				Class<?> cl = Class.forName(beanDef.getBeanClassName());

				classes[i] = cl;

				i++;
			} catch (Exception e) {
				logger.error("Got exception: " + e.getMessage());
			}
		}

		return classes;
	}

}
