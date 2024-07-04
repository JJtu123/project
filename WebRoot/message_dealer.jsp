<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Home</title>
<link href="view.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">
function goothers(i){
	var demo=document.getElementById("user"+i).getAttribute("value");
	document.getElementById("chat_special").value=demo;
	document.form1.submit();
}
<%//session.setAttribute("Image", "./images/icons/default.png");%>
</script>
</head>
<body>
<%
	String mid=request.getParameter("deal_mid");
	String fb=request.getParameter("feedback");
	String roa=request.getParameter("reject_or_accept");
	String driverClass = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/project?useSSL=false&serverTimezone=UTC";
	String urn = "root";
	String psw = "AnXin202511408!";
	String sender_id="";
	Class.forName(driverClass);//加载驱动 
	Connection conn = DriverManager.getConnection(url,urn,psw);//得到连接
	if(conn != null){
		String select_message="select * from message where mid='"+mid+"'";
		Statement stmt = conn.createStatement();
		ResultSet rs =stmt.executeQuery(select_message);
		rs.next();
		sender_id=rs.getString("fromid");
		if(roa.equals("1")){
			String accept_message="insert into message values(0,'"+rs.getString("toid")+"','"+rs.getString("fromid")+"','"+rs.getString("location")+"','"+rs.getString("salary")+"','"+rs.getString("course")+"','"+rs.getString("btime")+"','"+rs.getString("etime")+"','"+rs.getString("text")+"','"+fb+"','"+1+"','"+1+"','"+1+"',0)";
			Statement stmt_accept = conn.createStatement();
			stmt_accept.execute(accept_message);
			String update_date="update usr set lastApplyTime=? where uid='"+rs.getString("fromid")+"' or uid='"+rs.getString("toid")+"'";
			java.util.Date date = new java.util.Date();  
			PreparedStatement stmt_update = conn.prepareStatement(update_date);
			Timestamp stmp=new Timestamp(date.getTime());
			stmt_update.setTimestamp(1,stmp);
			stmt_update.executeUpdate();
		}
		else{
			String reject_message="insert into message values(0,'"+rs.getString("toid")+"','"+rs.getString("fromid")+"','"+rs.getString("location")+"','"+rs.getString("salary")+"','"+rs.getString("course")+"','"+rs.getString("btime")+"','"+rs.getString("etime")+"','"+rs.getString("text")+"','"+fb+"','"+1+"','"+1+"','"+0+"',0)";
			Statement stmt_reject = conn.createStatement();
			stmt_reject.execute(reject_message);
			String update_date="update usr set lastApplyTime=? where uid='"+rs.getString("fromid")+"' or uid='"+rs.getString("toid")+"'";
			java.util.Date date = new java.util.Date();  
			PreparedStatement stmt_update = conn.prepareStatement(update_date);
			Timestamp stmp=new Timestamp(date.getTime());
			stmt_update.setTimestamp(1,stmp);
			stmt_update.executeUpdate();
		}
		String solve="update message set solved=1 where mid='"+mid+"'";
		Statement stmt_solve = conn.createStatement();
		stmt_solve.execute(solve);
	}
	conn.close();
	%>
	  <script type="text/javascript">
 	    alert("操作成功!");
 	 	window.location.href="chat_specific.jsp?chat_to_id="+<%=sender_id%>;
 	 </script>  
 	 <%
%>
</body>
</html>