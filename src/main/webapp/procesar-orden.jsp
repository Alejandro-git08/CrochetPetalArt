<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    // Verificar que hay items en el carrito
    String totalItemsStr = request.getParameter("total_items");
    if (totalItemsStr == null || totalItemsStr.isEmpty()) {
        response.sendRedirect("carrito.jsp?error=carrito_vacio");
        return;
    }
    
    int totalItems = Integer.parseInt(totalItemsStr);
    String fechaEntrega = request.getParameter("fecha_entrega");
    String metodoPago = request.getParameter("metodo_pago");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        // Conexión a la base de datos
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(
            "jdbc:oracle:thin:@localhost:1521:XE", 
            "tu_usuario", 
            "tu_password"
        );
        
        conn.setAutoCommit(false); // Iniciar transacción
        
        // Simular usuario logueado (en producción obtener de sesión)
        int idUsuario = 1;
        
        // 1. Crear carrito si no existe
        String sqlCarrito = "INSERT INTO CARRITO (id_carrito, fecha_ingreso, estado_carrito, id_usuario) " +
                           "VALUES (seq_carrito.NEXTVAL, SYSDATE, 'abierto', ?)";
        pstmt = conn.prepareStatement(sqlCarrito, new String[]{"id_carrito"});
        pstmt.setInt(1, idUsuario);
        pstmt.executeUpdate();
        
        rs = pstmt.getGeneratedKeys();
        int idCarrito = 0;
        if (rs.next()) {
            idCarrito = rs.getInt(1);
        }
        rs.close();
        pstmt.close();
        
        // 2. Agregar items al carrito
        double totalCompra = 0;
        for (int i = 0; i < totalItems; i++) {
            String itemId = request.getParameter("item_" + i + "_id");
            String itemCantidad = request.getParameter("item_" + i + "_cantidad");
            String itemPrecio = request.getParameter("item_" + i + "_precio");
            
            if (itemId != null && itemCantidad != null && itemPrecio != null) {
                int productoId = Integer.parseInt(itemId);
                int cantidad = Integer.parseInt(itemCantidad);
                double precio = Double.parseDouble(itemPrecio);
                
                // Agregar al detalle del carrito
                String sqlDetalle = "INSERT INTO DETALLE_CARRITO (id_carrito, id_producto, cantidad_producto) " +
                                   "VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(sqlDetalle);
                pstmt.setInt(1, idCarrito);
                pstmt.setInt(2, productoId);
                pstmt.setInt(3, cantidad);
                pstmt.executeUpdate();
                pstmt.close();
                
                totalCompra += precio * cantidad;
            }
        }
        
        // 3. Crear orden usando el procedimiento almacenado
        String sqlProcedimiento = "{ call crear_orden_desde_carrito(?) }";
        CallableStatement cstmt = conn.prepareCall(sqlProcedimiento);
        cstmt.setInt(1, idCarrito);
        cstmt.execute();
        cstmt.close();
        
        // 4. Obtener ID de la orden creada
        String sqlOrden = "SELECT id_orden FROM ORDEN WHERE id_usuario = ? ORDER BY fecha_orden DESC";
        pstmt = conn.prepareStatement(sqlOrden);
        pstmt.setInt(1, idUsuario);
        rs = pstmt.executeQuery();
        
        int idOrden = 0;
        if (rs.next()) {
            idOrden = rs.getInt("id_orden");
        }
        rs.close();
        pstmt.close();
        
        // 5. Procesar pago usando el procedimiento almacenado
        if (idOrden > 0) {
            String sqlPago = "{ call ingresar_pago(?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), 'pendiente') }";
            cstmt = conn.prepareCall(sqlPago);
            cstmt.setInt(1, idOrden);
            cstmt.setString(2, metodoPago);
            cstmt.setDouble(3, totalCompra + 5.00); // Agregar costo de envío
            cstmt.setString(4, fechaEntrega);
            cstmt.execute();
            cstmt.close();
        }
        
        conn.commit(); // Confirmar transacción
        
        // Redirigir a página de confirmación
        response.sendRedirect("confirmacion.jsp?orden=" + idOrden);
        
    } catch (Exception e) {
        if (conn != null) {
            try {
                conn.rollback(); // Revertir transacción en caso de error
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
        
        out.println("<div class='alert alert-danger'>Error al procesar la orden: " + e.getMessage() + "</div>");
        e.printStackTrace();
        
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
