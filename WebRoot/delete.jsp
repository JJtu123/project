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
                <h2>注销账户</h2>
                <form method="post" action="delete_dealer.jsp">
                    <div class="inputBox">
                        <input type="text" placeholder="请输入要注销的账号" name="user" value=<%=session.getAttribute("del") %>>
 
                    </div>
                    <div class="inputBox">
                        <input type="password" placeholder="密码" name="pass">
 
                    </div>
                     <div class="inputBox">
                        <input type="text" placeholder="请输入您的密保问题" name="que">
 
                    </div>
                                          <div class="inputBox">
                        <input type="text" placeholder="请输入您的密保答案" name="ans">
 
                    </div>
                    <div class="inputBox">
                        <input type="submit" value="注销" onclick="return confirm('确定注销?')">
 
                    </div>
                     <p class="forget"><a href="main.jsp">返回主界面
                    </a></p>
                </form>
            </div>
        </div>
    </div>
</section>
</body>
 
</html>