<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmación de Pedido - Crochet's Petal Art</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <%
                    String ordenId = request.getParameter("orden");
                    if (ordenId != null && !ordenId.isEmpty()) {
                        
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
                            
                            // Obtener detalles de la orden
                            String sql = "SELECT o.id_orden, o.fecha_orden, o.fecha_entrega, " +
                                       "o.total_comprado, o.estado_orden, p.metodo, p.estado_pago " +
                                       "FROM ORDEN o " +
                                       "LEFT JOIN PAGO p ON o.id_orden = p.id_orden " +
                                       "WHERE o.id_orden = ?";
                            
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setInt(1, Integer.parseInt(ordenId));
                            rs = pstmt.executeQuery();
                            
                            if (rs.next()) {
                %>
                
                <div class="card shadow-lg">
                    <div class="card-header bg-success text-white text-center py-4">
                        <i class="fas fa-check-circle fa-3x mb-3"></i>
                        <h2 class="mb-0">¡Pedido Confirmado!</h2>
                        <p class="mb-0">Tu orden ha sido procesada exitosamente</p>
                    </div>
                    
                    <div class="card-body p-5">
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <h5><i class="fas fa-receipt me-2 text-primary"></i>Detalles del Pedido</h5>
                                <table class="table table-borderless">
                                    <tr>
                                        <td><strong>Número de Orden:</strong></td>
                                        <td>#<%= rs.getInt("id_orden") %></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Fecha del Pedido:</strong></td>
                                        <td><%= rs.getDate("fecha_orden") %></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Fecha de Entrega:</strong></td>
                                        <td><%= rs.getDate("fecha_entrega") %></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Estado:</strong></td>
                                        <td><span class="badge bg-warning"><%= rs.getString("estado_orden") %></span></td>
                                    </tr>
                                </table>
                            </div>
                            
                            <div class="col-md-6">
                                <h5><i class="fas fa-credit-card me-2 text-primary"></i>Información de Pago</h5>
                                <table class="table table-borderless">
                                    <tr>
                                        <td><strong>Método de Pago:</strong></td>
                                        <td><%= rs.getString("metodo") %></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Estado del Pago:</strong></td>
                                        <td><span class="badge bg-success"><%= rs.getString("estado_pago") %></span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Total Pagado:</strong></td>
                                        <td class="h5 text-primary">$<%= String.format("%.2f", rs.getDouble("total_comprado")) %></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        
                        <hr>
                        
                        <div class="alert alert-info">
                            <h6><i class="fas fa-info-circle me-2"></i>Información Importante</h6>
                            <ul class="mb-0">
                                <li>Recibirás un email de confirmación en los próximos minutos</li>
                                <li>Tu pedido será preparado con cuidado artesanal</li>
                                <li>Te notificaremos cuando tu pedido esté en camino</li>
                                <li>Puedes rastrear tu pedido en tu cuenta</li>
                            </ul>
                        </div>
                        
                        <div class="text-center mt-4">
                            <a href="index.jsp" class="btn btn-primary me-3">
                                <i class="fas fa-home me-2"></i>Volver al Inicio
                            </a>
                            <a href="mis-pedidos.jsp" class="btn btn-outline-primary">
                                <i class="fas fa-list me-2"></i>Ver Mis Pedidos
                            </a>
                        </div>
                    </div>
                </div>
                
                <%
                            } else {
                %>
                <div class="alert alert-warning text-center">
                    <h4>Orden no encontrada</h4>
                    <p>No se pudo encontrar la información de tu pedido.</p>
                    <a href="index.jsp" class="btn btn-primary">Volver al Inicio</a>
                </div>
                <%
                            }
                        } catch (Exception e) {
                            out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                        } finally {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        }
                    } else {
                %>
                <div class="alert alert-danger text-center">
                    <h4>Error</h4>
                    <p>No se especificó un número de orden válido.</p>
                    <a href="index.jsp" class="btn btn-primary">Volver al Inicio</a>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
    
    <script>
        // Limpiar carrito del localStorage después de confirmar pedido
        localStorage.removeItem('carrito');
        
        // Mostrar animación de confeti (opcional)
        document.addEventListener('DOMContentLoaded', function() {
            // Aquí puedes agregar una librería de confeti si lo deseas
            console.log('¡Pedido confirmado exitosamente!');
        });
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
