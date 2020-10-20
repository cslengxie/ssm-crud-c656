<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript"
	src="${APP_PATH}/static/js/jquery-3.0.0.min.js"></script>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.css"
	rel="stylesheet">
<script type="text/javascript"
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body>
	<!-- 员工修改的模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<label for="empName_add_input" class="col-sm-2 control-label">empName</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="empName_update_static"
								placeholder="empName" name="empName" readonly="readonly"><span class="help-block"></span>
						</div>
						<label for="email_add_input" class="col-sm-2 control-label">email</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="email_update_input"
								placeholder="Email" name="email"><span class="help-block"></span>
						</div>
						<label class="col-sm-2 control-label">gender</label> <label
							class="checkbox-inline"> <input type="radio"
							id="gender1_update_input" name="gender" value="M" checked="checked">
							男
						</label> <label class="checkbox-inline"> <input type="radio"
							name="gender" id="gender2_update_input" value="W"> 女
						</label>
						<div class="form-group">
							<label for="name" class="col-sm-2 control-label">deptName</label> 
							<div class="col-sm-4">
								<!-- 部门提交部门ID -->
								<select class="form-control" name="dId" id="dept_update_select">
									<!-- <option value="3">开发部</option> -->
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<label for="empName_add_input" class="col-sm-2 control-label">empName</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="empName_add_input"
								placeholder="empName" name="empName"><span class="help-block"></span>
						</div>
						<label for="email_add_input" class="col-sm-2 control-label">email</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="email_add_input"
								placeholder="Email" name="email"><span class="help-block"></span>
						</div>
						<label class="col-sm-2 control-label">gender</label> <label
							class="checkbox-inline"> <input type="radio"
							id="gender1_add_input" name="gender" value="M" checked="checked">
							男
						</label> <label class="checkbox-inline"> <input type="radio"
							name="gender" id="gender2_add_input" value="W"> 女
						</label>
						<div class="form-group">
							<label for="name" class="col-sm-2 control-label">deptName</label> 
							<div class="col-sm-4">
								<!-- 部门提交部门ID -->
								<select class="form-control" name="dId" id="dept_add_select">
									<!-- <option value="3">开发部</option> -->
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题行 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all"></th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
		<!-- 显示分页导航栏 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
	
		var totalRecord,currentPage;
	
		//1.页面加载完成后，直接去发送一个ajax请求，拿到分页数据
		$(function() {
			to_page(1);
		})

		function to_page(pn) {
			$.ajax({
				url : '${APP_PATH}/emps',
				data : 'pn=' + pn,
				type : 'get',
				success : function(result) {
					//1.解析并显示员工数据
					build_emp_table(result);
					//2.解析并显示分页导航栏
					build_page_nav(result);
					//3.解析显示分页文字信息
					build_page_info(result);
				}
			});
		}

		function build_emp_table(result) {
			//清空table
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				var checkboxTd = $("<td></td>").append("<input type='checkbox' class='check_item'>")
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(
						item.gender == "M" ? "男" : "女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>")
						.append(item.department.deptName);

				var editBtn = $("<button></button>").addClass(
						"btn btn-primary btn-sm edit_btn").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-pencil").append("编辑"));
				editBtn.attr("edit-id",item.empId);
				var delBtn = $("<button></button>").addClass(
						"btn btn-danger btn-sm delete_btn").append(
						$("<span></span>")
								.addClass("glyphicon glyphicon-trash").append(
										"删除"));
				delBtn.attr("del-id",item.empId);
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(
						delBtn);

				$("<tr></tr>").append(checkboxTd).append(empIdTd).append(empNameTd).append(
						genderTd).append(emailTd).append(deptNameTd).append(
						btnTd).appendTo("#emps_table tbody");

			})
		}

		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前第" + result.extend.pageInfo.pageNum + "页，总"
							+ result.extend.pageInfo.pages + "页，共"
							+ result.extend.pageInfo.total + "条记录。");
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}

		function build_page_nav(result) {
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;").attr("href", "#"));
			if (!result.extend.pageInfo.hasPreviousPage) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;").attr("href", "#"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			if (!result.extend.pageInfo.hasNextPage) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
			}
			//添加首页和上一页
			ul.append(firstPageLi).append(prePageLi);
			//页码号
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append(
						$("<a></a>").append(item).attr("href", "#"));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				});
				ul.append(numLi);
			})
			//下一页和末页
			ul.append(nextPageLi).append(lastPageLi);
			//把ul添加到nav标签
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		$("#emp_add_modal_btn").click(function(){
			//表单重置
			//reset_form("#empAddModal form");
			$("#empAddModal form")[0].reset();
			//发送ajax请求，查出部门信息，显示在下拉列表中
			getDepts("#dept_add_select");
			$("#empAddModal").modal({
				backdrop:"static"
			});
		})
		function getDepts(ele){
			//每次加载部门信息之前，清空下拉菜单
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"get",
				success:function(result){
					//console.log(result);
					$.each(result.extend.list,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		$("#emp_save_btn").click(function(){
			//前端校验
			if(!validate_add_form()){
				return false;
			}
			//后端校验
			if($(this).attr("ajax-va") == "error"){
				return false;
			}
			$.ajax({
				url : "${APP_PATH}/emp",
				type : "post",
				data : $("#empAddModal form").serialize(),//将form表单中的数据序列化
				success:function(result){
					//console.log(result);
					//1.关闭模态框
					$("#empAddModal").modal("hide");
					to_page(totalRecord);
				}
			});
		})
		//校验表单数据
		function validate_add_form(){
			//1.拿到校验的数据
			var empName = $("#empName_add_input").val();
			var regName = /^[a-zA-Z][a-zA-Z0-9_]{6,16}$/;
			if(!regName.test(empName)){
				//alert("用户名不合法");
				show_validate_msg("#empName_add_input","error","用户名不合法");
				return false;
			}else{
				show_validate_msg("#empName_add_input","success","");
			}
			//校验邮箱信息
			var email = $("#email_add_input").val();
			var regEmail = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_add_input","error","邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_add_input","success","");
			}
			return true;
		}
		function show_validate_msg(ele,status,msg){
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success" == status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		//校验用户名是否可用
		$("#empName_add_input").change(function(){
			var empName = this.value;
			$.ajax({
				url : "${APP_PATH}/checkUser",
				data : "empName=" + empName,
				type : "post",
				success:function(result){
					if(result.code == 100){
						show_validate_msg("#empName_add_input","success","用户名可用");
						$("#emp_save_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#empName_add_input","error","用户名已存在");
						$("#emp_save_btn").attr("ajax-va","error");
					}
				}
			});
		});
		//我们是按钮创建之前就绑定了click
		//1）可以在创建的时候绑定
		//2）绑定live()
		//JQuery新版本没有live，使用on替代
		$(document).on("click",".edit_btn",function(){
			//alert("edit");
			$("#empUpdateModal form")[0].reset();
			getDepts("#dept_update_select");
			//1.查出员工信息，显示员工信息
			getEmp($(this).attr("edit-id"));
			//2.查出部门信息，并显示部门列表
			//3.把员工id传递给模态框更新按钮
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
		});
		function getEmp(id){
			//alert(id);
			$.ajax({
				url : "${APP_PATH}/emp/" + id,
				type : "GET",
				dataType : "json",
				success : function(result){
					//console.log(result);
					var empData = result.extend.emp;
					$("#empName_update_static").val(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#dept_update_select").val([empData.dId]);
				}
			});
		}
		//点击更新，更新员工信息
		$("#emp_update_btn").click(function(){
			//验证邮箱是否合法
			var email = $("#email_update_input").val();
			var regEmail = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_update_input","error","邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_update_input","success","");
			}
			//发送ajax请求保存更新数据 发送PUT请求（在POST请求的基础上）
			$.ajax({
				url : "${APP_PATH}/emp/" + $(this).attr("edit-id"),
				type :"post",
				data : $("#empUpdateModal form").serialize() + "&_method=PUT",
				success:function(result){
					//alert(result.msg);
					//1.关闭模态框
					$("#empUpdateModal").modal("hide");
					//2.回到本页面
					to_page(currentPage);
				}
			});
		})
		//单个删除
		$(document).on("click",".delete_btn",function(){
			//1.弹出是否确认删除的对话框
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("del-id");
			if(confirm("是否确认删除【"+empName+"】的信息吗？")){
				//确认，发送ajax请求
				$.ajax({
					url : "${APP_PATH}/emp/" + empId,
					type : "delete",
					//data : "_method=DELETE",
					dataType : "json",
					success:function(result){
						alert(result.msg);
						//回到本页
						to_page(currentPage);
					}
				});
			}
		});
		//完成全选/全不全
		$("#check_all").click(function(){
			//attr获取的checked属性undefined
			//prop拿到boolean
			$(".check_item").prop("checked",$(this).prop("checked"));
		})
		$(document).on("click",".check_item",function(){
			//判断当前选中的元素是否是5个
			var flag = $(".check_item:checked").length == $(".check_item").length;
			$("#check_all").prop("checked",flag);
		})
		$("#emp_delete_all_btn").click(function(){
			var empNames = "";
			var idStr = "";
			$.each($(".check_item:checked"),function(){
				empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
				//组装员工id字符串
				idStr += $(this).parents("tr").find("td:eq(1)").text() + "-";
			});
			//去掉empNames多余的逗号
			empNames = empNames.substring(0,empNames.length-1);
			//去掉id多余的-
			idStr = idStr.substring(0,idStr.length-1);
			if(empNames == "" || idStr == "" || $(".check_item:checked").length == 0){
				alert("您没有选择有效的数据！！！");
				return;
			}
			if(confirm("确认删除【"+empNames+"】的信息吗？")){
				//发送ajax请求
				$.ajax({
					url : "${APP_PATH}/emp/" + idStr,
					type : "delete",
					success : function(result){
						alert(result.msg);
						to_page(currentPage);
					}
				});
			}
		});
	</script>
</body>
</html>