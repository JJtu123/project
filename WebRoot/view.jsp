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
<link href="view.css" type="text/css" rel="stylesheet" />
<%String to_usr_id=request.getParameter("chat_to_usr"); %>
<script type="text/javascript">
function goothers(i){
	var demo=document.getElementById("user"+i).getAttribute("value");
	document.getElementById("chat_special").value=demo;
	document.form1.submit();
}
function Reject(){
	if(confirm('确认拒绝?')==true)
	{
	document.getElementById("roa").value="0";
	document.form1.submit();
	}
}
function Accept(){
	if(confirm('确认接受?')==true)
	{
	document.getElementById("roa").value="1";
	document.form1.submit();
	}
}
function back(){
	if(confirm('确认返回消息界面?')==true)
	{
	window.location.href="chat_specific.jsp?chat_to_id="+<%=to_usr_id%>;
	}
}
<%//session.setAttribute("Image", "./images/icons/default.png");%>
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
	         		<button type="submit" class="navigate" id="search_button">
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
	<img id="back_chat" alt="" src="./images/icons/back.png" onclick="back()">
<%
	String mid=request.getParameter("mid");
	String fot=request.getParameter("fot");
	String sor=request.getParameter("sor");
	String driverClass = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/project?useSSL=false&serverTimezone=UTC";
	String urn = "root";
	String psw = "AnXin202511408!";
	Class.forName(driverClass);//加载驱动 
	Connection conn = DriverManager.getConnection(url,urn,psw);//得到连接
	if(conn != null){
		String select_message="select * from message where mid='"+mid+"'";
		Statement stmt = conn.createStatement();
		ResultSet rs =stmt.executeQuery(select_message);
		rs.next();
		String select_sender="select uname from usr where uid='"+rs.getString("toid")+"'";
		Statement stmt_sender = conn.createStatement();
		ResultSet rs_sender =stmt_sender.executeQuery(select_sender);
		rs_sender.next();
		String select_receiver="select uname from usr where uid='"+rs.getString("fromid")+"'";
		Statement stmt_receiver = conn.createStatement();
		ResultSet rs_receiver =stmt_receiver.executeQuery(select_receiver);
		rs_receiver.next();
		if(sor.equals("1")){
			%>
			<div class="contract">
			<%if(rs.getString("ApproveOrReject").equals("1")){ %>
				<img class="reject_or_approve" alt="" src="./images/icons/approve.png">
				<%}
			else{
				%>
				<img class="reject_or_approve" alt="" src="./images/icons/reject.png">
				<%
			}%>
				<div class="contract_head"><span>协议</span></div>
				<div class="contact_items"><span class="item_title">申请者:</span><span><%=rs_sender.getString("uname") %></span></div>
				<div class="contact_items"><span class="item_title">申请对象:</span><span><%=rs_receiver.getString("uname") %></span></div>
				<div class="contact_items"><span class="item_title">教学课程:</span><span><%=rs.getString("course") %></span></div>
				<div class="contact_items"><span class="item_title">教学地点:</span><span><%=rs.getString("location") %></span></div>
				<div class="contact_items"><span class="item_title">教学时间:</span><span><%=rs.getString("btime") %>~<%=rs.getString("etime") %></span></div>
				<div class="contact_items"><span class="item_title">教学薪资:</span><span><%=rs.getString("salary") %></span></div>
				<div class="contact_extra_words">
					<div class="words_head">申请者简述</div>
					<div class="contact_words"><%=rs.getString("text") %></div>
				</div>
				<div class="contact_extra_words">
					<div class="words_head">对象反馈</div>
					<div class="contact_words"><%=rs.getString("feedback") %></div>
				</div>
			</div>
			<%
			}
		else if(fot.equals("1")){//发送申请的发送者
			
		%>
		<div class="contract">
				<%if(rs.getString("solved").equals("0")){ %>
				<%
				}
				else{ %>
				<img class="reject_or_approve" alt="" src="./images/icons/solved.png">
				<%} %>
				<div class="contract_head"><span>协议</span></div>
				<div class="contact_items"><span class="item_title">申请者:</span><span><%=rs_receiver.getString("uname") %></span></div>
				<div class="contact_items"><span class="item_title">申请对象:</span><span><%=rs_sender.getString("uname") %></span></div>
				<div class="contact_items"><span class="item_title">教学课程:</span><span><%=rs.getString("course") %></span></div>
				<div class="contact_items"><span class="item_title">教学地点:</span><span><%=rs.getString("location") %></span></div>
				<div class="contact_items"><span class="item_title">教学时间:</span><span><%=rs.getString("btime") %>~<%=rs.getString("etime") %></span></div>
				<div class="contact_items"><span class="item_title">教学薪资:</span><span><%=rs.getString("salary") %></span></div>
				<div class="contact_extra_words">
					<div class="words_head">申请者简述</div>
					<div class="contact_words"><%=rs.getString("text") %></div>
				</div>
				<div class="contact_extra_words">
					<div class="words_head">对象反馈</div>
					<div class="contact_words"><%=rs.getString("feedback") %></div>
				</div>
		</div>
		<%
		}
		else if(rs.getString("solved").equals("0")){//发送申请的接收者
			%>
			<form action="message_dealer.jsp" name="form1">
			<input type="text" class="default_value" name="deal_mid" value=<%=rs.getString("mid") %>>
			<input type="text" id="roa" name="reject_or_accept" style="display:none;" value="">
			<div class="contract">
				<div class="contract_head"><span>协议</span></div>
				<div class="accept" onclick="Accept()"><span>接受</span></div>
				<div class="reject" onclick="Reject()"><span>拒绝</span></div>
				<div class="contact_items"><span class="item_title">申请者:</span><span><%=rs_receiver.getString("uname") %></span></div>
				<div class="contact_items"><span class="item_title">申请对象:</span><span><%=rs_sender.getString("uname") %></span></div>
				<div class="contact_items"><span class="item_title">教学课程:</span><span><%=rs.getString("course") %></span></div>
				<div class="contact_items"><span class="item_title">教学地点:</span><span><%=rs.getString("location") %></span></div>
				<div class="contact_items"><span class="item_title">教学时间:</span><span><%=rs.getString("btime") %>~<%=rs.getString("etime") %></span></div>
				<div class="contact_items"><span class="item_title">教学薪资:</span><span><%=rs.getString("salary") %></span></div>
				<div class="contact_extra_words">
					<div class="words_head">申请者简述</div>
					<div class="contact_words"><%=rs.getString("text") %></div>
				</div>
				<div class="contact_extra_words">
					<div class="words_head">对象反馈</div>
					<textarea id="t1" class="contact_words" name="feedback" placeholder="请输入您的反馈意见" value=""></textarea>
					<script>
					document.getElementById("t1").value=""
					</script> 
				</div>
		</div>
			</form>
			<%
		}
		else{
			%>
			<form action="message_dealer.jsp" name="form1">
			<input type="text" class="default_value" name="deal_mid" value=<%=rs.getString("mid") %>>
			<input type="text" id="roa" name="reject_or_accept" style="display:none;" value="">
			<div class="contract">
				<img class="reject_or_approve" alt="" src="./images/icons/solved.png">
				<div class="contract_head"><span>协议</span></div>
				<div class="contact_items"><span class="item_title">申请者:</span><span><%=rs_receiver.getString("uname") %></span></div>
				<div class="contact_items"><span class="item_title">申请对象:</span><span><%=rs_sender.getString("uname") %></span></div>
				<div class="contact_items"><span class="item_title">教学课程:</span><span><%=rs.getString("course") %></span></div>
				<div class="contact_items"><span class="item_title">教学地点:</span><span><%=rs.getString("location") %></span></div>
				<div class="contact_items"><span class="item_title">教学时间:</span><span><%=rs.getString("btime") %>~<%=rs.getString("etime") %></span></div>
				<div class="contact_items"><span class="item_title">教学薪资:</span><span><%=rs.getString("salary") %></span></div>
				<div class="contact_extra_words">
					<div class="words_head">申请者简述</div>
					<div class="contact_words"><%=rs.getString("text") %></div>
				</div>
				<div class="contact_extra_words">
					<div class="words_head">对象反馈</div>
					<div class="contact_words"><%=rs.getString("feedback") %></div>
				</div>
			</div>
			</form>
			<%
		}
	}
	conn.close();
	}
%>
</body>
</html>