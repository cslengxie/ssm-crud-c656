<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.toolbar {
	border: 1px solid #ccc;
	width: 800px;
}

.text {
	border: 1px solid #ccc;
	height: 400px;
	width: 800px;
}
</style>
</head>
<body>
	
	<div id="div1" class="toolbar"></div>
	<div style="padding: 5px 0; color: #ccc"></div>
	<div id="div2" class="text">
		<p>请在此输入内容</p>
	</div>
	
	<button id="btn1">获取html</button>
	<button id="btn2">获取text</button>
	<button id="tj">提交</button>
	<a href="ShowContentController">查看内容</a>
</body>
<script src="static/js/jquery-3.0.0.min.js"></script>
<script type="text/javascript" src="static/js/wangEditor.min.js"></script>
<script>
	var E = window.wangEditor
	var editor = new E('#div1', '#div2') // 两个参数也可以传入 elem 对象，class 选择器
	//开启debug模式
	editor.customConfig.debug = true;
	// 关闭粘贴内容中的样式
	editor.customConfig.pasteFilterStyle = false
	// 忽略粘贴内容中的图片
	editor.customConfig.pasteIgnoreImg = true
	// 使用 base64 保存图片
	//editor.customConfig.uploadImgShowBase64 = true

	// 上传图片到服务器
	editor.customConfig.uploadFileName = 'myFile'; //设置文件上传的参数名称
	editor.customConfig.uploadImgServer = 'upload.do'; //设置上传文件的服务器路径
	editor.customConfig.uploadImgMaxSize = 3 * 1024 * 1024; // 将图片大小限制为 3M
	//自定义上传图片事件
	editor.customConfig.uploadImgHooks = {
		before : function(xhr, editor, files) {

		},
		success : function(xhr, editor, result) {
			console.log("上传成功");
		},
		fail : function(xhr, editor, result) {
			console.log("上传失败,原因是" + result);
		},
		error : function(xhr, editor) {
			console.log("上传出错");
		},
		timeout : function(xhr, editor) {
			console.log("上传超时");
		}
	}

	editor.create();
	
	document.getElementById('btn1').addEventListener('click', function () {
        // 读取 html
        alert(editor.txt.html())
    }, false)

    document.getElementById('btn2').addEventListener('click', function () {
        // 读取 text
        alert(editor.txt.text())
    }, false)
    
    $(function(){
    	$("#tj").click(function(){
    		var content = editor.txt.html();
    		$.ajax({
    			url : 'TextController',
    			type: 'post',
    			data: {'content':content},
    			dataType: 'json',
    			success: function(data){
    				if(data.status == 1){
    					alert(data.msg);
    				}
    			}
    		});
    	});
    })
</script>
</html>