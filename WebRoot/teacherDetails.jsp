<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Teacher Details</title>
<link href="teacherDetails.css" type="text/css" rel="stylesheet" />
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
	         		<input type="text" class="" id="SeTmp" name="SearchText"> 
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
        <div class="teacher-details">
            <h2>教师详情</h2>
            <% String teacherId = request.getParameter("tid");
            if(teacherId==null){
            	teacherId=(String)session.getAttribute("visit_teacher");
            }
            else{
            	session.setAttribute("visit_teacher",teacherId);
            }
               if (teacherId != null && !teacherId.isEmpty()) {
                    try {
                    	/* 连接数据库 */
                        String url = "jdbc:mysql://localhost:3306/project?useUnicode=true&characterEncoding=UTF-8";
                        String user = "root";
                        String password = "AnXin202511408!";
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(url, user, password);
						/* 在teacher表中查找教师详情页面对应教师的信息表项 */
                        PreparedStatement teacherStarStmt = conn.prepareStatement("SELECT * FROM teacher WHERE tid = ?");
                        teacherStarStmt.setString(1, teacherId);	// teacherId：教师详情页面对应的教师tid
                        ResultSet teacherStarRs = teacherStarStmt.executeQuery();
                    	/* 处理获取的教师擅长课程courses字符串 */
                        if (teacherStarRs.next()) {
                        	List<String> CourseList = new ArrayList<String>();
                        	/* 将教师擅长课程courses字符串以“,”为分隔符进行分割 */
     						String[] CourseSet=teacherStarRs.getString("courses").split(",", -1);
                        	/* 将分割后的教师擅长课程courses重新拼接，以防止空字符串造成的异常 */
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
     						/* 处理教师空闲时间FreetimeList字符串 */
     						/* 先将FreetimeList字符串以“,”为分隔符进行分割 */
     						String[] splitFreetimeList = teacherStarRs.getString("FreetimeList").split(",", -1);
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
     						/* 通过教师uid在usr表中查找表项，以找到本页教师对应的教师头像保存路径 */
                        	String uid =teacherStarRs.getString("uid");
                        	String tmpSql = "SELECT * FROM usr WHERE uid = '" + uid + "'";
                        	Statement usrStarStmt = conn.createStatement();
                        	ResultSet tmpRs = usrStarStmt.executeQuery(tmpSql);
                        	String txt=(String)session.getAttribute("txt");
                        	tmpRs.next();
            %>
                <div class="teacher-info-container">
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
                    <div class="teacher-avatar">
                        <img src="<%= tmpRs.getString("addr") %>" alt="Teacher Avatar">
                    </div>
                    <div class="teacher-description">
                    	<p>教师姓名: <%= tmpRs.getString("uname") %></p>
                    	<p>教师用户ID: <%= teacherStarRs.getString("uid") %></p>
                        <p>教师地址: <%= teacherStarRs.getString("location") %></p>
                        <p>擅长课程: <%= Course %></p>
                        <p>学历: <%= teacherStarRs.getString("degree") %></p>
                        <p>期望薪资: <%= teacherStarRs.getString("ExpectSalary") %></p>
                        <p>空闲时间: </p>
                        <p> <%= finalFreetime %></p>
                        <!-- 其他教师信息 -->
                    </div>
                </div>
                <div class="apply-button">
            		<form action="apply.jsp" method="get">
                		<input type="hidden" name="fromid" value="<%= teacherStarRs.getString("uid") %>">
                		<input type="hidden" name="teacher_or_student" value="<%=1 %>">
                		<input type="submit" value="申请补课" class="apply-submit">
            		</form>
        		</div>
                <div class="comment-box">
                <%session.setAttribute("txt", txt); %>
                    <form action="comment_dealer.jsp" method="post">
                        <textarea name="comment" rows="4" cols="50" placeholder="输入你的评论"></textarea><br>
                        <select name="star" class="star-select">
                            <option value="1">1星</option>
                            <option value="2">2星</option>
                            <option value="3">3星</option>
                            <option value="4">4星</option>
                            <option value="5">5星</option>
                        </select>
                        <input type="hidden" name="tuid" value="<%= teacherId %>">
                        <input type="submit" value="发送评论" class="comment-submit">
                    </form>
                </div>
            <%
                        }
                        teacherStarRs.close();
                        teacherStarStmt.close();

                        PreparedStatement commentStmt = conn.prepareStatement("SELECT * FROM comments WHERE tid = ?");
                        commentStmt.setString(1, teacherId);
                        ResultSet commentRs = commentStmt.executeQuery();

                        while (commentRs.next()) {
            %>
                <div class="comment">
                    <p>评论者：<%= commentRs.getString("uid") %></p>
                    <p>评论内容：<%= commentRs.getString("comment") %></p>
                    <p>评分：<%= commentRs.getString("star") %></p>
                </div>
            <%
                        }
                        commentRs.close();
                        commentStmt.close();

                        conn.close();
                    } catch (Exception e) {
                        out.println("Database connection failed: " + e.getMessage());
                    }
                }
            %>
        </div>
        <div class="teacher-review">
            <!-- 在这里显示对教师的评价 -->
        </div>
    </div>
</body>
</html>
