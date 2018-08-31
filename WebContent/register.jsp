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

<title>注册——「考研宝」</title>

<link rel="stylesheet" href="<%=path%>/static/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=path%>/static/css/jquery.mCustomScrollbar.min.css" />
<link rel="stylesheet" href="<%=path%>/static/css/custom.css">
<link rel="stylesheet" href="<%=path%>/static/css/buttonStyle.css">
<link rel="shortcut icon" type="image/x-icon" href="<%=path%>/static/img/logo.ico" media="screen">
<link rel="stylesheet" href="<%=path%>/static/css/mystyle.css" type="text/css"  media="all">

</head>
<body>
<div class="register_box">
  	<div class="register" id="register">
      	<div class="register_logo"><img src="<%=path%>/static/img/login_logo.png" /></div>
      	<div class="register_name">
           	<p>注册</p>
      	</div>
      	<div class="register-warning-box">
      		<p class="register-warning" v-text="register_error"></p><!-- 提示错误信息 -->
      	</div>
      	<form action="/register/" method="post" id="register-form">
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
          	<dl class="register-item" style="margin-bottom: 15px;">
      		    <dt class="general-title register-item-tit">验证码:</dt>
      		    <dd class="register-item-ct">
      		    	<!-- {{ register_form.captcha }}
                	{{ active_form.captcha }} -->
      		    </dd>
			</dl>
          	<input value="注册" v-on:click="register" style="width:100%;" type="button">
      	</form>
      	<a href="" id="goToEmail" style="display: none;padding-top: 10px;text-align: center;color: black;">点击此处前往邮箱激活</a>
  	</div>
</div>

<script src="<%=path%>/static/js/jquery-3.3.1.min.js"></script>
<script src="<%=path%>/static/js/bootstrap.min.js"></script>
<script src="<%=path%>/static/js/vue.min.js"></script>
<script src="<%=path%>/static/js/sweetalert.js"></script>
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


</body>
</html>