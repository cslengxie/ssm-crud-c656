package com.crx.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.crx.crud.bean.Employee;
import com.github.pagehelper.PageInfo;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml",
		"file:src/main/webapp/WEB-INF/springDispatcherServlet-servlet.xml"})
public class MvcTest {
	
	//传入SpringMVC的ioc
	@Autowired
	WebApplicationContext context;
	//虚拟的mvc请求，获取到处理结果
	MockMvc mockMvc;
	
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception {
		//模拟请求拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "10")).andReturn();
		MockHttpServletRequest request = result.getRequest();
		PageInfo<Employee> page = (PageInfo<Employee>) request.getAttribute("pageInfo");
		System.out.println("当前页码：" + page.getPageNum());
		System.out.println("总页码：" + page.getPages());
		System.out.println("总记录数：" + page.getTotal());
		System.out.println("是否是第一页：" + page.isIsFirstPage());
		System.out.println("是否有下一页：" + page.isHasNextPage());
		System.out.println("连续显示的页码：");
		int[] nums = page.getNavigatepageNums();
		for (int i : nums) {
			System.out.print(i + ",");
		}
		System.out.println();
		//获取员工数据
		List<Employee> list = page.getList();
		for (Employee employee : list) {
			System.out.println(employee);
		}
	}
}
