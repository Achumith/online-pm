# Project Management System (PMS)

A Java-based web application for managing projects, tasks, and team collaboration. This project uses Java Servlets, JSP, MySQL, and Apache Tomcat.

## Prerequisites

Before running the project, ensure you have the following installed:

1.  **Java Development Kit (JDK)**: Recommended version 26.0.1 or higher.
2.  **Apache Tomcat**: Version 9.0 or higher recommended (installed at `C:\tomcat`).
3.  **MySQL Server**: Version 8.0 or higher.
4.  **PowerShell**: For running deployment scripts on Windows.

## Installation & Setup

### 1. Database Configuration

1.  Open your MySQL terminal or a GUI tool like MySQL Workbench.
2.  Create a database named `pms_db`:
    ```sql
    CREATE DATABASE pms_db;
    ```
3.  Import the database schema:
    ```bash
    mysql -u root -p pms_db < schema.sql
    ```
    *(Alternatively, run the contents of `schema.sql` manually in your SQL editor).*

4.  **Note**: The default database credentials are set to `root` / `root` in `src/main/java/com/pms/util/DBConnection.java`. Update these if your MySQL credentials differ.

### 2. Compilation

Compile the Java source files into the web application's classes directory. Run this command from the project root:

```powershell
javac -cp "lib\servlet-api.jar;lib\jsp-api.jar;lib\mysql-connector-j-9.7.0.jar" -d src\main\webapp\WEB-INF\classes src\main\java\com\pms\util\DBConnection.java src\main\java\com\pms\model\*.java src\main\java\com\pms\dao\*.java src\main\java\com\pms\filter\AuthFilter.java src\main\java\com\pms\servlet\*.java
```

### 3. Deployment

Deploy the compiled application to your Tomcat server using PowerShell:

```powershell
# Remove old deployment (if any)
Remove-Item -Path "C:\tomcat\webapps\ProjectManagement" -Recurse -Force -ErrorAction SilentlyContinue

# Create new application directory in Tomcat
New-Item -ItemType Directory -Path "C:\tomcat\webapps\ProjectManagement" -Force

# Copy web application files
Copy-Item -Path "src\main\webapp\*" -Destination "C:\tomcat\webapps\ProjectManagement" -Recurse -Force
```

### 4. Running the Project

Set the environment variables and start the Tomcat server:

```powershell
# Set Environment Variables (Adjust paths if necessary)
$env:CATALINA_HOME = "c:\tomcat"
$env:JAVA_HOME = "C:\Program Files\Java\jdk-26.0.1"

# Run Tomcat
c:\tomcat\bin\catalina.bat run
```

Once the server starts, you can access the application at:
`http://localhost:8080/ProjectManagement`

## Project Structure

- `src/main/java`: Backend logic (Servlets, DAOs, Models, Utilities).
- `src/main/webapp`: Frontend files (JSPs, CSS, JS, WEB-INF).
- `lib/`: Required JAR libraries.
- `schema.sql`: Database initialization script.
