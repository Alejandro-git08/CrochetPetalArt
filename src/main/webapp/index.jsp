<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crochet's Petal Art - Arreglos Florales Artesanales</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
    <!-- Header -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="index.jsp">
                <div class="brand-icon me-2">
                    <i class="fas fa-heart text-white"></i>
                </div>
                <div>
                    <h4 class="mb-0 brand-title">Crochet's Petal Art</h4>
                    <small class="text-muted">Arreglos florales artesanales</small>
                </div>
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <div class="mx-auto">
                    <form class="d-flex search-form" action="buscar.jsp" method="GET">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0">
                                <i class="fas fa-search text-muted"></i>
                            </span>
                            <input class="form-control border-start-0" type="search" 
                                   placeholder="Buscar productos..." name="q" 
                                   value="<%= request.getParameter("q") != null ? request.getParameter("q") : "" %>">
                        </div>
                    </form>
                </div>
                
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#loginModal">
                            <i class="fas fa-user me-1"></i> Cuenta
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link position-relative" href="carrito.jsp">
                            <i class="fas fa-shopping-cart me-1"></i> Carrito
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="cart-count">
                                0
                            </span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center min-vh-50">
                <div class="col-lg-6">
                    <h1 class="display-4 fw-bold hero-title mb-4">
                        Flores que Duran para Siempre
                    </h1>
                    <p class="lead text-muted mb-4">
                        Descubre nuestra colección única de arreglos florales tejidos a mano en crochet. 
                        Cada pieza es una obra de arte que conserva la belleza eterna de las flores.
                    </p>
                    <a href="#productos" class="btn btn-primary btn-lg px-4">
                        <i class="fas fa-leaf me-2"></i>Explorar Catálogo
                    </a>
                </div>
                <div class="col-lg-6">
                    <img src="images/hero-flowers.jpg" alt="Arreglos florales crochet" class="img-fluid rounded-3 shadow">
                </div>
            </div>
        </div>
    </section>

    <!-- Filtros de Categoría -->
    <section class="py-4 bg-light" id="productos">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="d-flex justify-content-center">
                        <div class="btn-group category-filters" role="group">
                            <input type="radio" class="btn-check" name="categoria" id="todos" value="" checked>
                            <label class="btn btn-outline-primary" for="todos">Todos</label>
                            
                            <input type="radio" class="btn-check" name="categoria" id="ramos" value="Ramos">
                            <label class="btn btn-outline-primary" for="ramos">Ramos</label>
                            
                            <input type="radio" class="btn-check" name="categoria" id="arreglos" value="Arreglos">
                            <label class="btn btn-outline-primary" for="arreglos">Arreglos</label>
                            
                            <input type="radio" class="btn-check" name="categoria" id="decorativos" value="Decorativos">
                            <label class="btn btn-outline-primary" for="decorativos">Decorativos</label>
                            
                            <input type="radio" class="btn-check" name="categoria" id="centros" value="Centros de Mesa">
                            <label class="btn btn-outline-primary" for="centros">Centros de Mesa</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Productos -->
    <section class="py-5">
        <div class="container">
            <div class="row" id="productos-container">
                <%
                    // Conexión a la base de datos
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
                            int id = rs.getInt("id_producto");
                            String nombre = rs.getString("nombre_producto");
                            double precio = rs.getDouble("precio_unitario");
                            int stock = rs.getInt("stock_producto");
                            String descripcion = rs.getString("descripcion");
                            String categoria = rs.getString("tipo_producto");
                %>
                
                <div class="col-lg-4 col-md-6 mb-4 producto-item" data-categoria="<%= categoria %>">
                    <div class="card h-100 shadow-sm product-card">
                        <div class="position-relative">
                            <img src="images/producto-<%= id %>.jpg" class="card-img-top product-image" 
                                 alt="<%= nombre %>" onerror="this.src='images/placeholder-product.jpg'">
                            <div class="position-absolute top-0 end-0 m-2">
                                <span class="badge bg-secondary">Stock: <%= stock %></span>
                            </div>
                            <% if (stock < 5 && stock > 0) { %>
                            <div class="position-absolute top-0 start-0 m-2">
                                <span class="badge bg-warning">¡Últimas unidades!</span>
                            </div>
                            <% } %>
                        </div>
                        
                        <div class="card-body d-flex flex-column">
                            <div class="mb-2">
                                <div class="text-warning mb-1">
                                    <% for(int i = 0; i < 5; i++) { %>
                                        <i class="fas fa-star"></i>
                                    <% } %>
                                    <small class="text-muted ms-1">(4.8)</small>
                                </div>
                            </div>
                            
                            <h5 class="card-title"><%= nombre %></h5>
                            <p class="card-text text-muted flex-grow-1"><%= descripcion %></p>
                            
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="h4 text-primary mb-0">$<%= String.format("%.2f", precio) %></span>
                                <span class="badge bg-light text-dark border"><%= categoria %></span>
                            </div>
                            
                            <% if (stock > 0) { %>
                            <button class="btn btn-primary w-100 agregar-carrito" 
                                    data-id="<%= id %>" 
                                    data-nombre="<%= nombre %>" 
                                    data-precio="<%= precio %>">
                                <i class="fas fa-cart-plus me-2"></i>Agregar al Carrito
                            </button>
                            <% } else { %>
                            <button class="btn btn-secondary w-100" disabled>
                                <i class="fas fa-times me-2"></i>Agotado
                            </button>
                            <% } %>
                        </div>
                    </div>
                </div>
                
                <%
                        }
                    } catch (Exception e) {
                        out.println("<div class='alert alert-danger'>Error al cargar productos: " + e.getMessage() + "</div>");
                    } finally {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    }
                %>
            </div>
        </div>
    </section>

    <!-- Modal de Login -->
    <div class="modal fade" id="loginModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Iniciar Sesión</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="login.jsp" method="POST">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="email" class="form-label">Correo electrónico</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Contraseña</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-primary">Iniciar Sesión</button>
                    </div>
                </form>
                <div class="text-center pb-3">
                    <small>¿No tienes cuenta? <a href="registro.jsp">Regístrate aquí</a></small>
                </div>
            </div>
        </div>
    </div>

 	<!-- Footer -->
    <footer class="bg-dark text-white py-5 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="d-flex align-items-center mb-3">
                        <div class="brand-icon me-2">
                            <i class="fas fa-heart text-white"></i>
                        </div>
                        <h5>Crochet's Petal Art</h5>
                    </div>
                    <p class="text-muted">Creando belleza eterna con nuestras manos, un pétalo a la vez.</p>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <h6>Productos</h6>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-muted text-decoration-none">Ramos</a></li>
                        <li><a href="#" class="text-muted text-decoration-none">Arreglos</a></li>
                        <li><a href="#" class="text-muted text-decoration-none">Decorativos</a></li>
                        <li><a href="#" class="text-muted text-decoration-none">Centros de Mesa</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <h6>Servicio</h6>
                    <ul class="list-unstyled">
                        <li><a href="envios.jsp" class="text-muted text-decoration-none">Envíos</a></li>
                        <li><a href="devoluciones.jsp" class="text-muted text-decoration-none">Devoluciones</a></li>
                        <li><a href="soporte.jsp" class="text-muted text-decoration-none">Soporte</a></li>
                        <li><a href="faq.jsp" class="text-muted text-decoration-none">FAQ</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <h6>Contacto</h6>
                    <div class="text-muted">
                        <p><i class="fas fa-envelope me-2"></i>info@crochetspetal.com</p>
                        <p><i class="fas fa-phone me-2"></i>+507 1234-5678</p>
                        <p><i class="fas fa-map-marker-alt me-2"></i>Panamá, Panamá</p>
                        <ul class="list-unstyled">
                        	<li><a href="nosotros.jsp" class="text-muted text-decoration-none">Nosotros</a></li>
                        </ul>	
                    </div>
                </div>
            </div>
            <hr class="my-4">
            <div class="text-center">
                <p class="mb-0">&copy; 2025 Crochet's Petal Art. Todos los derechos reservados.</p>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
