<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Database Connection Example</title>
</head>
<body>

<%
    // 定义数据库连接信息
    String url = "jdbc:mysql://localhost:3306/project";
    String user = "root";
    String password = "AnXin202511408!";

    // 尝试连接数据库
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, password);

        // 执行查询操作
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM teacher");

        // 显示查询结果
        out.println("<h1>教师信息：</h1>");
        out.println("<table border='1'>");
        out.println("<tr><th>ID</th><th>UID</th><th>Location</th><th>Courses</th><th>Degree</th><th>ExpectSalary</th><th>FreetimeList</th></tr>");
        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getInt("tid") + "</td>");
            out.println("<td>" + rs.getInt("uid") + "</td>");
            out.println("<td>" + rs.getString("location") + "</td>");
            out.println("<td>" + rs.getString("courses") + "</td>");
            out.println("<td>" + rs.getString("degree") + "</td>");
            out.println("<td>" + rs.getString("ExpectSalary") + "</td>");
            out.println("<td>" + rs.getString("FreetimeList") + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");

        // 关闭数据库连接
        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("数据库连接失败：" + e.getMessage());
    }
%>

</body>
</html>
