package com.crx.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crx.crud.bean.Employee;
import com.crx.crud.bean.EmployeeExample;
import com.crx.crud.bean.EmployeeExample.Criteria;
import com.crx.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {
	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	public void deleteEmpBatch(List<Integer> ids) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}
	
	public void deleteEmp(Integer id) {
		
		employeeMapper.deleteByPrimaryKey(id);
	}
	
	public void updateEmp(Employee employee) {
		
		employeeMapper.updateByPrimaryKeySelective(employee);
//		employeeMapper.updateByPrimaryKey(employee);
	}
	
	public Employee getEmp(Integer id) {
		return employeeMapper.selectByPrimaryKey(id);
	}
	
	public void saveEmp(Employee employee) {
		
		employeeMapper.insertSelective(employee);
	}
	
	public List<Employee> getAll(){
		
		return employeeMapper.selectByExampleWithDept(null);
	}
	
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		
		return count == 0;
	}
	
}
