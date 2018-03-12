package Montessori;

import com.microsoft.sqlserver.jdbc.SQLServerDriver;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;

public class LoginVerification {
    
    public LoginVerification(){}
    public static Connection SQLConnection() throws SQLException {
        System.out.println("database.SQLMicrosoft.SQLConnection()");
        String url = "jdbc:sqlserver://ah-zaf.odbc.renweb.com\\ah_zaf:1433;databaseName=ah_zaf";
        String loginName = "AH_ZAF_CUST";
        String password = "BravoJuggle+396";
        DriverManager.registerDriver(new SQLServerDriver());
        Connection cn = null;
        try {

            cn = DriverManager.getConnection(url, loginName, password);
        } catch (SQLException ex) {
            System.out.println("No se puede conectar con el Motor");
            System.err.println(ex.getMessage());
        }

        return cn;
    }

    public static ResultSet Query(Connection conn, String queryString) throws SQLException {
        Statement stmt = null;
        ResultSet rs = null;
        stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
        ResultSet.CONCUR_READ_ONLY);
        rs = stmt.executeQuery(queryString);
        return rs;
    }

    public static ResultSet SQLQuery(String queryString) throws SQLException {
        return Query(SQLConnection(), queryString);
    }

    public User consultUserDB(String user,String password) throws Exception {
        User u = null;
      
        String query = "select username,PersonID from Person where username = '"+user+"' and pswd = HASHBYTES('MD5', CONVERT(nvarchar(4000),'"+password+"'));";
        ResultSet rs = SQLQuery(query);

         if(!rs.next()) 
         {u=new User();
                 u.setId(0);}
         else{
             rs.beforeFirst();
            while(rs.next()){
               
                u = new User();
                u.setName(rs.getString("username"));
                u.setPassword(password);
                u.setId(rs.getInt("PersonID"));

            }}
        return u;
    }
    
    public HashMap getSecurityGroupID() throws SQLException{
     
        HashMap<Integer,String> mapGroups = new HashMap<Integer,String>();
               
        String query ="select groupid,Name from SecurityGroups";
        ResultSet rs = DBConect.ah.executeQuery(query);
        while(rs.next()){
            mapGroups.put(rs.getInt("groupid"),rs.getString("Name")); 
        }
            
        return mapGroups;
    }
    
     public int fromGroup(int staffid) throws SQLException{
        int aux  = -1;
        String query = "select groupid from SecurityGroupMembership where StaffID = " + staffid;
       // ResultSet rs = SQLQuery(query);
       ResultSet rs = DBConect.ah.executeQuery(query);
            while(rs.next()){
                aux = rs.getInt("groupid");
            }
      
        return aux;
    }
     
     public HashMap getSons(int staffid) throws SQLException{
      
        HashMap<Integer,String> mapSons = new HashMap<Integer,String>();        
        String query ="Select FirstName,LastName,b.StudentID from Students inner join (select StudentID from Parent_Student where ParentID ="+staffid+" and custody = 'true' and ParentsWeb = 'true') b on b.StudentID = Students.StudentID";
        
        ResultSet rs = DBConect.ah.executeQuery(query);
        while(rs.next()){
            mapSons.put(rs.getInt("StudentID"),rs.getString("FirstName")+", "+rs.getString("LastName")); 
        } 
        return mapSons;
    } 
    
}
