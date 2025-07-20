<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String nombre = request.getParameter("nombre");
    String email = request.getParameter("email");
    String telefono = request.getParameter("telefono");
    String provincia = request.getParameter("provincia");
    String distrito = request.getParameter("distrito");
    String calle = request.getParameter("calle");
    String password = request.getParameter("password");
    
    Connection conn = null;
    CallableStatement cstmt = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(
            "jdbc:oracle:thin:@localhost:1521:XE", 
            "tu_usuario", 
            "tu_password"
        );
        
        conn.setAutoCommit(false);
        
        // Verificar si el email ya existe
        String sqlCheck = "SELECT COUNT(*) FROM USUARIO WHERE correo_electronico = ?";
        pstmt = conn.prepareStatement(sqlCheck);
        pstmt.setString(1, email);
        rs = pstmt.executeQuery();
        
        if (rs.next() && rs.getInt(1) > 0) {
            response.sendRedirect("registro.jsp?error=email_existe");
            return;
        }
        rs.close();
        pstmt.close();
        
        // Insertar usuario usando procedimiento almacenado
        String sqlUsuario = "{ call insertar_usuario(?, ?, 1, ?, ?, ?) }";
        cstmt = conn.prepareCall(sqlUsuario);
        cstmt.setString(1, nombre);
        cstmt.setString(2, email);
        cstmt.setString(3, provincia);
        cstmt.setString(4, distrito);
        cstmt.setString(5, calle);
        cstmt.execute();
        cstmt.close();
        
        // Obtener ID del usuario recién creado
        String sqlGetId = "SELECT id_usuario FROM USUARIO WHERE correo_electronico = ?";
        pstmt = conn.prepareStatement(sqlGetId);
        pstmt.setString(1, email);
        rs = pstmt.executeQuery();
        
        int userId = 0;
        if (rs.next()) {
            userId = rs.getInt("id_usuario");
        }
        rs.close();
        pstmt.close();
        
        // Insertar teléfono usando procedimiento almacenado
        if (userId > 0) {
            String sqlTelefono = "{ call insertar_telefono(?, ?) }";
            cstmt = conn.prepareCall(sqlTelefono);
            cstmt.setInt(1, userId);
            cstmt.setString(2, telefono);
            cstmt.execute();
            cstmt.close();
        }
        
        conn.commit();
        
        // Crear sesión para el usuario
        session.setAttribute("user_id", userId);
        session.setAttribute("user_name", nombre);
        session.setAttribute("user_email", email);
        
        response.sendRedirect("index.jsp?registro=exitoso");
        
    } catch (Exception e) {
        if (conn != null) {
            try {
                conn.rollback();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
        response.sendRedirect("registro.jsp?error=registro_fallido");
        e.printStackTrace();
        
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (cstmt != null) cstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
