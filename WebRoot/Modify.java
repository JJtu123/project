package Ser;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import java.sql.*;
/**
 * Servlet implementation class Modify
 */
@WebServlet("/Modify")
@MultipartConfig
public class Modify extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Modify() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String uid=(String)session.getAttribute("uid");
    	String ToS=(String)session.getAttribute("ToS");
        if(ToS.equals("1")){
        	String account = request.getParameter("account");
        	Part f=request.getPart("avatar");
            String location = request.getParameter("location");
            String email = request.getParameter("email");
            String phone = request.getParameter("phonenumber");
            String degree = request.getParameter("degree");
            String course = request.getParameter("course0");
            course=course+","+request.getParameter("course1");
            course=course+","+request.getParameter("course2");
            course=course+","+request.getParameter("course3");
            course=course+","+request.getParameter("course4");
            course=course+","+request.getParameter("course5");
            String week=request.getParameter("beginw0");
            String hour=request.getParameter("beginh0");
            String miniute=request.getParameter("beginm0");
            String time = week+":"+hour+":"+miniute+",";
            week=request.getParameter("endw0");
            hour=request.getParameter("endh0");
            miniute=request.getParameter("endm0");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("beginw1");
            hour=request.getParameter("beginh1");
            miniute=request.getParameter("beginm1");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("endw1");
            hour=request.getParameter("endh1");
            miniute=request.getParameter("endm1");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("beginw2");
            hour=request.getParameter("beginh2");
            miniute=request.getParameter("beginm2");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("endw2");
            hour=request.getParameter("endh2");
            miniute=request.getParameter("endm2");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("beginw3");
            hour=request.getParameter("beginh3");
            miniute=request.getParameter("beginm3");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("endw3");
            hour=request.getParameter("endh3");
            miniute=request.getParameter("endm3");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("beginw4");
            hour=request.getParameter("beginh4");
            miniute=request.getParameter("beginm4");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("endw4");
            hour=request.getParameter("endh4");
            miniute=request.getParameter("endm4");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("beginw5");
            hour=request.getParameter("beginh5");
            miniute=request.getParameter("beginm5");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("endw5");
            hour=request.getParameter("endh5");
            miniute=request.getParameter("endm5");
            time = time+week+":"+hour+":"+miniute;
            String salary=request.getParameter("salary");
        	//接收用户名和密码  
        	String driverClass = "com.mysql.jdbc.Driver";
        	String url = "jdbc:mysql://localhost:3306/project?useSSL=false&serverTimezone=UTC";
        	String urn = "root";
        	String psw = "AnXin202511408!";
        	try {
				Class.forName(driverClass);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}//加载驱动 
        	Connection conn=null;
			try {
				conn = DriverManager.getConnection(url,urn,psw);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}//得到连接
        	if(conn != null){
        		String pathname="./images/avatar/"+uid+"_avatar";
        		f.write(pathname);
        		String sql = "update usr set email=' "+email+"' ,PhoneNumber= '"+phone+"' where uid= '"+uid+"'";
        		Statement stmt=null;
				try {
					stmt = conn.createStatement();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
        		try {
					stmt.execute(sql);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
        		sql = "update teacher set courses='"+course+"' ,FreetimeList= '"+time+"' ,location= '"+location+"' ,degree='"+degree+"' ,ExpectSalary='"+salary+"' where uid= '"+uid+"'";
        		try {
					stmt = conn.createStatement();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
        		try {
					stmt.execute(sql);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}				
        	}									
        	try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	response.sendRedirect("detail.jsp");         

        }
        else{
        	Part f=request.getPart("avatar");
        	String account = request.getParameter("account");
            String location = request.getParameter("location");
            String email = request.getParameter("email");
            String phone = request.getParameter("phonenumber");
            String degree = request.getParameter("degree");
            String course = request.getParameter("course0");
            course=course+","+request.getParameter("course1");
            course=course+","+request.getParameter("course2");
            course=course+","+request.getParameter("course3");
            course=course+","+request.getParameter("course4");
            course=course+","+request.getParameter("course5");
            String week=request.getParameter("beginw0");
            String hour=request.getParameter("beginh0");
            String miniute=request.getParameter("beginm0");
            String time = week+":"+hour+":"+miniute+",";
            week=request.getParameter("endw0");
            hour=request.getParameter("endh0");
            miniute=request.getParameter("endm0");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("beginw1");
            hour=request.getParameter("beginh1");
            miniute=request.getParameter("beginm1");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("endw1");
            hour=request.getParameter("endh1");
            miniute=request.getParameter("endm1");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("beginw2");
            hour=request.getParameter("beginh2");
            miniute=request.getParameter("beginm2");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("endw2");
            hour=request.getParameter("endh2");
            miniute=request.getParameter("endm2");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("beginw3");
            hour=request.getParameter("beginh3");
            miniute=request.getParameter("beginm3");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("endw3");
            hour=request.getParameter("endh3");
            miniute=request.getParameter("endm3");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("beginw4");
            hour=request.getParameter("beginh4");
            miniute=request.getParameter("beginm4");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("endw4");
            hour=request.getParameter("endh4");
            miniute=request.getParameter("endm4");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("beginw5");
            hour=request.getParameter("beginh5");
            miniute=request.getParameter("beginm5");
            time = time+week+":"+hour+":"+miniute+",";
            week=request.getParameter("endw5");
            hour=request.getParameter("endh5");
            miniute=request.getParameter("endm5");
            time = time+week+":"+hour+":"+miniute;
            String salary=request.getParameter("salary");
        	//接收用户名和密码  
        	String driverClass = "com.mysql.jdbc.Driver";
        	String url = "jdbc:mysql://localhost:3306/project?useSSL=false&serverTimezone=UTC";
        	String urn = "root";
        	String psw = "AnXin202511408!";
        	try {
				Class.forName(driverClass);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}//加载驱动 
        	Connection conn=null;
			try {
				conn = DriverManager.getConnection(url,urn,psw);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}//得到连接
        	if(conn != null){
        		String pathname="./images/avatar/"+uid+"_avatar";
        		f.write(pathname);
        		String sql = "update usr set email=' "+email+"' ,PhoneNumber= '"+phone+"' where uid= '"+uid+"'";
        		Statement stmt=null;
				try {
					stmt = conn.createStatement();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
        		try {
					stmt.execute(sql);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
        		sql = "update student set courses='"+course+"' ,FreetimeList= '"+time+"' ,location= '"+location+"' ,degree='"+degree+"' ,ExpectSalary='"+salary+"' where uid= '"+uid+"'";
        		try {
					stmt = conn.createStatement();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
        		try {
					stmt.execute(sql);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}					
        	}									
        	try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	response.sendRedirect("detail.jsp");     

        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
