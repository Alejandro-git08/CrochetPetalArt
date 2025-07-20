<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrito de Compras - Crochet's Petal Art</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
    <!-- Header simplificado -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="index.jsp">
                <div class="brand-icon me-2">
                    <i class="fas fa-heart text-white"></i>
                </div>
                <div>
                    <h4 class="mb-0 brand-title">Crochet's Petal Art</h4>
                    <small class="text-muted">Carrito de Compras</small>
                </div>
            </a>
            <a href="index.jsp" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left me-2"></i>Seguir Comprando
            </a>
        </div>
    </nav>

    <div class="container py-5">
        <div class="row">
            <div class="col-lg-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-light">
                        <h5 class="mb-0"><i class="fas fa-shopping-cart me-2"></i>Tu Carrito</h5>
                    </div>
                    <div class="card-body">
                        <div id="carrito-items">
                            <!-- Los items se cargarán con JavaScript -->
                        </div>
                        <div id="carrito-vacio" class="text-center py-5" style="display: none;">
                            <i class="fas fa-shopping-cart fa-3x text-muted mb-3"></i>
                            <h5 class="text-muted">Tu carrito está vacío</h5>
                            <p class="text-muted">Agrega algunos productos para comenzar</p>
                            <a href="index.jsp" class="btn btn-primary">
                                <i class="fas fa-leaf me-2"></i>Explorar Productos
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-4">
                <div class="card shadow-sm">
                    <div class="card-header bg-light">
                        <h5 class="mb-0"><i class="fas fa-calculator me-2"></i>Resumen del Pedido</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-flex justify-content-between mb-2">
                            <span>Subtotal:</span>
                            <span id="subtotal">$0.00</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Envío:</span>
                            <span id="envio">$5.00</span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between mb-3">
                            <strong>Total:</strong>
                            <strong id="total" class="text-primary">$0.00</strong>
                        </div>
                        
                        <form action="procesar-orden.jsp" method="POST" id="form-checkout">
                            <div class="mb-3">
                                <label for="fecha-entrega" class="form-label">Fecha de Entrega</label>
                                <input type="date" class="form-control" id="fecha-entrega" name="fecha_entrega" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="metodo-pago" class="form-label">Método de Pago</label>
                                <select class="form-select" id="metodo-pago" name="metodo_pago" required>
                                    <option value="">Seleccionar método</option>
                                    <option value="Tarjeta de Crédito">Tarjeta de Crédito</option>
                                    <option value="Tarjeta de Débito">Tarjeta de Débito</option>
                                    <option value="PayPal">PayPal</option>
                                    <option value="Transferencia">Transferencia Bancaria</option>
                                </select>
                            </div>
                            
                            <button type="submit" class="btn btn-primary w-100" id="btn-checkout" disabled>
                                <i class="fas fa-credit-card me-2"></i>Proceder al Pago
                            </button>
                        </form>
                    </div>
                </div>
                
                <!-- Información de Envío -->
                <div class="card shadow-sm mt-4">
                    <div class="card-body">
                        <h6><i class="fas fa-truck me-2"></i>Información de Envío</h6>
                        <small class="text-muted">
                            • Envío gratuito en compras mayores a $50<br>
                            • Tiempo de entrega: 2-5 días hábiles<br>
                            • Empaque especial para productos delicados
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/carrito.js"></script>
</body>
</html>
