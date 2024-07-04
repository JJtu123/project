<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*"%>
<html>
<head>
    <title>检查界面</title>
</head>
<body>

<form method="post" action="">

    <%
        String uid = (String)session.getAttribute("uid");
        //String tuid = (String)session.getAttribute("tuid");
        //String comment=request.getParameter("comment");
        //String rate=request.getParameter("star");
        String tuid = request.getParameter("tuid");
        String comment=request.getParameter("comment");
        String rate=request.getParameter("star");
    	//接收用户名和密码  
    	String driverClass = "com.mysql.jdbc.Driver";
    	String url = "jdbc:mysql://localhost:3306/project?useSSL=false&serverTimezone=UTC";
    	String urn = "root";
    	String psw = "AnXin202511408!";
    	Class.forName(driverClass);//加载驱动 
    	Connection conn = DriverManager.getConnection(url,urn,psw);//得到连接
    	if(conn != null){
    		session.setAttribute("visit_teacher", tuid);
    		String sql = "insert into comments values (0,'"+uid+"','"+tuid+"','"+comment+"','"+rate+"')";	//验证账号密码
    		Statement stmt = conn.createStatement();
    		stmt.execute(sql);			              				
        	conn.close();
    	}									
    	response.sendRedirect("teacherDetails.jsp");
    %>
</form>
</body>
</html>

