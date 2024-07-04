<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>处理申请</title>
</head>
<body>
<%
    String fromid = request.getParameter("fromid");
    String toid = request.getParameter("toid");
    String location = request.getParameter("location");
    String salary = request.getParameter("salary");
    String course = request.getParameter("course");
    String btime = request.getParameter("btime");
    String etime = request.getParameter("etime");
    String text = request.getParameter("text");
    String feedback = "";
    
    try {
        String url = "jdbc:mysql://localhost:3306/project?useUnicode=true&characterEncoding=UTF-8";
        String user = "root";
        String password = "AnXin202511408!";
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, password);

        String sql = "INSERT INTO message (mid, fromid, toid, location, salary, course, btime, etime, text, feedback, FromOrTo, readed, ApproveOrReject, solved) VALUES (0, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, 1, 2, 0)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, fromid);
        ps.setString(2, toid);
        ps.setString(3, location);
        ps.setString(4, salary);
        ps.setString(5, course);
        ps.setString(6, btime);
        ps.setString(7, etime);
        ps.setString(8, text);
        ps.setString(9, feedback);
        int result = ps.executeUpdate();
        if(request.getParameter("tos").equals("1")){
	        if (result > 0) {
	            //out.println("申请提交成功！");
	            %>
	            <script type="text/javascript">
	        		alert("申请提交成功！");
	        		window.location.href="teacherDetails.jsp";
	        	</script>
	        	<%
	        } 
	        else {
	            //out.println("申请提交失败！");
	        	%>
	            <script type="text/javascript">
	        		alert("申请提交成功！");
	        		window.location.href="teacherDetails.jsp";
	        	</script>
	        	<%
	        	}
        }
        else{
            if (result > 0) {
                //out.println("申请提交成功！");
                %>
                <script type="text/javascript">
            		alert("申请提交成功！");
            		window.location.href="studentDetails.jsp";
            	</script>
            	<%
            } 
            else {
                //out.println("申请提交失败！");
            	%>
                <script type="text/javascript">
            		alert("申请提交成功！");
            		window.location.href="studentDetails.jsp";
            	</script>
            	<%
            	}
            }
        
        ps.close();
        conn.close();
    } catch (Exception e) {
        out.println("Database connection failed: " + e.getMessage());
    }
%>
</body>
</html>
