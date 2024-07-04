<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Search Results</title>
<link href="search.css" type="text/css" rel="stylesheet" />
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
	<%}else{%>
<div class="col header">
		<div class="col header__inner">
	        <div class="col header__navwrap">
	          	<div class="col header__navbar">
	          		<a href="main.jsp" class="col header__navitem">首页</a>
	          		<a href="" class="col header__navitem"></a>
	          		<a href="" class="col header__navitem"></a>
	          		<a href="" class="col header__navitem"></a>
	          	 </div>
	         </div> 
	         <div class="col header__right">
	         	<form class="col header__search" action="search.jsp">
	         		<input type="text" class="" name="SearchText"> 
	         		<button type="submit" class="navigate">
		         		<i class="col icon iconfont icon-sousuo">
		         		</i> <!---->
	         		</button>
	         	</form> 
	         	<a id="my_messages" href="chat.jsp">
	         	<% String has_new="select * from message where (toid='"+session.getAttribute("uid")+"') and readed=1";
	         	String url_db = "jdbc:mysql://localhost:3306/project?useUnicode=true&characterEncoding=UTF-8";
                String user_db = "root";
                String password_db = "AnXin202511408!";
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn_db_nm = DriverManager.getConnection(url_db, user_db, password_db);
                Statement stmt_db_nm = conn_db_nm.createStatement();
           		ResultSet rs_db_nm = stmt_db_nm.executeQuery(has_new);	
           		if(!rs_db_nm.next()){
	         	%>
	         	<img class="message_box" alt="" src="./images/icons/no_new.png">
	         	<%}
           		else{
           		%>
           		<img class="message_box" alt="" src="./images/icons/new.png">
           		<%} 
           		conn_db_nm.close();%>
	         	</a>
	         	<div class="col header__avatarcontainer">
	         		<div class="col header__avatarwrp">
	         			<a href="detail.jsp" class="col header__avatar" target="_blank">
	         				<img id="header" class="col"  src=<%=session.getAttribute("Image") %>> <!---->
	         			</a>
	         		</div> <!---->
	         		<ul id="download" class="header__navitem--show header__navitem--account">
	         		<li class="header__userInfo"><a id="self" class="sp" href="detail.jsp">个人资料</a></li>
	         		<li class="header__userInfo"><a id="logout" class="sp" href="login.jsp" onclick="return confirm('确定登出?');">退出登录</a></li>
	         		</ul>
	         	</div>
	         </div>
	     </div>
	</div>
		<%
			String presentUid = (String)session.getAttribute("uid");
			String ToSTemp=(String)session.getAttribute("ToS");
			if (ToSTemp.equals("1"))
			{
		%>
    <div class="search-results">
        <h2>搜索结果</h2>
        <div class="results-container">
            <%
                String searchText = request.getParameter("SearchText");
                if (searchText != null && !searchText.isEmpty()) {
                    try {
                        // 连接数据库
                        String url = "jdbc:mysql://localhost:3306/project?useUnicode=true&characterEncoding=UTF-8";
                        String user = "root";
                        String password = "AnXin202511408!";
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(url, user, password);

                        // 执行查询操作
                        PreparedStatement studentStarStmt = conn.prepareStatement("SELECT * FROM student WHERE courses LIKE ?");
                        studentStarStmt.setString(1, "%" + searchText + "%");
                        ResultSet studentStarRs = studentStarStmt.executeQuery();

                        // 显示查询结果
                        while (studentStarRs.next()) {
                        	String uid = studentStarRs.getString("uid");
                        	String usrStarSql = "SELECT * FROM usr WHERE uid = '" + uid + "'";
                        	Statement usrStarStmt = conn.createStatement();
                        	ResultSet usrStarRs = usrStarStmt.executeQuery(usrStarSql);
                        	usrStarRs.next();
                        	/* 处理该学生薄弱课程courses字符串，以“,”分割 */
                        	String[] splitStudentCourses = studentStarRs.getString("courses").split(",", -1);
                        	/* 将分割后的学生薄弱科目字符串数据进行合并，中间以“，”分割 */
                        	String studentCourses = "";
                        	for (int i = 0; i < 2; i++)
                        	{
                        		if (!splitStudentCourses[i].equals(""))
                        		{
                        			studentCourses = studentCourses + " " + splitStudentCourses[i];
                        		}
                        		else
                        		{
                        			studentCourses = studentCourses + " ";
                        		}
                        	}
                        	studentCourses = studentCourses + "<br>";
                        	for (int i = 2; i < 4; i++)
                        	{
                        		if (!splitStudentCourses[i].equals(""))
                        		{
                        			studentCourses = studentCourses + " " + splitStudentCourses[i];
                        		}
                        		else
                        		{
                        			studentCourses = studentCourses + " ";
                        		}
                        	}
                        	studentCourses = studentCourses + "<br>";
                        	for (int i = 4; i < 6; i++)
                        	{
                        		if (!splitStudentCourses.equals(""))
                        		{
                        			studentCourses = studentCourses + " " + splitStudentCourses[i];
                        		}
                        		else
                        		{
                        			studentCourses = studentCourses + " ";
                        		}
                        	}
                        	studentCourses = studentCourses + "<br>";
            %>
                <div class="student-card">
                    <a href="studentDetails.jsp?sid=<%= studentStarRs.getString("sid") %>">
                    <%session.setAttribute("txt",searchText); %>
                        <div class="student-avatar">
                            <img src="<%= usrStarRs.getString("addr") %>" alt="Student Avatar">
                        </div>
                        <div class="student-info">
                            <p class="location">学生地址: <%= studentStarRs.getString("location") %></p>
                            <p class="courses">薄弱课程: </p>
                            <p class="course_item"> <%= studentCourses %></p>
                            <p class="salary">期望薪资: <%= studentStarRs.getString("ExpectSalary") %></p>
                        </div>
                    </a>
                </div>
            <%
                        }
                        // 关闭数据库连接
                        studentStarRs.close();
                        studentStarStmt.close();
                        conn.close();
                    } catch (Exception e) {
                        out.println("Database connection failed: " + e.getMessage());
                    }
                }
            %>
        </div>
    </div>
		<%
			}
			else
			{
		%>
    <div class="search-results">
        <h2>搜索结果</h2>
        <div class="results-container">
            <%
                String searchText = request.getParameter("SearchText");
                if (searchText != null && !searchText.isEmpty()) {
                    try {
                        // 连接数据库
                        String url = "jdbc:mysql://localhost:3306/project?useUnicode=true&characterEncoding=UTF-8";
                        String user = "root";
                        String password = "AnXin202511408!";
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(url, user, password);

                        // 执行查询操作
                        PreparedStatement teacherStarStmt = conn.prepareStatement("SELECT * FROM teacher WHERE courses LIKE ?");
                        teacherStarStmt.setString(1, "%" + searchText + "%");
                        ResultSet teacherStarRs = teacherStarStmt.executeQuery();

                        // 显示查询结果
                        while (teacherStarRs.next()) {
                        	String uid = teacherStarRs.getString("uid");
                        	String usrStarSql = "SELECT * FROM usr WHERE uid = '" + uid + "'";
                        	Statement usrStarStmt = conn.createStatement();
                        	ResultSet usrStarRs = usrStarStmt.executeQuery(usrStarSql);
                        	usrStarRs.next();
                        	/* 处理该教师擅长课程courses字符串，以“,”分割 */
                        	String[] splitTeacherCourses = teacherStarRs.getString("courses").split(",", -1);
                        	/* 将分割后的教师擅长科目字符串数据进行合并，中间以“，”分割 */
                        	String teacherCourses = "";
                        	for (int i = 0; i < 2; i++)
                        	{
                        		if (!splitTeacherCourses[i].equals(""))
                        		{
                        			teacherCourses = teacherCourses + " " + splitTeacherCourses[i];
                        		}
                        		else
                        		{
                        			teacherCourses = teacherCourses + " ";
                        		}
                        	}
                        	teacherCourses = teacherCourses + "<br>";
                        	for (int i = 2; i < 4; i++)
                        	{
                        		if (!splitTeacherCourses[i].equals(""))
                        		{
                        			teacherCourses = teacherCourses + " " + splitTeacherCourses[i];
                        		}
                        		else
                        		{
                        			teacherCourses = teacherCourses + " ";
                        		}
                        	}
                        	teacherCourses = teacherCourses + "<br>";
                        	for (int i = 4; i < 6; i++)
                        	{
                        		if (!splitTeacherCourses.equals(""))
                        		{
                        			teacherCourses = teacherCourses + " " + splitTeacherCourses[i];
                        		}
                        		else
                        		{
                        			teacherCourses = teacherCourses + " ";
                        		}
                        	}
                        	teacherCourses = teacherCourses + "<br>";
            %>
                <div class="teacher-card">
                    <a href="teacherDetails.jsp?tid=<%= teacherStarRs.getString("tid") %>">
                    <%session.setAttribute("txt",searchText); %>
                        <div class="teacher-avatar">
                            <img src="<%= usrStarRs.getString("addr") %>" alt="Teacher Avatar">
                        </div>
                        <div class="teacher-info">
                            <p class="location">教师地址: <%= teacherStarRs.getString("location") %></p>
                            <p class="courses">擅长课程: </p>
                            <p class="course_item"> <%= teacherCourses %></p>
                            <p class="salary">期望薪资: <%= teacherStarRs.getString("ExpectSalary") %></p>
                        </div>
                    </a>
                </div>
            <%
                        }
                        // 关闭数据库连接
                        teacherStarRs.close();
                        teacherStarStmt.close();
                        conn.close();
                    } catch (Exception e) {
                        out.println("Database connection failed: " + e.getMessage());
                    }
                }
            %>
        </div>
    </div>
		<%
			}
	}
		%>
</body>
</html>
