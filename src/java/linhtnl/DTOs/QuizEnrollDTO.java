/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package linhtnl.DTOs;

import java.io.Serializable;
import java.util.Vector;

/**
 *
 * @author ASUS
 */
public class QuizEnrollDTO implements Serializable{
    private String QuizID, ID,subID,subName,timeEnroll;
    private int numOfCorrection,numOfQuestion;
    private float score;
    private Vector<QuestionDTO> list ;

    public QuizEnrollDTO() {
    }

    public String getQuizID() {
        return QuizID;
    }

    public void setTimeEnroll(String timeEnroll) {
        this.timeEnroll = timeEnroll;
    }

    public String getTimeEnroll() {
        return timeEnroll.substring(0, 16);
    }

    public void setQuizID(String QuizID) {
        this.QuizID = QuizID;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public void setSubName(String subName) {
        this.subName = subName;
    }

    public void setSubID(String subID) {
        this.subID = subID;
    }

    public void setNumOfQuestion(int numOfQuestion) {
        this.numOfQuestion = numOfQuestion;
    }

    public String getSubName() {
        return subName;
    }

    public String getSubID() {
        return subID;
    }

    public int getNumOfQuestion() {
        return numOfQuestion;
    }

    public int getNumOfCorrection() {
        return numOfCorrection;
    }

    public void setNumOfCorrection(int numOfCorrection) {
        this.numOfCorrection = numOfCorrection;
    }

    public float getScore() {
        return score;
    }

    public void setScore(float score) {
        this.score = score;
    }

    public Vector<QuestionDTO> getList() {
        return list;
    }

    public void setList(Vector<QuestionDTO> list) {
        this.list = list;
    }
    
}
