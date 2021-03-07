/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package linhtnl.DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Vector;
import linh.util.SHA256;
import linhtnl.DTOs.QuestionDTO;
import linhtnl.db.LinhConnection;

/**
 *
 * @author ASUS
 */
public class QuestionQuizDAO {

    PreparedStatement pst;
    Connection con;
    ResultSet rs;

    private void closeConnection() throws Exception {
        if (rs != null) {
            rs.close();
        }
        if (pst != null) {
            pst.close();
        }
        if (con != null) {
            con.close();
        }
    }

    private String setQuizDetail(Vector<QuestionDTO> list, String userID, String quizID) throws Exception {
        String sql = "";
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String id = Calendar.getInstance().getTimeInMillis() + "";
        int count = 0;
        try {
            sql = "Insert into QuizEnroll(QuizId,StudentId,ID,timeEnroll,score,numOfCorrectQuestions) "
                    + "values (?,?,?,?,0,0) ";
            con = LinhConnection.getConnection();
            pst = con.prepareStatement(sql);
            pst.setString(1, quizID);
            pst.setString(2, userID);
            pst.setString(3, id);
            pst.setString(4, formatter.format(Calendar.getInstance().getTime()));
            if (pst.executeUpdate() > 0) {
                for (QuestionDTO dto : list) {
                    sql = "Insert QuestionQuiz(questionID,quizEnrollID) values (?,?)";
                    pst = con.prepareStatement(sql);
                    pst.setString(1, dto.getQuestionID());
                    pst.setString(2, id);
                    count += pst.executeUpdate();
                }
            }
        } finally {
            closeConnection();
        }
        return id;
    }

    public Vector<QuestionDTO> createQuiz(int numOfQuestion, String subID, String userID, String quizID) throws Exception {
        Vector<QuestionDTO> list = new Vector<>();
        try {
            String sql = "SELECT TOP (?) *\n"
                    + "FROM Question \n"
                    + "WHERE SubID = ?\n"
                    + "order by NEWID()";
            con = LinhConnection.getConnection();
            pst = con.prepareStatement(sql);
            pst.setInt(1, numOfQuestion);
            pst.setString(2, subID);
            rs = pst.executeQuery();
            while (rs.next()) {
                String quesID = rs.getString("QuestionID");
                String content = rs.getString("questionContent");
                String optionA = rs.getString("optionA");
                String optionB = rs.getString("optionB");
                String optionC = rs.getString("optionC");
                String optionD = rs.getString("optionD");
                QuestionDTO dto = new QuestionDTO();
                dto.setQuestionID(quesID);
                dto.setContent(content);
                dto.setOptionA(optionA);
                dto.setOptionB(optionB);
                dto.setOptionC(optionC);
                dto.setOptionD(optionD);
                list.add(dto);
            }
        } finally {
            closeConnection();
        }
        setQuizDetail(list, userID, quizID);
        return list;
    }

    public String getEnrollID(String studentID) throws Exception {
        String id = "";
        try {
            String sql = "select top 1 id from QuizEnroll \n"
                    + "where StudentID=? \n"
                    + "order by timeenroll desc ";
            con = LinhConnection.getConnection();
            pst = con.prepareStatement(sql);
            pst.setString(1, studentID);
            rs = pst.executeQuery();
            if (rs.next()) {
                id = rs.getString("id");
            }
        } finally {
            closeConnection();
        }
        return id;
    }

    public boolean writeAnswer(Vector<QuestionDTO> list, String QuizEnrollID) throws Exception {
        String sql = "";
        int count = 0;
        try {
            con = LinhConnection.getConnection();
            for (QuestionDTO dto : list) {
                sql = "update questionQuiz set answer_choose = '"+dto.getStuAnswer()+"' where questionID='"+dto.getQuestionID()+"' and quizEnrollID = '"+QuizEnrollID+"'";          
                pst = con.prepareStatement(sql);      
                System.out.println(sql);
                count += pst.executeUpdate();
            }
        } finally {
            closeConnection();
        }
        return count == list.size();
    }

    public boolean submitQuiz(Vector<QuestionDTO> list, String QuizEnrollID) throws Exception {
        float score = 0;
        int correct = 0;
        try {
            String sql = "select dbo.numberOfCorrect(?) as numberOfCorrectAnswers";
            con = LinhConnection.getConnection();
            pst = con.prepareStatement(sql);
            pst.setString(1, QuizEnrollID);
            rs = pst.executeQuery();
            if (rs.next()) {
                correct = rs.getInt("numberOfCorrectAnswers");
                score = (correct * 10) / list.size();
            }
            sql = "Update QuizEnroll set score =? , numOfCorrectQuestions=? where ID= ?";
            pst = con.prepareStatement(sql);
            pst.setFloat(1, score);
            pst.setInt(2, correct);
            pst.setString(3, QuizEnrollID);
            return pst.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
    }
}
