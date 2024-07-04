<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Submit Comment</title>
</head>
<body>
<%
    // 获取提交的评论内容、星级和教师ID
    String comment = request.getParameter("commentText");
    String starRating = request.getParameter("star");
    String teacherId = request.getParameter("tid");

    // 请将下面的代码替换为你的数据库连接信息和逻辑
    // 这里假设已经在会话中保存了用户信息
    String userId = (String)session.getAttribute("uid");

    // 确保评论内容和教师ID不为空
    if (comment != null && !comment.isEmpty() && teacherId != null && !teacherId.isEmpty()) {
        try {
            // 连接数据库，请替换为你的数据库连接信息
            String url = "jdbc:mysql://localhost:3306/project";
            String user = "root";
            String password = "AnXin202511408!";
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            // 插入评论和星级到数据库中
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO comments VALUES (0, ?, ?, ?, ?)");
            stmt.setString(1, userId);
            stmt.setString(2, teacherId);
            stmt.setString(3, comment);
            stmt.setString(4, starRating);
            stmt.executeUpdate();

            // 关闭数据库连接
            stmt.close();
            conn.close();
        } catch (Exception e) {
            // 处理数据库连接异常
            out.println("Database connection failed: " + e.getMessage());
        }
    }

    // 重定向回教师详情页面
    response.sendRedirect("teacherDetails.jsp?tid=" + teacherId);
%>
</body>
</html>
