/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package linhtnl.DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;
import linh.util.SHA256;
import linhtnl.DTOs.QuestionDTO;
import linhtnl.DTOs.QuizDTO;
import linhtnl.DTOs.QuizEnrollDTO;
import linhtnl.db.LinhConnection;

/**
 *
 * @author ASUS
 */
public class QuizDAO {

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

    public Vector<QuestionDTO> getQuestionByQuizID(String id) throws Exception {
        Vector<QuestionDTO> subList = new Vector<>();
        try {
            String sql = "select q.questionID, questionContent,optionA,optionB,optionC,optionD,correct_answer,answer_choose\n"
                    + "from Question Q, QuestionQuiz Qz\n"
                    + "Where Q.QuestionID=qz.questionID and quizEnrollID= ?";
            con = LinhConnection.getConnection();
            pst = con.prepareStatement(sql);
            pst.setString(1, id);
            rs = pst.executeQuery();
            while (rs.next()) {
                String qid = rs.getString("questionID");
                String content = rs.getString("questionContent");
                String optionA = rs.getString("optionA");
                String optionB = rs.getString("optionB");
                String optionC = rs.getString("optionC");
                String optionD = rs.getString("optionD");
                String correct = rs.getString("correct_answer");
                String choose = rs.getString("answer_choose");
                QuestionDTO q = new QuestionDTO();
                q.setContent(content);
                q.setQuestionID(qid);
                q.setOptionA(optionA);
                q.setOptionB(optionB);
                q.setOptionC(optionC);
                q.setOptionD(optionD);
                q.setCorrectAnswer(correct);
                q.setStuAnswer(choose);
                subList.add(q);
            }
        } finally {
            closeConnection();
        }
        return subList;
    }

    public Vector<QuizEnrollDTO> getQuizzesByStudentID(String studentID) throws Exception {
        Vector<QuizEnrollDTO> list = new Vector<>();
        try {
            String sql = "select qe.QuizID, ID, score,numOfCorrectQuestions,numOfQuestions,q.SubID,s.subName,timeEnroll \n"
                    + "from QuizEnroll QE, Quiz q,tblSubject s\n"
                    + "where StudentID = ? and QE.QuizId=q.QuizID and q.SubID=s.SubID";
            con = LinhConnection.getConnection();
            pst = con.prepareStatement(sql);
            pst.setString(1, studentID);
            rs = pst.executeQuery();
            while (rs.next()) {
                String quizID = rs.getString("QuizID");
                String ID = rs.getString("ID");
                float score = rs.getFloat("score");
                int numOfCorrectQuestions = rs.getInt("numOfCorrectQuestions");
                int numOfQues = rs.getInt("numOfQuestions");
                String subId = rs.getString("subID");
                String subName = rs.getString("subName");
                String timeEnroll = rs.getString("timeEnroll");
                QuizEnrollDTO dto = new QuizEnrollDTO();
                dto.setTimeEnroll(timeEnroll);
                dto.setQuizID(quizID);
                dto.setID(ID);
                dto.setScore(score);
                dto.setNumOfCorrection(numOfCorrectQuestions);
                dto.setNumOfQuestion(numOfQues);
                dto.setSubID(subId);
                dto.setSubName(subName);
                list.add(dto);
            }
//            for (QuizEnrollDTO dto : list) {
//                sql = "select questionContent,optionA,optionB,optionC,optionD,correct_answer,answer_choose\n"
//                        + "from Question Q, QuestionQuiz Qz\n"
//                        + "Where Q.QuestionID=qz.questionID and quizEnrollID= ?";
//                pst = con.prepareStatement(sql);
//                pst.setString(1, dto.getID());
//                rs = pst.executeQuery();
//                Vector<QuestionDTO> subList = new Vector<>();
//                while (rs.next()) {
//                    String content = rs.getString("questionContent");
//                    String optionA = rs.getString("optionA");
//                    String optionB = rs.getString("optionB");
//                    String optionC = rs.getString("optionC");
//                    String optionD = rs.getString("optionD");
//                    String correct = rs.getString("correct_answer");
//                    String choose = rs.getString("answer_choose");
//                    QuestionDTO q = new QuestionDTO();
//                    q.setContent(content);
//                    q.setOptionA(optionA);
//                    q.setOptionB(optionB);
//                    q.setOptionC(optionC);
//                    q.setOptionD(optionD);
//                    q.setCorrectAnswer(correct);
//                    q.setStuAnswer(choose);
//                    subList.add(q);
//                }
//                dto.setList(subList);
//            }
        } finally {
            closeConnection();
        }
        return list;
    }

    public QuizDTO getQuizByID(String id) throws Exception {
        QuizDTO dto = null;
        try {
            String sql = "SELECT QuizID,Q.SubID,numOfQuestions,timeOpen,timeClose,timeLimit,S.subName "
                    + "FROM Quiz Q, tblSubject S "
                    + "WHERE Q.SubID = s.SubID and QuizID = ?";
            con = LinhConnection.getConnection();
            pst = con.prepareStatement(sql);
            pst.setString(1, id);
            rs = pst.executeQuery();
            while (rs.next()) {
                String quizID = rs.getString("QuizID");
                String subID = rs.getString("SubID");
                int numOfQues = rs.getInt("numOfQuestions");
                String timeOpen = rs.getString("timeOpen");
                String timeClose = rs.getString("timeClose");
                int timeLimit = rs.getInt("timeLimit");
                String subName = rs.getString("subName");
                dto = new QuizDTO(quizID, subID, numOfQues, timeOpen, timeClose, timeLimit, subName);

            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    public Vector<QuizDTO> init() throws Exception {
        Vector<QuizDTO> list = new Vector<>();
        try {
            String sql = "SELECT QuizID,Q.SubID,numOfQuestions,timeOpen,timeClose,timeLimit,S.subName "
                    + "FROM Quiz Q, tblSubject S "
                    + "WHERE Q.SubID = s.SubID";
            con = LinhConnection.getConnection();
            pst = con.prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                String quizID = rs.getString("QuizID");
                String subID = rs.getString("SubID");
                int numOfQues = rs.getInt("numOfQuestions");
                String timeOpen = rs.getString("timeOpen");
                String timeClose = rs.getString("timeClose");
                int timeLimit = rs.getInt("timeLimit");
                String subName = rs.getString("subName");
                QuizDTO dto = new QuizDTO(quizID, subID, numOfQues, timeOpen, timeClose, timeLimit, subName);
                list.add(dto);
            }
        } finally {
            closeConnection();
        }
        return list;
    }
}
