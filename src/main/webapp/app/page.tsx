"use client"

import { useState } from "react"
import { ShoppingCart, User, Search, Heart, Star, Plus, Minus } from "lucide-react"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import { Badge } from "@/components/ui/badge"
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs"
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog"
import { Label } from "@/components/ui/label"

// Datos de ejemplo basados en el documento
const productos = [
  {
    id: 1,
    nombre: "Ramo de Rosas Crochet Clásico",
    precio: 45.99,
    stock: 12,
    descripcion: "Hermoso ramo de rosas tejidas a mano en crochet con colores vibrantes",
    categoria: "Ramos",
    imagen: "/placeholder.svg?height=300&width=300",
    rating: 4.8,
  },
  {
    id: 2,
    nombre: "Arreglo Floral Primaveral",
    precio: 32.5,
    stock: 8,
    descripcion: "Delicado arreglo con flores de primavera tejidas en crochet",
    categoria: "Arreglos",
    imagen: "/placeholder.svg?height=300&width=300",
    rating: 4.9,
  },
  {
    id: 3,
    nombre: "Girasoles Crochet Decorativos",
    precio: 28.75,
    stock: 15,
    descripcion: "Alegres girasoles tejidos perfectos para decoración del hogar",
    categoria: "Decorativos",
    imagen: "/placeholder.svg?height=300&width=300",
    rating: 4.7,
  },
  {
    id: 4,
    nombre: "Bouquet de Lavanda Artesanal",
    precio: 38.0,
    stock: 6,
    descripcion: "Relajante bouquet de lavanda tejida con aroma natural",
    categoria: "Ramos",
    imagen: "/placeholder.svg?height=300&width=300",
    rating: 4.6,
  },
  {
    id: 5,
    nombre: "Centro de Mesa Floral",
    precio: 55.25,
    stock: 4,
    descripcion: "Elegante centro de mesa con variedad de flores crochet",
    categoria: "Centros de Mesa",
    imagen: "/placeholder.svg?height=300&width=300",
    rating: 5.0,
  },
  {
    id: 6,
    nombre: "Tulipanes Multicolor",
    precio: 24.99,
    stock: 20,
    descripcion: "Coloridos tulipanes tejidos ideales para regalar",
    categoria: "Decorativos",
    imagen: "/placeholder.svg?height=300&width=300",
    rating: 4.5,
  },
]

const categorias = ["Todos", "Ramos", "Arreglos", "Decorativos", "Centros de Mesa"]

export default function CrochetsPetalArt() {
  const [carrito, setCarrito] = useState([])
  const [categoriaSeleccionada, setCategoriaSeleccionada] = useState("Todos")
  const [busqueda, setBusqueda] = useState("")
  const [mostrarCarrito, setMostrarCarrito] = useState(false)
  const [mostrarLogin, setMostrarLogin] = useState(false)

  const productosFiltrados = productos.filter((producto) => {
    const coincideCategoria = categoriaSeleccionada === "Todos" || producto.categoria === categoriaSeleccionada
    const coincideBusqueda = producto.nombre.toLowerCase().includes(busqueda.toLowerCase())
    return coincideCategoria && coincideBusqueda
  })

  const agregarAlCarrito = (producto) => {
    setCarrito((prev) => {
      const existente = prev.find((item) => item.id === producto.id)
      if (existente) {
        return prev.map((item) => (item.id === producto.id ? { ...item, cantidad: item.cantidad + 1 } : item))
      }
      return [...prev, { ...producto, cantidad: 1 }]
    })
  }

  const actualizarCantidad = (id, nuevaCantidad) => {
    if (nuevaCantidad === 0) {
      setCarrito((prev) => prev.filter((item) => item.id !== id))
    } else {
      setCarrito((prev) => prev.map((item) => (item.id === id ? { ...item, cantidad: nuevaCantidad } : item)))
    }
  }

  const totalCarrito = carrito.reduce((total, item) => total + item.precio * item.cantidad, 0)
  const cantidadTotal = carrito.reduce((total, item) => total + item.cantidad, 0)

  return (
    <div className="min-h-screen bg-gradient-to-br from-pink-50 via-purple-50 to-indigo-50">
      {/* Header */}
      <header className="bg-white/80 backdrop-blur-md border-b border-pink-200 sticky top-0 z-50">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-2">
              <div className="w-10 h-10 bg-gradient-to-br from-pink-500 to-purple-600 rounded-full flex items-center justify-center">
                <Heart className="w-6 h-6 text-white" />
              </div>
              <div>
                <h1 className="text-2xl font-bold bg-gradient-to-r from-pink-600 to-purple-600 bg-clip-text text-transparent">
                  Crochet's Petal Art
                </h1>
                <p className="text-sm text-gray-600">Arreglos florales artesanales</p>
              </div>
            </div>

            <div className="flex-1 max-w-md mx-8">
              <div className="relative">
                <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 w-4 h-4" />
                <Input
                  placeholder="Buscar productos..."
                  value={busqueda}
                  onChange={(e) => setBusqueda(e.target.value)}
                  className="pl-10 border-pink-200 focus:border-pink-400"
                />
              </div>
            </div>

            <div className="flex items-center space-x-4">
              <Dialog open={mostrarLogin} onOpenChange={setMostrarLogin}>
                <DialogTrigger asChild>
                  <Button variant="ghost" size="sm" className="text-gray-600 hover:text-pink-600">
                    <User className="w-4 h-4 mr-2" />
                    Cuenta
                  </Button>
                </DialogTrigger>
                <DialogContent>
                  <DialogHeader>
                    <DialogTitle>Iniciar Sesión</DialogTitle>
                    <DialogDescription>Accede a tu cuenta para gestionar tus pedidos</DialogDescription>
                  </DialogHeader>
                  <div className="space-y-4">
                    <div>
                      <Label htmlFor="email">Correo electrónico</Label>
                      <Input id="email" type="email" placeholder="tu@email.com" />
                    </div>
                    <div>
                      <Label htmlFor="password">Contraseña</Label>
                      <Input id="password" type="password" />
                    </div>
                    <Button className="w-full bg-gradient-to-r from-pink-500 to-purple-600 hover:from-pink-600 hover:to-purple-700">
                      Iniciar Sesión
                    </Button>
                    <p className="text-sm text-center text-gray-600">
                      ¿No tienes cuenta? <span className="text-pink-600 cursor-pointer">Regístrate aquí</span>
                    </p>
                  </div>
                </DialogContent>
              </Dialog>

              <Dialog open={mostrarCarrito} onOpenChange={setMostrarCarrito}>
                <DialogTrigger asChild>
                  <Button variant="ghost" size="sm" className="relative text-gray-600 hover:text-pink-600">
                    <ShoppingCart className="w-4 h-4 mr-2" />
                    Carrito
                    {cantidadTotal > 0 && (
                      <Badge className="absolute -top-2 -right-2 bg-pink-500 text-white text-xs">{cantidadTotal}</Badge>
                    )}
                  </Button>
                </DialogTrigger>
                <DialogContent className="max-w-md">
                  <DialogHeader>
                    <DialogTitle>Carrito de Compras</DialogTitle>
                  </DialogHeader>
                  <div className="space-y-4 max-h-96 overflow-y-auto">
                    {carrito.length === 0 ? (
                      <p className="text-center text-gray-500 py-8">Tu carrito está vacío</p>
                    ) : (
                      <>
                        {carrito.map((item) => (
                          <div key={item.id} className="flex items-center space-x-3 p-3 border rounded-lg">
                            <img
                              src={item.imagen || "/placeholder.svg"}
                              alt={item.nombre}
                              className="w-12 h-12 rounded object-cover"
                            />
                            <div className="flex-1">
                              <h4 className="font-medium text-sm">{item.nombre}</h4>
                              <p className="text-pink-600 font-semibold">${item.precio}</p>
                            </div>
                            <div className="flex items-center space-x-2">
                              <Button
                                size="sm"
                                variant="outline"
                                onClick={() => actualizarCantidad(item.id, item.cantidad - 1)}
                              >
                                <Minus className="w-3 h-3" />
                              </Button>
                              <span className="w-8 text-center">{item.cantidad}</span>
                              <Button
                                size="sm"
                                variant="outline"
                                onClick={() => actualizarCantidad(item.id, item.cantidad + 1)}
                              >
                                <Plus className="w-3 h-3" />
                              </Button>
                            </div>
                          </div>
                        ))}
                        <div className="border-t pt-4">
                          <div className="flex justify-between items-center mb-4">
                            <span className="font-semibold">Total:</span>
                            <span className="font-bold text-lg text-pink-600">${totalCarrito.toFixed(2)}</span>
                          </div>
                          <Button className="w-full bg-gradient-to-r from-pink-500 to-purple-600 hover:from-pink-600 hover:to-purple-700">
                            Proceder al Pago
                          </Button>
                        </div>
                      </>
                    )}
                  </div>
                </DialogContent>
              </Dialog>
            </div>
          </div>
        </div>
      </header>

      {/* Hero Section */}
      <section className="py-20 text-center">
        <div className="container mx-auto px-4">
          <h2 className="text-5xl font-bold mb-6 bg-gradient-to-r from-pink-600 via-purple-600 to-indigo-600 bg-clip-text text-transparent">
            Flores que Duran para Siempre
          </h2>
          <p className="text-xl text-gray-600 mb-8 max-w-2xl mx-auto">
            Descubre nuestra colección única de arreglos florales tejidos a mano en crochet. Cada pieza es una obra de
            arte que conserva la belleza eterna de las flores.
          </p>
          <Button
            size="lg"
            className="bg-gradient-to-r from-pink-500 to-purple-600 hover:from-pink-600 hover:to-purple-700 text-white px-8 py-3"
          >
            Explorar Catálogo
          </Button>
        </div>
      </section>

      {/* Filtros */}
      <section className="py-8 bg-white/50">
        <div className="container mx-auto px-4">
          <Tabs value={categoriaSeleccionada} onValueChange={setCategoriaSeleccionada}>
            <TabsList className="grid w-full grid-cols-5 max-w-2xl mx-auto">
              {categorias.map((categoria) => (
                <TabsTrigger
                  key={categoria}
                  value={categoria}
                  className="data-[state=active]:bg-pink-500 data-[state=active]:text-white"
                >
                  {categoria}
                </TabsTrigger>
              ))}
            </TabsList>
          </Tabs>
        </div>
      </section>

      {/* Productos */}
      <section className="py-12">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {productosFiltrados.map((producto) => (
              <Card
                key={producto.id}
                className="group hover:shadow-xl transition-all duration-300 border-pink-100 hover:border-pink-300"
              >
                <CardHeader className="p-0">
                  <div className="relative overflow-hidden rounded-t-lg">
                    <img
                      src={producto.imagen || "/placeholder.svg"}
                      alt={producto.nombre}
                      className="w-full h-64 object-cover group-hover:scale-105 transition-transform duration-300"
                    />
                    <div className="absolute top-4 right-4">
                      <Badge variant="secondary" className="bg-white/90">
                        Stock: {producto.stock}
                      </Badge>
                    </div>
                  </div>
                </CardHeader>
                <CardContent className="p-6">
                  <div className="flex items-center mb-2">
                    <div className="flex text-yellow-400">
                      {[...Array(5)].map((_, i) => (
                        <Star key={i} className={`w-4 h-4 ${i < Math.floor(producto.rating) ? "fill-current" : ""}`} />
                      ))}
                    </div>
                    <span className="ml-2 text-sm text-gray-600">({producto.rating})</span>
                  </div>
                  <CardTitle className="text-lg mb-2 text-gray-800">{producto.nombre}</CardTitle>
                  <p className="text-gray-600 text-sm mb-4">{producto.descripcion}</p>
                  <div className="flex items-center justify-between">
                    <span className="text-2xl font-bold text-pink-600">${producto.precio}</span>
                    <Badge variant="outline" className="border-purple-200 text-purple-600">
                      {producto.categoria}
                    </Badge>
                  </div>
                </CardContent>
                <CardFooter className="p-6 pt-0">
                  <Button
                    onClick={() => agregarAlCarrito(producto)}
                    className="w-full bg-gradient-to-r from-pink-500 to-purple-600 hover:from-pink-600 hover:to-purple-700"
                    disabled={producto.stock === 0}
                  >
                    {producto.stock === 0 ? "Agotado" : "Agregar al Carrito"}
                  </Button>
                </CardFooter>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-gray-900 text-white py-12">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
            <div>
              <div className="flex items-center space-x-2 mb-4">
                <div className="w-8 h-8 bg-gradient-to-br from-pink-500 to-purple-600 rounded-full flex items-center justify-center">
                  <Heart className="w-4 h-4 text-white" />
                </div>
                <h3 className="text-xl font-bold">Crochet's Petal Art</h3>
              </div>
              <p className="text-gray-400">Creando belleza eterna con nuestras manos, un pétalo a la vez.</p>
            </div>
            <div>
              <h4 className="font-semibold mb-4">Productos</h4>
              <ul className="space-y-2 text-gray-400">
                <li>Ramos</li>
                <li>Arreglos</li>
                <li>Decorativos</li>
                <li>Centros de Mesa</li>
              </ul>
            </div>
            <div>
              <h4 className="font-semibold mb-4">Servicio</h4>
              <ul className="space-y-2 text-gray-400">
                <li>Envíos</li>
                <li>Devoluciones</li>
                <li>Soporte</li>
                <li>FAQ</li>
              </ul>
            </div>
            <div>
              <h4 className="font-semibold mb-4">Contacto</h4>
              <div className="space-y-2 text-gray-400">
                <p>info@crochetspetal.com</p>
                <p>+507 1234-5678</p>
                <p>Panamá, Panamá</p>
              </div>
            </div>
          </div>
          <div className="border-t border-gray-800 mt-8 pt-8 text-center text-gray-400">
            <p>&copy; 2025 Crochet's Petal Art. Todos los derechos reservados.</p>
          </div>
        </div>
      </footer>
    </div>
  )
}
