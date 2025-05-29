
package vn.edu.hcmuaf.fit.sourcedoannoithat.controller.mod;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.NewsDAO;

import java.io.IOException;
@WebServlet(name = "DeleteNews", value = "/mod/newsmanager/deleteNews")
public class DeleteNews extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idRaw = request.getParameter("id");
        if (idRaw != null) {
            try {
                int id = Integer.parseInt(idRaw);
                NewsDAO dao = new NewsDAO();
                boolean deleted = dao.deleteNewsById(id);

                if (deleted) {
                    response.sendRedirect(request.getContextPath() + "/mod/newsmanager?msg=deleted");
                } else {
                    response.sendRedirect(request.getContextPath() + "/mod/newsmanager?error=not_found");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/mod/newsmanager?error=invalid_id");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/mod/newsmanager?error=missing_id");
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 
    }
}