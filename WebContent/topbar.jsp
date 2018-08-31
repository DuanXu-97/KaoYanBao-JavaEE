<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="com.kyb.model.*" %>  
<%
	String path1 = request.getContextPath();
	String basePath1 = request.getScheme() + "://"
	                + request.getServerName() + ":" + request.getServerPort()
	                + path1 + "/";
%>
    

    <div class="topbar">
	    <div class="wraper">
	        <div class="logo">
	    		<a href="index.jsp" ><img src="<%=path1%>/static/img/FullLOGO.png"></a>
	    	</div>
	        <div class="nav">
	            <ul class="parent">
	                <li><a href="index.jsp">首页</a><span class="lines"></span></li><!--跳转到首页-->
	                <% User user = (User)session.getAttribute("Username");
						if(user!=null){%>
	                <li><a href="QuestionQuery">错题回顾</a><span class="lines"></span></li><!--跳转到错题整理页面-->
	                <% } else { %>
	                <li><a style="cursor: pointer;" data-toggle="modal" data-target="#myModal">错题回顾</a><span class="lines"></span></li><!--跳转到错题整理页面-->
	                <% } %>
	                <li><a href="NewsQuery">资讯广场</a><span class="lines"></span></li><!--跳转到资讯页面-->
	                <li><a href="recommendQuestion.jsp">智能组题</a><span class="lines"></span></li><!--跳转到组卷页面-->

	                <%if(user!=null){%>
                        <li>
                        <a href="userCenter.jsp" title="个人中心"><i class="glyphicon glyphicon-user"></i><span class="lines"></span><%=user.getUsername()%></a>
                        <!--跳转到个人信息页面-->
                        </li>
	                    <li><a href="logout"><i class="glyphicon glyphicon-off" style="padding-right: 7px;top: 1.5px;"></i>注销</a></li><!--登出用户-->
                	<% } else { %>
             		    <li><a data-toggle="modal" data-target="#loginModal" style="cursor: pointer;"><i class="glyphicon glyphicon-log-in" style="padding-right: 7px;top: 1.5px;"></i>登陆</a><span class="lines"></span></li><!--跳转到登录页面-->
             		    <li><a data-toggle="modal" data-target="#registerModal" style="cursor: pointer;"><i class="glyphicon glyphicon-registration-mark" style="padding-right: 7px;top: 1.5px;"></i>注册</a><span class="lines"></span></li><!--跳转到注册页面-->
	               	<% } %>
	            </ul>
	        </div>
	    </div>
	</div>

	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  		<div class="modal-dialog" role="document">

			<div class="login_box">
			  	<div class="login" id="login">
			      	<div class="login_logo"><img src="<%=path1%>/static/img/login_logo.png" /></div>
			      	<div class="login_name">
			           	<p>登录</p>
			      	</div>
			      	<div class="login-warning-box">
			      		<p class="login-warning" v-text="login_error"></p><!-- 提示错误信息，如密码错误 -->
			      		<a href="/activateEmail/" id="goToActivatePage" style="display: none;">点击此处前往邮箱激活页面</a>
			      	</div>
			      	<form action="/login/" method="post" id="login-form">
			          	<input name="username" type="text" id="username" placeholder="用户名或邮箱">
			          	<input name="password" type="password" id="password" placeholder="密码">
			          	<input value="登录" v-on:click="login" style="width:100%;" type="button">
			      	</form>
			  	</div>
			</div>

		</div>
	</div>
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  		<div class="modal-dialog" role="document">

			<div class="register_box">
			  	<div class="register" id="register">
			      	<div class="register_logo"><img src="<%=path1%>/static/img/login_logo.png" /></div>
			      	<div class="register_name">
			           	<p>注册</p>
			      	</div>
			      	<div class="register-warning-box">
			      		<p class="register-warning" v-text="register_error"></p><!-- 提示错误信息 -->
			      	</div>
			      	<form method="post" id="register-form">
			      		<dl class="register-item">
			      		    <dt class="general-title register-item-tit">用户名:</dt>
			      		    <dd class="register-item-ct">
			          			<input name="username" type="text" v-model="username" maxlength="50" placeholder="输入用户名">	
			      		    </dd>
			      		</dl>
			      		<dl class="register-item">
			      		    <dt class="general-title register-item-tit">邮箱:</dt>
			      		    <dd class="register-item-ct">
								<input name="email" type="text" v-model="email" maxlength="50" placeholder="输入邮箱">      		
			      		    </dd>
						</dl>
						<dl class="register-item">
			      		    <dt class="general-title register-item-tit">密码:</dt>
			      		    <dd class="register-item-ct">
				          		<input name="password1" type="password" v-model="password1" maxlength="50" placeholder="输入密码">
			      		    </dd>
						</dl>
						<dl class="register-item">
			      		    <dt class="general-title register-item-tit">重复密码:</dt>
			      		    <dd class="register-item-ct">
				          		<input name="password2" type="password" v-model="password2" v-on:blur="judgeequal" maxlength="50" placeholder="重复密码">
			      		    </dd>
						</dl>
			          	
			          	<input value="注册" v-on:click="register" style="width:100%;margin-top: 15px;" type="button">
			      	</form>
			      	<a href="" id="goToEmail" style="display: none;padding-top: 10px;text-align: center;color: black;">点击此处前往邮箱激活</a>
			  	</div>
			</div>

		</div>
	</div>
	<script src="<%=path1%>/static/js/jquery-3.3.1.min.js"></script>
	<script src="<%=path1%>/static/js/vue.min.js"></script>
	<script src="<%=path1%>/static/js/sweetalert.js"></script>
	<script type="text/javascript">
		var hash={
	        'qq.com': 'http://mail.qq.com',
	        'gmail.com': 'http://mail.google.com',
	        'sina.com': 'http://mail.sina.com.cn',
	        '163.com': 'http://mail.163.com',
	        '126.com': 'http://mail.126.com',
	        'yeah.net': 'http://www.yeah.net/',
	        'sohu.com': 'http://mail.sohu.com/',
	        'tom.com': 'http://mail.tom.com/',
	        'sogou.com': 'http://mail.sogou.com/',
	        '139.com': 'http://mail.10086.cn/',
	        'hotmail.com': 'http://www.hotmail.com',
	        'live.com': 'http://login.live.com/',
	        'live.cn': 'http://login.live.cn/',
	        'live.com.cn': 'http://login.live.com.cn',
	        '189.com': 'http://webmail16.189.cn/webmail/',
	        'yahoo.com.cn': 'http://mail.cn.yahoo.com/',
	        'yahoo.cn': 'http://mail.cn.yahoo.com/',
	        'eyou.com': 'http://www.eyou.com/',
	        '21cn.com': 'http://mail.21cn.com/',
	        '188.com': 'http://www.188.com/',
	        'foxmail.coom': 'http://www.foxmail.com'
	    }
	</script>
	
	<script type="text/javascript">
		function refresh_captcha(){
		    $.get("/captcha/refresh/?"+Math.random(), function(result){
		        $("#register-form .captcha").attr("src",result.image_url);
		        $('#id_captcha_0').attr("value",result.key);
		    });
		    return false;
		}
	
		function validateEmail(email) {
			var re = /^[a-z0-9\.\-\_]+\@[a-z0-9\-\_]+(\.[a-z0-9\-\_]+){1,4}$/;
			return re.test(email.toLowerCase());
		}
	
		$(function () {
		    var vm_register = new Vue({
		        el: '#register',
		        data: {
		            username: '',
		            email: '',
		            password1: '',
		            password2: '',
		            register_error: ''
		        },
		        methods: {
		        	judgeequal:function () {
		        		if (this.password1 !== this.password2) {
		                    this.register_error = "两次密码不一致";
		                    return;
		                }
		        	},
		            register: function () {
		                if (! this.username.trim()) {
		                    this.register_error = "请输入用户名";
		                    return;
		                }
		                if (! validateEmail(this.email.trim().toLowerCase())) {
		                    this.register_error = "请输入正确的邮箱";
		                    return;
		                }
		                if (this.password1.length < 6) {
		                    this.register_error = "密码长度最少为6位";
		                    return;
		                }
		                if (this.password1 !== this.password2) {
		                    this.register_error = "两次密码不一致";
		                    return;
		                }
		                var email = this.email.trim().toLowerCase();
	
		            	$.ajax({
			                cache: false,
			                type: "POST",
			                url:"register",
			                data:$('#register-form').serialize(),
			                dateType:"json",
			                async: true,
			                success: function(data) {
			                    if(data.status == 'success'){
			                    	vm_register.register_error = '';
			                        swal ({
		                                icon: "success",
		                                text: "激活邮件已成功发送，请前往激活",
		                                type:"success"
		                            });
			                        var url = vm_register.email.split('@')[1];
			                        $("#goToEmail").attr("href",hash[url]);
			                        $("#goToEmail").css("display","inherit");
			                    }else if(data.status == 'fail'){
			                        vm_register.register_error = data.msg;
			                        //根据后端返回信息显示登录错误
			                    }
			                }
			            });
					}
	            }
	        });
		});
	</script>
	<script type="text/javascript"> 
	
		$(function(){ 
			$("#id_captcha_1").css("width","60%");
			$("#id_captcha_1").attr("placeholder","输入验证码");
			$("#register-form .captcha").css("cursor","pointer"); 
			$("#register-form .captcha").click(function(){
				refresh_captcha();
			});
		});
	
	</script> 
	