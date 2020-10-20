package com.crx.crud.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crx.crud.bean.Employee;
import com.crx.crud.service.EmployeeService;
import com.crx.crud.util.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class EmployeeController {
	
	@Autowired
	private EmployeeService employeeService;
	
	@ResponseBody
	@RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("ids") String ids) {
		//批量删除
		if(ids.contains("-")) {
			List<Integer> del_ids = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			//组装id的集合
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			//调用service的批量删除方法
			employeeService.deleteEmpBatch(del_ids);
		//单个删除	
		}else {
			int id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		
		return Msg.success();
	}
	
	/**
	 * 直接发送ajax=put请求
	 * Employee数据封装不进来，都为null
	 * 
	 * SQL语句update tbl_emp where emp_id=1;
	 * 
	 * 
	 * 
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
	public Msg updateEmp(Employee employee) {
		
		employeeService.updateEmp(employee);
		
		return Msg.success();
	}
	
	@RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id) {
		Employee employee = employeeService.getEmp(id);
		
		return Msg.success().add("emp", employee);
	}
	
	@ResponseBody
	@RequestMapping("/checkUser")
	public Msg checkUser(String empName) {
		boolean b = employeeService.checkUser(empName);
		
		if(b) {
			return Msg.success();
		}else {
			return Msg.fail();
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/emp",method = RequestMethod.POST)
	public Msg saveEmp(Employee employee) {
		
		employeeService.saveEmp(employee);
		
		return Msg.success();
	}
	
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value ="pn",defaultValue = "1") Integer pn) {
		PageHelper.startPage(pn, 5);
		List<Employee> list = employeeService.getAll();
		PageInfo<Employee> page = new PageInfo<Employee>(list,5);
		
		return Msg.success().add("pageInfo", page);
	}
	
	/**
	 * 查询员工数据（分页查询）
	 * @return
	 */
	/*
	 * @RequestMapping("/emps") public String getEmps(@RequestParam(value =
	 * "pn",defaultValue = "1") Integer pn,Model model) { //这不是一个分页查询
	 * //引入PageHelper分页插件 //在查询之前只需要调用，传入页码，以及每页的大小 PageHelper.startPage(pn, 5);
	 * //startPage后紧跟这个查询就是一个分页查询 List<Employee> list = employeeService.getAll();
	 * //使用PageInfo包装查询后的结果，只需要将PageInfo交给页面就可以了
	 * //封装了详细的分页信息，包括我们查询出来的数据，可以传入连续显示的页数 PageInfo<Employee> page = new
	 * PageInfo<Employee>(list,5); model.addAttribute("pageInfo", page);
	 * 
	 * return "list"; }
	 */
	
}
