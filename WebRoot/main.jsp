<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Home</title>
<link href="main.css" type="text/css" rel="stylesheet" />
<script>
function searchTeachers() {
    var searchText = document.getElementById("SearchText").value;
    // 发送课程名称到服务器进行处理
    // 这里可以使用Ajax技术发送异步请求到服务器，以便实现无刷新查询
    // 假设我们在这里直接调用search.jsp进行查询
    window.location.href = "search.jsp?searchText=" + searchText;
}

function showMoreTeachers() {
    var teachers = document.querySelectorAll('.teacher');
    for (var i = 0; i < teachers.length; i++) {
        teachers[i].style.display = 'block';
    }
    document.querySelector('.more-teachers').style.display = 'none';
}

function showMoreStudents() {
    var students = document.querySelectorAll('.student');
    for (var i = 0; i < students.length; i++) {
        students[i].style.display = 'block';
    }
    document.querySelector('.more-students').style.display = 'none';
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
			String uid = (String)session.getAttribute("uid");
			String ToSTemp=(String)session.getAttribute("ToS");
			if (ToSTemp.equals("1"))
			{
		%>
				 <!-- 添加“今日要闻”标题 -->
    <h2 class="headline teacherHead">今日要闻</h2>
	<!-- 新增的图片轮播部分 -->
    <div class="slideshow-container">
        <div class="slideshow-img-container">
            <img src="images/avatar/background_01.jpg" style="width:100%">
            <img src="images/avatar/background_02.jpg" style="width:100%">
            <img src="images/avatar/background_03.jpg" style="width:100%">
            <img src="images/avatar/background_04.jpg" style="width:100%">
            <img src="images/avatar/background_05.jpg" style="width:100%">
        </div>
    </div>
    
    <div class="recommended-students">
        <h2>推荐学生</h2>
        <div class="student-card">
            <!-- 这里放置推荐的学生信息 -->
            <% 
            try {
                if (uid != null && !uid.isEmpty()) {
                	/* 连接数据库 */
                    String url = "jdbc:mysql://localhost:3306/project?useUnicode=true&characterEncoding=UTF-8";
                    String user = "root";
                    String password = "AnXin202511408!";
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(url, user, password);
					/* 查找当前用户对应的教师tid */
                    PreparedStatement teacherTidStmt = conn.prepareStatement("SELECT tid FROM teacher WHERE uid = ?");
                    teacherTidStmt.setString(1, uid);
                    ResultSet teacherTidRs = teacherTidStmt.executeQuery();
                    teacherTidRs.next();
                    String tid = teacherTidRs.getString("tid");
                    /* 查找当前教师所选擅长课程 */
                    PreparedStatement teacherCoursesStmt = conn.prepareStatement("SELECT courses FROM teacher WHERE tid = ?");
                    teacherCoursesStmt.setString(1, tid);
                    ResultSet teacherCoursesRs = teacherCoursesStmt.executeQuery();
                    String teacherCourses=null;
                    if(teacherCoursesRs.next()) {
                    	// 创建一个Map，存储学生uid和对应的最近被申请时间
						Map<String, LocalDateTime> studentApplications = new HashMap<>();
						// 定义日期时间格式
			            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                    	/* 当前教师选择了课程 */
                        teacherCourses = teacherCoursesRs.getString("courses");
						/* 将教师所选课程courses字符串以“,”为分隔符进行分割 */
						String[] splitTeacherCourses = teacherCoursesRs.getString("courses").split(",", -1);
						for (int i = 0; i < splitTeacherCourses.length; i++)
						{
							if (!splitTeacherCourses[i].equals(""))
							{
								/* 查询符合教师某一课程的学生信息 */
								PreparedStatement studentStarStmt = conn.prepareStatement("SELECT * FROM student WHERE courses LIKE ?");
								studentStarStmt.setString(1, "%" + splitTeacherCourses[i] + "%");
								ResultSet studentStarRs = studentStarStmt.executeQuery();
								/* 遍历符合当前教师擅长课程的学生，并将结果保存在Map中 */
								while (studentStarRs.next()) {
									String tmpUid = studentStarRs.getString("uid");
									/* 查询该学生对应的最近被申请时间 */
									PreparedStatement usrLastApplyTimeStmt = conn.prepareStatement("SELECT lastApplyTime FROM usr WHERE uid = ?");
									usrLastApplyTimeStmt.setString(1, tmpUid);
									ResultSet usrLastApplyTimeRs = usrLastApplyTimeStmt.executeQuery();
									if (usrLastApplyTimeRs.next())
									{
										String tmpStringLastApplyTime = usrLastApplyTimeRs.getString("lastApplyTime");
										// 解析字符串为LocalDateTime
					                	LocalDateTime tmpLastApplyTime = LocalDateTime.parse(tmpStringLastApplyTime, formatter);
					                	studentApplications.put(tmpUid, tmpLastApplyTime);
									}
								}
							}
						}
						// 将Map的entrySet转换为List
						List<Map.Entry<String, LocalDateTime>> entryList = new ArrayList<>(studentApplications.entrySet());
						// 使用Comparator对List进行排序（按照最近被申请时间排序）
			            Collections.sort(entryList, new Comparator<Map.Entry<String, LocalDateTime>>() {
			                @Override
			                public int compare(Map.Entry<String, LocalDateTime> entry1, Map.Entry<String, LocalDateTime> entry2) {
			                    return entry1.getValue().compareTo(entry2.getValue()); // 按值（最近被申请时间）升序排序
			                }
			            });
						// 遍历所有键，即按照学生最近被申请时间由小到大的顺序遍历学生uid
						for (Map.Entry<String, LocalDateTime> entry : entryList)
						{
							String keyUid = entry.getKey();
							String lastApplyTime = entry.getValue().format(formatter);
							PreparedStatement tmpStmt = conn.prepareStatement("SELECT * FROM student WHERE uid = ?");
							tmpStmt.setString(1, keyUid);
							ResultSet tmpRs = tmpStmt.executeQuery();
							if (tmpRs.next())
							{
								/* 将学生薄弱科目courses字符串以“,”为分隔符进行分割 */
         						String[] splitStudentCourses = tmpRs.getString("courses").split(",", -1);
                            	/* 将分割后的学生薄弱科目字符串数据进行合并，中间以“，”分割，同时防止空字符串造成的异常 */
                            	String studentCourses = "";
                            	for (int j = 0; j < 6; j++)
                            	{
                            		if (j < splitStudentCourses.length - 1)
                            		{
                            			studentCourses = studentCourses + "\t" + splitStudentCourses[j] + "<br>";
                            		}
                            		else
                            		{
                            			studentCourses = studentCourses + "<br>";
                            		}
                            	}
         						/* 查找当前学生uid，从而查找学生头像 */
         						String studentUid = tmpRs.getString("uid");
         						String usrStarSql = "SELECT * FROM usr WHERE uid = '"+ studentUid + "'";
         						Statement usrStarStmt = conn.createStatement();
         						ResultSet usrStarRs = usrStarStmt.executeQuery(usrStarSql);
         						usrStarRs.next();
        %>
            <div class="student">
                <img src="<%= usrStarRs.getString("addr") %>" alt="学生头像">
                <p>用户名:<%= usrStarRs.getString("uname") %></p>
                <p>学生地址:<%= tmpRs.getString("location") %></p>
                <p class="courses">薄弱课程:</p><p class="course_items"> <%= studentCourses %> </p>
                <p class="salary">期望薪资:<%= tmpRs.getString("ExpectSalary") %> </p>
                <%session.setAttribute("txt", "main"); %>
                <a href="studentDetails.jsp?sid=<%= tmpRs.getString("sid") %>&txt=<%="main"%>" class="view-detail-button">显示详情</a>
            </div>
        <%
        						usrStarRs.close();
        						usrStarStmt.close();
							} // if (tmpRs.next())
						} // for (Map.Entry<String, LocalDateTime> entry : entryList)
                        //conn.close();
                    	teacherCoursesRs.close();
                    	teacherCoursesStmt.close();
                	} // if(teacherCoursesRs.next())
                } // if (uid != null && !uid.isEmpty())
            } catch (Exception e) {
                out.println("数据库连接失败：" + e.getMessage());
            }
            %>
        </div>
        <!-- 更多按钮，点击展示剩余的学生 -->
        <a href="#" class="more-students" onclick="showMoreStudents()">更多</a>
    </div>
		<%
			}
			else
			{
		%>
    <!-- 添加“今日要闻”标题 -->
    <h2 class="headline tercherHead">今日要闻</h2>
	<!-- 新增的图片轮播部分 -->
    <div class="slideshow-container">
        <div class="slideshow-img-container">
            <img src="images/avatar/background_01.jpg" style="width:100%">
            <img src="images/avatar/background_02.jpg" style="width:100%">
            <img src="images/avatar/background_03.jpg" style="width:100%">
            <img src="images/avatar/background_04.jpg" style="width:100%">
            <img src="images/avatar/background_05.jpg" style="width:100%">
        </div>
    </div>

    <div class="recommended-teachers">
        <h2>推荐教师</h2>
        <div class="teacher-card">
            <!-- 这里放置推荐的教师信息 -->
            <% 
                try 
            {
                    if (uid != null && !uid.isEmpty()) {
                    	/* 连接数据库 */
                        String url = "jdbc:mysql://localhost:3306/project?useUnicode=true&characterEncoding=UTF-8";
                        String user = "root";
                        String password = "AnXin202511408!";
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(url, user, password);
						/* 查找当前用户对应的学生sid */
                        PreparedStatement studentSidStmt = conn.prepareStatement("SELECT sid FROM student WHERE uid = ?");
                        studentSidStmt.setString(1, uid);
                        ResultSet studentSidRs = studentSidStmt.executeQuery();
                        studentSidRs.next();
                        String sid = studentSidRs.getString("sid");
                        /* 查找当前学生所选课程 */
                        PreparedStatement studentCoursesStmt = conn.prepareStatement("SELECT courses FROM student WHERE sid = ?");
                        studentCoursesStmt.setString(1, sid);
                        ResultSet studentCoursesRs = studentCoursesStmt.executeQuery();
                        String studentCourses=null;
                        if(studentCoursesRs.next()) {
                        	// 创建一个Map，存储教师uid和对应的最近被申请时间
							Map<String, LocalDateTime> teacherApplications = new HashMap<>();
							// 定义日期时间格式
				            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        	/* 当前学生选择了课程 */
                            studentCourses = studentCoursesRs.getString("courses");
							/* 将学生所选课程courses字符串以“,”为分隔符进行分割 */
							String[] splitStudentCourses = studentCoursesRs.getString("courses").split(",", -1);
							for (int i = 0; i < splitStudentCourses.length; i++)
							{
								if (!splitStudentCourses[i].equals(""))
								{
									/* 查询符合学生某一课程的教师信息 */
									PreparedStatement teacherStarStmt = conn.prepareStatement("SELECT * FROM teacher WHERE courses LIKE ?");
									teacherStarStmt.setString(1, "%" + splitStudentCourses[i] + "%");
									ResultSet teacherStarRs = teacherStarStmt.executeQuery();
									/* 遍历符合当前学生薄弱课程的教师，并将结果保存在Map中 */
									while (teacherStarRs.next()) {
										String tmpUid = teacherStarRs.getString("uid");
										/* 查询该教师对应的最近被申请时间 */
										PreparedStatement usrLastApplyTimeStmt = conn.prepareStatement("SELECT lastApplyTime FROM usr WHERE uid = ?");
										usrLastApplyTimeStmt.setString(1, tmpUid);
										ResultSet usrLastApplyTimeRs = usrLastApplyTimeStmt.executeQuery();
										if (usrLastApplyTimeRs.next())
										{
											String tmpStringLastApplyTime = usrLastApplyTimeRs.getString("lastApplyTime");
											// 解析字符串为LocalDateTime
						                	LocalDateTime tmpLastApplyTime = LocalDateTime.parse(tmpStringLastApplyTime, formatter);
						                	teacherApplications.put(tmpUid, tmpLastApplyTime);
										}
									}
								}
							}
							// 将Map的entrySet转换为List
							List<Map.Entry<String, LocalDateTime>> entryList = new ArrayList<>(teacherApplications.entrySet());
							// 使用Comparator对List进行排序（按照最近被申请时间排序）
				            Collections.sort(entryList, new Comparator<Map.Entry<String, LocalDateTime>>() {
				                @Override
				                public int compare(Map.Entry<String, LocalDateTime> entry1, Map.Entry<String, LocalDateTime> entry2) {
				                    return entry1.getValue().compareTo(entry2.getValue()); // 按值（最近被申请时间）升序排序
				                }
				            });
							// 遍历所有键，即按照教师最近被申请时间由小到大的顺序遍历教师uid
							for (Map.Entry<String, LocalDateTime> entry : entryList)
							{
								String keyUid = entry.getKey();
								String lastApplyTime = entry.getValue().format(formatter);
								PreparedStatement tmpStmt = conn.prepareStatement("SELECT * FROM teacher WHERE uid = ?");
								tmpStmt.setString(1, keyUid);
								ResultSet tmpRs = tmpStmt.executeQuery();
								if (tmpRs.next())
								{
									/* 将教师擅长科目courses字符串以“,”为分隔符进行分割 */
	         						String[] splitTeacherCourses = tmpRs.getString("courses").split(",", -1);
	                            	/* 将分割后的教师擅长科目字符串数据进行合并，中间以“，”分割，同时防止空字符串造成的异常 */
	                            	String teacherCourses = "";
	                            	for (int j = 0; j < 6; j++)
	                            	{
	                            		if (j < splitTeacherCourses.length - 1)
	                            		{
	                            			teacherCourses = teacherCourses + "\t" + splitTeacherCourses[j] + "<br>";
	                            		}
	                            		else
	                            		{
	                            			teacherCourses = teacherCourses + "<br>";
	                            		}
	                            	}
	         						/* 查找当前教师uid，从而查找教师头像 */
	         						String teacherUid = tmpRs.getString("uid");
	         						String usrStarSql = "SELECT * FROM usr WHERE uid = '"+ teacherUid + "'";
	         						Statement usrStarStmt = conn.createStatement();
	         						ResultSet usrStarRs = usrStarStmt.executeQuery(usrStarSql);
	         						usrStarRs.next();
            %>
                <div class="teacher">
                    <img src="<%= usrStarRs.getString("addr") %>" alt="教师头像">
                    <p>用户名:<%= usrStarRs.getString("uname") %></p>
                    <p>教师地址:<%= tmpRs.getString("location") %></p>
                    <p class="courses">擅长课程:</p><p class="course_items"><%= teacherCourses %> </p>
                    <p class="salary">期望薪资:<%= tmpRs.getString("ExpectSalary") %> </p>
                    <%session.setAttribute("txt", "main"); %>
                    <a href="teacherDetails.jsp?tid=<%= tmpRs.getString("tid") %>" class="view-detail-button">显示详情</a>
                </div>
            <%
            						usrStarRs.close();
            						usrStarStmt.close();
								} // if (tmpRs.next())
							} // for (Map.Entry<String, LocalDateTime> entry : entryList)
                            //conn.close();
                        	studentCoursesRs.close();
                        	studentCoursesStmt.close();
                    	} // if(studentCoursesRs.next())
                    } // if (uid != null && !uid.isEmpty())
                } 
            catch (Exception e) {
                    out.println("数据库连接失败：" + e.getMessage());
                }
            %>
        </div>
        <!-- 更多按钮，点击展示剩余的教师 -->
        <a href="#" class="more-teachers" onclick="showMoreTeachers()">更多</a>
    </div>
		<%
			}
	}
		%>
</body>
</html>
