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


            System.out.println("Connected to database ");
            // Create a statement
            Statement stmt = conn.createStatement();

            // Execute a query and get the result set
            ResultSet rs = stmt.executeQuery("SELECT * FROM tkey_location");

            //Loop through the result set and print out the data
            while (rs.next()) {
                String city = rs.getString("id_city");
                String country = rs.getString("ds_country");
                String building = rs.getString("ds_building");
                System.out.printf("City: %s, country: %s, building: %s\n", city, country, building);
            }
            

            // Close the result set, statement, and connection
            rs.close();
            stmt.close();
            
            // Close the connection
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            System.out.println("Not connected to database");
        }
    }
}