<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import ="com.kyb.model.*" %>  
<%@ page import ="com.kyb.Dao.*" %> 
<%@ page import ="java.util.*" %>
<%@ page import = "javax.servlet.http.HttpSession" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
                    + request.getServerName() + ":" + request.getServerPort()
                    + path + "/";
%>

<%User u = (User)request.getSession().getAttribute("Username");%>
<%TagDao TD = new TagDao( ); %>
<% 
	List<Question> questionList = new ArrayList<Question>();
	questionList = (List<Question>)request.getAttribute("questionList"); 
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>错题回顾——「考研宝」</title>

<link rel="stylesheet" href="<%=path%>/static/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=path%>/static/css/jquery.mCustomScrollbar.min.css" />
<link rel="stylesheet" href="<%=path%>/static/css/custom.css">
<link rel="stylesheet" href="<%=path%>/static/css/buttonStyle.css">
<link rel="shortcut icon" type="image/x-icon" href="<%=path%>/static/img/logo.ico" media="screen">
<link rel="stylesheet" href="<%=path%>/static/css/mystyle.css" type="text/css"  media="all">
<link rel="stylesheet" type="text/css" href="<%=path%>/static/css/introBox.css">
<style>
.presentPage{
	color:black!important;
	background-color: transparent!important;
	cursor: initial;
}
</style>

</head>
<body>
<%@include file="topbar.jsp"%>
	<div class="page-wrapper">
		<div class="page-content">
			<div class="container-fluid">
				<div class="questionPage-wrapper row">
					<div class="question-area col-md-9">
						<div class="queslist-wraper">
					        <div id="question-holder" class="content detail">
					            <div class="saved-question">
					
					            <% for(Question q:questionList){ %>
						           
						            <div class="fly-panel detail-box" >
						                <div class="questitle-line ques-category-<%=q.getCategory() %>"></div>
						                <p class="general-title" style="display: inline-block;">题目：</p>
						                <i class="glyphicon glyphicon-remove ques-remove" title="删除题目"></i>
						                <i class="glyphicon glyphicon-pencil ques-rewrite" title="修改题目"></i>
						                <div id="title-info-<%=q.getId() %>" class="ques-title" style="margin-bottom: 10px;"></div>
						                <input type="hidden" id="title-content-<%=q.getId() %>" value='<%=q.getTitle() %>' >
						                <div class="categoryAndTags">
						               		<% if(q.getCategory().equals("math")){%>
						                        <span class="label label-success ques-category-math" style="margin-right: 10px">数学</span>
						                    <%} else if(q.getCategory().equals("english")){%>
						                        <span class="label label-success ques-category-english" style="margin-right: 10px">英语</span>
						                    <%} else if(q.getCategory().equals("politic")){%>
						                        <span class="label label-success ques-category-politic" style="margin-right: 10px">政治</span>
						                    <%} else if(q.getCategory().equals("major")){%>
						                        <span class="label label-success ques-category-major" style="margin-right: 10px">专业课</span>
						                    <%} else {%>
						                        <span class="label label-success ques-category-math" style="margin-right: 10px">数学</span>
						                    <%}%>
						                    
						                    <% List<Tag> tagList = new ArrayList<Tag>(); %>
						                    <% tagList = TD.QueryTagByQuestionId(q.getId()); %>					
						                    <% for(Tag tag:tagList){ %>
						                        <span class="label label-success category-tags"><%=tag.getName() %></span>
						                    <% } %>
						                </div>
						                <div>
						                    <div style="margin-bottom: 10px;margin-top: 10px">
						                        <p class="general-title">答案：</p>
						                        <div id="answer-info-<%=q.getId() %>" class="ques-answer"></div>
						                        <input type="hidden" id="answer-content-<%=q.getId() %>" value='<%=q.getAnswer() %>' >
						                    </div>
						                    <div class="ques-note-box ques-note-category-<%=q.getCategory() %>">
						                        <p class="general-title">笔记：</p>
						                        <div id="note-info-<%=q.getId() %>" class="ques-note"></div>
						                        <input type="hidden" id="note-content-<%=q.getId() %>" value='<%=q.getNote() %>' >
						                    </div>
						                </div>
						            </div>
					            <% } %>
					            </div>
				            </div>
					    </div>
					    
					    <div style="overflow: hidden;width: 100%;"></div>

					    <!--分页展示-->
					    <nav class="pagination">
					        <div class="pageturn">
					            <ul class="pagelist">

				                    <% Page p = (Page)request.getAttribute("page"); %>
				                    
				                    <li class="long">
				                        <a href="QuestionQuery?pagenum=${page.pagenum-1}" class="btn btn-primary">上一页</a>
				                    </li>
				                    
				                    <c:choose>
				                    	<c:when test="${page.pageCount<10}">
					                    	<% for(int i=1; i<=p.getPageCount(); i++){ %>
					                    		<li >
						                            <a href="QuestionQuery?pagenum=<%=i %>" class="btn btn-primary <% if(i == p.getPagenum()){ %> presentPage <% } %>"><%=i %></a>
						                        </li>
						                    <% } %>
					                    </c:when>
				                    
				                    	<c:when test="${page.pagenum<6}">
					                    	<% for(int i=1; i<=10; i++){ %>
					                    		<li >
						                            <a href="QuestionQuery?pagenum=<%=i %>" class="btn btn-primary <% if(i == p.getPagenum()){ %> presentPage <% } %>"><%=i %></a>
						                        </li>
						                    <% } %>
					                    </c:when>
					                    
					                    <c:when test="${page.pagenum>=page.pageCount-5}">
					                    	<% for(int i=-9; i<=0; i++){ %>
						                    	<li >
						                            <a href="QuestionQuery?pagenum=<%=p.getPageCount()+i %>" class="btn btn-primary <% if(p.getPageCount()+i == p.getPagenum()){ %> presentPage <% } %>"><%=p.getPageCount()+i %></a>
						                        </li>
						                    <% } %>
					                    </c:when>
				                    
					                    <c:otherwise>
					                    	<% for(int i=-5; i<5; i++){ %>
						                    	<li >
						                            <a href="QuestionQuery?pagenum=<%=p.getPagenum()+i %>" class="btn btn-primary <% if(i == 0){ %> presentPage <% } %>"><%=p.getPagenum()+i %></a>
						                        </li>
						                    <% } %>
					                    </c:otherwise>
				                    </c:choose>
				                    
				                    <li class="long">
			                        	<a href="QuestionQuery?pagenum=${page.pagenum+1}" class="btn btn-primary">下一页</a>
				                    </li>
					                
  
					
					            </ul>
					        </div>
					    </nav>  
					
					    <h3 class="empty-tips">点击右侧"添加题目"添加您的题目</h3>
					    
				    </div>

					<div class="col-md-3 right-bar">
					    <div class="fly-panel funcBtn-area row" >
					        <% if(user!=null){%>
					        <button id="add-question" class="btn btn-primary"><i class="glyphicon glyphicon-plus"></i>添加题目</button>
					        <% } else { %>
					        <button id="add-question-withoutuser" class="btn btn-primary" data-toggle="modal" data-target="#myModal" style="float: left;"><i class="glyphicon glyphicon-plus"></i>添加题目</button>
					        <% } %>
					        <form id="search-form" action="questionSearch" method="post" class="ques-search">
					        	<% String searchContent = request.getParameter("search"); %>
					            <input class="search-input" autocomplete="off" placeholder="搜索内容" type="text" name="search" value="<%=searchContent %>">
					            <i id="ques-search-submit" class="glyphicon glyphicon-search"></i>
					        </form>
					    </div>
					
					    <div class="fly-panel filter-area row">
					    	<div class="col-md-3 filter-panel-title" >
					    		<p>内容过滤</p>
					    	</div>
					        <div class="filter-box col-md-9">
								<div class="filter-text">
									<input class="filter-title" type="text" readonly placeholder="选择科目过滤" />
									<i class="glyphicon glyphicon-menu-down"></i>
								</div>
								<form id="filterCategory-form" action="filterCategory" method="get">
									<select name="filterCategory" id="filterCategory">
									
				                        <option value="all">全部</option>
										<option value="math">数学</option>
										<option value="english">英语</option>
										<option value="politic">政治</option>
										<option value="major">专业课</option>
									
									</select>
								</form>
							</div>
					    </div>
					 
					    <div class="fly-panel intro-area row">
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
    $(function(){
        if( $(".saved-question").children().length === 0 &&  $(".ques-adding-box").length === 0  ){
            $('.empty-tips').fadeIn();
            $('.pagination').hide();
        }
        else{
            $('.empty-tips').hide();
            $('.pagination').show();
        }

        $(document).click(function(){
            if( $(".saved-question").children().length === 0 &&  $(".ques-adding-box").length === 0  ){
                $('.empty-tips').fadeIn();
                $('.pagination').hide();
            }
            else{
                $('.empty-tips').hide();
                $('.pagination').show();
            }

        });

        $("#ques-search-submit").click(function(){	//搜索功能的ajax
	    	$("#search-form").submit();
        });

        $(".search-input").keyup(function(event){//回车提交搜索
            if(event.keyCode ==13){
	        	$("#search-form").submit();
            }
        });
    });

   <% String filterCategory = request.getParameter("filterCategory"); %>
    switch('<%=filterCategory %>')
        {
            case 'all':
                $('.filter-box option[value="all"]').attr('selected','selected');
                break;
            case 'math':
                $('.filter-box option[value="math"]').attr('selected','selected');
                break;
            case 'english':
                $('.filter-box option[value="english"]').attr('selected','selected');
                break;
            case 'politic':
                $('.filter-box option[value="politic"]').attr('selected','selected');
                break;
            case 'major':
                $('.filter-box option[value="major"]').attr('selected','selected');
                break;
            default:break;
        } 
    
	    $(".right-bar").css("left",$(".question-area").offset().left+$(".question-area").width()+30);
	    $(window).resize(function(){
	        $(".right-bar").css("left",$(".question-area").offset().left+$(".question-area").width()+30);
	    });
	        
	</script>
	<script src="<%=path %>/static/js/selectFilter.js"></script>
	<script type="text/javascript">
	    $('.filter-box').selectFilter({
	        callBack : function (val){
	            if(val === 'all'){
	                window.location.href = 'QuestionQuery';
	            }
	            else{
	                $("#filterCategory-form").submit();
	            }
	        }
	    });
	</script>
	<script type="text/javascript" src='<%=path %>/static/js/stopExecutionOnTimeout.js?t=1'></script>
	<script src="<%=path %>/static/js/wangEditor.min.js"></script>
	
	<script type="text/javascript">
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
	
	<script type="text/javascript">
	    var originWidth = 0;//测试用
	
	    function renderTagsBtn(){
	        $(".tag").mouseenter(function(){
	            originWidth = $(this).width();
	            $(this).css("border","1px solid #3d79e5");
	            $(this).stop(true, false).animate({"width":$(this).width()+30});
	            $(this).children(".tag-btn-area").fadeIn();
	        });
	
	        $(".tag").mouseleave(function(){
	            $(this).css("border","1px solid #bebebe");
	            $(this).children(".tag-btn-area").fadeOut(150);
	            $(this).stop(true, false).animate({"width":originWidth+22});
	        });
	
	        $(".tag-btn-remove").click(function(){
	            $(this).parent().parent().remove();
	            $("#hidden-tags").val($("#hidden-tags").val().replace("_"+$(this).parent().parent().children("a").text(),""));
	        });
	    }
	
	    function renderAddQuesBtns(){
	        $(".btn-addTags i").click(function(){//点击添加标签时
	            $(".btn-addTags").hide();
	            $("#input-tag").show().animate({"width":"150px","opacity":"100"});
	            $("#save-tag").fadeIn(100);
	            $("#input-tag").focus();
	        });
	
	        renderTagsBtn();
	
	        $("#input-tag").blur(function(){//输入框失去焦点时取消添加标签
	            $("#save-tag").fadeOut(100,function(){
	                $("#input-tag").animate({"width":"23px","opacity":"0"},function(){
	                    $("#input-tag").hide();
	                    $(".btn-addTags").show();
	                });
	            });
	        });
	
	        $("#save-tag").click(function(){//点击保存标签时
	            if($("#input-tag").val()){
	                var reStr = '(_'+$("#input-tag").val()+'$|_'+$("#input-tag").val()+'_)';
	                var reg = new RegExp(reStr);
	                if($("#hidden-tags").val().match(reg)) {
	                    swal ({
	                        icon: "error",
	                        text: "已经输入此标签"
	                    });
	                }
	                else{
	                    $("#hidden-tags").val($("#hidden-tags").val() + '_' + $("#input-tag").val());
	                    $("#save-tag").fadeOut(100,function(){
	                        $(".tag-added").append('<li class="tag"><a href="##">'
	                            + $("#input-tag").val()
	                            +'</a><div class="tag-btn-area"><i class="glyphicon glyphicon-remove tag-btn tag-btn-remove" title="删除"></i></div></li>');
	                        $("#input-tag").animate({"width":"23px","opacity":"0"},function(){
	                            $("#input-tag").hide();
	                            $(".btn-addTags").show();
	                            $("#input-tag").val("");
	                        });
	                        renderTagsBtn();
	                    });
	                }
	                
	            }
	        });
	
	        $("#input-tag").keyup(function(event){//回车保存标签
	            if(event.keyCode ==13){
	                if($("#input-tag").val()){
	                    var reStr = '(_'+$("#input-tag").val()+'$|_'+$("#input-tag").val()+'_)';
	                    var reg = new RegExp(reStr);
	                    if($("#hidden-tags").val().match(reg)) {
	                        swal ({
	                            icon: "error",
	                            text: "已经输入此标签"
	                        });
	                    }
	                    else{
	                        $("#hidden-tags").val($("#hidden-tags").val() + '_' + $("#input-tag").val());
	                        $("#save-tag").fadeOut(100,function(){
	                            $(".tag-added").append('<li class="tag"><a href="##">'
	                            + $("#input-tag").val() 
	                            +'</a><div class="tag-btn-area"><i class="glyphicon glyphicon-remove tag-btn tag-btn-remove" title="删除"></i></div></li>');
	                            $("#input-tag").animate({"width":"23px","opacity":"0"},function(){
	                                $("#input-tag").hide();
	                                $(".btn-addTags").show();
	                                $("#input-tag").val("");
	                            });
	                            renderTagsBtn();
	                        });
	                    }
	                }
	            }
	        });
	    }
	    
	    jQuery(function($) {
	    	$(".ques-remove").click(function(){
	    		$.ajax({
	                cache: false,
	                type: "GET",
	                url:"remove_question",
	                data: {
	                	id: $(this).parent().children("input").attr("id").split("-")[2]
	                },
	                dateType:"json",
	                async: true,
	                success: function(data) {
	                    if(data.status == 'success'){
	                        window.location.reload();//刷新当前页面.
	                    }else if(data.status == 'fail'){
	                        swal ({
	                            icon: "error",
	                            text: "删除失败请重试"
	                        });
	                    }
	                },
	            });
	    	});
	    	
	    	$(".ques-rewrite").click(function(){
	            var quesId = $(this).parent().children("input").attr("id").split("-")[2];
	            var exist = $(".ques-adding-box");

	            if (exist.length) {
	                if($(".ques-adding-box .warning").length === 0) $("#button-group").append('<p class="warning">请先保存当前编辑中的题目!</p>');
	            }

	            else{
	                $(this).parent().hide();
	                var qh = $(this).parent();


	                qh.after('<div class="fly-panel detail-box ques-adding-box" style="display:none;">    <div class="questitle-line ques-category-adding"></div>     <div style="margin-top: 10px">              <form id="ques_adding_form">                        <div class="form-group row" style="margin-bottom: 10px;">                   <div class="category-area col-md-4 col-sm-12">                  <label class="general-title" style="float: left;margin-bottom: 10px">选择科目：</label>                                  <select class="form-control" id="category" name="category" style="width: 50%;height: 24px;padding: 0 0 0 0;">                       <option value="math">数学</option>                                        <option value="english">英语</option>                                         <option value="politic">政治</option>                                         <option value="major">专业课</option>                              </select>               </div>                                                          <ul class="tag-area col-md-8">                  <div class="tag-added">                 </div>                  <div class="btn-addTags" title="添加标签">                      <i class="glyphicon glyphicon-plus"></i>                    </div>                  <div class="tag-inputBox">                      <input id="input-tag" type="text" placeholder="请输入标签">                      <input id="hidden-tags" type="text" name="tags" hidden>                     <i class="glyphicon glyphicon-ok" id="save-tag" title="保存"></i>                 </div>              </ul>                           </div>              <div class="text-area">             <p class="general-title">输入题目：</p>                          <div id="rich-text-menu1"></div>                            <div class="rich-text" style="margin-bottom: 10px;min-height: 50px;">                                   <div id="rich-text-box1"></div>                             </div>                          <input name="title" type="hidden" id="title">                           <p style="margin-bottom: 5px;" class="general-title">输入答案：</p>                          <div id="rich-text-menu2"></div>                            <div class="rich-text" style="margin-bottom: 10px;min-height: 80px;">                               <div id="rich-text-box2"></div>                             </div>                          <input name="answer" type="hidden" id="answer">                             <p style="margin-bottom: 5px;" class="general-title">输入笔记：</p>                          <div id="rich-text-menu3"></div>                            <div class="rich-text">                                 <div id="rich-text-box3"></div>                         </div>                          <input name="note" type="hidden" id="note">                 </div>                  </form>             <div id="button-group" style="margin-top: 10px;">                       <button id="save-adding-question" type="button" class="rkmd-btn btn-white ripple-effect ripple-dark"><i class="glyphicon glyphicon-ok"></i>保存</button>                      <button id="delete-adding-question" class="rkmd-btn btn-white ripple-effect ripple-dark"><i class="glyphicon glyphicon-remove"></i>返回</button>              </div>      </div></div>  ');

	                //类别部分
	                var category = $(this).parent().children(".categoryAndTags").children("span:first-child").text();
	                $('#category  option:contains('+category+') ').attr("selected",true);

	                //标签部分
	                var tagsObject = $(this).parent().children(".categoryAndTags").children(".category-tags");
	                var maxIndex = tagsObject.length - 1;
	                var tags = '';
	                $(this).parent().children(".categoryAndTags").children(".category-tags").text(function(index, content){
	                    tags += (index === maxIndex) ? content : content + '_'; 
	                });


	                if(tags != '')
	                {
	                    $("#hidden-tags").val('_'+tags);//向tags中添加原标签  
	                    for(var num in tags.split('_'))
	                    {
	                        $(".tag-added").append('<li class="tag"><a href="##">'
	                        + tags.split('_')[num] 
	                        +'</a><div class="tag-btn-area"><i class="glyphicon glyphicon-remove tag-btn tag-btn-remove" title="删除"></i></div></li>');
	                    }
	                }
	                

	                //题目、答案、笔记部分
	                var E = window.wangEditor;
	                var editor1 = new E('#rich-text-menu1','#rich-text-box1');
	                var editor2 = new E('#rich-text-menu2','#rich-text-box2');
	                var editor3 = new E('#rich-text-menu3','#rich-text-box3');   
	                //这里注意，下面的/news/upload是我的路由部分，主要是上传图片的后端代码
	                editor1.customConfig.uploadImgServer = 'ques/upload' ; // 上传图片到服务器
	                editor2.customConfig.uploadImgServer = 'ques/upload' ; // 上传图片到服务器
	                editor3.customConfig.uploadImgServer = 'ques/upload' ; // 上传图片到服务器
	                  //定义上传的filename，即上传图片的名称
	                editor1.customConfig.uploadFileName = 'images';
	                editor2.customConfig.uploadFileName = 'images';
	                editor3.customConfig.uploadFileName = 'images';
	                editor1.customConfig.showLinkImg = false;
	                editor2.customConfig.showLinkImg = false;
	                editor3.customConfig.showLinkImg = false;
	                  //开启wangEditor的错误提示，有利于我们更快的找到出错的地方
	                editor1.customConfig.debug=true;
	                editor2.customConfig.debug=true;
	                editor3.customConfig.debug=true;
	              
	              	editor1.customConfig.zIndex = 40;
	       		 	editor2.customConfig.zIndex = 20;
	       		 	editor3.customConfig.zIndex = 10;

	                editor1.create();
	                editor2.create();
	                editor3.create();

	                editor1.txt.html($(this).parent().children(".ques-title").html());
	                editor2.txt.html($(this).parent().find(".ques-answer").html());
	                editor3.txt.html($(this).parent().find(".ques-note").html());

	                $(".ques-adding-box").fadeIn();

	                renderAddQuesBtns();

	                $("#save-adding-question").click(function(){
	                    var info1 = editor1.txt.html();
	                    var info2 = editor2.txt.html();
	                    var info3 = editor3.txt.html();
	                    document.getElementById("title").value = info1;
	                    document.getElementById("answer").value = info2;
	                    document.getElementById("note").value = info3;
	
                    $.ajax({
                        cache: false,
                        type: "POST",
                        url:"add_question",
                        data:$('#ques_adding_form').serialize(),
                        dateType:"json",
                        async: true,
                        success: function(data) {
                            if(data.status == 'success'){
                                $.ajax({
                                    cache: false,
                                    type: "GET",
                                    url:"remove_question",
                                    data: {
                                        id: quesId
                                    },
                                    dateType:"json",
                                    async: true,
                                    success: function(data) {
                                        if(data.status == 'success'){
                                            window.location.reload();//刷新当前页面.
                                        }else if(data.status == 'fail'){
                                            swal ({
                                                icon: "error",
                                                text: "修改失败，请重试！"
                                            });
                                        }
                                    },
                                });
                            }else if(data.status == 'fail'){
                                swal ({
                                    icon: "error",
                                    text: "修改失败，请重试！"
                                });
                            }
                        },
                    });
                });

                $("#delete-adding-question").click(function(){
                    $('#title-info-'+ quesId).parent().show();
                    $(".ques-adding-box").remove();
                });

            }
        });
	    	
	    	$("#add-question").click(function(){
	            $("html,body").animate({scrollTop:0}, 200);
	            var exist = $(".ques-adding-box");
	            if (exist.length) {
	                if($(".ques-adding-box .warning").length === 0) $("#button-group").append('<p class="warning">请先保存当前编辑中的题目!</p>');
	            }
	            else
	            {
	                var qh = $("#question-holder");
	                qh.prepend('<div class="fly-panel detail-box ques-adding-box" style="display:none;">    <div class="questitle-line ques-category-adding"></div>     <div style="margin-top: 10px">              <form id="ques_adding_form">                        <div class="form-group row" style="margin-bottom: 10px;">                   <div class="category-area col-md-4 col-sm-12">                  <label class="general-title" style="float: left;margin-bottom: 10px">选择科目：</label>                                  <select class="form-control" id="category" name="category" style="width: 50%;height: 24px;padding: 0 0 0 0;">                       <option value="math">数学</option>                                        <option value="english">英语</option>                                         <option value="politic">政治</option>                                         <option value="major">专业课</option>                              </select>               </div>                                                          <ul class="tag-area col-md-8">                  <div class="tag-added">                   </div>                  <div class="btn-addTags" title="添加标签">                      <i class="glyphicon glyphicon-plus"></i>                    </div>                  <div class="tag-inputBox">                      <input id="input-tag" type="text" placeholder="请输入标签">                      <input id="hidden-tags" type="text" name="tags" hidden>                     <i class="glyphicon glyphicon-ok" id="save-tag" title="保存"></i>                 </div>              </ul>                           </div>              <div class="text-area">             <p class="general-title">输入题目：</p>                          <div id="rich-text-menu1"></div>                            <div class="rich-text" style="margin-bottom: 10px;min-height: 50px;">                                   <div id="rich-text-box1"></div>                             </div>                          <input name="title" type="hidden" id="title">                           <p style="margin-bottom: 5px;" class="general-title">输入答案：</p>                          <div id="rich-text-menu2"></div>                            <div class="rich-text" style="margin-bottom: 10px;min-height: 80px;">                               <div id="rich-text-box2"></div>                             </div>                          <input name="answer" type="hidden" id="answer">                             <p style="margin-bottom: 5px;" class="general-title">输入笔记：</p>                          <div id="rich-text-menu3"></div>                            <div class="rich-text">                                 <div id="rich-text-box3"></div>                         </div>                          <input name="note" type="hidden" id="note">                 </div>                  </form>             <div id="button-group" style="margin-top: 10px;">                       <button id="save-adding-question" type="button" class="rkmd-btn btn-white ripple-effect ripple-dark"><i class="glyphicon glyphicon-ok"></i>保存</button>                      <button id="delete-adding-question" class="rkmd-btn btn-white ripple-effect ripple-dark"><i class="glyphicon glyphicon-remove"></i>删除</button>              </div>      </div></div> ');
	                $(".ques-adding-box").fadeIn();
	                

	                var E = window.wangEditor;
	                var editor1 = new E('#rich-text-menu1','#rich-text-box1');
	                var editor2 = new E('#rich-text-menu2','#rich-text-box2');
	                var editor3 = new E('#rich-text-menu3','#rich-text-box3');   

	                //这里注意，下面的/news/upload是我的路由部分，主要是上传图片的后端代码
	                editor1.customConfig.uploadImgServer = 'ques/upload' ; // 上传图片到服务器
	                editor2.customConfig.uploadImgServer = 'ques/upload' ; // 上传图片到服务器
	                editor3.customConfig.uploadImgServer = 'ques/upload' ; // 上传图片到服务器
	                  //定义上传的filename，即上传图片的名称
	                editor1.customConfig.uploadFileName = 'images';
	                editor2.customConfig.uploadFileName = 'images';
	                editor3.customConfig.uploadFileName = 'images';
	                editor1.customConfig.showLinkImg = false;
	                editor2.customConfig.showLinkImg = false;
	                editor3.customConfig.showLinkImg = false;
	                  //开启wangEditor的错误提示，有利于我们更快的找到出错的地方
	                editor1.customConfig.debug=true;
	                editor2.customConfig.debug=true;
	                editor3.customConfig.debug=true;
	              
	              	editor1.customConfig.zIndex = 40;
	       		 	editor2.customConfig.zIndex = 20;
	       		 	editor3.customConfig.zIndex = 10;
	                
	                editor1.create();
	                editor2.create();
	                editor3.create();

	                renderAddQuesBtns();

	                $("#save-adding-question").click(function(){
	                    var info1 = editor1.txt.html();
	                    var info2 = editor2.txt.html();
	                    var info3 = editor3.txt.html();
	                    document.getElementById("title").value = info1;
	                    document.getElementById("answer").value = info2;
	                    document.getElementById("note").value = info3;

	                   
	                    $.ajax({
	                        cache: false,
	                        type: "POST",
	                        url:"add_question",
	                        data:$('#ques_adding_form').serialize(),
	                        dateType:"json",
	                        async: true,
	                        success: function(data) {
	                            if(data.status == 'success'){
	                                 window.location.reload();//刷新当前页面
	                            }else if(data.status == 'fail'){
	                                swal ({
	                                    icon: "error",
	                                    text: "提交失败，请重试！"
	                                });
	                            }
	                        },
	                    });
	                });

	                $("#delete-adding-question").click(function(){
	                    $(".ques-adding-box").remove();
	                });

	            }
	        });
	    });
	    </script>    
	    <script type="text/javascript">
			window.onload=function()
		  	{
				<% for(Question q:questionList){ %>
			    var info1 = document.getElementById("title-content-<%=q.getId() %>").value;
			    document.getElementById("title-info-<%=q.getId() %>").innerHTML=info1;
			    var info2 = document.getElementById("answer-content-<%=q.getId() %>").value;
			    document.getElementById("answer-info-<%=q.getId() %>").innerHTML=info2;
			    var info3 = document.getElementById("note-content-<%=q.getId() %>").value;
			    document.getElementById("note-info-<%=q.getId() %>").innerHTML=info3;
			    <% } %>
		  	}
		
		</script>
</body>
</html>