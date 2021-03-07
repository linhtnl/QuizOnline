/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package linhtnl.DTOs;

import java.io.Serializable;

/**
 *
 * @author ASUS
 */
public class QuestionDTO implements Serializable{
    private String content, optionA,optionB,optionC,optionD,correctAnswer,userID,createDate,questionID,subID;
    private boolean isAvailable;
    private String stuAnswer;
    public QuestionDTO() {
    }

    public String getContent() {
        return content;
    }

    public void setStuAnswer(String stuAnswer) {
        this.stuAnswer = stuAnswer;
    }

    public String getStuAnswer() {
        return stuAnswer;
    }

    public String getQuestionID() {
        return questionID;
    }

    public void setSubID(String subID) {
        this.subID = subID;
    }

    public String getSubID() {
        return subID;
    }

    public void setQuestionID(String questionID) {
        this.questionID = questionID;
    }
    
    public void setContent(String content) {
        this.content = content;
    }

    public String getOptionA() {
        return optionA;
    }

    public void setOptionA(String optionA) {
        this.optionA = optionA;
    }

    public String getOptionB() {
        return optionB;
    }

    public void setOptionB(String optionB) {
        this.optionB = optionB;
    }

    public String getOptionC() {
        return optionC;
    }

    public void setOptionC(String optionC) {
        this.optionC = optionC;
    }

    public String getOptionD() {
        return optionD;
    }

    public void setOptionD(String optionD) {
        this.optionD = optionD;
    }

    public String getCorrectAnswer() {
        return correctAnswer;
    }

    public void setCorrectAnswer(String correctAnswer) {
        this.correctAnswer = correctAnswer;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public boolean isIsAvailable() {
        return isAvailable;
    }

    public void setIsAvailable(boolean isAvailable) {
        this.isAvailable = isAvailable;
    }

    @Override
    public String toString() {
        return questionID +" - "+content;
    }
    
}
