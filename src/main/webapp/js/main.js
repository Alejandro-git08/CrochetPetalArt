// JavaScript para Crochet's Petal Art

// Carrito de compras
const carrito = JSON.parse(localStorage.getItem("carrito")) || []

// Actualizar contador del carrito al cargar la página
document.addEventListener("DOMContentLoaded", () => {
  actualizarContadorCarrito()
  configurarFiltros()
  configurarBotonesCarrito()
})

// Configurar filtros de categoría
function configurarFiltros() {
  const filtros = document.querySelectorAll('input[name="categoria"]')
  filtros.forEach((filtro) => {
    filtro.addEventListener("change", function () {
      filtrarProductos(this.value)
    })
  })
}

// Filtrar productos por categoría
function filtrarProductos(categoria) {
  const productos = document.querySelectorAll(".producto-item")

  productos.forEach((producto) => {
    const categoriaProducto = producto.getAttribute("data-categoria")

    if (categoria === "" || categoriaProducto === categoria) {
      producto.style.display = "block"
      producto.style.animation = "fadeInUp 0.6s ease forwards"
    } else {
      producto.style.display = "none"
    }
  })
}

// Configurar botones de agregar al carrito
function configurarBotonesCarrito() {
  const botones = document.querySelectorAll(".agregar-carrito")
  botones.forEach((boton) => {
    boton.addEventListener("click", function () {
      const id = Number.parseInt(this.getAttribute("data-id"))
      const nombre = this.getAttribute("data-nombre")
      const precio = Number.parseFloat(this.getAttribute("data-precio"))

      agregarAlCarrito(id, nombre, precio)

      // Animación del botón
      this.innerHTML = '<div class="loading"></div> Agregando...'
      this.disabled = true

      setTimeout(() => {
        this.innerHTML = '<i class="fas fa-check me-2"></i>¡Agregado!'
        this.classList.remove("btn-primary")
        this.classList.add("btn-success")

        setTimeout(() => {
          this.innerHTML = '<i class="fas fa-cart-plus me-2"></i>Agregar al Carrito'
          this.classList.remove("btn-success")
          this.classList.add("btn-primary")
          this.disabled = false
        }, 1500)
      }, 800)
    })
  })
}

// Agregar producto al carrito
function agregarAlCarrito(id, nombre, precio) {
  const productoExistente = carrito.find((item) => item.id === id)

  if (productoExistente) {
    productoExistente.cantidad += 1
  } else {
    carrito.push({
      id: id,
      nombre: nombre,
      precio: precio,
      cantidad: 1,
    })
  }

  localStorage.setItem("carrito", JSON.stringify(carrito))
  actualizarContadorCarrito()

  // Mostrar notificación
  mostrarNotificacion(`${nombre} agregado al carrito`, "success")
}

// Actualizar contador del carrito
function actualizarContadorCarrito() {
  const contador = document.getElementById("cart-count")
  const totalItems = carrito.reduce((total, item) => total + item.cantidad, 0)

  if (contador) {
    contador.textContent = totalItems
    contador.style.display = totalItems > 0 ? "inline" : "none"
  }
}

// Mostrar notificaciones
function mostrarNotificacion(mensaje, tipo = "info") {
  // Crear elemento de notificación
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

  // Auto-remover después de 3 segundos
  setTimeout(() => {
    if (notificacion.parentNode) {
      notificacion.remove()
    }
  }, 3000)
}

// Búsqueda en tiempo real
function configurarBusqueda() {
  const campoBusqueda = document.querySelector('input[name="q"]')
  if (campoBusqueda) {
    campoBusqueda.addEventListener("input", function () {
      const termino = this.value.toLowerCase()
      buscarProductos(termino)
    })
  }
}

// Buscar productos
function buscarProductos(termino) {
  const productos = document.querySelectorAll(".producto-item")

  productos.forEach((producto) => {
    const nombre = producto.querySelector(".card-title").textContent.toLowerCase()
    const descripcion = producto.querySelector(".card-text").textContent.toLowerCase()

    if (nombre.includes(termino) || descripcion.includes(termino)) {
      producto.style.display = "block"
    } else {
      producto.style.display = "none"
    }
  })
}

// Animaciones CSS adicionales
const style = document.createElement("style")
style.textContent = `
    @keyframes slideInRight {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
`
document.head.appendChild(style)

// Configurar búsqueda al cargar
document.addEventListener("DOMContentLoaded", configurarBusqueda)

// Smooth scroll para enlaces internos
document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
  anchor.addEventListener("click", function (e) {
    e.preventDefault()
    const target = document.querySelector(this.getAttribute("href"))
    if (target) {
      target.scrollIntoView({
        behavior: "smooth",
        block: "start",
      })
    }
  })
})
