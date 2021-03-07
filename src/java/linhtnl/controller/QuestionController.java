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
import linhtnl.DTOs.QuestionDTO;
import linhtnl.DTOs.SearchDTO;
import linhtnl.DTOs.UserDTO;
import org.eclipse.jdt.internal.compiler.impl.Constant;

/**
 *
 * @author ASUS
 */
public class QuestionController extends HttpServlet {

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
            out.println("<title>Servlet QuestionController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet QuestionController at " + request.getContextPath() + "</h1>");
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
            String action = request.getParameter("action");
            System.out.println("Action: " + action);
            UserDTO acc = (UserDTO) session.getAttribute("ACC");
            QuestionDAO dao = new QuestionDAO();
            if (acc != null) {
                if (action.equals("pagination")) {
                    SearchDTO search = (SearchDTO) session.getAttribute("searchInfo");
                    int page = Integer.parseInt(request.getParameter("pageNum"));
                    Vector<QuestionDTO> listQuestion = new Vector<>();
                    if (search != null) {
                        listQuestion = dao.getQuestionbyPage(page, search);
                    } else {
                        listQuestion = dao.getQuestionbyPage(page, null);
                    }
                    session.setAttribute("listQuestion", listQuestion);
                    url = Constants.TEACHER_DASHBOARD;
                    session.setAttribute("pageNum", page);
                } else if (action.equals("create")) {
                    String questionContent = request.getParameter("questionContent").trim();
                    String optionA = request.getParameter("optionA").trim();
                    String optionB = request.getParameter("optionB").trim();
                    String optionC = request.getParameter("optionC").trim();
                    String optionD = request.getParameter("optionD").trim();
                    String subID = request.getParameter("subject").trim();
                    String correctAnswerByLetter = request.getParameter("correctAnswer").trim();
                    String correctAnswer = "";
                    switch (correctAnswerByLetter) {
                        case "A":
                            correctAnswer = optionA;
                            break;
                        case "B":
                            correctAnswer = optionB;
                            break;
                        case "C":
                            correctAnswer = optionC;
                            break;
                        case "D":
                            correctAnswer = optionD;
                            break;
                    }
                    QuestionDTO dto = new QuestionDTO();
                    dto.setContent(questionContent);
                    dto.setOptionA(optionA);
                    dto.setOptionB(optionB);
                    dto.setOptionC(optionC);
                    dto.setOptionD(optionD);
                    dto.setSubID(subID);
                    dto.setCorrectAnswer(correctAnswer);
                    if (dao.createQuestion(dto)) {
                        url = Constants.TEACHER_DASHBOARD;
                        int totalPage = dao.getTotalPages();
                        Vector<QuestionDTO> listQuestion = dao.getQuestionbyPage(1, null);
                        session.setAttribute("totalPage", totalPage);
                        session.setAttribute("listQuestion", listQuestion);
                        session.setAttribute("pageNum", 1);
                    }
                } else if (action.equals("update")) {
                    String questionID = request.getParameter("questionID");
                    QuestionDTO dto = dao.getQuestionByID(questionID);
                    if (dto != null) {
                        session.setAttribute("QuestionDTO", dto);
                        url = Constants.TEACHER_UPDATE_QUESTION;
                    }

                } else if (action.equals("delete")) {
                    String questionID = request.getParameter("questionID");
                    if (dao.deleteQuestion(questionID)) {
                        url = Constants.TEACHER_DASHBOARD;
                        //update list
                        int totalPage = dao.getTotalPages();
                        Vector<QuestionDTO> listQuestion = dao.getQuestionbyPage(1, null);
                        session.setAttribute("totalPage", totalPage);
                        session.setAttribute("listQuestion", listQuestion);
                        session.setAttribute("pageNum", 1);
                    }
                } else if (action.equals("submit_update")) {
                    QuestionDTO dto = (QuestionDTO) session.getAttribute("QuestionDTO");
                    String questionContent = request.getParameter("questionContent").trim();
                    String optionA = request.getParameter("optionA").trim();
                    String optionB = request.getParameter("optionB").trim();
                    String optionC = request.getParameter("optionC").trim();
                    String optionD = request.getParameter("optionD").trim();
                    String subID = request.getParameter("subject").trim();
                    String correctAnswerByLetter = request.getParameter("correctAnswer").trim();
                    String correctAnswer = "";
                    boolean status = request.getParameter("status").trim().equals("1") ? true : false;
                    switch (correctAnswerByLetter) {
                        case "A":
                            correctAnswer = optionA;
                            break;
                        case "B":
                            correctAnswer = optionB;
                            break;
                        case "C":
                            correctAnswer = optionC;
                            break;
                        case "D":
                            correctAnswer = optionD;
                            break;
                    }
                    dto.setContent(questionContent);
                    dto.setOptionA(optionA);
                    dto.setOptionB(optionB);
                    dto.setOptionC(optionC);
                    dto.setOptionD(optionD);
                    dto.setSubID(subID);
                    dto.setCorrectAnswer(correctAnswer);
                    dto.setIsAvailable(status);
                    if (dao.updateQuestion(dto)) {
                        url = Constants.TEACHER_DASHBOARD;
                        int totalPage = dao.getTotalPages();
                        Vector<QuestionDTO> listQuestion = dao.getQuestionbyPage(1, null);
                        session.setAttribute("totalPage", totalPage);
                        session.setAttribute("listQuestion", listQuestion);
                        session.setAttribute("pageNum", 1);
                    }
                } else if (action.equals("search")) {
                    String subjectId = request.getParameter("subject");
                    String status = request.getParameter("status");
                    String content = request.getParameter("txtSearch");
                    SearchDTO search = new SearchDTO(content, subjectId, status);
                    Vector<QuestionDTO> listQuestion = dao.getQuestionbyPage(1, search);
                    session.setAttribute("searchInfo", search);
                    session.setAttribute("listQuestion", listQuestion);
                    session.setAttribute("pageNum", 1);
                    url = Constants.TEACHER_DASHBOARD;
                }else if(action.equals("Get All")){
                    Vector<QuestionDTO> listQuestion = dao.getQuestionbyPage(1, null);
                    session.setAttribute("searchInfo", null);
                    session.setAttribute("listQuestion", listQuestion);
                    session.setAttribute("pageNum", 1);
                    url = Constants.TEACHER_DASHBOARD;
                }
            } else {
                url = Constants.LOGIN;
            }
        } catch (Exception e) {
            e.printStackTrace();
            log("ERROR at doPost-QuestionController: " + e.getMessage());
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
