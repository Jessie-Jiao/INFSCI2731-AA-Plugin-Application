/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dataAccessObject;

import DbConnect.DbConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *This class is to create a DAO for security question
 * @author Hanwei Cheng
 */
public class SecurityQuestionDao {
    private int keyNum;
    private Connection connection;
    Statement st = null;
    ResultSet rs = null;
    String sql = "";
    int recordNum;
    String  question1 = "What is the name of your favorite book as a child?";
    String  question2 = "What is the name of your 1st grade teacher?";
    String  question3 = "What was the color of the first car you owned?";
    String  question4 = "What was the name of the first pet you owned?";
    String  question5 = "What is the name of the city where you got lost?";
    String  question6 = "Where were you New Year's 2000?";
    String  question7 = "Who was your childhood role model?";
    String  question8 = "When you were young, what did you want to be be when you grew up?";
    String  question9 = "What is the street name you lived in as a child?";
    String  question10 = "In what town/city did your mother and father meet?";
            
     public SecurityQuestionDao() {
        //connect to database and select the record
        connection = DbConnection.getConnection();
        System.out.println("==SecurityQuestionDao connection==");
    }
    
    //check whether if there are any records in the table
     public int SecQueKeyNum(){
         try{
             sql = "SELECT count(id) from INFSCI2731.security_question";
             PreparedStatement ps = connection.prepareStatement(sql);
             rs = ps.executeQuery() ;
             if(rs.next())
                 return rs.getInt("count(id)");
             else return -1;
           } catch (SQLException e) {
                e.printStackTrace();
                return -1;
           }    
     }
     
     public boolean checkSecQueEmpty(){
         keyNum = SecQueKeyNum();
         if (keyNum == 0) return true;
         else return false;
     }
     
     public void fillSecQueTable(){
             try{
                sql = "INSERT INTO INFSCI2731.security_question(question) values (?)";
                PreparedStatement ps1 = connection.prepareStatement(sql);
                ps1.setString(1, question1);
                ps1.executeUpdate();
                
                sql = "INSERT INTO INFSCI2731.security_question(question) values (?)";
                PreparedStatement ps2 = connection.prepareStatement(sql);
                ps2.setString(1, question2);
                ps2.executeUpdate();
                
                sql = "INSERT INTO INFSCI2731.security_question(question) values (?)";
                PreparedStatement ps3 = connection.prepareStatement(sql);
                ps3.setString(1, question3);
                ps3.executeUpdate();
                
                sql = "INSERT INTO INFSCI2731.security_question(question) values (?)";
                PreparedStatement ps4 = connection.prepareStatement(sql);
                ps4.setString(1, question4);
                ps4.executeUpdate();
                
                sql = "INSERT INTO INFSCI2731.security_question(question) values (?)";
                PreparedStatement ps5 = connection.prepareStatement(sql);
                ps5.setString(1, question5);
                ps5.executeUpdate();
                
                sql = "INSERT INTO INFSCI2731.security_question(question) values (?)";
                PreparedStatement ps6 = connection.prepareStatement(sql);
                ps6.setString(1, question6);
                ps6.executeUpdate();
                
                sql = "INSERT INTO INFSCI2731.security_question(question) values (?)";
                PreparedStatement ps7 = connection.prepareStatement(sql);
                ps7.setString(1, question7);
                ps7.executeUpdate();
                
                sql = "INSERT INTO INFSCI2731.security_question(question) values (?)";
                PreparedStatement ps8 = connection.prepareStatement(sql);
                ps8.setString(1, question8);
                ps8.executeUpdate();
                
                sql = "INSERT INTO INFSCI2731.security_question(question) values (?)";
                PreparedStatement ps9 = connection.prepareStatement(sql);
                ps9.setString(1, question9);
                ps9.executeUpdate();
                
                sql = "INSERT INTO INFSCI2731.security_question(question) values (?)";
                PreparedStatement ps10 = connection.prepareStatement(sql);
                ps10.setString(1, question10);
                ps10.executeUpdate();
          
             } catch (SQLException e) {
                   e.printStackTrace();
             }     
  
     }
    
    //get the content of the question according to the id
    public String getQuestionContent(int id) {
        
        try{
            //prepare and execute search query
            sql = "SELECT question FROM INFSCI2731.security_question WHERE id = ?"; 
            PreparedStatement ps = connection.prepareStatement(sql);
                ps.setInt(1, id) ;                
                rs = ps.executeQuery() ;

            if (rs.next()) { 
                return rs.getString("question");                    
            }else
                return "error";
         
        } catch (SQLException e) {
                e.printStackTrace();
                return "error";
        }    
    }
    
    public ResultSet getSecurityQuestions() {
         try{
            //prepare and execute search query
            sql = "SELECT * FROM INFSCI2731.security_question"; 
            PreparedStatement ps = connection.prepareStatement(sql);            
                rs = ps.executeQuery() ;

            if (rs.next()) { 
                rs.beforeFirst();
                return rs;                    
            }else
                return null;
         
        } catch (SQLException e) {
                e.printStackTrace();
                return null;
        }   
        
    }

}
