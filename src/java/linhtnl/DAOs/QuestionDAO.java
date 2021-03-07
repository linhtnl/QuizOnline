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
import linhtnl.DTOs.SearchDTO;
import linhtnl.db.LinhConnection;

/**
 *
 * @author ASUS
 */
public class QuestionDAO {

    PreparedStatement pst;
    Connection con;
    ResultSet rs;
    SHA256 SHA = new SHA256();
    private final int questionsPerPage = 20;

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

    public boolean updateQuestion(QuestionDTO dto) throws Exception {
        boolean check = false;
        try {
            String sql = "UPDATE Question "
                    + "SET questionContent=?, optionA=?, optionB=?, optionC=?, optionD=?,correct_answer=?,status=?,subId=? "
                    + "WHERE QuestionID = ?";
            con = LinhConnection.getConnection();
            pst = con.prepareStatement(sql);
            pst.setString(1, dto.getContent());
            pst.setString(2, dto.getOptionA());
            pst.setString(3, dto.getOptionB());
            pst.setString(4, dto.getOptionC());
            pst.setString(5, dto.getOptionD());
            pst.setString(6, dto.getCorrectAnswer());
            pst.setBoolean(7, dto.isIsAvailable());
            pst.setString(8, dto.getSubID());
            pst.setString(9, dto.getQuestionID());
            check = pst.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean deleteQuestion(String id) throws Exception {
        boolean check = false;
        try {
            String sql = "Update Question set status = 0 where QuestionId = ?";
            con = LinhConnection.getConnection();
            pst = con.prepareStatement(sql);
            pst.setString(1, id);
            check = pst.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public QuestionDTO getQuestionByID(String id) throws Exception {
        QuestionDTO dto = null;
        try {
            String sql = "Select * from Question where QuestionID = ?";
            con = LinhConnection.getConnection();
            pst = con.prepareStatement(sql);
            pst.setString(1, id);
            rs = pst.executeQuery();
            if (rs.next()) {
                dto = new QuestionDTO();
                dto.setQuestionID(rs.getString("QuestionID"));
                dto.setContent(rs.getString("questionContent"));
                dto.setOptionA(rs.getString("optionA"));
                dto.setOptionB(rs.getString("optionB"));
                dto.setOptionC(rs.getString("optionC"));
                dto.setOptionD(rs.getString("optionD"));
                dto.setCorrectAnswer(rs.getString("correct_answer"));
                dto.setIsAvailable(rs.getBoolean("status"));
                dto.setSubID(rs.getString("subID"));
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    public boolean createQuestion(QuestionDTO dto) throws Exception {
        boolean check = false;

        try {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
            String id = dto.getSubID() + Calendar.getInstance().getTimeInMillis();
            String createDate = formatter.format(Calendar.getInstance().getTime());
            String sql = "Insert Question(QuestionID, questionContent,optionA,optionB,optionC,optionD,correct_answer,createDate,subID) "
                    + "values(?,?,?,?,?,?,?,?,?)";
            con = LinhConnection.getConnection();
            pst = con.prepareStatement(sql);
            pst.setString(1, id);
            pst.setString(2, dto.getContent());
            pst.setString(3, dto.getOptionA());
            pst.setString(4, dto.getOptionB());
            pst.setString(5, dto.getOptionC());
            pst.setString(6, dto.getOptionD());
            pst.setString(7, dto.getCorrectAnswer());
            pst.setString(8, createDate);
            pst.setString(9, dto.getSubID());
            check = pst.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public int getCountQuestions() throws Exception {
        int total = 0;
        try {
            String sql = "Select count(QuestionID) as total\n"
                    + "from Question";
            con = LinhConnection.getConnection();
            pst = con.prepareStatement(sql);
            rs = pst.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } finally {
            closeConnection();
        }
        return total;
    }

    public int getTotalPages() throws Exception {
        return (int) Math.ceil(getCountQuestions() * 1.0 / questionsPerPage);
    }

    public Vector<QuestionDTO> getQuestionbyPage(int page, SearchDTO search) throws Exception {
        Vector<QuestionDTO> result = new Vector<>();
        String whereStm = "";
        if (search != null) {
            whereStm += "WHERE questionContent like '%" + search.getContent() + "%'";
            if (!search.getSubID().equals("")) {
                whereStm += " and SubID = '" + search.getSubID() + "'";
            }
            if (!search.getStatus().equals("")) {
                whereStm += " and status=" + search.getStatus() + " \n";
            }
        }
        System.out.println("Where clause:" +whereStm);
        try {
            String sql = "DECLARE @PageNumber AS INT, @RowspPage AS INT\n"
                    + "SET @PageNumber = " + page + "\n"
                    + "SET @RowspPage = " + questionsPerPage + " \n"
                    + "SELECT *\n"
                    + "FROM Question\n" + whereStm
                    + "\nORDER BY QuestionID\n"
                    + "OFFSET ((@PageNumber - 1) * @RowspPage) ROWS\n"
                    + "FETCH NEXT @RowspPage ROWS ONLY";
            con = LinhConnection.getConnection();
            pst = con.prepareStatement(sql);
            System.out.println(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                QuestionDTO dto = new QuestionDTO();
                dto.setQuestionID(rs.getString("QuestionID"));
                dto.setContent(rs.getString("questionContent"));
                dto.setOptionA(rs.getString("optionA"));
                dto.setOptionB(rs.getString("optionB"));
                dto.setOptionC(rs.getString("optionC"));
                dto.setOptionD(rs.getString("optionD"));
                dto.setCorrectAnswer(rs.getString("correct_answer"));
                dto.setIsAvailable(rs.getBoolean("status"));
                dto.setSubID(rs.getString("subID"));
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }
}
