import java.sql.*;
public class App {
    public static void main(String[] args) throws Exception {
        try {
            // Load the PostgreSQL JDBC driver
            Class.forName("org.postgresql.Driver");

            // Set up the connection parameters
            String url = "jdbc:postgresql://localhost:5432/wab3_db";
            String user = "postgres";
            String password = "R00t1";

            // Create a connection to the database
            Connection conn = DriverManager.getConnection(url, user, password);

            // Do something with the connection (e.g. query the database)
            System.out.println("Connected to database ");

            
            // Close the connection
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            System.out.println("Not connected to database");
        }
    }
}