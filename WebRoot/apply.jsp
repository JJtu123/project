<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>申请补课</title>
<link href="apply.css" type="text/css" rel="stylesheet" />
<script>
function back(){
	if(confirm('确认返回?')==true){
		var tmp=<%=request.getParameter("teacher_or_student")%>;
		if(tmp=="1"){
			window.location.href="teacherDetails.jsp";
		}
		else{
			window.location.href="studentDetails.jsp";
		}
	}
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
	         		<input type="text" id="SeTmp" class="" name="SearchText"> 
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
    <div class="apply-container">
        <h2>申请补课</h2>
        <form action="apply_dealer.jsp" method="post">
            <label for="applicantType">申请人类型:</label>
            <select name="applicantType" id="applicantType">
                <option value="student">学生</option>
                <option value="teacher">教师</option>
            </select><br><br>
            <img id="back_chat" alt="" src="./images/icons/back.png" onclick="back()">
            <input type="hidden" name="tos" value=<%=request.getParameter("teacher_or_student") %>>
            <label for="teacherId">发送者ID:</label>
            <input type="text" id="fromid" name="fromid" value=<%=session.getAttribute("uid") %> required><br><br>
            
            <label for="studentId">接收者ID:</label>
            <input type="text" id="toid" name="toid" value=<%=request.getParameter("fromid")%> required><br><br>
            
            <label for="course">地点:</label>
            <input type="text" id="location" name="location" required><br><br>
            
            <label for="time">期望薪资:</label>
            <input type="text" id="salary" name="salary" required><br><br>
            
            <label for="location">课程:</label>
            <input type="text" id="course" name="course" required><br><br>
            
            <label for="location">开始时间:</label>
            <input type="text" id="btime" name="btime" required><br><br>
            
            <label for="location">结束时间:</label>
            <input type="text" id="etime" name="etime" required><br><br>
            
            <label for="location">申请理由:</label>
            <input type="text" id="text" name="text" required><br><br>
            
            <input type="submit" value="提交申请">
        </form>
    </div>
</div>
</body>
</html>
