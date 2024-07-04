<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Details</title>
<link href="studentDetails.css" type="text/css" rel="stylesheet" />

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
    <div class="container">
        <div class="student-details">
            <h2>学生详情</h2>
            <% String studentId = request.getParameter("sid");
            if(studentId==null){
            	studentId=(String)session.getAttribute("visit_student");
            }
            else{
            	session.setAttribute("visit_student",studentId);
            }
               if (studentId != null && !studentId.isEmpty()) {
                    try {
                    	/* 连接数据库 */
                        String url = "jdbc:mysql://localhost:3306/project?useUnicode=true&characterEncoding=UTF-8";
                        String user = "root";
                        String password = "AnXin202511408!";
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(url, user, password);
						/* 在student表中查找学生详情页面对应学生的信息表项 */
                        PreparedStatement studentStarStmt = conn.prepareStatement("SELECT * FROM student WHERE sid = ?");
                        studentStarStmt.setString(1, studentId);	// studentId：学生详情页面对应的学生sid
                        ResultSet studentStarRs = studentStarStmt.executeQuery();
                    	/* 处理获取的学生薄弱课程courses字符串 */
                        if (studentStarRs.next()) {
                        	List<String> CourseList = new ArrayList<String>();
                        	/* 将学生薄弱课程courses字符串以“,”为分隔符进行分割 */
     						String[] CourseSet=studentStarRs.getString("courses").split(",", -1);
                        	/* 将分割后的学生薄弱课程courses重新拼接，以防止空字符串造成的异常 */
     						for (int tmp = 0;tmp < CourseSet.length; tmp++)
     						{
     							if (!CourseSet[tmp].equals(""))
     							{
     								CourseList.add(CourseSet[tmp]);
     							}
     						}
     						String Course = "";
     						for(String elements : CourseList)
     						{
     							Course=Course+elements + "，";
     						}
     						Course = Course.substring(0, Course.length() - 1);	// 去掉Course字符串的最后一个字符
     						/* 处理学生空闲时间FreetimeList字符串 */
     						/* 先将FreetimeList字符串以“,”为分隔符进行分割 */
     						String[] splitFreetimeList = studentStarRs.getString("FreetimeList").split(",", -1);
     						/* 从第一项开始，将字符串数组FreetimeList中的每两个相邻表项进行组合，合成一段空闲时间表示 */
     						int valuableSplitPeerCnt = 0;
     						String[] finalFreetimeList = new String[splitFreetimeList.length / 2];
     						for (int i = 0; i < finalFreetimeList.length; i++)
     						{
     							if (!splitFreetimeList[i * 2].equals("::") && !splitFreetimeList[i * 2 + 1].equals("::"))
     							{
     								finalFreetimeList[i] = splitFreetimeList[i * 2] + "~" + splitFreetimeList[i * 2 + 1];
     								valuableSplitPeerCnt = valuableSplitPeerCnt + 1;
     							}
     						}
     						/* 将finalFreetimeList合并成一个字符串进行显示输出 */
     						String finalFreetime = "    ";
     						for (int i = 0; i < valuableSplitPeerCnt; i++)
     						{
     							finalFreetime = finalFreetime + "    " + finalFreetimeList[i] + "<br>";
     						}
     						/* 通过学生uid在usr表中查找表项，以找到本页学生对应的学生头像保存路径 */
                        	String uid =studentStarRs.getString("uid");
                        	String tmpSql = "SELECT * FROM usr WHERE uid = '" + uid + "'";
                        	Statement usrStarStmt = conn.createStatement();
                        	String txt=(String)session.getAttribute("txt");
                        	ResultSet tmpRs = usrStarStmt.executeQuery(tmpSql);
                        	tmpRs.next();
            %>
                <div class="student-info-container">
                 <%
                if(txt.equals("main")){
                	%>
                	<img class="back_chat" alt="" src="./images/icons/back.png" onclick="backM()">
                <%
                }
                else{
                	%>
                	<img class="back_chat" alt="" src="./images/icons/back.png" onclick=<%="backS(\""+txt+"\")"%>>
                <%
                }
                %>
                <script>
					function backM(){
						if(confirm('确认返回?')==true)
						{
						window.location.href="main.jsp";
						}
					}
					function backS(tmp){
						if(confirm('确认返回?')==true)
						{
						window.location.href="search.jsp?SearchText="+tmp;
						}
					}
				</script>
                    <div class="student-avatar">
                        <img src="<%= tmpRs.getString("addr") %>" alt="Student Avatar">
                    </div>
                    <div class="student-description">
                    	<p>学生姓名: <%= tmpRs.getString("uname") %></p>
                    	<p>学生用户ID: <%= studentStarRs.getString("uid") %></p>
                        <p>学生地址: <%= studentStarRs.getString("location") %></p>
                        <p>薄弱课程: <%= Course %></p>
                        <p>学历: <%= studentStarRs.getString("degree") %></p>
                        <p>期望薪资: <%= studentStarRs.getString("ExpectSalary") %></p>
                        <p>空闲时间: </p>
                        <p> <%= finalFreetime %></p>
                        <!-- 其他学生信息 -->
                    </div>
                </div>
                <div class="apply-button">
            		<form action="apply.jsp" method="get">
                		<input type="hidden" name="fromid" value="<%= studentStarRs.getString("uid") %>">
                		<input type="hidden" name="teacher_or_student" value="<%=0 %>">
                		<input type="submit" value="申请补课" class="apply-submit">
            		</form>
        		</div>
            <%
                        }

                        conn.close();
                    } catch (Exception e) {
                        out.println("Database connection failed: " + e.getMessage());
                    }
                }
            %>
        </div>
    </div>
</body>
</html>
