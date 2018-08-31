<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import ="java.util.List" %>
<%@ page import ="com.kyb.model.*" %>
<%@ page import ="com.kyb.Dao.*" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
                    + request.getServerName() + ":" + request.getServerPort()
                    + path + "/";
%>

<% CommonweaknessDao CWD = new CommonweaknessDao(); %>
<%  List<Course> courseList = new ArrayList<Course>( );%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>添加初始标签——「考研宝」</title>

    <link rel="stylesheet" href="<%=path%>/static/css/bootstrap.min.css">
    <link rel="shortcut icon" type="image/x-icon" href="<%=path%>/static/img/logo.ico" media="screen">
    <link rel="stylesheet" href="<%=path%>/static/css/mystyle.css" type="text/css"  media="all">


</head>
<body>
    <div class="activateSuccess" onselectstart="return false;">
        <div class="initialTags-header"> 
            <h4>选择或添加您的薄弱标签</h4>
            <div class="divider-line"></div>
        </div>
        <div class="panel-area">
            <ul>
            	<% courseList = CWD.QueryCourseAll(); %>
                <% for(Course c:courseList) {%>
                <li class="panel course-<%=c.getId()%>">
                    <h5><%=c.getName()%></h5>
                    <div class="divider-line"></div>
                    <div class="tags-select-area">
                        <ul>
                            <% List<Commontags> tagList = CWD.QueryCommontagsByCid(c.getId()); %>
                            <% for(Commontags t:tagList) {%>
                            <li class="tag"><%=t.getName() %></li>   
                            <%  } %>
                        </ul>
                    </div>
                    <div class="divider-line"></div>
                    <h5>添加你自己的标签</h5>
                    <div class="tags-add-area">
                        <div class="tag-added">
                        </div>
                        <div class="btn-addTags" title="添加标签">
                            <i class="glyphicon glyphicon-plus"></i>
                        </div>
                        <div class="tag-inputBox">
                            <input class="input-tag" id="input-tag-<%=c.getId()%>" type="text" placeholder="请输入标签">
                            <i class="glyphicon glyphicon-ok save-tag" id="save-tag-<%=c.getId()%>" title="保存"></i>
                        </div>
                    </div>
                    <input class="hidden-tags" id="hidden-tags-<%=c.getId()%>" type="text" name="initialTags-<%=c.getId()%>" hidden>
                </li>
                <% } %>
            </ul> 
        </div>
        <div class="initialTags-footer"> 
            <button class="btn btn-primary" id="submitInitialTags">保存并完成注册</button>
        </div>
        
    </div>



    <script src="<%=path%>/static/js/jquery-3.3.1.min.js"></script>
    <script src="<%=path%>/static/js/bootstrap.min.js"></script>
    <script src="<%=path%>/static/js/vue.min.js"></script>
    <script src="<%=path%>/static/js/sweetalert.js"></script>

    <script type="text/javascript">

        $(".tags-select-area .tag").click(function(){   //éæ©æ ç­¾æ¶
            var courseID = $(this).closest('.panel').attr("class").split(' ')[1].split('-')[1];
            if($(this).hasClass('selected')){
                $(this).removeClass('selected');
                $('#hidden-tags-' + courseID).val($('#hidden-tags-' + courseID).val().replace("_"+$(this).text(),""));
            }
            else{
                var reStr = '(_'+$(this).text()+'$|_'+$(this).text()+'_)';
                var reg = new RegExp(reStr);
                if($('#hidden-tags-' + courseID).val().match(reg)) {
                    swal ({
                        icon: "error",
                        text: "已经输入此标签",
                    });
                }
                else{
                    $(this).addClass('selected');
                    $('#hidden-tags-' + courseID).val($('#hidden-tags-' + courseID).val() + '_' + $(this).text());
                }
            }
        });

        $("#submitInitialTags").click(function(){
            var initialTagsArray = []; //ajaxä¼ çæ°ç»ï¼å¶ååç´ ä¸ºcourseTagså¯¹è±¡
            var $course = $('.hidden-tags');
            for (var i = 0; i < $course.length; i++) {
                courseTags = {};//å¯¹è±¡ï¼æä¸¤ä¸ªå±æ§ï¼course_idåinitialTags
                courseTags['course_id'] = $course[i].id.split('-')[2];
                courseTags['initialTags'] = $course[i].value;//è¯¥ç§ç®çåå§æ ç­¾ï¼æ ¼å¼ä¸é®é¢é¡µé¢çç¸å
                initialTagsArray[i] = courseTags;
            }
            
            $.ajax({
                cache: false,
                type: "POST",
                url:"initialTags",//è¿éè·¯å¾æ ¹æ®åç«¯ä¿®æ¹
                data: {
                  userInitialTags : initialTagsArray,
                  length: $course.length
                }, 
                dateType:"json",
                async: true,
                success: function(data) {
                    if(data.status == 'success'){
                        swal ({
                            icon: "success",
                            text: "保存成功",
                            showCancelButton: true,
                            confirmButtonText: '回到首页',
                            cancelButtonText: '取消',
                        }).then(function(isConfirm) {
                            if(isConfirm === true){
                                window.location.href = "index.jsp";
                            }
                        });
                    }else if(data.status == 'fail'){
                        swal ({
                            icon: "error",
                            text: "保存失败，请重试",
                        });
                    }
                }
            });
        });
    </script>

    <script type="text/javascript">
        var originWidth = 0;//æµè¯ç¨

        function renderTagsBtn(){
            $(".tags-add-area .tag").mouseenter(function(){
                originWidth = $(this).width();
                $(this).css("border","1px solid #3d79e5");
                $(this).stop(true, false).animate({"width":$(this).width()+30});
                $(this).children(".tag-btn-area").fadeIn();
            });

            $(".tags-add-area .tag").mouseleave(function(){
                $(this).css("border","1px solid #bebebe");
                $(this).children(".tag-btn-area").fadeOut(150);
                $(this).stop(true, false).animate({"width":originWidth+22});
            });

            $(".tags-add-area .tag-btn-remove").click(function(){
                var courseID = $(this).closest('.panel').attr("class").split(' ')[1].split('-')[1];
                $(this).parent().parent().remove();
                $('#hidden-tags-' + courseID).val($('#hidden-tags-' + courseID).val().replace("_"+$(this).parent().parent().children("a").text(),""));
            });
        }

        function renderTagsAnimeBtns(){
            $(".btn-addTags i").click(function(){//ç¹å»æ·»å æ ç­¾æ¶
                var courseID = $(this).closest('.panel').attr("class").split(' ')[1].split('-')[1];
                $(this).parent(".btn-addTags").hide();
                $('#input-tag-'+courseID).show().animate({"width":"150px","opacity":"100"});
                $('#save-tag-'+courseID).fadeIn(100);
                $('#input-tag-'+courseID).focus();
            });

            renderTagsBtn();

            $(".input-tag").blur(function(){//è¾å¥æ¡å¤±å»ç¦ç¹æ¶åæ¶æ·»å æ ç­¾
                var courseID = $(this).closest('.panel').attr("class").split(' ')[1].split('-')[1];
                $('#save-tag-'+courseID).fadeOut(100,function(){
                    $('#input-tag-'+courseID).animate({"width":"23px","opacity":"0"},function(){
                        $('#input-tag-'+courseID).hide();
                        $('.course-'+courseID+' .btn-addTags').show();
                    });
                });
            });

            $(".save-tag").click(function(){//ç¹å»ä¿å­æ ç­¾æ¶
                var courseID = $(this).closest('.panel').attr("class").split(' ')[1].split('-')[1];
                if($('#input-tag-'+courseID).val()){
                    var reStr = '(_'+$('#input-tag-'+courseID).val()+'$|_'+$('#input-tag-'+courseID).val()+'_)';
                    var reg = new RegExp(reStr);
                    if($('#hidden-tags-'+courseID).val().match(reg)) {
                        swal ({
                            icon: "error",
                            text: "已经输入此标签",
                        });
                    }
                    else{
                        $('#hidden-tags-'+courseID).val($('#hidden-tags-'+courseID).val() + '_' + $('#input-tag-'+courseID).val());
                        $('#save-tag-'+courseID).fadeOut(100,function(){
                            $('.course-'+courseID+' .tag-added').append('<li class="tag"><a href="##">'
                                + $('#input-tag-'+courseID).val() 
                                +'</a><div class="tag-btn-area"><i class="glyphicon glyphicon-remove tag-btn tag-btn-remove" title="删除"></i></div></li>');
                            $('#input-tag-'+courseID).animate({"width":"23px","opacity":"0"},function(){
                                $('#input-tag-'+courseID).hide();
                                $('.course-'+courseID+' .btn-addTags').show();
                                $('#input-tag-'+courseID).val("");
                            });
                            renderTagsBtn();
                        });
                    }
                    
                }
            });

            $(".input-tag").keyup(function(event){//åè½¦ä¿å­æ ç­¾
                if(event.keyCode ==13){
                    var courseID = $(this).closest('.panel').attr("class").split(' ')[1].split('-')[1];
                    if($('#input-tag-'+courseID).val()){
                        var reStr = '(_'+$('#input-tag-'+courseID).val()+'$|_'+$('#input-tag-'+courseID).val()+'_)';
                        var reg = new RegExp(reStr);
                        if($('#hidden-tags-'+courseID).val().match(reg)) {
                            swal ({
                                icon: "error",
                                text: "已经输入此标签",
                            });
                        }
                        else{
                            $('#hidden-tags-'+courseID).val($('#hidden-tags-'+courseID).val() + '_' + $('#input-tag-'+courseID).val());
                            $('#save-tag-'+courseID).fadeOut(100,function(){
                                $('.course-'+courseID+' .tag-added').append('<li class="tag"><a href="##">'
                                + $('#input-tag-'+courseID).val() 
                                +'</a><div class="tag-btn-area"><i class="glyphicon glyphicon-remove tag-btn tag-btn-remove" title="删除"></i></div></li>');
                                $('#input-tag-'+courseID).animate({"width":"23px","opacity":"0"},function(){
                                    $('#input-tag-'+courseID).hide();
                                    $('.course-'+courseID+' .btn-addTags').show();
                                    $('#input-tag-'+courseID).val("");
                                });
                                renderTagsBtn();
                            });
                        }
                    }
                }
            });
        }

        renderTagsAnimeBtns();
    </script>

</body>
</html>