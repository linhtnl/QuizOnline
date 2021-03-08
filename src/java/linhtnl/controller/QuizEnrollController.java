/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package linhtnl.controller;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import linh.util.Constants;
import linhtnl.DAOs.QuestionQuizDAO;
import linhtnl.DAOs.QuizDAO;
import linhtnl.DTOs.QuestionDTO;
import linhtnl.DTOs.QuizDTO;
import linhtnl.DTOs.QuizEnrollDTO;
import linhtnl.DTOs.UserDTO;

/**
 *
 * @author ASUS
 */
public class QuizEnrollController extends HttpServlet {

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
            out.println("<title>Servlet QuizController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet QuizController at " + request.getContextPath() + "</h1>");
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
        try {
            Gson gson = new Gson();
            String json = gson.toJson(questions);
            response.setContentType("application/json");
            response.getWriter().print(json);
        } catch (Exception e) {
            e.printStackTrace();
            log("ERROR at doGet-QuizController: " + e.getMessage());
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private Vector<QuestionDTO> questions;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = Constants.ERROR;
        try {
            String action = request.getParameter("action");
            System.out.println("Action: " + action);
            HttpSession session = request.getSession();
            UserDTO acc = (UserDTO) session.getAttribute("ACC");

            if (acc != null) {
                QuestionQuizDAO dao = new QuestionQuizDAO();
                switch (action) {
                    case "take_quiz":
                        String quizID = request.getParameter("quizID");
                        QuizDAO qDAO = new QuizDAO();
                        QuizDTO quizDTO = qDAO.getQuizByID(quizID);
                        if (quizDTO != null) {
                            url = Constants.STUDENT_TAKE_QUIZ;
                            session.setAttribute("quizDTO", quizDTO);
                            questions = dao.createQuiz(quizDTO.getNumOfQuestions(), quizDTO.getSubID(), acc.getEmail(), quizID);
                            session.setAttribute("exam", questions);
                            session.setAttribute("enrollID", dao.getEnrollID(acc.getEmail()));
                        }
                        break;
                    case "Submit":
                        Vector<QuestionDTO> listQ = (Vector<QuestionDTO>) session.getAttribute("exam");
                        for (QuestionDTO dto : listQ) {
                            String x = request.getParameter("option-" + dto.getQuestionID()) == null ? "" : request.getParameter("option-" + dto.getQuestionID());
                            System.out.println(dto.getQuestionID() + " - " + x);
                            dto.setStuAnswer(x);
                        }
                        String enrollID = (String) session.getAttribute("enrollID");
                        boolean a = dao.writeAnswer(listQ, enrollID);
                       
                        dao.submitQuiz(listQ, enrollID);
                        Vector<QuizEnrollDTO> listQuizTaken = new QuizDAO().getQuizzesByStudentID(acc.getEmail());
                        session.setAttribute("listQuizTaken", listQuizTaken);
                        url = Constants.STUDENT_DASHBOARD;
                        break;
                    case "review":
                        String id = request.getParameter("ID");
                        QuizEnrollDTO dto = null;
                        for (QuizEnrollDTO o : (Vector<QuizEnrollDTO>) session.getAttribute("listQuizTaken")) {
                            if (o.getID().equals(id)) {
                                dto = o;
                            }
                        }
                        Vector<QuestionDTO> questions = new QuizDAO().getQuestionByQuizID(id);
                       
                        session.setAttribute("questionsQuizz", questions);
                        session.setAttribute("QuizEnrollDTO", dto);
                        url = Constants.STUDENT_REVIEW;
                        break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            log("ERROR at doPost-QuizEnrollController: " + e.getMessage());
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
