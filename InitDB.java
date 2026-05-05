import java.sql.*;
import java.nio.file.*;

public class InitDB {
    public static void main(String[] args) throws Exception {
        String url = "jdbc:mysql://localhost:3306/?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        String user = "root";
        String pass = args.length > 0 ? args[0] : ""; 
        
        System.out.println("Connecting to MySQL...");
        try (Connection c = DriverManager.getConnection(url, user, pass);
             Statement st = c.createStatement()) {
            
            String schema = new String(Files.readAllBytes(Paths.get("schema.sql")));
            String[] commands = schema.split(";");
            
            for (String cmd : commands) {
                String trimmed = cmd.trim();
                if (!trimmed.isEmpty()) {
                    System.out.println("Executing: " + (trimmed.length() > 50 ? trimmed.substring(0, 50) + "..." : trimmed));
                    st.execute(trimmed);
                }
            }
            System.out.println("Database initialized successfully!");
        }
    }
}
