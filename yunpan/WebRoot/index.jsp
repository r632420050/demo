<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!-- c标签 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<meta charset="UTF-8" />
<head>
	<title>百度云盘技术</title>
	<!-- 布局样式 -->
	<link href="css/layout.css" rel="stylesheet" type="text/css" />
	<!-- 上传样式 -->
	<link href="js/upload/upload.css" rel="stylesheet" type="text/css" />
	<!-- jquery核心js -->
	<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
	<!-- 工具JS -->
	<script type="text/javascript" src="js/util.js"></script>
	<!-- 拖动JS -->
	<script type="text/javascript" src="js/tmdrag.js"></script>
	<!-- 弹出层js -->
	<script type="text/javascript" src="js/tmDialog.js"></script>
	<!-- 上传组件js -->
	<script type="text/javascript" src="js/upload/tz_upload.js"></script>

	<!-- 去除页面的滚动条 -->
	<style type="text/css">
		html, body{overflow: hidden;font-size:12px;color:#666;}
		a{text-decoration:none;}
		#box .name-text input{height:31px;line-height: 31px;width: 280px;}
		.select{background: #c5c5c5}
		#contentbox h1{font-size: 32px;text-align: center;margin-top: 50px;}
		.btns{background: #999;border-radius:2px;padding:8px 10px;color: #fff;}
		.page{margin:15px;line-height: 20px;height:20px;float:left;width: 100%;}
		.off{background:#ccc;padding:5px;color:#fff;}
		.on{background:green;padding:5px;color:#fff;}
		#tmpage{position: relative;top:8px;left:24px;float:left;}
		
	</style>
	<!-- 
		---初学者,有点经验
		1：先写业务,而不是先写特效。是项目里面需要他的时候自然而然就去学习的.比如:验证码，文件上传。
		2：一定是先写业务，必须一定讲业务的代表CURD 增删查改 先把数据库把保存在表中。
		3：在思考数据合法性，完整性-----验证/js /服务器端的验证也好
		
		4：删除改成逻辑删除,利用update修改表中的is_delete=1
		5：回收站就是查询is_delete=1的数据  : 还原和删除
		
	 -->
</head>
<body>
<div id="container">
  <div id="header">
   <div class="h_header">
	<div class="fl "> <a class="logo" href="https://pan.baidu.com/"></a> </div>
  	<div class="fr h_info">
  		<div class="fl h_user">
  			当前用户：<span>${user.account}</span> , 身份：<span>${user.username}</span>
  		</div>
  		<div class="fr h_out">
  			<a href="service/logout.jsp">
  				<span>退出</span>
  				<i></i>
  			</a>
  		</div>
  	</div>
   </div>		
 </div>
  <div id="mainContent">
    <div id="sidebar">
    	<ul>
				<li class="slidebar select"><a href="javascript:void(0);" onclick="fn_loadresources(this)">全部文件</a></li>
	    		<li class="slidebar"><a href="javascript:void(0);" data-type="1" onclick="fn_loadresources(this)">文件</a></li>
	    		<li class="slidebar"><a href="javascript:void(0);" data-type="2" onclick="fn_loadresources(this)">图片</a></li>
	    		<li class="slidebar"><a href="javascript:void(0);" data-type="3" onclick="fn_loadresources(this)">视频</a></li>
	    		<li class="slidebar"><a href="javascript:void(0);" data-type="4" onclick="fn_loadresources(this)">其他</a></li>
	    		<li class="slidebar"><a href="javascript:void(0);" data-type="5"  id="recycle" onclick="fn_loadresources(this)">回收站</a></li>
    	</ul>
    </div>
    <div id="content">
    	<div id="box">
			<div class="header fl" style="width: 100%;" id="contentheader">
				<div class="upload fl  t_buttons"><span id="tmupload"></span></div>
				<div class="fl tool_button newfile t_buttons" >
					<a href="javascript:void(0)">
					 <img src="images/newfile.png" width="18px" heigth="18px"/>新建文件夹</a>
				</div>
				<div class="fl tool_button t_buttons"  >
					<a href="javascript:void(0)">
					 <img src="images/download.png" width="18px" heigth="18px"/>下载</a>
				</div>
				<div class="fl tool_button"  style="display:none;" id="deletebatch" >
					<a href="javascript:void(0)">批量删除</a>
				</div>
			</div>
			<ul class="fl" style="width: 100%;" id="contentbox">
				<li id="contenttitle">
					<div class="col c1" style="width: 50%;">
		                <div class="fl"><input type='checkbox' class='chk'></div>
		                <div class="name fl"><span class="name-text">文件名</span></div>
		            </div>
		            <div class="col" style="width: 16%">大小</div>
		            <div class="col" style="width: 23%">修改时间</div>
		            <div class="col" style="width: 10%">操作</div>
				</li>
			</ul>
		</div>
    </div>
  </div>
</div>

<script type="text/javascript">
	$(function(){
		//禁止文本窗口选中
		//tm_forbiddenSelect();
		//禁止浏览器的右键
		//document.body.oncontextmenu=document.body.ondragstart= document.body.onselectstart=document.body.onbeforecopy=function(){return false;};
		//工具类的高度是自动换算的
		$("#sidebar").height(getClientHeight()-73);
		//内容栏的高度是自动换算的
		$("#content").height(getClientHeight()-75);
		//这行是浏览器改变的时候自动的改变内容和工具栏的高度
		$(window).resize(function(){
			$("#sidebar").height(getClientHeight()-73);
			$("#content").height(getClientHeight()-75);
		});
		
		//加载资源文件
		fn_loadresources();
		//执行保存文件
		$.tmUpload({"fileTypes":"*.*",
			url:"/yunpan/service/upload.jsp",//上传的路径
			callback:function(data,file){
			//alert(data);
			var jdata = eval("("+data+")");
			fn_saveresource(jdata);
		}});
		
		//编辑资源
		fn_editResource();
		
		//全选按钮
		$("#contenttitle").find(".chk").click(function(){
		  if($(this).prop("checked")){
		  	$("#contentbox").find(".items").find(".chk").prop("checked",true);
		  	$("#deletebatch").fadeIn("slow");
		  }else{
		    $("#contentbox").find(".items").find(".chk").prop("checked",false);
		    $("#deletebatch").fadeOut("slow");
		  }
		});
		
		//点击选择框
		$("#contentbox").on("click",".chk",function(){
			 if($(this).prop("checked")){
			  $("#deletebatch").stop(true,true).fadeIn("slow");
			 } 
			 if($("#contentbox").find(".chk:checked").length==0){
			  $("#deletebatch").stop(true,true).fadeOut("slow");
			 }
			 
		  
		});
		
		//点击批量删除
	    $("#deletebatch").click(function(){
		  tm_dialoag({
		  	title:"删除提示",
		    content:"你确定要删除选中的内容？",
		    callback:function(ok){
		  		if(ok){
		  		   var ids = [];
		  		   //判断勾选了哪些文件，同时获取文件的id
		  		   var $checkboxs = $("#contentbox").find(".chk:checked");
		  		   
		  		   $checkboxs.each(function(){
		  		      var opid = $(this).parents(".items").data("opid");
		  		      if(opid){
		  		      	ids.push(opid);
		  		      }
		  		   });
		  		  
		  		 // alert(ids); 
		  		  //如果没有选中 
		  		  if(ids.length<1) return;
		  		  var url;
		  		  if($("#recycle").data("isclick") == "1"){
		  		  	url="service/removeResources.jsp";
		  		  }else{
		  		    url="service/deleteResources.jsp";
		  		  } 
		  		   //请求服务器进行删除
		  		  $.ajax({
		  		  	type:"post",
		  		  	url:url,
		  		    data:{"ids":ids.toString()},
		  		    success:function(data){
		  		    	if(data.trim()=="success"){
		  		    	    $checkboxs.each(function(){
					  		   $(this).parents(".items").slideUp("slow",function(){
								 $(this).remove();
							   });
					  		 });
		  		    	   $("#deletebatch").fadeOut("slow");
		  		    	   $("#contenttitle").find(".chk").prop("checked",false);
		  		    	    alert("删除成功！");
		  		    	}else{
		  		    		alert("删除失败！");
		  		    	}
		  		    } 
		  		  }); 
		  		   
		  		   
		  		  
		  	     }
		  			 
		  	}
		  });
	    });
	    
	    
	    
		
	});
	
	/**
	* 资源加载
	*/
	function fn_loadresources(obj){
	    //重新请求资源时，把全选按钮设置为不能全选
	    $("#contenttitle").find(".chk").prop("checked",false);
		var datatype = "";
		if(obj){
			datatype = $(obj).data("type");
		}
		
		$.ajax({
			type:"post",
			url:"service/loadresource.jsp",
			data:{"type":datatype},
			success:function(data){
				if(data.trim() =="fail"){
					alert("加载数据出错");	
				}else{
					var jsonArray = eval("("+data+")");
					$("#contentbox .items").remove();
					for(i in jsonArray )
					   fn_appendresource(jsonArray[i]);
					}
				}
			});
			
		  	if($(obj).attr("id")=="recycle"){
				$("#recycle").data("isclick",1);
				$("#contentheader .t_buttons").hide();
			}else{
				$("#recycle").data("isclick",0);
				$("#contentheader .t_buttons").show();
			}	
		
	   }
	
	
	//保存文件
	function fn_saveresource(jdata){
		var name = jdata.name;
		var size = jdata.size;
		var sizeString  = jdata.sizeString;
		var newName = jdata.newName;
		var ext = jdata.ext;
		var url = jdata.url;
		var width = "100";//图片的宽度
		var height = "100";//图片的高度
		var description = "";//描述
		var folderId = 1;//对应的文件夹
		//参数设置
		var params = {
			"name":name,
			"newName":newName,
			"size":size,
			"url":url,
			"sizeString":sizeString,
			"ext":ext,
			"width":width,
			"height":height,
			"description":description,
			"folderId":folderId
		};
		
		//发送ajax
		$.ajax({
			type:"post",
			url:"/yunpan/service/saveresource.jsp",
			data:params,
			success:function(data){
				var result = data.trim();
				if(result=="fail"){
					tm_dialoag({title:"添加提示",width:340,height:200,content:"非常抱歉，文件添加失败!"});
				}else{
					var jsonData = eval("("+data+")");
					fn_appendresource(jsonData);
				}
			}
		});
	}
	
	/**
	删除资源文件
	*/
	function fn_deleteresource(obj){
		
		var opid = $(obj).data("opid");
		tm_dialoag({title:"删除提示",content:"请确认是否要删除？",
			callback:function(ok){
				//发送ajax
				$.ajax({
					type:"post",
					url:"service/deleteResource.jsp",
					data:{"id":opid},
					success:function(data){
						var result = data.trim();
						if(result=="success"){
							$(obj).parents(".items").slideUp("slow",function(){
								$(this).remove();
							});
							tm_dialoag({title:"删除提示",width:340,height:200,content:"恭喜您，文件删除成功!"});
						}else{
							tm_dialoag({title:"删除提示",width:340,height:200,content:"非常抱歉，文件删除失败!"});
						}
					}
				});	
			}
		});
		
	}
	
	//修改文件名称
	function fn_editResource(){
	
	
		$("#contentbox").on("click",".edit",function(){
			var $name = $(this).parents(".items").find(".resource-name");
			var text = $name.text();
			var html = "<input type='text' maxlength='50' class='itemvalue' value='"+text+"'/>"+
			           "&nbsp;&nbsp;&nbsp;<a href='javascript:void(0);' class='save'><img src='images/icon_ok.png' alt='保存' /></a>"+
			           "&nbsp;&nbsp;&nbsp;<a href='javascript:void(0);' class='cancle'><img src='images/icon_close.png'  alt='取消' /></a>";
			$name.html(html);
			$(this).hide();
			$name.next().hide();
			$name.find(".itemvalue").select();
			var $this = $(this);
			
			//点击取消按钮
			$name.find(".cancle").click(function(){
				alert(1);
				$name.html(text);
				$this.show();
				$name.next().show();
			});
			
			
			//保存
			$name.find(".save").click(function(){
		
				var newValue = $name.find(".itemvalue").val();
	
				//如果输入的值为空
				if(newValue =="" || newValue == text ){
					$name.find(".cancle").trigger("click");
					return;
				}

				if(newValue.length>100){
					alert("长度过长")
					return;
				}
				//alert("保存的文件名："+newValue);
				
				var id = $(this).parents(".items").data("opid");
				var ext = $name.next().text();
				$.ajax({
					type:"post",
					url:"service/updateResource.jsp",
					data:{"id":id,"name":newValue+ext},
					success:function(data){
					  if(data.trim()=="success"){						 
						 $name.next().show();
						 $name.html(newValue);
						 $this.show();
						 alert("修改成功！"); 
					  }else{
						$name.find(".cancle").trigger("click");  
						alert("修改失败！"); 
					  }	
					
				}
					
			  });
				
		});
			
	});
		
 }
	
	
	function fn_appendresource(jdata){
	
	     //如果是回收站，不增加按钮
	     var html="";
	     if($("#recycle").data("isclick") != "1"){
	            html ="    	<a href='javascript:void(0);' class='edit' ><img src='images/edit.png'></a>&nbsp;&nbsp;"+
		            "    	<a href='javascript:void(0);' data-opid='"+jdata.id+"' onclick='fn_deleteresource(this);' ><img src='images/delete.gif'></a>";
	     }
	
		$("#contentbox").append("<li class='items' data-opid='"+jdata.id+"'>"+
				"		<div class='col c1' style='width: 50%;'>"+
		        "        <div class='fl'><input type='checkbox' class='chk'>"+
		        "        <span class='icon'><img src='images/gif.png'></span></div>"+
		        "        <div class='name fl'>"+
		        "           <span class='name-text'><span class='resource-name'>"+tm_getFileName(jdata.name)+"</span><span class='fileext'>."+jdata.ext+"</span></span>"+
		        "           </div>"+
		        "    </div>"+
		        "    <div class='col' style='width: 16%'>"+jdata.sizeString+"</div>"+
		        "    <div class='col' style='width: 23%;color:green;' >"+fn_dateFormat(jdata.createTime)+"</div>"+
		        "    <div class='col buttons' style='width: 10%'>"
		        +html+
		        "    </div>"+
				"</li>");
		$("#content").height(getClientHeight()-75);
		
	}
	
	/**
	 *日期处理
	*/
	function fn_dateFormat(strDate){
		var date;
		if(strDate){
		  date = new Date(strDate);
		}else{
		  date= new Date();
		}
		
		return getTimeFormat(date) +"&nbsp;&nbsp;&nbsp;&nbsp;("+date.format("yyyy-MM-dd HH:mm:ss")+")";
		
	}
	
	
</script>
</body>
</html>
