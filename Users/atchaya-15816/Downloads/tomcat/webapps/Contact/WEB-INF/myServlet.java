import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.OutputStream;
import java.io.FileOutputStream;
import java.io.FileInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
@MultipartConfig
public class myServlet extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse resp)throws IOException, ServletException{
		resp.setContentType("image/*");
		RequestDispatcher rd = req.getRequestDispatcher("contact.jsp");
		rd.forward(req,resp);
	}
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws IOException, ServletException{
		Connection connection = null;
		try{
			connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Raj","atchaya-15816","vinci@Da22raj");
			PreparedStatement statement = connection.prepareStatement("insert into contactDetails values(default,?,?,?)");
			Part filePart = req.getPart("image");
			String fname = req.getParameter("fname");
			String lname = req.getParameter("lname");
			String name = fname+" "+lname;
			String number = req.getParameter("number");
			String imageName = filePart.getSubmittedFileName();
			if(!imageName.equals("")){
				OutputStream oStream = new FileOutputStream(new File("/Users/atchaya-15816/Downloads/tomcat/webapps/images/"+imageName));
				InputStream iStream = filePart.getInputStream();
				int read = 0;
				byte[] bytes = new byte[1024];
				while((read = iStream.read(bytes))!= -1){
					oStream.write(bytes,0,read);
				}
				oStream.close();
				iStream.close();
			}
			else{
				imageName = "";
			}
			statement.setString(1,number);
			statement.setString(2,name);
			statement.setString(3,imageName);
			statement.executeUpdate();
			doGet(req,resp);
			// resp.getWriter().println("Contact Created");
		}
		catch(SQLException e){
			resp.getWriter().println(e);
		}
		finally{
			if(connection != null){
				try{
					connection.close();
				}
				catch(Exception e){}
			}
		}
	}
}

