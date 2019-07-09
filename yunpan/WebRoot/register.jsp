<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.yunpan.dao.*" %>
<%@ page import="com.yunpan.bean.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
  <head>

    
    <title>注册页面</title>
    <meta charset="UTF-8">
	<style type="text/css">
   
        *{
           margin:0;padding:0;font-size:14px;font-family:"微软雅黑"
        }

	    body{
		    margin:0;padding:0;    
			font-family: '微软雅黑';
			font-size:14px;
            /*background:rgba(255, 255, 255, 0.55);*/
            overflow：hidden;
		}   

        .container{
          
          margin:20px auto;
          width:330px;
          height:600px;
          border:1px solid #ccc;
          padding:20px;
          box-shadow: 1px 1px 5px 1px #ccc;
          background:rgba(255, 255, 255, 1)
        }
        
        .items{
         margin:10px 0 0 10px;
        }
        
        input[type="text"],input[type="password"]{
          height:35px;
          width:300px;
          outline:none;
	      border:1px solid #ccc;
          background:none;
        }
        

        
        input[type="button"]{
            height: 40px;
		    width: 300px;
		    background: #007fff;
            margin:10px 0 0 10px;
		    border: none;
		    border-radius: 5px;
		    font-size: 18px;
		    color: #ffff;
        }
        
        input[type="button"]:hover{
          background: #479df3;
        }
        input:hover{
         border:1px solid #007fff;
        }
        
        
         textarea{
         font-family: '微软雅黑';
		 font-size:14px;
         width:300px;
         height:100px;
         resize:none;
         
         }
         select{
         
         /*关键：将默认的select选择框样式清除/*/
          appearance:none;
          -moz-appearance:none;
          -webkit-appearance:none;
          height:30px;
          width:100px;
          text-align:center;
         }

         #code{
          width:200px;
         }
         img{
          margin-left:10px;
          /*使得input和img在同一行居中对齐的方法:1、网站搜到最多的就是给img添加一个align="absmiddle"属性   或者下面的方法*/
          vertical-align:middle;
         }
         #area{
          width:95px;
         }

    </style>


  </head>
  
  <%
    List<Province> provinces = ProvinceDao.findProvinces();
    pageContext.setAttribute("provinces", provinces);
 
   %>

<body>
      <div class="container">
        <h1>注册</h1>
        <form method="post">
           <div class="items"><input type="text" id="account" name="account" placeholder="请输入注册账号"  autocomplete="off" maxlength="20" /></div>
           <div class="items"><input type="password" id="password" name="password" placeholder="请输入密码(不少于6位)" maxlength="20" /></div>
           <div class="items"><input type="text" id="nickname" name="nickname" placeholder="请输入用户名"  autocomplete="off" maxlength="50" /></div>
           <div class="items"><input type="text" id="telephone"  name="telephone" placeholder="请输入电话号码"  autocomplete="off" maxlength="50" /></div>
           <div class="items"><input type="text" id="email"   name="email" placeholder="请输入邮箱"  autocomplete="off" maxlength="50" /></div>
           <div class="items">
                 <label><input type="radio" name="male" value="1" checked="checked"> 男</label>
                 <label><input type="radio" name="male" value="2"> 女 </label>
           
               <label><input type="checkbox" name="hobby" value="1"> A</label>
               <label><input type="checkbox" name="hobby" value="2"> B </label>
               <label><input type="checkbox" name="hobby" value="3"> O </label>
           </div>
           <div class="items" style="height:40px;">
             <input type="text" id="code" name="code" placeholder="请输入验证码"  autocomplete="off" maxlength="20" /> <img onclick="this.src='service/validatecode.jsp?date='+Math.random();" src="service/validatecode.jsp"/>
           </div>
           <div class="items">
           	<select id="province" name="province" onchange="fn_select_citys(this)">
           		<option value="">省份</option>
           		<c:forEach var="pv" items="${provinces}">
           		 <option data-id="${pv.id}" value="${pv.province}">${pv.province}</option>
           		</c:forEach>
           	</select>
           	<select id="city" name="city" onchange="fn_select_areas(this)">
           		<option value="">城市</option>
           	</select>
           	<select id="area" name="area">
           		<option value="">县、区</option>
           	</select>
           </div>
           <div class="items"><textarea name="remarks"  id="remarks" placeholder="请输入描述信息"></textarea>   </div>
           <input type="button"  value="注册"  onclick="fn_register()"/>
          </form>
    </div>
    

    
    <script type="text/javascript" src="js/jquery-1.11.1.min.js"></script> 	
    <script type="text/javascript">
    	
    	  
    	  //根据省份ID查询所有的城市信息
    	  function fn_select_citys(obj){
    	    var provinceId = $(obj).find("option:selected").data("id");
    	    //alert(provinceId);
    	    if(!provinceId){ 
    	       $("#city").html("<option value=''>城市</option>"); 
    	       $("#area").html("<option value=''>县、区</option>"); 
    	       return;
    	    }
    	     //发送一个ajax请求根据provinceId查询对应的城市信息，将查询的信息添加到id=city的select框中
    	     $.ajax({
    	       type:"post",  //请求方式get/post
    	       url:"service/city.jsp", //请求对应的地
    	       data:{"provinceId":provinceId}, //往服务器传递的参数
    	       success:function(data){  //服务器交互成功调用的回调函数，data就是服务端传递出来的数据
    	         var result = data.trim();
    	         if(result == "fail"){
    	          alert("查询失败");
    	         }else{
    	           //将字符串的json转换为对象的json
    	           var jdata = eval(result);
    	           //
    	           var html = "<option value=''>城市</option>";
    	           var length=jdata.length;
    	           for(var i=0;i<length;i++){
    	             html = html +"<option data-id='"+jdata[i].id+"' value='"+jdata[i].city+"'>"+jdata[i].city+"</option>";
    	           }
    	           $("#city").html(html);
    	         }
    	       }
    	     });
    	  }
    	  
    	  //根据城市Id查询县、区
    	  function fn_select_areas(obj){
    	  
    	    var cityId = $(obj).find("option:selected").data("id");
    	    //alert(cityId);
    	    if(!cityId){
    	      $("#area").html("<option value=''>县、区</option>"); 
    	       return;
    	    }
    	    $.ajax({
    	      type:"post", //请求的方式 post
    	      url:"service/area.jsp", //请求的url地址
    	      data:{"cityId":cityId}, //请求的参数
    	      success:function(data){ //请求成功后的回调函数
    	        var result = data.trim();
    	        if(result=="fail"){
    	         alert("查询失败");
    	        }else{
    	          //将json字符串转换为json数组
    	          var jdata = eval(result);
    	          var html ="<option value=''>县、区</option>";
    	          var length = jdata.length;
    	          
    	          for(var i=0; i<length ; i++){
    	            html = html + "<option data-id='"+jdata[i].id+"' value='"+jdata[i].area+"'>"+jdata[i].area+"</option>";
    	          }
    	          $("#area").html(html);
    	        }
    	        
    	      }
    	    
    	    });
    	    
    	  }
    	  
    	  //注册功能 
    	  function fn_register(){
              //返回的是一个字符串
    	      var $serializedata = $('form').serialize();
    	      alert($serializedata);
    	      
    	         var d = {};
    	        //返回的是一个json对象数组
			    var t = $('form').serializeArray();
	
			    $.each(t, function() {
			       ///判断值是否有同名的多个数据  例如checkbox这个情况 就需要特殊处理
			      if(d[this.name]){
			         d[this.name] = d[this.name] +","+ this.value;
			      }else{
			         d[this.name] = this.value;
			      }
			    });
			    
			    alert(JSON.stringify(d));	    
    	      
    	      $.ajax({
    	        type:"post", //请求的方式
    	        url:"service/user.jsp", //请求的url地址
    	        data:$serializedata,  //传入的参数
    	        success:function(data){  //请求成功后返回的参数
    	        
    	          var result = data.trim();
    	          if(result == "success"){
    	            alert("保存成功");
    	            window.location.href="login.html";
    	          }else{
    	            alert("保存失败");
    	          }
    	        }
    	      
    	      });
    	      
    	      
    	      //清除页面：
    	      
//     	    $("#account").val("");
//     	    $("#password").val("");
//     	    $("#telephone").val("");
//     	    $("#nickname").val("");
//     	    $("#email").val("");
//             $("#province").val("");
//     	    $("#city").val("");
//     	    $("#area").val("");
    	    $("#code").val("");
//     	    $("#remarks").val("");
//     	    $("input:checkbox").prop("checked",false);
    	      
    	      
    	    //  alert(121);
    	      
  
			    
			 
			     
    	      
    	     //     	  单行文字：$("#text").val();
//       密码：$("#pass").val();
//       单选：$("input:radio:checked").val();
//       多选：遍历 $("input:checkbox"),判断是否选中
//       下拉：$("#select").val();
//       或者$("#select option:select").val();
//       多行文字：$("textarea").val();
    	  
//     	    var account = $("#account").val();
//     	    var password = $("#password").val();
//     	    var telephone = $("#telephone").val();
//     	    var email  = $("#email").val();
//     	    var male = $("input:radio:checked").val();
//     	    var privince = $("#privince").val();
//     	    var city = $("#city").val();
//     	    var area = $("#area").val();
//     	    var remarks = $("#remarks").val();
    	    
//     	    var params = {
//     	        "account":account,
//     	        "password":password,
//     	        "telephone":telephone,
//     	        "email":email,
//     	        "male":male,
//     	        "privince":privince,
//     	        "city":city,
//     	        "area":area,
//     	        "remarks":remarks
//     	    }
//     	    alert(params);
//     	    alert(JSON.stringify(params));
    	      
    	  }
    		
    
    </script>
    

</body>
</html>

