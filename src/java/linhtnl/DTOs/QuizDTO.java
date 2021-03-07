/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package linhtnl.DTOs;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author ASUS
 */
public class QuizDTO implements Serializable {

    private String quizID, subID, timeOpen, timeClose;
    private int numOfQuestions, timeLimit;
    private String subName;

    public QuizDTO(String quizID, String subID, int numOfQuestions, String timeOpen, String timeClose, int timeLimit, String subName) {
        this.quizID = quizID;
        this.subID = subID;
        this.numOfQuestions = numOfQuestions;
        this.timeOpen = timeOpen;
        this.timeClose = timeClose;
        this.timeLimit = timeLimit;
        this.subName = subName;
    }

    public QuizDTO() {
    }

    public String getQuizID() {
        return quizID;
    }

    public void setQuizID(String quizID) {
        this.quizID = quizID;
    }

    public String getSubID() {
        return subID;
    }

    public void setSubID(String subID) {
        this.subID = subID;
    }

    public int getNumOfQuestions() {
        return numOfQuestions;
    }

    public void setNumOfQuestions(int numOfQuestions) {
        this.numOfQuestions = numOfQuestions;
    }

    public boolean getIsReady() throws ParseException {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Date open = formatter.parse(timeOpen);
        Date close = formatter.parse(timeClose);
        Date now = Calendar.getInstance().getTime();
        if (now.after(open) && now.before(close)) {
            return true;
        }
        return false;

    }

    public String getTimeOpen() {
        return timeOpen.substring(0, 16);
    }

    public void setTimeOpen(String timeOpen) {
        this.timeOpen = timeOpen;
    }

    public String getTimeClose() {
        return timeClose.substring(0, 16);
    }

    public void setTimeClose(String timeClose) {
        this.timeClose = timeClose;
    }

    public int getTimeLimit() {
        return timeLimit;
    }

    public void setTimeLimit(int timeLimit) {
        this.timeLimit = timeLimit;
    }

    public String getSubName() {
        return subName;
    }

    public void setSubName(String subName) {
        this.subName = subName;
    }

}
