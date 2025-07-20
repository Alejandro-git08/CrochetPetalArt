<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrar Productos - Crochet's Petal Art</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="../css/styles.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 bg-dark text-white p-0">
                <div class="d-flex flex-column min-vh-100">
                    <div class="p-3 border-bottom">
                        <h5><i class="fas fa-cog me-2"></i>Panel Admin</h5>
                    </div>
                    <nav class="nav flex-column p-3">
                        <a class="nav-link text-white active" href="productos.jsp">
                            <i class="fas fa-box me-2"></i>Productos
                        </a>
                        <a class="nav-link text-white" href="ordenes.jsp">
                            <i class="fas fa-shopping-cart me-2"></i>Órdenes
                        </a>
                        <a class="nav-link text-white" href="usuarios.jsp">
                            <i class="fas fa-users me-2"></i>Usuarios
                        </a>
                        <a class="nav-link text-white" href="../index.jsp">
                            <i class="fas fa-home me-2"></i>Volver a la Tienda
                        </a>
                    </nav>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-9 col-lg-10">
                <div class="p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2><i class="fas fa-box me-2 text-primary"></i>Gestión de Productos</h2>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalProducto">
                            <i class="fas fa-plus me-2"></i>Nuevo Producto
                        </button>
                    </div>
                    
                    <!-- Tabla de Productos -->
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th>ID</th>
                                            <th>Nombre</th>
                                            <th>Categoría</th>
                                            <th>Precio</th>
                                            <th>Stock</th>
                                            <th>Estado</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
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
                                                
                                                String sql = "SELECT p.id_producto, p.nombre_producto, p.precio_unitario, " +
                                                           "p.stock_producto, p.descripcion, cp.tipo_producto " +
                                                           "FROM PRODUCTO p " +
                                                           "LEFT JOIN CATEGORIA_PRODUCTO cp ON p.id_tipo_producto = cp.id_tipo_producto " +
                                                           "ORDER BY p.id_producto";
                                                
                                                pstmt = conn.prepareStatement(sql);
                                                rs = pstmt.executeQuery();
                                                
                                                while (rs.next()) {
                                                    int stock = rs.getInt("stock_producto");
                                                    String estadoStock = stock > 10 ? "En Stock" : stock > 0 ? "Stock Bajo" : "Agotado";
                                                    String badgeClass = stock > 10 ? "bg-success" : stock > 0 ? "bg-warning" : "bg-danger";
                                        %>
                                        <tr>
                                            <td><%= rs.getInt("id_producto") %></td>
                                            <td><%= rs.getString("nombre_producto") %></td>
                                            <td><%= rs.getString("tipo_producto") %></td>
                                            <td>$<%= String.format("%.2f", rs.getDouble("precio_unitario")) %></td>
                                            <td><%= stock %></td>
                                            <td><span class="badge <%= badgeClass %>"><%= estadoStock %></span></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary me-1" 
                                                        onclick="editarProducto(<%= rs.getInt("id_producto") %>)">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn btn-sm btn-outline-danger" 
                                                        onclick="eliminarProducto(<%= rs.getInt("id_producto") %>)">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <%
                                                }
                                            } catch (Exception e) {
                                                out.println("<tr><td colspan='7' class='text-center text-danger'>Error: " + e.getMessage() + "</td></tr>");
                                            } finally {
                                                if (rs != null) rs.close();
                                                if (pstmt != null) pstmt.close();
                                                if (conn != null) conn.close();
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Modal para Producto -->
    <div class="modal fade" id="modalProducto" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Nuevo Producto</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="procesar-producto.jsp" method="POST">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="nombre" class="form-label">Nombre del Producto</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="categoria" class="form-label">Categoría</label>
                                <select class="form-select" id="categoria" name="categoria" required>
                                    <option value="">Seleccionar categoría</option>
                                    <option value="1">Ramos</option>
                                    <option value="2">Arreglos</option>
                                    <option value="3">Decorativos</option>
                                    <option value="4">Centros de Mesa</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="precio" class="form-label">Precio</label>
                                <input type="number" class="form-control" id="precio" name="precio" step="0.01" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="stock" class="form-label">Stock</label>
                                <input type="number" class="form-control" id="stock" name="stock" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="descripcion" class="form-label">Descripción</label>
                            <textarea class="form-control" id="descripcion" name="descripcion" rows="3" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-primary">Guardar Producto</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editarProducto(id) {
            // Implementar edición de producto
            alert('Función de edición para producto ID: ' + id);
        }
        
        function eliminarProducto(id) {
            if (confirm('¿Estás seguro de que quieres eliminar este producto?')) {
                window.location.href = 'eliminar-producto.jsp?id=' + id;
            }
        }
    </script>
</body>
</html>
