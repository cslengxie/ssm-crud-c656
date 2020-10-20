package com.crx.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crx.crud.bean.Department;
import com.crx.crud.service.DepartmentService;
import com.crx.crud.util.Msg;

@Controller
public class DepartmentController {
	
	@Autowired
	private DepartmentService departmentService;
	
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		//查询出所有的部门信息
		List<Department> list = departmentService.getDepts();
		
		return Msg.success().add("list", list);
	}
	
}
