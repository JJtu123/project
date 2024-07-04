<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Home</title>
<link href="chat.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">
function goothers(i){
	var demo=document.getElementById("user"+i).getAttribute("value");
	document.getElementById("chat_special").value=demo;
	document.form1.submit();
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
<form action="chat_specific.jsp" name="form1">
	<input id="chat_special" name="chat_to_id" type="text" placeholder="234">
	<div id="chatbox">
		<div id="chatpage">
			<div id="chatsign">
				<span id="chatsignsp">消息中心</span>
			</div>
			<div>
				<div id="chatuser">
				<%
				String driverClass = "com.mysql.jdbc.Driver";
		    	String url = "jdbc:mysql://localhost:3306/project?useSSL=false&serverTimezone=UTC";
		    	String urn = "root";
		    	String psw = "AnXin202511408!";
		    	Class.forName(driverClass);//加载驱动 
		    	Connection conn = DriverManager.getConnection(url,urn,psw);//得到连接
		    	if(conn != null){
		    		String select_user="select distinct fromid  from message where toid='"+session.getAttribute("uid")+"' and readed=1";
		    		Statement stmt = conn.createStatement();
	        		ResultSet rs =stmt.executeQuery(select_user);
	        		int u_count=0;
	        		while(rs.next()){
	        			{
	        				String user_select="select *  from usr where uid='"+rs.getString("fromid")+"'";
	        				stmt = conn.createStatement();
	                		ResultSet rs_ur =stmt.executeQuery(user_select);
	                		rs_ur.next();
	        				String sender_avatar=rs_ur.getString("addr");
	        				String sender_uname=rs_ur.getString("uname");
							%>
						
						<div class="user_item" id=<%=("user"+u_count) %> value=<%=rs.getString("fromid") %> onclick=<%="goothers("+u_count+")"%>>
							<img class="user_image" src=<%=sender_avatar %>>
							<span class="user_name"><%=sender_uname %></span>
							<svg t="1718481119750" class="user_icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="4048">
							<path d="M512 512m-512 0a512 512 0 1 0 1024 0 512 512 0 1 0-1024 0Z" fill="#0081F7" p-id="4049">
							</path>
							</svg>
						</div>
						<%
	        			}
	        			u_count++;
	        		}
	        		select_user="select distinct fromid  from message where toid='"+session.getAttribute("uid")+"' and readed=0 and fromid not in("+"select distinct fromid  from message where toid='"+session.getAttribute("uid")+"' and readed=1"+")";
		    		stmt = conn.createStatement();
	        		rs =stmt.executeQuery(select_user);
	        		while(rs.next()){
	        			{
	        				String user_select="select *  from usr where uid='"+rs.getString("fromid")+"'";
	        				stmt = conn.createStatement();
	                		ResultSet rs_ur =stmt.executeQuery(user_select);
	                		rs_ur.next();
	        				String sender_avatar=rs_ur.getString("addr");
	        				String sender_uname=rs_ur.getString("uname");
							%>
						<div class="user_item" id=<%=("user"+u_count) %> value=<%=rs.getString("fromid") %> onclick=<%="goothers("+u_count+")"%>>
							<img class="user_image" src=<%=sender_avatar %>>
							<span class="user_name"><%=sender_uname %></span>
						</div>
						<%
	        			}
	        			u_count++;
	        		}

	        		select_user="select distinct toid as fromid  from message where fromid='"+session.getAttribute("uid")+"' and toid not in("+"select fromid  from message where toid='"+session.getAttribute("uid")+"')";
		    		stmt = conn.createStatement();
	        		rs =stmt.executeQuery(select_user);
	        		while(rs.next()){
	        			{
	        				String user_select="select *  from usr where uid='"+rs.getString("fromid")+"'";
	        				stmt = conn.createStatement();
	                		ResultSet rs_ur =stmt.executeQuery(user_select);
	                		rs_ur.next();
	        				String sender_avatar=rs_ur.getString("addr");
	        				String sender_uname=rs_ur.getString("uname");
							%>
						<div class="user_item" id=<%=("user"+u_count) %> value=<%=rs.getString("fromid") %> onclick=<%="goothers("+u_count+")"%>>
							<img class="user_image" src=<%=sender_avatar %>>
							<span class="user_name"><%=sender_uname %></span>
						</div>
						<%
	        			}
	        			u_count++;
	        		}
		    	}
				%>
				</div>
				<div id="chatcontent">
					<span id="user_alarm">
					选择左侧框中的用户进行对话
					</span>
				</div>
			</div>
		</div>
	</div>
</form>
<%} %>
</body>
</html>