import provinciasYciudades.*
import certificaciones.*

class Vendedor {
	var property viveEn // ciudad en la que vive -> objeto ciudad
	var property certificaciones = []
	
	method puedeTrabajar(ciudad)
	method agregar(certificacion) {
		if (not certificaciones.contains(certificacion) ) { 
			certificaciones.add(certificacion)
		}
	}
	method certificaProductos() {
		return certificaciones.count({ certificacion => certificacion.esProducto()})
	}
	method certificaSinProductos() {
		return certificaciones.count({ certificacion => not certificacion.esProducto()})
	}
	method esVersatil() { 
		return self.certificaProductos() >= 3 
		and self.certificaSinProductos() >= 1 
	}
	method totalPuntos() { 
		return certificaciones.sum( { certificacion => certificacion.puntos() } )
	}
	method esFirme() { 
		return self.totalPuntos() >= 30
	}
	method esInfluyente()
	method tieneAfinidad(centroDistribucion) { 
		return self.puedeTrabajar(centroDistribucion.ciudad())
	}
	method esCandidato(centroDistribucion) { 
		return self.esVersatil() and self.tieneAfinidad(centroDistribucion)
	}
	method esPersonaFisica()
}

class VendedorFijo inherits Vendedor {
	
	override method puedeTrabajar(ciudad) { return self.viveEn() == ciudad }
	override method esInfluyente() = false
	override method esPersonaFisica() = true 
}

class Viajante inherits Vendedor {
	var property provinciasHabilitadas = [] // provincias habilitadas para trabajar -> lista de objeto provincia
	
	method habilitar(provincia) {
		provinciasHabilitadas.add(provincia)
	}
	override method puedeTrabajar(ciudad) { 
		return provinciasHabilitadas.any( { provincia => provincia == ciudad.provincia() } )
	}
	override method esInfluyente() { 
		return provinciasHabilitadas.sum( { provincia => provincia.problacion() } ) >= 10000000 
	}
	override method esPersonaFisica() = true
}

class ComercioCorresponsal inherits Vendedor {
	var property sucursales = [] // ciudad donde hay sucursales -> lista de ciudades
	
	method agregarSucursal(ciudad) { sucursales.add(ciudad) }
	
	override method puedeTrabajar(ciudad) {
		return sucursales.any( { unaCiudad => unaCiudad == ciudad } )
	}
	method sucursalesEnCiudades() { 
		return sucursales.asSet().size()
	}
	method sucursalesEnProvincias() { 
		return sucursales.map( { ciudad => ciudad.provincia() } ).asSet().size()
	}
	override method esInfluyente() { 
		return self.sucursalesEnCiudades() >= 5 or 
		self.sucursalesEnProvincias() >= 3
	}
	override method tieneAfinidad(centroDistribucion) {
		return super(centroDistribucion) and sucursales.any( { ciudad => not centroDistribucion.puedeCubrir(ciudad) } )
	}
	override method esPersonaFisica() = false
}
