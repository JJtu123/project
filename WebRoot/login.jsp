<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="modify.css">
    <title>123</title>
 
 
</head>
<body>
 
<section>
<%session.setAttribute("rst", ""); %>
<%session.setAttribute("del", ""); %>
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
                <h2>登录</h2>
                <form method="post" action="check.jsp">
                    <div class="inputBox">
                        <input type="text" placeholder="账号" name="user">
 
                    </div>
                    <div class="inputBox">
                        <input type="password" placeholder="密码" name="pass">
 
                    </div>
                    <div class="inputBox">
                        <input type="submit" value="登录">
 
                    </div>
                    <p class="forget">忘记密码?<a href="amend.jsp">
                        点击这里
                    </a></p>
                    <p class="forget">没有账户?<a href="register.jsp">
                        注册
                    </a></p>
                </form>
            </div>
        </div>
    </div>
</section>
</body>
 
</html>