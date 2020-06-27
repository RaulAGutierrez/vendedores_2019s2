import vendedores.*


class Cliente {
	var vendedor = null // vendedor asignado al cliente -> tipo vendedor
	
	method vendedorAsignado() { return vendedor }
	method puedeSerAtendido(unVendedor)
}

class Inseguro inherits Cliente {
	
	override method puedeSerAtendido(unVendedor) { 
		if (unVendedor.esVersatil() and unVendedor.esFirme()) { 
			vendedor = unVendedor
		} else { self.error ("no es el vendedor correcto para el cliente") }
	}
}

class Detallista inherits Cliente {
	
	override method puedeSerAtendido(unVendedor) { 
		if (unVendedor.certificaProductos() >= 3) { 
			vendedor = unVendedor
		} else { self.error ("no es el vendedor correcto para el cliente") }
	}
}

class Humanista inherits Cliente {
	
	override method puedeSerAtendido(unVendedor) { 
		if (unVendedor.esPersonaFisica()) { 
			vendedor = unVendedor
		} else { self.error ("no es el vendedor correcto para el cliente") }
	}
}