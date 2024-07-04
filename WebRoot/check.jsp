<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*"%>
<html>
<head>
    <title>检查界面</title>
</head>
<body>

<form method="post" action="">

    <%
        String user1 = request.getParameter("user");
        String pass1 = request.getParameter("pass");
    	//接收用户名和密码  
    	String driverClass = "com.mysql.jdbc.Driver";
    	String url = "jdbc:mysql://localhost:3306/project?useSSL=false&serverTimezone=UTC";
    	String urn = "root";
    	String psw = "AnXin202511408!";
    	Class.forName(driverClass);//加载驱动 
    	Connection conn = DriverManager.getConnection(url,urn,psw);//得到连接
    	if(conn != null){
    		String sql = "select * from usr where uid='"+user1+"' and pwd='"+ pass1 + "'";	//验证账号密码
    		Statement stmt = conn.createStatement();
    		ResultSet rs = stmt.executeQuery(sql);			
        		if(rs.next())
        		{
        			session.setAttribute("uid",user1 );
        			session.setAttribute("ToS",rs.getString("TeacherOrStudent") );
        			session.setAttribute("Image",rs.getString("addr")  );
        			%>
        	         <script type="text/javascript">
        	       	    alert("登陆成功!");
        	       	 	window.location.href="main.jsp";
        	       	 </script>
        		<% 
        		}
        		else	
        			%>
        	  <script type="text/javascript">
           	    alert("登陆失败!\n请检查您的账号和密码是否正确!");
           	 	window.location.href="login.jsp";
           	 </script>            				
    	<%
    	conn.close();
    	}									
    	

    %>
</form>
</body>
</html>

