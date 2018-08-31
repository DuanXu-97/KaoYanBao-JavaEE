<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import ="java.util.List" %>    
<%@ page import ="com.kyb.Dao.NewsDao" %> 

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
                    + request.getServerName() + ":" + request.getServerPort()
                    + path + "/";
%>
<% List<News> NewsList = (List<News>)request.getAttribute("NewsList"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>资讯广场——「考研宝」</title>

<link rel="stylesheet" href="<%=path%>/static/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=path%>/static/css/jquery.mCustomScrollbar.min.css" />
<link rel="stylesheet" href="<%=path%>/static/css/custom.css">
<link rel="stylesheet" href="<%=path%>/static/css/buttonStyle.css">
<link rel="shortcut icon" type="image/x-icon" href="<%=path%>/static/img/logo.ico" media="screen">
<link rel="stylesheet" href="<%=path%>/static/css/mystyle.css" type="text/css"  media="all">
<style>
.container-fluid{
	width: 1200px!important;
    margin: 10px auto!important;
}
</style>
</head>
<body style="background:url('<%=path %>/static/img/bg_cwj.png') repeat-y center top; background-color: #eee; background-size: 100%;">
<%@include file="topbar.jsp"%>
	<div class="page-wrapper">
		<div class="page-content">
			<div class="container-fluid">
			
				<div class="row hotspot" style="position: relative;">
	                    <div class="col-md-5 col-sm-12" id="inbox-wrapper" style="position: fixed;width: 520px;margin: auto;">
	
	                        <section style="padding: 15px;" class="panel search-test-inner" id="hotspot-list">
	                            <header class="panel-heading">
	                                <h4>资讯广场
	                        			<form action="#" class="pull-right">
				                            <div class="input-append">
				                                <input type="text" class="form-control search-value" placeholder="搜索热点">
				                            </div>
				                        </form>
			                       	</h4>
	                            </header>
	
	                            <div class="panel-body">
	                                <div class="table-responsive pull-left">
	                                    <table class="table table-inbox table-hover">
	                                        <tbody class="search-value-list">
	
	                                        	<% for( News h:NewsList ){ %>
	
	                                        	<tr class="list-item" id='ListItem_<%=h.getId() %>' date-page="1" v-on:click="clickListItem(<%=h.getId() %>)">
	                                                <td><i class="glyphicon glyphicon-star"></i>
	                                                </td>
	                                                <td class="list-item-content">
	                                                	<a href="#">
		                                                	<span class="title search-tit"><%=h.getTitle() %></span>
		                                                	<p>
		                                                	</p>
	                                           			</a>
	                                                </td>
	                                                <td class="text-right"><%=h.getDateString() %></td>
	                                            </tr>
	
	                                        	<% } %>
	
	                                      </tbody>
	                                    </table>
	
	                                </div>
	
	                                <div class="hotspot-option">
	                                    
	                                    <ul class="hotspot-pag pull-right">
	                                        <li><span v-text = "presentPage+' of '+AmountPages"></span>
	                                        </li>
	                                        <li>
	                                            <a class="btn btn-default btn-sm" v-on:click="clickPageLeft" href="#"><i class="glyphicon glyphicon-chevron-left  pag-left"></i></a>
	                                        </li>
	                                        <li>
	                                            <a class="btn btn-default btn-sm" v-on:click="clickPageRight" href="#"><i class="glyphicon glyphicon-chevron-right pag-right"></i></a>
	                                        </li>
	                                    </ul>
	
	                                </div>
	                            </div>
	                        </section>
	
	                    </div>
	                    <div class="col-md-7 col-sm-12" id="view-hotspot-wrapper" style="position: absolute;right: 0px;width: 720px;margin: auto;">
	                        <div class="panel">
	                            <div class="panel-body">
	                                <header>
	                                    <h2>资讯详情</h2>
	                                    <div id="list-item-date-box" class="hotspot-item-box">
	
	                                    	<% for( News h:NewsList ){ %>
	                                    	<p class="pull-right hotspot-item-<%=h.getId() %>" ><%=h.getDateString() %></p>
	                                    	<% } %>
	
	                                    </div>
	                                </header>
	                                <div class="row view-hotspot-header">
	                                    <div class="col-md-8 info-sourse hotspot-item-box" id="list-item-title-box" style="padding-left: 30px;display: inline-block;">
	
	                                        <% for( News h:NewsList ){ %>
	                                        <h4 class="hotspot-item-<%=h.getId() %>"><%=h.getTitle() %></h4>
	                                        <% } %>
	
	                                    </div>
	                                    <!-- <div class="col-md-4"  style="margin-top: 5px; display: inline-block;float: right;">
	                                        <div class="pull-right">
	                                            <button class="btn btn-sm btn-primary" id="collectionBtn" v-on:click="clickCollection" style="outline: none;">收藏</button>
	                                        </div>
	                                    </div> -->
	                                </div>
	
	                                <div class="row">
	                                    <div class="col-md-12">
	
	                                        <div class="panel view-hotspot-body hotspot-item-box" id="list-item-content-box">
	
	                                        	<% for( News h:NewsList ){ %>
	                                            <div class="panel-body hotspot-item-<%=h.getId() %>">
	                                                <p><%=h.getContent() %></p>
	                                            </div>
	                                            <% } %>
	
	                                        </div>
	                                    </div>
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

			var vm_hotspotlist = new Vue({
				el: '#hotspot-list',
				data: {
					maxLen: 30,//列表梗概字数
					AmountofItem: 0,//总共爬取的新闻数
					AmountifItemPrepage: 5,//列表每页的条目数
					presentPage: 1
	        	},
	        	computed:{
	        		AmountPages:function(){
	        			return Math.ceil(this.AmountofItem/this.AmountifItemPrepage);
	        		}
	        	},
	        	methods:{
	        		initial:function(){

	        			<% for( News h:NewsList ){ %>

						this.AmountofItem++;

						$("#ListItem_<%=h.getId() %>").attr("date-page",Math.ceil(this.AmountofItem/this.AmountifItemPrepage).toString());
						

						<% } %>

	        			$('.search-value-list > [date-page!='+this.presentPage+']').hide();
						$(".hotspot-item-box").children().hide();
						
						$(".list-item").removeClass("active");
						$(".search-value-list").children(":first").addClass("active");
						var firstId = $(".search-value-list").children(":first").attr("id").split("_")[1];
						$(".hotspot-item-"+firstId).show();
						

	        		},

	        		clickListItem:function(id){
	        			$('.hotspot-item-box').children().not('.hotspot-item-'+id+'').hide();
						$('.hotspot-item-box .hotspot-item-'+id+'').fadeIn();
						if($('#ListItem_'+id+'').hasClass('collected')){//用户已经收藏该新闻
							$("collectionBtn").text('取消收藏');
						}
						else{
							$("collectionBtn").text('收藏');
						}
						$(".list-item").not('#ListItem_'+id+'').removeClass("active");
						$('#ListItem_'+id+'').addClass("active");
	        		},

	        		clickCollection:function(){
	        			if($('.active').hasClass('collected'))//用户已经收藏该新闻
	        			{
	        				// $("collectionBtn").text('收藏');
	        				// $('.active i').css("color","#cccccc");
	        				// $('.active').removeClass("collected");
	        				$.ajax({
				                cache: false,
				                type: "POST",
				                url:"hotspot/removeCollected/",
				                data:{
				                	//id是取消收藏的新闻id
				                	id : $('.active').attr('id').split('_')[1]
				                },
				                dateType:"json",
				                async: true,
				                success: function(data) {
				                    if(data.status == 'success'){
				                        $("collectionBtn").text('收藏');
				        				$('.active i').css("color","#cccccc");
				        				$('.active').removeClass("collected");
				                    }else if(data.status == 'fail'){
				                        swal ({
										 	icon: "error",
										 	text: "取消收藏失败，请重试",
										 	type:"error"
								 		});
				                    }
				                },
				            });
	        			}
	        			else{
	        				// $("collectionBtn").text('取消收藏');
	        				// $('.active i').css("color","#edce8c");
	        				// $('.active').addClass("collected");
	        				$.ajax({
				                cache: false,
				                type: "POST",
				                url:"hotspot/addCollected/",
				                data:{
				                	//id是要收藏的新闻id
				                	id : $('.active').attr('id').split('_')[1]
				                },
				                dateType:"json",
				                async: true,
				                success: function(data) {
				                    if(data.status == 'success'){
				                        $("collectionBtn").text('取消收藏');
				        				$('.active i').css("color","#edce8c");
				        				$('.active').addClass("collected");
				                    }else if(data.status == 'fail'){
				                        swal ({
										 	icon: "error",
										 	text: "取消收藏失败，请重试",
										 	type:"error"
								 		});
				                    }
				                },
				            });
	        			}
	        			
	        		},

	        		clickPageLeft:function(){
						if(this.presentPage>1){
							this.presentPage--;
						}
						$('.search-value-list > [date-page!='+this.presentPage+']').hide();
						$('.search-value-list > [date-page='+this.presentPage+']').show();
	        		},

	        		clickPageRight:function(){
						if(this.presentPage<Math.ceil(this.AmountofItem/this.AmountifItemPrepage)){
							this.presentPage++;
						}
						$('.search-value-list > [date-page!='+this.presentPage+']').hide();
						$('.search-value-list > [date-page='+this.presentPage+']').show();
	        		}

	        	}
			});

			vm_hotspotlist.initial();

	</script>

	<script src="<%=path%>/static/js/jQuery.Hz2Py-min.js"></script>
	<script src="<%=path%>/static/js/jsSearch.js"></script>

	<script type="text/javascript">
		//前端JS实现搜索
		$(function(){
			new SEARCH_ENGINE("search-test-inner","search-value","search-value-list","search-tit");
		});
	</script>
	<script type="text/javascript">
		$(window).on('scroll', function() {
			smoothBackgroundScroll('<%=path %>/static/img/bg_cwj.png');
		});

		function smoothBackgroundScroll(imgsrc) {
			function loadImageHeight(url, width) {
				var img = new Image();
				img.src = url;
				if (width) {
					img.width = width;
				}
				return img.height;
			}

			var dh, wh, ih, st, posy, backh, backw;
			if (!this._smoothBackgroundScroll) {
				var bcksize = $(document.body).css('background-size');
				var bmatch = /(\w+)\s*(\w+)/.exec(bcksize);
				if (!bmatch || bmatch.length < 3) {
					backh = loadImageHeight(imgsrc)
				} else {
					backh = parseInt(bmatch[2]);
					if (isNaN(backh)) {
						backw = parseInt(bmatch[1]);
						backh = loadImageHeight(imgsrc, parseInt(backw));
					}
				}
				this._smoothBackgroundScroll = {
					dh: $(document).height()
					, wh: $(window).height()
					, ih: backh
				}
			}
			dh = this._smoothBackgroundScroll.dh;
			wh = this._smoothBackgroundScroll.wh
			ih = this._smoothBackgroundScroll.ih;
			st = $(document).scrollTop();
			posy = (dh + ih) * st / (dh + wh);
			document.body.style.backgroundPosition = 'center ' + posy + 'px';
		}
	</script>
	

</body>
</html>