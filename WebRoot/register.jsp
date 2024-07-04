<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="modify.css">
    <title>123</title>
</head>
<body>
<section>
<div class="color"></div>
    <div class="color"></div>
    <div class="color"></div>
    <div class="box">
    <div class="circle" style="--x:0"></div>
    <div class="circle" style="--x:1"></div>
    <div class="circle" style="--x:2"></div>
    <div class="circle" style="--x:3"></div>
    <div class="circle" style="--x:4"></div>
    <div class="container">
        <div class="form">
            <h2>注册</h2>
    		<form method="post" action="registersuccess.jsp">
                    <div class="inputBox">
                        <input type="text" placeholder="请输入用户名" name="user" value=<%=session.getAttribute("rst") %>>
 
                    </div>
                    <div class="inputBox">
                        <input type="password" placeholder="请输入密码" name="pass">
                    </div>
                    <div class="inputBox">
                        <input type="text" placeholder="请输入密保问题" name="question">
                    </div>
                   <div class="inputBox">
                        <input type="text" placeholder="请输入密保答案" name="answer">
                    </div>
                    <div class="inputBox">  
 						<select id="sec" style="width: 300px;height: 50px" name="ToS"><option value="1">教师</option><option value="0">学生</option></select>
                    </div>
                    <div class="inputBox">
                        <input type="submit" value="确认">
 
                    </div>

                     <p class="forget">返回登录<a href="login.jsp">
                        登录
                    </a></p>
                </form>
    </div>
    </div>
    </div>
    </section>
</body>
</html>

