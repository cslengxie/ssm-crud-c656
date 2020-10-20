package com.crx.crud.test;

import java.util.List;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.crx.crud.bean.Department;
import com.crx.crud.bean.Employee;
import com.crx.crud.bean.EmployeeExample;
import com.crx.crud.bean.EmployeeExample.Criteria;
import com.crx.crud.dao.DepartmentMapper;
import com.crx.crud.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testMybatis3() {
		//查询所有
//		List<Employee> list = employeeMapper.selectByExample(null);
//		System.out.println(list);
		//查询员工名字中有f字母的，并且员工的部门号是3
		//xxxExample就是封装查询条件
		EmployeeExample example = new EmployeeExample();
		//创建一个criteria，这个criteria就是拼接条件
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameLike("%f%");
		criteria.andDIdEqualTo(3);
//		List<Employee> list = employeeMapper.selectByExample(example);
//		System.out.println(list);
		
		Criteria criteria2 = example.createCriteria();
		criteria2.andEmailLike("%e%");

		example.or(criteria2);
		
		List<Employee> selectByExample = employeeMapper.selectByExample(example);
		System.out.println(selectByExample);
		
		
	}
	
	@Test
	public void testCRUD() {
		//1.插入几个部门
//		departmentMapper.insertSelective(new Department(null, "开发部"));
//		departmentMapper.insertSelective(new Department(null, "测试部"));
		
		//2.插入员工数据
//		employeeMapper.insertSelective(new Employee(null, "Tom", "M", "tom@crx.com", 3));
//		employeeMapper.insertSelective(new Employee(null, "Jerry", "W", "jerry@crx.com", 4));
		
		//3.查询数据
//		System.out.println(employeeMapper.selectByPrimaryKeyWithDept(1));
//		System.out.println(employeeMapper.selectByExampleWithDept(null));
		
		//4.批量插入，使用可以执行批量操作的sqlSession
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i = 0;i < 1000;i++) {
			//UUID根据时间戳随机生成16为的字符串，只要前5位加上i
			String uid = UUID.randomUUID().toString().substring(0,5) + i;
			mapper.insert(new Employee(null, uid, "M", uid + "@crx.com", 4));
		}
	}
}
