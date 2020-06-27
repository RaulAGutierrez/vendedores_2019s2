import vendedores.*


class CentroDistribucion {
	const property vendedores = [] // vendedores con los que trabaja -> lista de vendedores
	var property ciudad // ciudad donde esta el centro -> tipo ciudad
	
	method agregar(vendedor) { 
		if (not vendedores.contains(vendedor)) {
			vendedores.add(vendedor)
		} else { 
			self.error("El vendedor ya esta registrado")
		}
	}
	method vendedorEstrella() {
		return vendedores.max( { vendedor => vendedor.totalPuntos() } )
	}
	method puedeCubrir(unaCiudad) { 
		return vendedores.any( { vendedor => vendedor.puedeTrabajar(unaCiudad) } )
	}
	method coleccionVendedoresGenericos() { 
		return vendedores.filter( { vendedor => vendedor.esVersatil() } )
	}
	method esRobusto() { 
		return vendedores.count( { vendedor => vendedor.esFirme() } ) >= 3
	}
	method repartir(certificacion) { 
		vendedores.forEach( { vendedor => vendedor.agregar(certificacion) } )
	}
	
}
