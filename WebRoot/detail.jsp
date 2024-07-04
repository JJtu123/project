<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*,java.util.Random"%>
<html>
<head>
    <title>个人信息界面</title>
    <link href="detail.css" type="text/css" rel="stylesheet" />
    <meta name="referrer" content="no-referrer">
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
<%
	String uid=(String)session.getAttribute("uid");
	if(uid==null)
	{%>
	     <script type="text/javascript">
	  	    alert("尚未登录!请先登录!");
	  	 	window.location.href="login.jsp";
	  	 </script>	
	<%}
	else{
	session.setAttribute("del", uid);	
	//String uid="351382152394950";
     String driverClass = "com.mysql.jdbc.Driver";
   	String url = "jdbc:mysql://localhost:3306/project?useSSL=false&serverTimezone=UTC";
   	String urn = "root";
   	String psw = "AnXin202511408!";
   	Class.forName(driverClass);//加载驱动 
   	Connection conn = DriverManager.getConnection(url,urn,psw);//得到连接
   	if(conn != null){
   		String sql = "select * from usr where uid='"+uid+"'";	//验证账号密码
   		Statement stmt = conn.createStatement();
   		ResultSet rs = stmt.executeQuery(sql);	
   		rs.next();
   		int flag=rs.getInt("TeacherOrStudent");
   		if(flag==1){
   			String username=rs.getString("uname");
   			String email=rs.getString("email");
   			String phonenumber=rs.getString("phonenumber");
   			sql = "select * from teacher where uid='"+uid+"'";
   			stmt = conn.createStatement();
   			rs = stmt.executeQuery(sql);	
   			rs.next();
   			String[] courses=rs.getString("courses").split(",",-1);
   			String degree=rs.getString("degree");
   			String location=rs.getString("location");
   			String salary=rs.getString("ExpectSalary");
   			String[] freetime=rs.getString("FreetimeList").split(",",-1);
   			int i=0;
   			int j=0;
%>
<div class="outer">
	<div class="basic">
		<div class="pic">
			<img alt="" src=<%=session.getAttribute("Image") %>>
		</div>
		<div class="uname">
			<%=username %>
		</div>
		<div class="identity">身份:教师</div>
		<a href="edit_detail.jsp" id="modify" target="_self">编辑信息</a>
	</div>
	<div class="details">
	<div id="ShowOption">
		</a>
		<a href="detail.jsp" id="MyDetail">
	<span class="notext" >我的信息</span>
	<?xml version="1.0" encoding="UTF-8"?>
	<svg class="notice" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24" height="24" viewBox="0 0 24 24" version="1.1">
    	<title>ic_Business cards filled</title>
    	<defs>
        <path d="M19.5,3 C21.709139,3 23.5,4.790861 23.5,7 L23.5,17 C23.5,19.209139 21.709139,21 19.5,21 L4.5,21 C2.290861,21 0.5,19.209139 0.5,17 L0.5,7 C0.5,4.790861 2.290861,3 4.5,3 L19.5,3 Z M16.5033314,12.25 C13.360271,12.25 12.5536763,14.2267892 12.2432474,14.8888889 C12.1248328,15.1414501 12.0452065,15.4798878 12.0043686,15.9042018 C12.0013041,15.9360426 11.9997692,15.9680121 11.9997692,16 C11.9997692,16.5522631 12.4474669,16.9999609 12.9997301,17 L12.9997301,17 L20.0001643,17 C20.0328578,17 20.0655317,16.9983967 20.0980681,16.995196 C20.6477083,16.9411252 21.0494467,16.4517208 20.9953604,15.9020821 C20.9537162,15.4787605 20.8764012,15.1410294 20.7634154,14.8888889 C20.4667244,14.2267892 19.6463918,12.25 16.5033314,12.25 Z M9.25,15.25 L4.75,15.25 C4.33578644,15.25 4,15.5857864 4,16 C4,16.3796958 4.28215388,16.693491 4.64822944,16.7431534 L4.75,16.75 L9.25,16.75 C9.66421356,16.75 10,16.4142136 10,16 C10,15.5857864 9.66421356,15.25 9.25,15.25 Z M9.25,11.25 L4.75,11.25 C4.33578644,11.25 4,11.5857864 4,12 C4,12.3796958 4.28215388,12.693491 4.64822944,12.7431534 L4.75,12.75 L9.25,12.75 C9.66421356,12.75 10,12.4142136 10,12 C10,11.5857864 9.66421356,11.25 9.25,11.25 Z M16.5033314,6.875 C15.1226196,6.875 14.0033314,7.99428813 14.0033314,9.375 C14.0033314,10.7557119 15.1226196,11.875 16.5033314,11.875 C17.8840433,11.875 19.0033314,10.7557119 19.0033314,9.375 C19.0033314,7.99428813 17.8840433,6.875 16.5033314,6.875 Z M9.25,7.25 L4.75,7.25 C4.33578644,7.25 4,7.58578644 4,8 C4,8.37969577 4.28215388,8.69349096 4.64822944,8.74315338 L4.75,8.75 L9.25,8.75 C9.66421356,8.75 10,8.41421356 10,8 C10,7.58578644 9.66421356,7.25 9.25,7.25 Z" id="_path-1"/>
    	</defs>
    	<g id="_ic_Business-cards-filled" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <mask id="_mask-2" fill="white">
            <use xlink:href="#_path-1"/>
        </mask>
        <use id="_形状结合" fill="#000000" xlink:href="#_path-1"/>
    	</g>
	</svg>
	</a>
	<a href="delete.jsp" id="Delete">
	<span class="notext" >注销账号</span>
	<?xml version="1.0" encoding="UTF-8"?>
	<svg class="notice" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24" height="24" viewBox="0 0 24 24" version="1.1">
    	<title>ic_power_off</title>
    	<g id="__ic_power_off" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <g id="__icon">
            <polygon id="__Fill-1" points="0 24 24 24 24 0 0 0"/>
            <line x1="12" y1="2.8" x2="12" y2="11.2" id="__Stroke-8" stroke="#000000" stroke-width="1.6" stroke-linecap="round"/>
            <path d="M7.40058,4.03354 C4.65118,5.62434 2.79998,8.59514 2.79998,11.99994 C2.79998,17.08094 6.91898,21.19994 11.99998,21.19994 C17.08098,21.19994 21.19998,17.08094 21.19998,11.99994 C21.19998,8.59514 19.34878,5.62434 16.59938,4.03354" id="__Stroke-10" stroke="#000000" stroke-width="1.6" stroke-linecap="round"/>
        </g>
    	</g>
	</svg>
	</a>
	<a href=<%="amend.jsp?rst="+session.getAttribute("uid")%> id="CModify">
	<span class="notext" >修改密码</span>
	<svg t="1717653762921" class="icon notice" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="5111" width="200" height="200"><path d="M766.598 75.624c-112.55-65.312-250.07-87.553-385.693-51.212C110.437 96.883-50.07 374.89 22.4 645.357c72.472 270.468 350.479 430.975 620.946 358.504 270.467-72.472 430.975-350.479 358.503-620.946-0.211-0.789-0.424-1.577-0.639-2.363h-62.505a454.786 454.786 0 0 1 5.189 17.892c63.895 238.46-77.618 483.566-316.077 547.461-238.46 63.895-483.566-77.617-547.461-316.077-63.895-238.46 77.617-483.566 316.077-547.46 119.62-32.053 240.912-12.416 340.164 45.217l-42.383 73.409 217.66-6.997L809.104 2l-42.507 73.624z" fill="#000000" p-id="5112"></path><path d="M442 447h140v-70c0-38.66-31.34-70-70-70s-70 31.34-70 70v70z m44 186.012V716h52v-82.988c25.786-10.321 44-35.54 44-65.012 0-38.66-31.34-70-70-70s-70 31.34-70 70c0 29.472 18.214 54.69 44 65.012zM390 447v-70c0-67.379 54.621-122 122-122 67.379 0 122 54.621 122 122v70h37c18.778 0 34 15.222 34 34v252c0 18.778-15.222 34-34 34H353c-18.778 0-34-15.222-34-34V481c0-18.778 15.222-34 34-34h37z" fill="#000000" p-id="5113"></path></svg>

	</a>
</div>
		<div class="data">
			<div class="deheader"><span>基本信息</span></div>
			<div class="content">
				<div><span>地址:<%=location.equals("")?"未填写":location %></span></div>
				<div><span>电话号码:<%=phonenumber.equals("")?"未填写":phonenumber %></span></div>
				<div><span>邮箱:<%=email.equals("")?"未填写":email %></span></div>
				<div><span>学历:<%=degree.equals("")?"未填写":degree %></span></div>
				<% for(i=0;i<6;i++){
				%>
				<div><span>课程<%=i+1%>:<%=courses[i].equals("")?"未填写":courses[i] %></span></div>
				<%} %>
				<div><span>期望薪资(元/小时):<%=salary.equals("")?"未填写":salary %></span></div>
				<% for(j=0;j<12;j+=2){
					String[] ftm=freetime[j].split(":",-1);
					String weekday=ftm[0].equals("")?"未填写":ftm[0];
					String hour=ftm[1].equals("")?"未填写":ftm[1];
					String minute=ftm[2].equals("")?"未填写":ftm[2];
					String opt=weekday+":"+hour+":"+minute;
					ftm=freetime[j+1].split(":",-1);
					weekday=ftm[0].equals("")?"未填写":ftm[0];
					hour=ftm[1].equals("")?"未填写":ftm[1];
					minute=ftm[2].equals("")?"未填写":ftm[2];
					String opt1=weekday+":"+hour+":"+minute;
				%>
				<div><span>空闲时间<%=j/2+1%>:<%=opt %><span id="snatch">~</span><%=opt1 %></span></div>
				<%} %>
			</div>
		</div>
	</div>
</div>
<%
				conn.close();
	       		}	

	    else{
	   			String username=rs.getString("uname");
	   			String email=rs.getString("email");
	   			String phonenumber=rs.getString("phonenumber");
	   			sql = "select * from student where uid='"+uid+"'";
	   			stmt = conn.createStatement();
	   			rs = stmt.executeQuery(sql);	
	   			rs.next();
	   			String[] courses=rs.getString("courses").split(",",-1);
	   			String degree=rs.getString("degree");
	   			String location=rs.getString("location");
	   			String salary=rs.getString("ExpectSalary");
	   			String[] freetime=rs.getString("FreetimeList").split(",",-1);
	   			int i=0;
	   			int j=0;
%>
<div class="outer">
	<div class="basic">
		<div class="pic">
			<img alt="" src=<%=session.getAttribute("Image") %>>
		</div>
		<div class="uname">
			<%=username %>
		</div>
		<div class="identity">身份:学生</div>
		<a href="edit_detail.jsp" id="modify" target="_self">编辑信息</a>
	</div>
	<div class="details">
			<div id="ShowOption">
				</a>
		<a href="detail.jsp" id="MyDetail">
	<span class="notext" >我的信息</span>
	<?xml version="1.0" encoding="UTF-8"?>
	<svg class="notice" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24" height="24" viewBox="0 0 24 24" version="1.1">
    	<title>ic_Business cards filled</title>
    	<defs>
        <path d="M19.5,3 C21.709139,3 23.5,4.790861 23.5,7 L23.5,17 C23.5,19.209139 21.709139,21 19.5,21 L4.5,21 C2.290861,21 0.5,19.209139 0.5,17 L0.5,7 C0.5,4.790861 2.290861,3 4.5,3 L19.5,3 Z M16.5033314,12.25 C13.360271,12.25 12.5536763,14.2267892 12.2432474,14.8888889 C12.1248328,15.1414501 12.0452065,15.4798878 12.0043686,15.9042018 C12.0013041,15.9360426 11.9997692,15.9680121 11.9997692,16 C11.9997692,16.5522631 12.4474669,16.9999609 12.9997301,17 L12.9997301,17 L20.0001643,17 C20.0328578,17 20.0655317,16.9983967 20.0980681,16.995196 C20.6477083,16.9411252 21.0494467,16.4517208 20.9953604,15.9020821 C20.9537162,15.4787605 20.8764012,15.1410294 20.7634154,14.8888889 C20.4667244,14.2267892 19.6463918,12.25 16.5033314,12.25 Z M9.25,15.25 L4.75,15.25 C4.33578644,15.25 4,15.5857864 4,16 C4,16.3796958 4.28215388,16.693491 4.64822944,16.7431534 L4.75,16.75 L9.25,16.75 C9.66421356,16.75 10,16.4142136 10,16 C10,15.5857864 9.66421356,15.25 9.25,15.25 Z M9.25,11.25 L4.75,11.25 C4.33578644,11.25 4,11.5857864 4,12 C4,12.3796958 4.28215388,12.693491 4.64822944,12.7431534 L4.75,12.75 L9.25,12.75 C9.66421356,12.75 10,12.4142136 10,12 C10,11.5857864 9.66421356,11.25 9.25,11.25 Z M16.5033314,6.875 C15.1226196,6.875 14.0033314,7.99428813 14.0033314,9.375 C14.0033314,10.7557119 15.1226196,11.875 16.5033314,11.875 C17.8840433,11.875 19.0033314,10.7557119 19.0033314,9.375 C19.0033314,7.99428813 17.8840433,6.875 16.5033314,6.875 Z M9.25,7.25 L4.75,7.25 C4.33578644,7.25 4,7.58578644 4,8 C4,8.37969577 4.28215388,8.69349096 4.64822944,8.74315338 L4.75,8.75 L9.25,8.75 C9.66421356,8.75 10,8.41421356 10,8 C10,7.58578644 9.66421356,7.25 9.25,7.25 Z" id="_path-1"/>
    	</defs>
    	<g id="_ic_Business-cards-filled" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <mask id="_mask-2" fill="white">
            <use xlink:href="#_path-1"/>
        </mask>
        <use id="_形状结合" fill="#000000" xlink:href="#_path-1"/>
    	</g>
	</svg>
	</a>
	<a href="delete.jsp" id="Delete">
	<span class="notext" >注销账号</span>
	<?xml version="1.0" encoding="UTF-8"?>
	<svg class="notice" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24" height="24" viewBox="0 0 24 24" version="1.1">
    	<title>ic_power_off</title>
    	<g id="__ic_power_off" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <g id="__icon">
            <polygon id="__Fill-1" points="0 24 24 24 24 0 0 0"/>
            <line x1="12" y1="2.8" x2="12" y2="11.2" id="__Stroke-8" stroke="#000000" stroke-width="1.6" stroke-linecap="round"/>
            <path d="M7.40058,4.03354 C4.65118,5.62434 2.79998,8.59514 2.79998,11.99994 C2.79998,17.08094 6.91898,21.19994 11.99998,21.19994 C17.08098,21.19994 21.19998,17.08094 21.19998,11.99994 C21.19998,8.59514 19.34878,5.62434 16.59938,4.03354" id="__Stroke-10" stroke="#000000" stroke-width="1.6" stroke-linecap="round"/>
        </g>
    	</g>
	</svg>
	</a>
	<a href=<%="amend.jsp?rst="+session.getAttribute("uid")%> id="CModify">
	<span class="notext" >修改密码</span>
	<svg t="1717653762921" class="icon notice" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="5111" width="200" height="200"><path d="M766.598 75.624c-112.55-65.312-250.07-87.553-385.693-51.212C110.437 96.883-50.07 374.89 22.4 645.357c72.472 270.468 350.479 430.975 620.946 358.504 270.467-72.472 430.975-350.479 358.503-620.946-0.211-0.789-0.424-1.577-0.639-2.363h-62.505a454.786 454.786 0 0 1 5.189 17.892c63.895 238.46-77.618 483.566-316.077 547.461-238.46 63.895-483.566-77.617-547.461-316.077-63.895-238.46 77.617-483.566 316.077-547.46 119.62-32.053 240.912-12.416 340.164 45.217l-42.383 73.409 217.66-6.997L809.104 2l-42.507 73.624z" fill="#000000" p-id="5112"></path><path d="M442 447h140v-70c0-38.66-31.34-70-70-70s-70 31.34-70 70v70z m44 186.012V716h52v-82.988c25.786-10.321 44-35.54 44-65.012 0-38.66-31.34-70-70-70s-70 31.34-70 70c0 29.472 18.214 54.69 44 65.012zM390 447v-70c0-67.379 54.621-122 122-122 67.379 0 122 54.621 122 122v70h37c18.778 0 34 15.222 34 34v252c0 18.778-15.222 34-34 34H353c-18.778 0-34-15.222-34-34V481c0-18.778 15.222-34 34-34h37z" fill="#000000" p-id="5113"></path></svg>
	</a>
</div>
		<div class="data">
			<div class="deheader"><span>基本信息</span></div>
			<div class="content">
				<div><span>地址:<%=location.equals("")?"未填写":location %></span></div>
				<div><span>电话号码:<%=phonenumber.equals("")?"未填写":phonenumber %></span></div>
				<div><span>邮箱:<%=email.equals("")?"未填写":email %></span></div>
				<div><span>学历:<%=degree.equals("")?"未填写":degree %></span></div>
				<% for(i=0;i<6;i++){
				%>
				<div><span>课程<%=i+1%>:<%=courses[i].equals("")?"未填写":courses[i] %></span></div>
				<%} %>
				<div><span>期望薪资(元/小时):<%=salary.equals("")?"未填写":salary %></span></div>
				<% for(j=0;j<12;j+=2){
					String[] ftm=freetime[j].split(":",-1);
					String weekday=ftm[0].equals("")?"未填写":ftm[0];
					String hour=ftm[1].equals("")?"未填写":ftm[1];
					String minute=ftm[2].equals("")?"未填写":ftm[2];
					String opt=weekday+":"+hour+":"+minute;
					ftm=freetime[j+1].split(":",-1);
					weekday=ftm[0].equals("")?"未填写":ftm[0];
					hour=ftm[1].equals("")?"未填写":ftm[1];
					minute=ftm[2].equals("")?"未填写":ftm[2];
					String opt1=weekday+":"+hour+":"+minute;
				%>
				<div><span>空闲时间<%=j/2+1%>:<%=opt %><span id="snatch">~</span><%=opt1 %></span></div>
				<%} %>
			</div>
		</div>
	</div>
</div>
<%			conn.close();
	       	}		
       	}
    }%>
</body>
</html>