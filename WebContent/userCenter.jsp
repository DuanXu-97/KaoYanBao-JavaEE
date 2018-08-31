<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="com.kyb.model.*" %>  
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
                    + request.getServerName() + ":" + request.getServerPort()
                    + path + "/";
    String savePath = this.getServletContext().getRealPath("/WEB-INF/image");
%>
<%
//得到session
HttpSession hs=request.getSession(true);
String pass =(String)hs.getAttribute("pass");
if("user".equals(pass)){
	 %>
<% User u = (User)session.getAttribute("Username");
//System.out.println(u.getAvatarPath());
System.out.println(u.getAvatarPath());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>个人中心——「考研宝」</title>

<link rel="stylesheet" href="<%=path%>/static/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=path%>/static/css/jquery.mCustomScrollbar.min.css" />
<link rel="stylesheet" href="<%=path%>/static/css/custom.css">
<link rel="stylesheet" href="<%=path%>/static/css/buttonStyle.css">
<link rel="shortcut icon" type="image/x-icon" href="<%=path%>/static/img/logo.ico" media="screen">
<link rel="stylesheet" href="<%=path%>/static/css/mystyle.css" type="text/css"  media="all">
<link href="<%=path%>/static/css/cropper.min.css" rel="stylesheet">
<link href="<%=path%>/static/css/sitelogo.css" rel="stylesheet">
<link href="<%=path%>/static/css/bootstrap-datetimepicker.min.css" rel="stylesheet">

</head>
<body>
<%@include file="topbar.jsp"%>
	<div class="page-wrapper">
		<div class="page-content">
			<div class="container-fluid">
			
<div class="userCenter-wrapper userCenter">
	<div class="panel">
		<div class="userCenter-basic">
			<h4>个人账户</h4>
			<div class="divider-line"></div>
  			<div class="user-pic" data-toggle="modal" data-target="#avatar-modal">
				<img class="img-responsive img-rounded" src="<%=path%>/<%=u.getAvatarPath()%>" />
				<div class="mask mask-hidden userAvatarMask">
					<img class="img-responsive img-rounded" src="<%=path%>/static/img/avatarMask.png" style="display: none;"/> 
				</div>
			</div>
			
			<div class="basicInfo-list">
				<form  id="changePassword-form">
		      		<dl class="userCenter-item">
		      		    <dt class="general-title userCenter-item-tit">用户名:</dt>
		      		    <dd class="userCenter-item-ct">
		          			<input name="username" type="text" value='<%=u.getUsername() %>' maxlength="50" disabled>	
		      		    </dd>
		      		</dl>
		      		<dl class="userCenter-item">
		      		    <dt class="general-title userCenter-item-tit">邮箱:</dt>
		      		    <dd class="userCenter-item-ct">
		          			<input name="email" type="text" value='<%=u.getEmail() %>' maxlength="50" disabled>	
		      		    </dd>
		      		</dl>
		      		<dl class="userCenter-item">
		      		    <dt class="general-title userCenter-item-tit">密码:</dt>
		      		    <dd class="userCenter-item-ct">
		      		    	<input name="password" type="password" value='<%=u.getPassword() %>' maxlength="50" disabled style="width: auto;">
		          			<button type="button" class="btn btn-primary"  data-toggle="modal" data-target="#password-modal" style="margin-left: 20px;">修改密码</button>
		      		    </dd>
		      		</dl>
		      	</form>
			</div>
  		</div>
	</div>

	<div class="panel">
		<div class="userCenter-info" id="userCenter-info">
			<h4>个人信息</h4>
			<div class="divider-line"></div>
			<form  id="userCenter-form">
	      		<dl class="userCenter-item">
	      		    <dt class="general-title userCenter-item-tit">昵称:</dt>
	      		    <dd class="userCenter-item-ct">
	          			<input name="nickname" type="text" v-model="nickname" value="<%=u.getNickname() %>" maxlength="50">
	      		    </dd>
	      		</dl>
	      		<dl class="userCenter-item">
	      		    <dt class="general-title userCenter-item-tit">性别:</dt>
	      		    <dd class="userCenter-item-ct">
					   	<select class="form-control" id="gender" name="gender" value="<%=u.getGender() %>" v-model="gender" style="width: 20%;height: 40px;padding: 0 0 0 0;">
						    <option value="male">男</option>
						    <option value="female">女</option>
					    </select>
	      		    </dd>
				</dl>
				<dl class="userCenter-item">
	      		    <dt class="general-title userCenter-item-tit">生日:</dt>
	      		    <dd class="userCenter-item-ct">
		          		<input name="birthday" type="text"  readonly id="datetimepicker" class="form-control" value=
		          		'<% if(u.getBirthday() != null) { %><%= u.getBirthday() %> <%} else {%>1990-01-01<% }%>'>
	      		    </dd>
				</dl>
	          	<dl class="userCenter-item">
	      		    <dt class="general-title userCenter-item-tit">目前所在大学:</dt>
	      		    <dd class="userCenter-item-ct">
		          		<input name="presentCollege" type="text" v-model="presentCollege" maxlength="50" value="<%=u.getPresentCollege() %>">
	      		    </dd>
				</dl>
				<dl class="userCenter-item">
	      		    <dt class="general-title userCenter-item-tit">目标大学:</dt>
	      		    <dd class="userCenter-item-ct">
		          		<input name="targetCollege" type="text" v-model="targetCollege" maxlength="50" value="<%=u.getTargetCollege() %>">
	      		    </dd>
				</dl>
				<dl class="userCenter-item">
	      		    <dt class="general-title userCenter-item-tit">座右铭:</dt>
	      		    <dd class="userCenter-item-ct">
		          		<input name="motto" type="text" v-model="motto" maxlength="50" value="<%=u.getMotto() %>">
	      		    </dd>
				</dl>
	      	</form>
	      	<div class="userCenter-warning-box">
	      		<p class="userCenter-warning" v-text="userCenter_error"></p><!-- 提示错误信息 -->
	      	</div>
	      	<div style="text-align: left;padding-left: 10px;margin-top: 10px;">
				<button id="save-userCenter" v-on:click="saveUserCenter" class="btn btn-primary">保存</button>
			</div>

		</div>
	</div>
</div>


<div class="modal fade" id="password-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document" style="margin-top: 100px;">

		<div class="passwordChange_box">
		  	<div class="login" id="passwordChange">
		      	<div class="login_logo"><img src="<%=path%>/static/img/login_logo.png" /></div>
		      	<div class="login_name">
		           	<p>修改密码</p>
		      	</div>
		      	<div class="login-warning-box">
		      		<p class="login-warning" v-text="passwordChange_error"></p><!-- 提示错误信息，如密码错误 -->
		      	</div>
		      	<form method="post" id="passwordChange-form">
		          	<input name="previousPassword" type="password" v-model="previousPassword" id="previousPassword" placeholder="原密码">
		          	<input name="newPassword1" type="password" v-model="newPassword1" id="newPassword1" placeholder="新密码">
		          	<input name="newPassword2" type="password" v-model="newPassword2" id="newPassword2" v-on:blur="judgeequal" placeholder="重复新密码">
		          	<input value="提交" v-on:click="saveNewPassword" style="width:100%;" type="button">
		      	</form>
		  	</div>
		</div>

	</div>
</div>



<div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<form class="avatar-form">
				<div class="modal-header">
					<button class="close" data-dismiss="modal" type="button">&times;</button>
					<h4 class="modal-title" id="avatar-modal-label">上传图片</h4>
				</div>
				<div class="modal-body">
					<div class="avatar-body">
						<div class="avatar-upload">
							<input class="avatar-src" name="avatar_src" type="hidden">
							<input class="avatar-data" name="avatar_data" type="hidden">
							<label for="avatarInput" style="line-height: 35px;">图片上传</label>
							<button class="btn btn-info"  type="button" style="height: 35px;" onClick="$('input[id=avatarInput]').click();">请选择图片</button>
							<span id="avatar-name"></span>
							<input class="avatar-input hide" id="avatarInput" name="avatar_file" type="file"></div>
						<div class="row">
							<div class="col-md-9">
								<div class="avatar-wrapper"></div>
							</div>
							<div class="col-md-3">
								<div class="avatar-preview preview-lg" id="imageHead"></div>
							</div>
						</div>
						<div class="row avatar-btns">
							<div class="col-md-4">
								<div class="btn-group">
									<button class="btn btn-info fa fa-undo" data-method="rotate" data-option="-90" type="button" title="Rotate -90 degrees"> 向左旋转</button>
								</div>
								<div class="btn-group">
									<button class="btn  btn-info fa fa-repeat" data-method="rotate" data-option="90" type="button" title="Rotate 90 degrees"> 向右旋转</button>
								</div>
							</div>
							<div class="col-md-5" style="text-align: right;">
								<button class="btn btn-info glyphicon glyphicon-move" data-method="setDragMode" data-option="move" type="button" title="移动">
					            <span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="$().cropper(&quot;setDragMode&quot;, &quot;move&quot;)">
					            </span>
					          </button>
					          <button type="button" class="btn btn-info glyphicon glyphicon-zoom-in" data-method="zoom" data-option="0.1" title="放大图片">
					            <span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="$().cropper(&quot;zoom&quot;, 0.1)">
					              <!--<span class="fa fa-search-plus"></span>-->
					            </span>
					          </button>
					          <button type="button" class="btn btn-info glyphicon glyphicon-zoom-in" data-method="zoom" data-option="-0.1" title="缩小图片">
					            <span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="$().cropper(&quot;zoom&quot;, -0.1)">
					              <!--<span class="fa fa-search-minus"></span>-->
					            </span>
					          </button>
					          <button type="button" class="btn btn-info glyphicon glyphicon-refresh" data-method="reset" title="重置图片">
						            <span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="$().cropper(&quot;reset&quot;)" aria-describedby="tooltip866214">
						       </button>
					        </div>
							<div class="col-md-3">
								<button class="btn btn-info btn-block avatar-save glyphicon glyphicon-saved" type="button" data-dismiss="modal"> 保存修改</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
			
			</div>
		</div>
	</div>
	
	<script src="<%=path%>/static/js/jquery.min.js"></script>
    <script src="<%=path%>/static/js/bootstrap.min.js"></script>
    <script src="<%=path%>/static/js/vue.min.js"></script>
    <script src="<%=path%>/static/js/sweetalert.js"></script>
  	

    <script src="<%=path%>/static/js/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="<%=path%>/static/js/custom.js"></script>
	<script src="<%=path%>/static/js/cropper.js"></script>
	<script src="<%=path%>/static/js/sitelogo.js"></script>
	<script src="<%=path%>/static/js/html2canvas.min.js" charset="utf-8"></script>
	<script src="<%=path%>/static/js/bootstrap-datetimepicker.min.js"></script>
	<script src="<%=path%>/static/js/bootstrap-datetimepicker.zh-CN.js"></script>
	
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
			                url:"/login/",
			                data:$('#login-form').serialize(),
			                dateType:"json",
			                async: true,
			                success: function(data) {
			                    if(data.status == 'success'){
			                        window.location.href = data.url;//跳转到首页
			                    }else if(data.status == 'fail'){
			                        vm_login.login_error = data.msg;
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
		$(function(){
			$(".user-pic").mouseover(function(){
				$(".userAvatarMask").removeClass("mask-hidden");
				$(".userAvatarMask img").fadeIn();
			});
			$(".user-pic").mouseleave(function(){
				$(".userAvatarMask").addClass("mask-hidden");
				$(".userAvatarMask img").fadeOut();
			});
		});
	</script>

	<script type="text/javascript">
		$(function(){
			$('#datetimepicker').datetimepicker({
				startDate:'1990-1-1',
    			format: 'yyyy-mm-dd',
    			language:"zh-CN",
    			minView: "month",
    			autoclose: 1
			});
		});
	</script>

	<script type="text/javascript">

		$('#avatarInput').on('change', function(e) {
			var filemaxsize = 1024 * 5;//5M
			var target = $(e.target);
			var Size = target[0].files[0].size / 1024;
			if(Size > filemaxsize) {
				swal ({
                    icon: "error",
                    text: "图片过大，请重新选择!",
                    type:"error"
                });
				$(".avatar-wrapper").children().remove;
				return false;
			}
			if(!this.files[0].type.match(/image.*/)) {
				swal ({
                    icon: "error",
                    text: "请选择正确的图片!",
                    type:"error"
                });
			} else {
				var filename = document.querySelector("#avatar-name");
				var texts = document.querySelector("#avatarInput").value;
				var teststr = texts;
				testend = teststr.match(/[^\\]+\.[^\(]+/i); //直接完整文件名的
				filename.innerHTML = testend;
			}

		});

		$(".avatar-save").on("click", function() {
			var img_lg = document.getElementById('imageHead');
			// 截图小的显示框内的内容
			html2canvas(img_lg, {
				allowTaint: true,
				taintTest: false,
				onrendered: function(canvas) {
					canvas.id = "mycanvas";
					//生成base64图片数据
					var dataUrl = canvas.toDataURL("image/jpeg");
					var newImg = document.createElement("img");
					newImg.src = document.createElement("img");;
					imagesAjax(dataUrl);
					//$('.user-pic img').attr('src',dataUrl );//ajax成功之后删除此行
				}
			});
		})

		function imagesAjax(src) {
			var data = {};
			data.img = src;

			$.ajax({
				url: "upload_userpic",//这里路径根据后端修改
				data: data,
				type: "POST",
				dataType: 'json',
				success: function(result) {
					if(result.status == 'success') {
						$('.user-pic img').attr('src',src );
					}
				}
			});
		}
	</script>

	<script type="text/javascript">
		var vm_userCenter = new Vue({
        el: '#userCenter-info',
        data: {
            nickname: '<%= u.getNickname() %>',
            gender: '<%= u.getGender() %>',
            birthday: '',
            // 生日不用这里渲染，格式：'1990-08-15'
            presentCollege: '<%= u.getPresentCollege() %>',
            targetCollege: '<%= u.getTargetCollege() %>',
            motto: '<%= u.getMotto() %>',
            userCenter_error:''
        },
        methods: {
        	saveUserCenter:function(){
        		if(this.nickname.length > 5){
        			this.userCenter_error = "昵称不能大于5个字";
        			return;
        		}
        		else if(this.presentCollege.length > 30){
        			this.userCenter_error = "大学名称不能大于30个字";
        			return;
        		}
        		else if(this.targetCollege.length > 30){
        			this.userCenter_error = "大学名称不能大于30个字";
        			return;
        		}
        		else if(this.motto.length > 30){
        			this.userCenter_error = "座右铭不能大于30个字";
        			return;
        		}

        		else{
					$.ajax({
		                cache: false,
		                type: "POST",
		                url:"userCenter_compile",//这里路径根据后端修改
		                data:$('#userCenter-form').serialize(),
		                dateType:"json",
		                async: true,
		                success: function(data) {
		                    if(data.status == 'success'){
		                    	vm_userCenter.userCenter_error = '';
		                        swal ({
	                                icon: "success",
	                                text: "保存成功！",
	                                type:"success"
	                            });
		                    }else if(data.status == 'fail'){
		                        vm_userCenter.userCenter_error = data.msg;
		                        //根据后端返回信息显示保存错误
		                    }
		                }
		            });
        		}
        	}
        }
    });
	</script>

	<script type="text/javascript">
		//密码修改
		var vm_passwordChange = new Vue({
	        el: '#passwordChange',
	        data: {
	        	previousPassword:'',
	        	newPassword1:'',
	        	newPassword2:'',
	        	passwordChange_error:''
	        },
	        methods: {
	        	judgeequal:function () {
	        		if (this.newPassword1 !== this.newPassword2) {
	                    this.passwordChange_error = "两次密码不一致";
	                    return;
	                }
	        	},
	            saveNewPassword: function() {
	            	if (!this.previousPassword.trim()) {
	                    this.passwordChange_error = "请输入原密码";
	                    return;
	                }
	                else if (!this.newPassword1.trim()) {
	                    this.passwordChange_error = "请输入新密码";
	                    return;
	                }
	                else if (!this.newPassword2.trim()) {
	                    this.passwordChange_error = "请再次输入新密码";
	                    return;
	                }
	            	else if (this.newPassword1 !== this.newPassword2) {
	                    this.passwordChange_error = "两次密码不一致";
	                    return;
	                }
					else if (this.newPassword1.length < 6){
						this.passwordChange_error = "密码长度需大于6位";
						return;
					}
					else{
						
		            	$.ajax({
			                cache: false,
			                type: "POST",
			                url:"passwordChange",
			                data:$('#passwordChange-form').serialize(),
			                dateType:"json",
			                async: true,
			                success: function(data) {
			                    if(data.status == 'success'){
			                    	swal ({
		                                icon: "success",
		                                text: "密码修改成功！",
		                                type:"success"
		                            });
			                        window.location.href = 'userCenter.jsp';//跳转到首页
			                    }else if(data.status == 'fail'){
			                        vm_passwordChange.passwordChange_error = data.msg;
			                    }
			                },
			            });
					}
	            }
	        }
    	});
	</script>

</body>
</html>
<% }else{
	response.sendRedirect("index.jsp");return;}
%>