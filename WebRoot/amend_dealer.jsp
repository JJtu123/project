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
<%
String testid=(String)session.getAttribute("uid");
	if(testid==null)
	{%>
         <script type="text/javascript">
      	    alert("尚未登录!请先登录!");
      	 	window.location.href="login.jsp";
      	 </script>	
	<%}%>
<form method="post" action="">

    <%

        String user1 = request.getParameter("user");
		session.setAttribute("rst",user1);
        String pass1 = request.getParameter("pass");
        String pass2 = request.getParameter("pass1");
        String question=request.getParameter("que");
        String answer=request.getParameter("ans");
    	//接收用户名和密码  
    	String driverClass = "com.mysql.jdbc.Driver";
    	String url = "jdbc:mysql://localhost:3306/project?useSSL=false&serverTimezone=UTC";
    	String urn = "root";
    	String psw = "AnXin202511408!";
    	Class.forName(driverClass);//加载驱动 
    	Connection conn = DriverManager.getConnection(url,urn,psw);//得到连接
    	String cmp="select * from usr where uid='"+user1+"' and question='"+question+"' and answer='"+answer+"'";
    	Statement cmpt = conn.createStatement();
		ResultSet rest=cmpt.executeQuery(cmp);

    	if(conn != null){
    		if(!rest.next()){
   			 %>
   		       	<script type="text/javascript">
   		       	    alert("您的账号或者密保不正确!\n请重新输入!");
   		       	 	window.location.href="amend.jsp";
   		       	 </script>
   				<%
   		}
    		else if(pass1.equals(pass2)){
    			String sql = "update usr set pwd='"+pass2+"' where uid='"+user1+"'";
        		Statement stmt = conn.createStatement();
        		stmt.execute(sql);
        %>
       	<script type="text/javascript">
       	    alert("重置成功!\n请牢记你的密码!");
       	 	window.location.href="login.jsp";
       	 </script>
		<%
            		}
            	else	    	               	
            	{
         %>
         <script type="text/javascript">
       	    alert("两次输入的密码不一致,重置失败!");
       	 	window.location.href="amend.jsp";
       	 </script>
         <%
    		}            				
    	}									
    	conn.close();
    %>
</form>
</body>
</html>
