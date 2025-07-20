<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Nosotros</title>
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
    
    <!-- Sección Sobre Nosotros -->
	<section class="py-5 bg-light">
   		<div class="container text-center">
        	<h2 class="mb-5">Sobre Nosotros</h2>
        	<div class="row justify-content-center">
        
        		<!-- Integrante 1 -->
        		<div class="col-md-4 col-lg-2 mb-4">
        			<div class="card border-0 shadow-sm">
            			<img src="img/jorshua.jpg" class="card-img-top" alt="Integrante 1">
                		<div class="card-body">
                			<h5 class="card-title">Jorshua Jiménez</h5>
                    		<p class="card-text">Cédula: 8-1026-2297</p>
                    		<p class="card-text">Ingeniería de Software</p>
                    		<p class="card-text">experiencia</p>
                		</div>
            		</div>
				</div>
				
				<!-- Integrante 2 -->
        		<div class="col-md-4 col-lg-2 mb-4">
        			<div class="card border-0 shadow-sm">
            			<img src="img/sebastian.jpg" class="card-img-top" alt="Integrante 2">
                		<div class="card-body">
                			<h5 class="card-title">Sebastian Mejía</h5>
                    		<p class="card-text">Cédula: 4-816-1428</p>
                    		<p class="card-text">Ingeniería de Software</p>
                    		<p class="card-text">experiencia</p>
                		</div>
            		</div>
				</div>
				
				<!-- Integrante 3 -->
        		<div class="col-md-4 col-lg-2 mb-4">
        			<div class="card border-0 shadow-sm">
            			<img src="img/ariel.jpg" class="card-img-top" alt="Integrante 3">
                		<div class="card-body">
                			<h5 class="card-title">Ariel Montoya</h5>
                    		<p class="card-text">Cédula: 8-1019-1143</p>
                    		<p class="card-text">Ingeniería de Software</p>
                    		<p class="card-text">experiencia</p>
                		</div>
            		</div>
				</div>
				
				<!-- Integrante 4 -->
        		<div class="col-md-4 col-lg-2 mb-4">
        			<div class="card border-0 shadow-sm">
            			<img src="img/diego.jpg" class="card-img-top" alt="Integrante 4">
                		<div class="card-body">
                			<h5 class="card-title">Diego Portugal</h5>
                    		<p class="card-text">Cédula: 8-972-2106</p>
                    		<p class="card-text">Ingeniería de Software</p>
                    		<p class="card-text">experiencia</p>
                		</div>
            		</div>
				</div>
				
				<!-- Integrante 5 -->
        		<div class="col-md-4 col-lg-2 mb-4">
        			<div class="card border-0 shadow-sm">
            			<img src="img/alejandro.jpg" class="card-img-top" alt="Integrante 5">
                		<div class="card-body">
                			<h5 class="card-title">Alejandro Santos</h5>
                    		<p class="card-text">Cédula: 8-996-1474</p>
                    		<p class="card-text">Ingeniería de Software</p>
                    		<p class="card-text">experiencia</p>
                		</div>
            		</div>
				</div>
				
        	</div>
    	</div>
	</section>
    
    
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
</body>
</html>