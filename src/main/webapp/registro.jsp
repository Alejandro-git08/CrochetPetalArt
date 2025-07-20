<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro - Crochet's Petal Art</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="card shadow-lg">
                    <div class="card-header text-center py-4">
                        <div class="brand-icon mx-auto mb-3">
                            <i class="fas fa-heart text-white"></i>
                        </div>
                        <h3 class="brand-title mb-0">Crear Cuenta</h3>
                        <p class="text-muted">Únete a Crochet's Petal Art</p>
                    </div>
                    
                    <div class="card-body p-5">
                        <form action="procesar-registro.jsp" method="POST" id="form-registro">
                            <div class="row">
                                <div class="col-md-12 mb-3">
                                    <label for="nombre" class="form-label">Nombre Completo</label>
                                    <input type="text" class="form-control" id="nombre" name="nombre" required>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="email" class="form-label">Correo Electrónico</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="telefono" class="form-label">Teléfono</label>
                                <input type="tel" class="form-control" id="telefono" name="telefono" required>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label for="provincia" class="form-label">Provincia</label>
                                    <select class="form-select" id="provincia" name="provincia" required>
                                        <option value="">Seleccionar</option>
                                        <option value="Panamá">Panamá</option>
                                        <option value="Chiriquí">Chiriquí</option>
                                        <option value="Veraguas">Veraguas</option>
                                        <option value="Herrera">Herrera</option>
                                        <option value="Los Santos">Los Santos</option>
                                        <option value="Coclé">Coclé</option>
                                        <option value="Colón">Colón</option>
                                        <option value="Darién">Darién</option>
                                        <option value="Bocas del Toro">Bocas del Toro</option>
                                    </select>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label for="distrito" class="form-label">Distrito</label>
                                    <input type="text" class="form-control" id="distrito" name="distrito" required>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label for="calle" class="form-label">Calle/Dirección</label>
                                    <input type="text" class="form-control" id="calle" name="calle" required>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="password" class="form-label">Contraseña</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="confirm-password" class="form-label">Confirmar Contraseña</label>
                                <input type="password" class="form-control" id="confirm-password" name="confirm_password" required>
                            </div>
                            
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="terminos" required>
                                <label class="form-check-label" for="terminos">
                                    Acepto los <a href="#" class="text-primary">términos y condiciones</a>
                                </label>
                            </div>
                            
                            <button type="submit" class="btn btn-primary w-100 mb-3">
                                <i class="fas fa-user-plus me-2"></i>Crear Cuenta
                            </button>
                        </form>
                        
                        <div class="text-center">
                            <p class="mb-0">¿Ya tienes cuenta? <a href="index.jsp" class="text-primary">Inicia sesión aquí</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Validación del formulario
        document.getElementById('form-registro').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirm-password').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Las contraseñas no coinciden');
                return;
            }
            
            if (password.length < 6) {
                e.preventDefault();
                alert('La contraseña debe tener al menos 6 caracteres');
                return;
            }
        });
    </script>
</body>
</html>
