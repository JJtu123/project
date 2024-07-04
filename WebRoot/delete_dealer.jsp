<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*"%>
<html>
<head>
    <title>检查界面</title>
     <script>
    // 显示警告框
    function showAlert(String Msg) {
      alert(Msg);
    }
  </script>
</head>
<body>

<form method="post" action="">

    <%

        String user1 = request.getParameter("user");
		session.setAttribute("rst",user1);
        String pass1 = request.getParameter("pass");
        String question=request.getParameter("que");
        String answer=request.getParameter("ans");
    	//接收用户名和密码  
    	String driverClass = "com.mysql.jdbc.Driver";
    	String url = "jdbc:mysql://localhost:3306/project?useSSL=false&serverTimezone=UTC";
    	String urn = "root";
    	String psw = "AnXin202511408!";
    	Class.forName(driverClass);//加载驱动 
    	Connection conn = DriverManager.getConnection(url,urn,psw);//得到连接
    	if(conn != null){
    			String sql = "select * from usr where uid='"+user1+"' and pwd='"+pass1+"' and question='"+question+"' and answer='"+answer+"'";	//验证账号密码
        		Statement stmt = conn.createStatement();
        		ResultSet rs =stmt.executeQuery(sql);
        		if(!rs.next()){
        			%>
          <script type="text/javascript">
       	    alert("注销失败!\n请检查您的账号密码以及密保是否正确!");
       	 	window.location.href="delete.jsp";
       	 </script>
        			<%
        		}
        		else{
        			sql = "delete from usr where uid='"+user1+"'";
        			stmt = conn.createStatement();
        			stmt.execute(sql);
        			String tos=(String)session.getAttribute("ToS");
        			if(tos.equals("1")){
        				sql = "select tid from teacher where uid='"+user1+"'";
            			stmt = conn.createStatement();
            			ResultSet rs_t=stmt.executeQuery(sql);
            			rs_t.next();
            			sql = "delete from comments where tid='"+rs_t.getString("tid")+"'";
            			stmt = conn.createStatement();
            			stmt.execute(sql);
        			}
        			sql = "delete from teacher where uid='"+user1+"'";
        			stmt = conn.createStatement();
        			stmt.execute(sql);
        			sql = "delete from message where fromid='"+user1+"' or toid='"+user1+"'";
        			stmt = conn.createStatement();
        			stmt.execute(sql);
        			sql = "delete from student where uid='"+user1+"'";
        			stmt = conn.createStatement();
        			stmt.execute(sql);
        			sql = "delete from comments where uid='"+user1+"'";
        			stmt = conn.createStatement();
        			stmt.execute(sql);
        			
        %>
       	<script type="text/javascript">
       	    alert("注销成功!");
       	 	window.location.href="login.jsp";
       	 </script>
		<%
            		}						
    	conn.close();
    	}
    %>
</form>
</body>
</html>