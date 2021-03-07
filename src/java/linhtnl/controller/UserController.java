
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package linhtnl.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import linh.util.Constants;
import linhtnl.DAOs.QuestionDAO;
import linhtnl.DAOs.QuizDAO;
import linhtnl.DAOs.SubjectDAO;
import linhtnl.DAOs.UserDAO;
import linhtnl.DTOs.QuestionDTO;
import linhtnl.DTOs.QuizDTO;
import linhtnl.DTOs.QuizEnrollDTO;
import linhtnl.DTOs.SubjectDTO;
import linhtnl.DTOs.UserDTO;

/**
 *
 * @author ASUS
 */
public class UserController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UserController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = Constants.ERROR;
        try {
            HttpSession session = request.getSession();
            UserDAO dao = new UserDAO();
            String action = request.getParameter("action");
            UserDTO dto = new UserDTO();
            if (action.equals("login")) {
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                dto = dao.checkLogin(email, password);
                if (dto.getRole() == null) {
                    dto.setError("Invalid email or password");
                    url = Constants.LOGIN;
                } else if (dto.getRole().equalsIgnoreCase("teacher")) {
                    url = Constants.TEACHER_DASHBOARD;
                    //INIT SUBJECT
                    SubjectDAO subDAO = new SubjectDAO();
                    Vector<SubjectDTO> listSubject = subDAO.init();
                    //INIT QUESTION
                    QuestionDAO quesDAO = new QuestionDAO();
                    int page = 1;
                    int totalPage = quesDAO.getTotalPages();
                    Vector<QuestionDTO> listQuestion = quesDAO.getQuestionbyPage(page,null);
                    session.setAttribute("totalPage", totalPage);
                    session.setAttribute("listQuestion", listQuestion);
                    session.setAttribute("pageNum", page);
                    session.setAttribute("listSubject", listSubject);
                } else if (dto.getRole().equalsIgnoreCase("student")) {
                    //Get list Quiz
                    QuizDAO qDAO=new QuizDAO();
                    Vector<QuizDTO> listQuiz = qDAO.init();
                    session.setAttribute("listQuiz", listQuiz);
                    Vector<QuizEnrollDTO> listQuizTaken = qDAO.getQuizzesByStudentID(dto.getEmail());
                    session.setAttribute("listQuizTaken", listQuizTaken);
                    url = Constants.STUDENT_DASHBOARD;
                }
                session.setAttribute("ACC", dto);
            } else if (action.equals("register")) {
                String email = request.getParameter("email");
                String name = request.getParameter("name");
                String pass = request.getParameter("password");
                dto = new UserDTO(email);
                dto.setPassword(pass);
                dto.setUsername(name);
                if (dao.isExist(email)) {
                    dto.setError("Email is registed");
                    url = Constants.REGISTRATION;
                } else {
                    boolean check = dao.createNewAccount(dto);
                    if (check) {
                        url = Constants.STUDENT_DASHBOARD;
                    }
                }
                session.setAttribute("ACC", dto);
            } else if (action.equals("logout")) {
                session.invalidate();
                url = Constants.LOGIN;
            }
        } catch (Exception e) {
            e.printStackTrace();
            log("ERROR at doPost-UserController: " + e.getMessage());
        } finally {
            response.sendRedirect(url);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
