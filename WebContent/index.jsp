<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
                    + request.getServerName() + ":" + request.getServerPort()
                    + path + "/";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>首页——「考研宝」</title>

<link rel="stylesheet" href="<%=path%>/static/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=path%>/static/css/jquery.mCustomScrollbar.min.css" />
<link rel="stylesheet" href="<%=path%>/static/css/custom.css">
<link rel="stylesheet" href="<%=path%>/static/css/buttonStyle.css">
<link rel="shortcut icon" type="image/x-icon" href="<%=path%>/static/img/logo.ico" media="screen">
<link rel="stylesheet" href="<%=path%>/static/css/mystyle.css" type="text/css"  media="all">

</head>
<body>
<%@include file="topbar.jsp"%>
	<div class="page-wrapper">
		<div class="page-content">
			<div class="container-fluid">
				<div class="index">
					<div class="first-block">
						<div class="text-banner">
							<div class="text-container">	
									<h1>考研宝</h1>
									<br/>
									<h5>基于数据挖掘的轻量化考研复习平台</h5>
							</div>
							
						</div>
						<div class="img-container">
							<img src="<%=path%>/static/img/MG.png">
							
						</div>
					</div>
				
					<div class="solution-list second-block">
						<div class="text-container">	
							<h1>三大模块 助力考研</h1>
							<br/>
							<h1>Three Main Modules</h1>
						</div>
						<div class="divider-line"></div>
						<ul id="solutionList" class="clearfix">
							<li>
								<div class="solution-item-wrapper solution-item-01">
									<p class="solution-title">错题回顾</p>
									<div class="short-bar"></div>
									<p class="solution-intro">在这里，你可以在线记录错题，回顾错题，分享错题。把错题看做是一种资源是对经验的总结升华。</p>
									<a href="questionList.jsp">查看详情</a>
								</div>
							</li>
						
							<li  class="active">
								<div class="solution-item-wrapper solution-item-03">
									<p class="solution-title">智能组题</p>
									<div class="short-bar"></div>
									<p class="solution-intro">在这里，你可以获得通过分析你的错题记录进而为你智能地推荐的题目，针对你的薄弱点进行有针对性的练习。</p>
									<a href="recommendQuestion.jsp">查看详情</a>
								</div>
							</li>
							<li>
								<div class="solution-item-wrapper solution-item-04">
									<p class="solution-title">资讯广场</p>
									<div class="short-bar"></div>
									<p class="solution-intro">在这里，你可以第一时间了解到考研资讯，从此拒绝错过关键时间点，为考研保驾护航、助力远航。</p>
									<a href="/hot_spot/">查看详情</a>
								</div>
							</li>
						</ul>
						<div class="divider-line"></div>
					</div>
					<footer>
						<p>Powered by 计设考研宝项目组. Copyright © 2018. All rights reserved.</p>
					</footer>
				</div>
			</div>
		</div>
	</div>
	<script src="<%=path%>/static/js/jquery-3.3.1.min.js"></script>
    <script src="<%=path%>/static/js/bootstrap.min.js"></script>
    <script src="<%=path%>/static/js/vue.min.js"></script>
    <script src="<%=path%>/static/js/sweetalert.js"></script>
  	

    <script src="<%=path%>/static/js/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="<%=path%>/static/js/custom.js"></script>
	
	<script type="text/javascript">
		var vm_login = new Vue({
	        el: '#login',
	        data: {
	        	login_error:''
	        },
	        methods: {
	            login: function() {
			        if($(".login #username").val() === "" && $(".login #password").val() === ""){
			        	this.login_error = "请输入用户名和密码";
					}
					else if($(".login #username").val() === ""){
						this.login_error = "请输入用户名";
					}
					else if($(".login #password").val() === ""){
						this.login_error = "请输入密码";
					}
					else{
						
		            	$.ajax({
			                cache: false,
			                type: "POST",
			                url:"login",
			                data:$('#login-form').serialize(),
			                dateType:"json",
			                async: true,
			                success: function(data) {
			                    if(data.status == 'success'){
			                        window.location.href = data.url;//跳转到首页
			                    }else if(data.status == 'fail'){
			                        vm_login.login_error = data.msg;
			                        if(data.msg === "用户未激活, 请先激活用户"){
			                        	$("#goToActivatePage").css("display","inline-block");
			                        }
			                        //根据后端返回信息显示登录错误
			                    }
			                }
			            });
					}
	            }
	        }
    	});
	</script>
	
	
	<script type="text/javascript">
	$(document).ready(function(){
		
		var b = $("#solutionList li");
		b.mouseover(function() {
			var e = $(this);
			b.removeClass("active");
			e.addClass("active")
		});

	});
	</script>
</body>
</html>