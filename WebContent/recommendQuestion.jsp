<%@page import="com.kyb.Dao.TagDao"%>
<%@page import="com.kyb.service.RecommendQuestionService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import ="com.kyb.model.*" %>  
<%@ page import ="com.kyb.Dao.QuestionDao.*" %> 
<%@ page import ="com.kyb.service.RecommendQuestionService.*" %> 
<%@ page import ="java.util.*" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
                    + request.getServerName() + ":" + request.getServerPort()
                    + path + "/";
%>
<% User u = (User)session.getAttribute("Username");%>
<%RecommendQuestionService RQS = new RecommendQuestionService(); %>
<% 
	List <Question> libRecommendQuestionList = RQS.recommend_lib_Question(u.getId()); 
    List <Question> shareRecommendQuestionList = RQS.recommend_share_Question(u.getId()); 
	List <Question> relationRecommendQuestionList = RQS.recommend_relation_Question(u.getId()); 
%>
<% TagDao TD = new TagDao( ); %>

<!DOCTYPE html>
<html>
<head>；
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>智能组题——「考研宝」</title>

<link rel="stylesheet" href="<%=path%>/static/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=path%>/static/css/jquery.mCustomScrollbar.min.css" />
<link rel="stylesheet" href="<%=path%>/static/css/custom.css">
<link rel="stylesheet" href="<%=path%>/static/css/buttonStyle.css">
<link rel="shortcut icon" type="image/x-icon" href="<%=path%>/static/img/logo.ico" media="screen">
<link rel="stylesheet" href="<%=path%>/static/css/mystyle.css" type="text/css"  media="all">
<link rel="stylesheet" type="text/css" href="<%=path%>/static/css/introBox.css">

</head>
<body>
<%@include file="topbar.jsp"%>
	<div class="page-wrapper">
		<div class="page-content">
			<div class="container-fluid">
			
			
			<div class="loader">
				<div id="center">
				  	<img src="<%=path%>/static/img/FullLOGO.png" width="250" alt="">
				  	<div class="skype-loader">
					    <div class="dot">
					      	<div class="first"></div>
					    </div>
					    <div class="dot"></div>
					    <div class="dot"></div>
					    <div class="dot"></div>
				  	</div>
					  组题中...
				</div>
			</div>
			
			<div class="recommendQuestion">
				<div class="row">
					<div class="col-md-9">
						<div class="rq-header">
							<div class="btn-column-group">
								<button class="btn btn-column column-active" id="btn-column-quesLib">题库推荐</button>
								<button class="btn btn-column" id="btn-column-quesShare">共享推荐</button>
								<button class="btn btn-column" id="btn-column-quesRelation">关联推荐</button>
							</div>
						</div>
						<div class="fly-panel rq-list">
							<div class="title">
								<i></i>
								<h4>题库推荐</h4>
							</div>
		
							<!-- 题库推荐 -->
							<div class="rq-content-warpper rq-quesLib"><!-- rq是recommendQusetion的缩写 -->						
								<% if( libRecommendQuestionList.size() ==0 ) {%>
									<h4 style="text-align: center;color: #969696;">实在抱歉，无法找到适合您的题目</h4>
								<% } else { %>
									<% for( Question rq:libRecommendQuestionList ) {%>
									<div class="rq-id rq-content-<%=rq.getId() %>">
										<div class="dashed-line"></div>
										<div class="rq-title">
											<!-- 题目 -->
											<h5></h5>
											<input type="hidden" class="receive" value='<%=rq.getTitle() %>' >
										</div>
										<div class="btn-content-group">
											<ul class="tag-area col-md-10">
												<div class="tag-added"> <!-- 题目原有标签 -->
													
													<% List<Tag> tagList = TD.QueryTagByQuestionId(rq.getId()); %>					
						                    		<% for(Tag t:tagList){ %>
													<li class="tag rq-lib tag-content-<%=t.getId() %>">
														<a href="##"><%=t.getName() %></a>
														<div class="tag-btn-area">
															<i class="glyphicon glyphicon-thumbs-up tag-btn tag-btn-thumbsup" title="赞"></i>
															<i class="glyphicon glyphicon-thumbs-down tag-btn tag-btn-thumbsdown" title="踩"></i>
															<% if(t.getScore() < 10) {%>
																<i class="glyphicon glyphicon-remove tag-btn tag-btn-remove" title="删除"></i>
															<% } %>
														</div>
													</li>
													<% } %>
												</div>
												<div class="btn-addTags" title="添加标签">
													<i class="glyphicon glyphicon-plus"></i>
												</div>
												<div class="tag-inputBox">
													<input class="input-tag" type="text" placeholder="请输入标签">
													<input class="hidden-tags" type="text" name="tags" hidden>
													<i class="glyphicon glyphicon-ok save-tag" title="保存"></i>
												</div>
											</ul>
											<button class="rq-answer-btn">查看答案<i class="glyphicon glyphicon-chevron-down" style="padding-left: 5px"></i></button>
										</div>
										
										<div class="rq-answer" style="display: none;">
											<p></p>
											<input type="hidden" class="receive" value='<%=rq.getAnswer() %>' >
										</div>
									</div>
									<% } %>
		
									<div class="dashed-line"></div><!-- 结尾虚线 -->
								<% } %>
							</div>
		
		
							<!-- 共享推荐 -->
							<div class="rq-content-warpper rq-quesShare" style="display: none;">
								<% if( shareRecommendQuestionList.size() ==0 ) {%>
									<h4 style="text-align: center;color: #969696;">实在抱歉，无法找到适合您的题目</h4>
								<% } else { %>
									<% for( Question rq:shareRecommendQuestionList ) {%>
									<div class="rq-id rq-content-<%=rq.getId() %>">
										<div class="dashed-line"></div>
										<div class="rq-title">
											<h5></h5>
											<input type="hidden" class="receive" value='<%=rq.getTitle() %>' >
										</div>
										<div class="btn-content-group">
											<ul class="tag-area col-md-10">
												<div class="tag-added"><!-- 题目原有标签 -->
													<% List<Tag> tagList = TD.QueryTagByQuestionId(rq.getId()); %>					
						                    		<% for(Tag t:tagList){ %>
													<li class="tag rq-lib">
														<a href="##"><%=t.getName() %></a>
													</li>
													<% } %>
												</div>
											</ul>
											<button class="rq-answer-btn">查看答案<i class="glyphicon glyphicon-chevron-down" style="padding-left: 5px"></i></button>
										</div>
										
										<div class="rq-answer" style="display: none;">
											<p></p>
											<input type="hidden" class="receive" value='<%=rq.getAnswer() %>' >
										</div>
									</div>
									<% } %>
		
								
									<div class="dashed-line"></div><!-- 结尾虚线 -->
								<% } %>
								
							</div>
		
		
							<!-- 关联推荐 -->
							<div class="rq-content-warpper rq-quesRelation" style="display: none;">
								<% if( relationRecommendQuestionList.size() ==0 ) {%>
									<h4 style="text-align: center;color: #969696;">实在抱歉，无法找到适合您的题目</h4>
								<% }else{ %>
									<% for( Question rq:relationRecommendQuestionList ) {%>
									<div class="rq-id rq-content-<%=rq.getId() %>">
										<div class="dashed-line"></div>
										<div class="rq-title">
											<h5></h5>
											<input type="hidden" class="receive" value='<%=rq.getTitle() %>'>
										</div>
										<div class="btn-content-group">
											<ul class="tag-area col-md-10">
												<div class="tag-added"><!-- 题目原有标签 -->
													<% List<Tag> tagList = TD.QueryTagByQuestionId(rq.getId()); %>					
						                    		<% for(Tag t:tagList){ %>
													<li class="tag rq-lib">
														<a href="##"><%=t.getName() %></a>
													</li>
													<% } %>
												</div>
											</ul>
											<button class="rq-answer-btn">查看答案<i class="glyphicon glyphicon-chevron-down" style="padding-left: 5px"></i></button>
										</div>
										
										<div class="rq-answer" style="display: none;">
											<p></p>
											<input type="hidden" class="receive" value='<%=rq.getAnswer() %>' >
										</div>
									</div>
									<% } %>
		
								
									<div class="dashed-line"></div><!-- 结尾虚线 -->
								<% } %>
								
							</div>
		
							
						</div>
					</div>
		
					<!-- 这块是前端写死的内容 -->
					<div class="col-md-3" style="padding: 0px;">
						<div class="fly-panel right-bar">
							<div class="demo" onselectstart="return false;">
					            <div class="demo__close-menu"></div>
					            <div class="demo__section demo__section-1 active" data-section="1">
					                <div class="demo__menu-btn"></div>
					                <h2 class="demo__section-heading">关于标签</h2>
					                <p>本平台使用标签系统来为您推荐和匹配题目，所以在添加错题时，我们鼓励您添加为题目标签来说明题目的内容，并为其他用户带来方便</p>
					                <div class="divider-line"></div>
					            </div>
					            <div class="demo__section demo__section-2 inactive" data-section="2">
					                <div class="demo__menu-btn"></div>
					                <h2 class="demo__section-heading">关于标签规范</h2>
					                <p>在添加标签时，请尽量将题目的考点或题目中的名词术语作为标签内容，例如"分段函数""高斯分布"等，请尽量不要加入过于口语化或者过于抽象的标签。</p>
					                <div class="divider-line"></div>
					            </div>
					        </div> 
						</div>
					</div>
					<!-- -->
		
				</div>
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

<script type="text/javascript" src='/static/js/stopExecutionOnTimeout.js?t=1'></script>
<script type="text/javascript">
	$(function(){
	
		<% for( Question rq:libRecommendQuestionList ) {%>
	   		var info1 = $(".rq-quesLib .rq-content-<%=rq.getId() %> .rq-title input").val();
		    $(".rq-quesLib .rq-content-<%=rq.getId() %> .rq-title h5").html(info1);
		    var info2 = $(".rq-quesLib .rq-content-<%=rq.getId() %> .rq-answer input").val();
		    $(".rq-quesLib .rq-content-<%=rq.getId() %> .rq-answer p").html(info2);
	    <% } %>
	
	   	<% for( Question rq:shareRecommendQuestionList ) {%>
	   		var info1 = $(".rq-quesShare .rq-content-<%=rq.getId() %> .rq-title input").val();
		    $(".rq-quesShare .rq-content-<%=rq.getId() %> .rq-title h5").html(info1);
		    var info2 = $(".rq-quesShare .rq-content-<%=rq.getId() %> .rq-answer input").val();
		    $(".rq-quesShare .rq-content-<%=rq.getId() %> .rq-answer p").html(info2);
	    <% } %>
	
	   	<% for( Question rq:relationRecommendQuestionList ) {%>
	   		var info1 = $(".rq-quesRelation .rq-content-<%=rq.getId() %> .rq-title input").val();
		    $(".rq-quesRelation .rq-content-<%=rq.getId() %> .rq-title h5").html(info1);
		    var info2 = $(".rq-quesRelation .rq-content-<%=rq.getId() %> .rq-answer input").val();
		    $(".rq-quesRelation .rq-content-<%=rq.getId() %> .rq-answer p").html(info2);
	    <% } %>
	
	   	setTimeout(function(){
	   		$('.loader').fadeOut();
	   	},1500)
	   	
	});
</script>

<script type="text/javascript">
   	var vm_rq = new Vue({
   		el:'.rq-list',
   		data:{
   			AmountofRqLibItem : 0,
   			AmountofRqShareItem : 0,
   			AmountofRqRelationItem : 0
   		},
   		methods:{
   			initial:function(){
   				<% for( Question rq:libRecommendQuestionList ) {%>
					this.AmountofRqLibItem++;
					//给题库推荐中题目编号
					$(".rq-quesLib .rq-content-<%=rq.getId() %> h5").html('<p>'+this.AmountofRqLibItem+'、</p>'+$(".rq-quesLib .rq-content-<%=rq.getId() %> h5").html());
				<% } %>

				<% for( Question rq:shareRecommendQuestionList ) {%>
					this.AmountofRqShareItem++;
					//给共享推荐中题目编号
					$(".rq-quesShare .rq-content-<%=rq.getId() %> h5").html('<p>'+this.AmountofRqShareItem+'、</p>'+$(".rq-quesShare .rq-content-<%=rq.getId() %> h5").html());
				<% } %>

				<% for( Question rq:relationRecommendQuestionList ) {%>
					this.AmountofRqRelationItem++;
					//给共享推荐中题目编号
					$(".rq-quesRelation .rq-content-<%=rq.getId() %> h5").html('<p>'+this.AmountofRqRelationItem+'、</p>'+$(".rq-quesRelation .rq-content-<%=rq.getId() %> h5").html());
				<% } %>

   			}
   		}

   	});

   	$(function(){
		vm_rq.initial();
   	});

   </script>
   <script type="text/javascript">
		$(function(){
			//顶部导航栏
			$(".btn-column").mousedown(function(){
				$this = $(this);
				$('.btn-column').removeClass('column-active');
				$this.addClass('column-active');
				$(".title h4").text($this.text());
				if($this.text()==='题库推荐'){
					$(".rq-quesRelation").hide();
					$(".rq-quesShare").hide();
					$(".rq-quesLib").show();
				}
				else if($this.text()==='共享推荐'){
					$(".rq-quesRelation").hide();
					$(".rq-quesLib").hide();
					$(".rq-quesShare").show();
				}
				else{
					$(".rq-quesLib").hide();
					$(".rq-quesShare").hide();
					$(".rq-quesRelation").show();
				}
			});

			//“查看答案”按钮
			$('.rq-answer-btn').click(function(){
				$this = $(this);
				var rqid = $this.closest('.rq-id').attr("class").split(' ')[1].split('-')[2];
				$thisrq = $this.closest('.rq-id');
				if($thisrq.children('.rq-answer').hasClass('showed')){
					$thisrq.children('.rq-answer').fadeOut(200);
					$thisrq.children('.rq-answer').removeClass('showed');
				}
				else{
					$thisrq.children('.rq-answer').fadeIn();
					$thisrq.children('.rq-answer').addClass('showed');
				}
				
			});
		});

	</script>
	
	<script type="text/javascript">
		//标签相关的操作
	    var originWidth = 0;//测试用

	    function renderTagsBtn(){
	    	$(".glyphicon-thumbs-up").mousedown(function(){
	    		$this = $(this);
	    		if($this.next('.glyphicon-thumbs-down').hasClass('clicked')) return;
	    		else if($this.hasClass('clicked')){//取消点赞
	    			$.ajax({
		                cache: false,
		                type: "POST",
		                url:"thumbs",
		                data: {
		                	type : "thumbsUp",
		                	action : "cancel",
		                	rqid : $this.closest('.rq-id').attr("class").split(' ')[1].split('-')[2],
		                	tagid : $this.closest('.tag').attr("class").split(' ')[2].split('-')[2]
		                },
		                dateType:"json",
		                async: true,
		                success: function(data) {
		                    if(data.status == 'success'){
		                        $this.css("color","black");
    							$this.removeClass('clicked');
		                    }else if(data.status == 'fail'){
		                       	swal ({
								 	icon: "error",
								 	text: data.msg,
							 	});
		                    }
		                }
			        });
	    		}
	    		else{//点赞
	    			$.ajax({
		                cache: false,
		                type: "POST",
		                url:"thumbs",
		                data: {
		                	type : "thumbsUp",
		                	action : "confirm",
		                	rqid : $this.closest('.rq-id').attr("class").split(' ')[1].split('-')[2],
		                	tagid : $this.closest('.tag').attr("class").split(' ')[2].split('-')[2]
		                },
		                dateType:"json",
		                async: true,
		                success: function(data) {
		                    if(data.status == 'success'){
				    			$this.css("color","#3d79e5");
				    			$this.addClass('clicked');
		                    }else if(data.status == 'fail'){
		                       	swal ({
								 	icon: "error",
								 	text: data.msg,
							 	});
		                    }
		                }
			        });
	    		}
	    	});

	    	$(".glyphicon-thumbs-down").mousedown(function(){
	    		$this = $(this);
	    		if($this.prev('.glyphicon-thumbs-up').hasClass('clicked')) return;
	    		else if($this.hasClass('clicked')){//取消点踩
	    			$.ajax({
		                cache: false,
		                type: "POST",
		                url:"thumbs",
		                data: {
		                	type : "thumbsDown",
		                	action : "cancel",
		                	rqid : $this.closest('.rq-id').attr("class").split(' ')[1].split('-')[2],
		                	tagid : $this.closest('.tag').attr("class").split(' ')[2].split('-')[2]
		                },
		                dateType:"json",
		                async: true,
		                success: function(data) {
		                    if(data.status == 'success'){
				    			$this.css("color","black");
				    			$this.removeClass('clicked');
		                    }else if(data.status == 'fail'){
		                       	swal ({
								 	icon: "error",
								 	text: data.msg,
							 	});
		                    }
		                }
			        });
	    		}
	    		else{//点踩
	    			$.ajax({
		                cache: false,
		                type: "POST",
		                url:"thumbs",
		                data: {
		                	type : "thumbsDown",
		                	action : "confirm",
		                	rqid : $this.closest('.rq-id').attr("class").split(' ')[1].split('-')[2],
		                	tagid : $this.closest('.tag').attr("class").split(' ')[2].split('-')[2]
		                },
		                dateType:"json",
		                async: true,
		                success: function(data) {
		                    if(data.status == 'success'){
				    			$this.css("color","#3d79e5");
	    						$this.addClass('clicked');
		                    }else if(data.status == 'fail'){
		                       	swal ({
								 	icon: "error",
								 	text: data.msg,
							 	});
		                    }
		                }
			        });
	    		}

	    	});

	        $(".tag").mouseenter(function(){
	            originWidth = $(this).width();
	            $this = $(this);
	            $this.css("border","1px solid #3d79e5");
	            if($this.hasClass('rq-lib'))
	            {
	            	$this.stop(true, false).animate({"width":$(this).width()+60});
	            }
	            else
	            {
	            	$this.stop(true, false).animate({"width":$(this).width()+30});
	            }
	            $this.children(".tag-btn-area").fadeIn();
	        });

	        $(".tag").mouseleave(function(){
	        	$this = $(this);
	            $this.css("border","1px solid #bebebe");
	            $this.children(".tag-btn-area").fadeOut(150);
	            $this.stop(true, false).animate({"width":originWidth+22});
	        });

	        $(".tag-btn-remove").click(function(){
	        	$this = $(this);
	        	$.ajax({	
	                cache: false,
	                type: "POST",
	                url:"removeTagtoQues",
	                data: {
	                	rqid : $this.closest('.rq-id').attr("class").split(' ')[1].split('-')[2],
		                tag : $this.closest('.tag').find("a").text()
	                },
	                dateType:"json",
	                async: true,
	                success: function(data) {
	                    if(data.status == 'success'){
	                    	
			    			$this.parent().parent().remove();
	            			$this.closest('.tag-area').find(".hidden-tags").val($(".hidden-tags").val().replace("_"+$(this).parent().parent().children("a").text(),""));

	                    }else if(data.status == 'fail'){
	                       	swal ({
							 	icon: "error",
							 	text: data.msg,
						 	});
	                    }
	                }
	        	});
	        });
	    }
	    
	    function renderAddQuesBtns(){
	        $(".btn-addTags i").click(function(){//点击添加标签时
	        	$this = $(this);
	        	$thisrq = $this.closest('.rq-id');
	            $thisrq.find(".btn-addTags").hide();
	            $thisrq.find(".input-tag").show().animate({"width":"150px","opacity":"100"});
	            $thisrq.find(".save-tag").fadeIn(100);
	            $thisrq.find(".input-tag").focus();
	        });

	        renderTagsBtn();

	        $(".input-tag").blur(function(){//输入框失去焦点时取消添加标签
	        	$this = $(this);
	        	$thisrq = $this.closest('.rq-id');
	            $thisrq.find(".save-tag").fadeOut(100,function(){
	                $thisrq.find(".input-tag").animate({"width":"23px","opacity":"0"},function(){
	                    $thisrq.find(".input-tag").hide();
	                    $thisrq.find(".btn-addTags").show();
	                });
	            });
	        });

	        $(".save-tag").click(function(){//点击保存标签时
	        	$this = $(this);
	        	$thisrq = $this.closest('.rq-id');
	            if($thisrq.find(".input-tag").val()){
	                var reStr = '(_'+$thisrq.find(".input-tag").val()+'$|_'+$thisrq.find(".input-tag").val()+'_)';
	                var reg = new RegExp(reStr);
	                if($thisrq.find(".hidden-tags").val().match(reg)) {
	                    swal ({
	                        icon: "error",
	                        text: "已经输入此标签",
	                    });
	                }
	                else{
	                	$.ajax({
			                cache: false,
			                type: "POST",
			                url:"addTagtoQues",
			                data: {
			                	rqid : $this.closest('.rq-id').attr("class").split(' ')[1].split('-')[2],
		                		tag : $thisrq.find(".input-tag").val()
			                },
			                dateType:"json",
			                async: true,
			                success: function(data) {
			                    if(data.status == 'success'){

					    			$thisrq.find(".hidden-tags").val($thisrq.find(".hidden-tags").val() + '_' + $thisrq.find(".input-tag").val());
				                    $thisrq.find(".save-tag").fadeOut(100,function(){
				                        $thisrq.find(".tag-added").append('<li class="tag"><a href="##">'
				                            + $thisrq.find(".input-tag").val()
				                            +'</a><div class="tag-btn-area"><i class="glyphicon glyphicon-remove tag-btn tag-btn-remove" title="删除"></i></div></li>');
				                        $thisrq.find(".input-tag").animate({"width":"23px","opacity":"0"},function(){
				                            $thisrq.find(".input-tag").hide();
				                            $thisrq.find(".btn-addTags").show();
				                            $thisrq.find(".input-tag").val("");
				                        });
				                        renderTagsBtn();
				                    });

			                    }else if(data.status == 'fail'){
			                       	swal ({
									 	icon: "error",
									 	text: data.msg,
								 	});
			                    }
			                }
			        	});
	                }
	            }
	        });

	        $(".input-tag").keyup(function(event){//回车保存标签
	            if(event.keyCode ==13){
	            	$this = $(this);
	        		$thisrq = $this.closest('.rq-id');
	                if($thisrq.find(".input-tag").val()){
	                    var reStr = '(_'+$thisrq.find(".input-tag").val()+'$|_'+$thisrq.find(".input-tag").val()+'_)';
	                    var reg = new RegExp(reStr);
	                    if($thisrq.find(".hidden-tags").val().match(reg)) {
	                        swal ({
	                            icon: "error",
	                            text: "已经输入此标签",
	                        });
	                    }
	                    else{
	                    	$.ajax({	//这个ajax与上面的功能相同
				                cache: false,
				                type: "POST",
				                url:"addTagtoQues",
				                data: {
				                	rqid : $this.closest('.rq-id').attr("class").split(' ')[1].split('-')[2],
		                			tag : $thisrq.find(".input-tag").val()
				                },
				                dateType:"json",
				                async: true,
				                success: function(data) {
				                    if(data.status == 'success'){
				                    	
						    			$thisrq.find(".hidden-tags").val($thisrq.find(".hidden-tags").val() + '_' + $thisrq.find(".input-tag").val());
					                    $thisrq.find(".save-tag").fadeOut(100,function(){
					                        $thisrq.find(".tag-added").append('<li class="tag"><a href="##">'
					                            + $thisrq.find(".input-tag").val()
					                            +'</a><div class="tag-btn-area"><i class="glyphicon glyphicon-remove tag-btn tag-btn-remove" title="删除"></i></div></li>');
					                        $thisrq.find(".input-tag").animate({"width":"23px","opacity":"0"},function(){
					                            $thisrq.find(".input-tag").hide();
					                            $thisrq.find(".btn-addTags").show();
					                            $thisrq.find(".input-tag").val("");
					                        });
					                        renderTagsBtn();
					                    });

				                    }else if(data.status == 'fail'){
				                       	swal ({
										 	icon: "error",
										 	text: data.msg,
									 	});
				                    }
				                }
				        	});
	                    }
	                }
	            }
	        });
	    }

	    $(function(){
	    	renderAddQuesBtns();
	    });
	</script>
	<script type="text/javascript">
		//右边栏标签说明
		$(document).ready(function () {
		    var $demo = $('.demo');
		    var numOfSections = $('.demo__section').length;
		    $(document).on('click', '.demo__menu-btn', function () {
		        $demo.addClass('menu-active');
		    });
		    $(document).on('click', '.demo__close-menu', function () {
		        $demo.removeClass('menu-active');
		    });
		    $(document).on('click', '.demo.menu-active .demo__section', function () {
		        var $section = $(this);
		        var index = +$section.data('section');
		        $('.demo__section.active').removeClass('active');
		        $('.demo__section.inactive').removeClass('inactive');
		        $section.addClass('active');
		        $demo.removeClass('menu-active');
		        for (var i = index + 1; i <= numOfSections; i++) {
		            if (window.CP.shouldStopExecution(1)) {
		                break;
		            }
		            $('.demo__section[data-section=' + i + ']').addClass('inactive');
		        }
		        window.CP.exitedLoop(1);
		    });
		});
	</script>
			

</body>
</html>