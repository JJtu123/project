<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*"%>
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
                <h2>重置密码</h2>
                <form method="post" action="amend_dealer.jsp">
                    <div class="inputBox">
                        <input type="text" placeholder="账号" name="user" value=<%=session.getAttribute("uid")==null?"":session.getAttribute("uid") %>>
 
                    </div>
                    <div class="inputBox">
                        <input type="password" placeholder="新密码" name="pass">
 
                    </div>
                     <div class="inputBox">
                        <input type="password" placeholder="确认密码" name="pass1">
 
                    </div>
                      <div class="inputBox">
                        <input type="text" placeholder="请输入您的密保问题" name="que">
 
                    </div>
                                          <div class="inputBox">
                        <input type="text" placeholder="请输入您的密保答案" name="ans">
 
                    </div>
                    <div class="inputBox">
                        <input type="submit" value="确认">
 
                    </div>
                    <p class="forget">没有账户?<a href="register.jsp">
                        注册
                    </a></p>
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