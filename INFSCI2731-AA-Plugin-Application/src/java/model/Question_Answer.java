/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import dataAccessObject.AnswerDao;
import dataAccessObject.UserDao;

/**
 *This class is to create bean for question_answer
 * @author Hanwei Cheng
 */
public class Question_Answer {
    private int id;
    private String answer;
    private int account_info_id;
    private int security_question_id;
    private int timestamps_id;
    private AnswerDao dao;

    public int getId() {
        return id;
    }

    public String getAnswer() {
        return answer;
    }

    public int getAccount_info_id() {
        return account_info_id;
    }

    public int getSecurity_question_id() {
        return security_question_id;
    }

    public int getTimestamps_id() {
        return timestamps_id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public void setAccount_info_id(int account_info_id) {
        this.account_info_id = account_info_id;
    }

    public void setSecurity_question_id(int security_question_id) {
        this.security_question_id = security_question_id;
    }

    public void setTimestamps_id(int timestamps_id) {
        this.timestamps_id = timestamps_id;
    }
    
    public void generateRecord(){
        // create new timeStamp
        TimeStamp time = new TimeStamp();
        long timeID = time.getTimeStampsID();
        //create a new set question and answer
        dao = new AnswerDao();
      System.out.println("===== bean of question_answer " + answer + account_info_id + security_question_id);
        this.id =(int)dao.createQuestionAnswer(answer, account_info_id, security_question_id,timeID);
        
    }
    
}
