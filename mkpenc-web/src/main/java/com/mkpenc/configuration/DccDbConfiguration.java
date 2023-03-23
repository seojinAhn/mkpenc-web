package com.mkpenc.configuration;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.BooleanTypeHandler;
import org.apache.ibatis.type.EnumTypeHandler;
import org.apache.ibatis.type.TypeHandler;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
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
import com.zaxxer.hikari.HikariDataSource;

import javax.sql.DataSource;
import java.util.Set;

@Configuration
@EnableTransactionManagement
public class DccDbConfiguration {
	private static Logger logger = LoggerFactory.getLogger(DccDbConfiguration.class);
	private static final String BASE_PACKAGE = "com.mkpenc.dcc";
	
	@Primary
	@Bean(name="dccdataSource")
	@ConfigurationProperties(prefix = "datasource.mssql-dcc")
	public DataSource dccdataSource() {
		return DataSourceBuilder.create().type(HikariDataSource.class).build();
	}    
		
	@Primary
	@Bean(name="dccsqlSessionFactory")
	public SqlSessionFactory dccsqlSessionFactory(@Qualifier("dccdataSource")DataSource dccdataSource,
			ApplicationContext applicationContext) throws Exception {

		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setDataSource(dccdataSource);
		sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath:sql/mssqlDCC/**/*.xml"));
		sqlSessionFactoryBean.setTypeAliases(findModel());
		sqlSessionFactoryBean.getObject().getConfiguration().setMapUnderscoreToCamelCase(true);
      /*
		sqlSessionFactoryBean.setTypeHandlers(new TypeHandler[] {
                new EnumTypeHandler(TestCdType.class)
        });
        */
		return sqlSessionFactoryBean.getObject();
	}
	
	@Primary
	@Bean(name="dccsqlSessionTemplate")
	public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory dccsqlSessionFactory) {
		return new SqlSessionTemplate(dccsqlSessionFactory);
	}
	
	
    @Primary
    @Bean(name="dcctxManager")
    public PlatformTransactionManager dcctxManager(@Qualifier("dccdataSource") DataSource dccdataSource) {
        DataSourceTransactionManager txManager = new DataSourceTransactionManager(dccdataSource);
        txManager.setGlobalRollbackOnParticipationFailure(true);
        txManager.setRollbackOnCommitFailure(true);

        return txManager;
    }

	@Bean(name="dccmapperScanner")
	@Primary
	public MapperScannerConfigurer dccmapperScanner() {
		MapperScannerConfigurer mapperScannerConfigurer = new MapperScannerConfigurer();
		mapperScannerConfigurer.setAnnotationClass(Mapper.class);
		mapperScannerConfigurer.setBasePackage(BASE_PACKAGE);
		mapperScannerConfigurer.setSqlSessionFactoryBeanName("dccsqlSessionFactory");

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
