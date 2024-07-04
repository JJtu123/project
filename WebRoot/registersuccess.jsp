<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*,java.util.Random"%>
<html>
<head>
    <title>注册成功界面</title>
    <style type="text/css">
        .center{
            text-align:center;
            margin-top: 50px;
        }
        .fon{
            font-size: 40px;
        }
        .fon1{
            font-size: 20px;
        }
        body{
            background: url("images/wallhaven-wqrm7r.jpg");
            background-size: 100% 100%;
        }
        input {
            background-color: transparent;
            outline: none;
            color: black;
        }
    </style>
</head>
<body>
<form method="post" action="check.jsp">
    <%
        String user = null;
        String pass = null;
        String ToS	= null;
        String question=request.getParameter("question");
        String answer=request.getParameter("answer");
        if(request.getParameter("user")!="" && request.getParameter("pass") != "")
        {
            user = request.getParameter("user");
            pass = request.getParameter("pass");
            ToS	 = request.getParameter("ToS");
            String driverClass = "com.mysql.jdbc.Driver";
        	String url = "jdbc:mysql://localhost:3306/project?useSSL=false&serverTimezone=UTC";
        	String urn = "root";
        	String psw = "AnXin202511408!";
        	String str="0123456789";
        	Class.forName(driverClass);//加载驱动 
        	Connection conn = DriverManager.getConnection(url,urn,psw);//得到连接
            Random random=new Random();
            StringBuffer uid=new StringBuffer();
            boolean flag=true;
            while(flag){
            	for(int i=0;i<15;i++){
                    int number=random.nextInt(10);
                    while(i==0 && number==0){
                  	  number=random.nextInt(10);
                    }
                    uid.append(str.charAt(number));
                  }
            	if(conn != null){
            		String sql = "select * from usr where uid='"+uid+"'";	//验证账号密码
            		Statement stmt = conn.createStatement();
            		ResultSet rs = stmt.executeQuery(sql);			
                		if(rs.next())
         					flag=true;
                		else	    	               	
            				flag=false;          				
            	}	
            }
        	if(conn != null){
        		String sql = "insert into usr values ('"+uid+"',"+ToS+",'"+user+"','"+ pass + "','','','./images/icons/default.png','"+question+"','"+answer+"','1000-01-01 00:00:00')";	//验证账号密码
        		Statement stmt = conn.createStatement();
        		stmt.execute(sql);			            
        		if(ToS.equals("1")){
        			sql = "insert into teacher values (0, '"+uid+"','',',,,,,','','','::,::,::,::,::,::,::,::,::,::,::,::')";
        			stmt = conn.createStatement();
            		stmt.execute(sql);
        		}
        		else{
        			sql = "insert into student values (0, '"+uid+"','',',,,,,','','','::,::,::,::,::,::,::,::,::,::,::,::')";
        			stmt = conn.createStatement();
            		stmt.execute(sql);
        		}
        	}									
        	conn.close();
        
    %>

         <script type="text/javascript">
      	    alert("注册成功!\n您的账号为:"+<%=uid%>+"\n请牢记您的账号密码!");
      	 	window.location.href="login.jsp";
      	 </script>	
	<%
        }
	%>
</form>
</body>
</html>

