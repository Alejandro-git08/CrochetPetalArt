// JavaScript para el carrito de compras

const carrito = JSON.parse(localStorage.getItem("carrito")) || []

document.addEventListener("DOMContentLoaded", () => {
  cargarCarrito()
  configurarFechaMinima()
  configurarFormulario()
})

// Cargar items del carrito
function cargarCarrito() {
  const container = document.getElementById("carrito-items")
  const carritoVacio = document.getElementById("carrito-vacio")

  if (carrito.length === 0) {
    container.style.display = "none"
    carritoVacio.style.display = "block"
    return
  }

  container.style.display = "block"
  carritoVacio.style.display = "none"

  let html = ""
  carrito.forEach((item, index) => {
    html += `
            <div class="row align-items-center border-bottom py-3" data-index="${index}">
                <div class="col-md-2">
                    <img src="images/producto-${item.id}.jpg" 
                         class="img-fluid rounded" 
                         alt="${item.nombre}"
                         onerror="this.src='images/placeholder-product.jpg'">
                </div>
                <div class="col-md-4">
                    <h6 class="mb-1">${item.nombre}</h6>
                    <small class="text-muted">Precio unitario: $${item.precio.toFixed(2)}</small>
                </div>
                <div class="col-md-3">
                    <div class="input-group input-group-sm">
                        <button class="btn btn-outline-secondary" type="button" onclick="cambiarCantidad(${index}, -1)">
                            <i class="fas fa-minus"></i>
                        </button>
                        <input type="text" class="form-control text-center" value="${item.cantidad}" readonly>
                        <button class="btn btn-outline-secondary" type="button" onclick="cambiarCantidad(${index}, 1)">
                            <i class="fas fa-plus"></i>
                        </button>
                    </div>
                </div>
                <div class="col-md-2">
                    <strong class="text-primary">$${(item.precio * item.cantidad).toFixed(2)}</strong>
                </div>
                <div class="col-md-1">
                    <button class="btn btn-sm btn-outline-danger" onclick="eliminarItem(${index})">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>
        `
  })

  container.innerHTML = html
  actualizarTotales()
}

// Cambiar cantidad de un item
function cambiarCantidad(index, cambio) {
  if (carrito[index]) {
    carrito[index].cantidad += cambio

    if (carrito[index].cantidad <= 0) {
      eliminarItem(index)
    } else {
      localStorage.setItem("carrito", JSON.stringify(carrito))
      cargarCarrito()
    }
  }
}

// Eliminar item del carrito
function eliminarItem(index) {
  if (confirm("¿Estás seguro de que quieres eliminar este producto?")) {
    carrito.splice(index, 1)
    localStorage.setItem("carrito", JSON.stringify(carrito))
    cargarCarrito()

    // Mostrar notificación
    mostrarNotificacion("Producto eliminado del carrito", "info")
  }
}

// Actualizar totales
function actualizarTotales() {
  const subtotal = carrito.reduce((total, item) => total + item.precio * item.cantidad, 0)
  const envio = subtotal >= 50 ? 0 : 5.0
  const total = subtotal + envio

  document.getElementById("subtotal").textContent = `$${subtotal.toFixed(2)}`
  document.getElementById("envio").textContent = envio === 0 ? "GRATIS" : `$${envio.toFixed(2)}`
  document.getElementById("total").textContent = `$${total.toFixed(2)}`

  // Habilitar/deshabilitar botón de checkout
  const btnCheckout = document.getElementById("btn-checkout")
  btnCheckout.disabled = carrito.length === 0
}

// Configurar fecha mínima (mañana)
function configurarFechaMinima() {
  const fechaEntrega = document.getElementById("fecha-entrega")
  const mañana = new Date()
  mañana.setDate(mañana.getDate() + 1)
  fechaEntrega.min = mañana.toISOString().split("T")[0]
}

// Configurar formulario
function configurarFormulario() {
  const form = document.getElementById("form-checkout")
  form.addEventListener("submit", (e) => {
    e.preventDefault()

    if (carrito.length === 0) {
      alert("Tu carrito está vacío")
      return
    }

    // Agregar items del carrito como campos ocultos
    carrito.forEach((item, index) => {
      const inputId = document.createElement("input")
      inputId.type = "hidden"
      inputId.name = `item_${index}_id`
      inputId.value = item.id
      form.appendChild(inputId)

      const inputCantidad = document.createElement("input")
      inputCantidad.type = "hidden"
      inputCantidad.name = `item_${index}_cantidad`
      inputCantidad.value = item.cantidad
      form.appendChild(inputCantidad)

      const inputPrecio = document.createElement("input")
      inputPrecio.type = "hidden"
      inputPrecio.name = `item_${index}_precio`
      inputPrecio.value = item.precio
      form.appendChild(inputPrecio)
    })

    const inputTotal = document.createElement("input")
    inputTotal.type = "hidden"
    inputTotal.name = "total_items"
    inputTotal.value = carrito.length
    form.appendChild(inputTotal)

    // Mostrar loading
    const btnCheckout = document.getElementById("btn-checkout")
    btnCheckout.innerHTML = '<div class="loading"></div> Procesando...'
    btnCheckout.disabled = true

    // Enviar formulario
    setTimeout(() => {
      form.submit()
    }, 1000)
  })
}

// Mostrar notificaciones
function mostrarNotificacion(mensaje, tipo = "info") {
  const notificacion = document.createElement("div")
  notificacion.className = `alert alert-${tipo} alert-dismissible fade show position-fixed`
  notificacion.style.cssText = `
        top: 20px;
        right: 20px;
        z-index: 9999;
        min-width: 300px;
        animation: slideInRight 0.3s ease;
    `

  notificacion.innerHTML = `
        ${mensaje}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `

  document.body.appendChild(notificacion)

  setTimeout(() => {
    if (notificacion.parentNode) {
      notificacion.remove()
    }
  }, 3000)
}
