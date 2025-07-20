<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    if (email != null && password != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:XE", 
                "tu_usuario", 
                "tu_password"
            );
            
            // En un sistema real, la contraseña estaría hasheada
            String sql = "SELECT u.id_usuario, u.nombre_usuario, u.correo_electronico " +
                        "FROM USUARIO u WHERE u.correo_electronico = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                // Login exitoso
                session.setAttribute("user_id", rs.getInt("id_usuario"));
                session.setAttribute("user_name", rs.getString("nombre_usuario"));
                session.setAttribute("user_email", rs.getString("correo_electronico"));
                
                response.sendRedirect("index.jsp?login=exitoso");
            } else {
                response.sendRedirect("index.jsp?error=credenciales_invalidas");
            }
            
        } catch (Exception e) {
            response.sendRedirect("index.jsp?error=error_login");
            e.printStackTrace();
            
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    } else {
        response.sendRedirect("index.jsp");
    }
%>
