package servlet;
import java.io.*;
import jakarta.servlet.http.*;

public class HelloServlet extends HttpServlet {

    String message;

    public void init() {
        message = "Hello !";
    }
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>" + message + "</h1>");
        out.println("</body></html>");
    }

}
