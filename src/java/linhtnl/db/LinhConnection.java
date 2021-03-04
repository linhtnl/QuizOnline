/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package linhtnl.db;
import java.sql.Connection;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
/**
 *
 * @author ADMIN
 */
public class LinhConnection {
   
    public static Connection getConnection()throws Exception{
        Context context = new InitialContext();
        Context tomcatContext =(Context)context.lookup("java:comp/env");
        DataSource ds = (DataSource)tomcatContext.lookup("QuizOnline");
        Connection con = ds.getConnection();
        return con;
    }
}
