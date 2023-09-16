object registroAbatidosCOD {
	
	// atributo lista de listas para representar el registro [cantidad de abatidos, día]
	const registro = [] // [cantidad,dia]
	
	method cant(regi) = regi.first() // también regi.get(0)
	method dia(regi) = regi.last() // también regi.get(1)
	method yaEstaElDia(dia) = registro.any({r => self.dia(r) == dia})
	method registroDia(dia) = registro.find({r=> self.dia(r) == dia})
	//method registrosDeDias(listaDeDias) = registro.filter({r=>listaDeDias.contains(self.dia(r))})
	
	method agregarAbatidosDia(cantidad,dia) {
		if(self.yaEstaElDia(dia)) self.error("Ya existe el día en el registro")
		registro.add([cantidad,dia])
	}
	
	method agregarAbatidosVariosDias(registrosAbatidos) {
		if(registrosAbatidos.any({r=> self.yaEstaElDia(self.dia(r))})) {
			self.error("Ya existe alguno de los días que se quiere agregar, se cancela toda la operación")
		}
		registro.addAll(registrosAbatidos)
	}

	method eliminarElRegistroDelDia(dia) {
		if(!self.yaEstaElDia(dia)) {self.error("No existe el día en el registro")}
		registro.remove(self.registroDia(dia))
	}
	
	method eliminarLosRegistrosDeDias(listaDias) {
		if(listaDias.any({d=> !self.yaEstaElDia(d)})) {
			self.error("Alguno de los días que se quiere borrar no existe en el registro, se cancela toda la operación")
		}
		listaDias.forEach({dia=>self.eliminarElRegistroDelDia(dia)})
	}
	
	method cantidadDeDiasRegistrados() = registro.size()
	method estaVacioElRegistro() = registro.isEmpty()
	method algunDiaAbatio(cantidad) = registro.any({r=>self.cant(r)==cantidad})
	method primerValorDeAbatidos() = registro.first()
	method ultimoValorDeAbatidos() = registro.last()
	method maximoValorDeAbatidos() = self.cant(registro.max({r=>self.cant(r)}))
	method totalAbatidos() = registro.sum({r=>self.cant(r)})
	method cantidadDeAbatidosElDia(dia) =
		if(!self.yaEstaElDia(dia)) self.error("No existe el dia en el registro")
		else self.cant(self.registroDia(dia))
	
	method ultimoValorDeAbatidosConSize() = self.cant(registro.get(registro.size()-1))
	method diasConAbatidosSuperioresA(cuanto) = 
		registro.filter({r => self.cant(r) > cuanto}).map({r=>self.dia(r)})
	method valoresDeAbatidosPares() = registro.filter({r => self.cant(r).even()}).map({r=>self.cant(r)})
	method elValorDeAbatidos(cantidad) = registro.find({r => self.cant(r) == cantidad})
	method abatidosSumando(cantidad) = registro.map({r => self.cant(r) + cantidad})
	method abatidosEsAcotada(n1,n2) = registro.all({r => self.cant(r).between(n1,n2)})
	method algunDiaAbatioMasDe(cantidad) = registro.any({r => self.cant(r) > cantidad})
	method todosLosDiasAbatioMasDe(cantidad) = registro.all({r => self.cant(r) > cantidad})
	method cantidadAbatidosMayorALaPrimera() = registro.count({r => self.cant(r) > self.cant(registro.first())})
	method esCrack() {
		if(self.estaVacioElRegistro()) self.error("No hay ningún registro de abatidos")
		if (registro.size()<2) return false
		else return (1..registro.size()-1).all({i => self.cant(registro.get(i)) > self.cant(registro.get(i-1))})
	} 
	
	method agregarAbatidosDiaPlus(cantidad,dia) {
		if(self.yaEstaElDia(dia)) {
			const regi = self.registroDia(dia)
			self.eliminarElRegistroDelDia(dia)
			self.agregarAbatidosDia(self.cant(regi)+cantidad,self.dia(regi))
		}
		else {
			self.agregarAbatidosDia(cantidad,dia)
		}
	}
	
	method ordenarRegistro() {
		if(registro.size()>=2) {
			registro.sortBy({a,b=> self.dia(a) < self.dia(b)})
		}
	}

	method esCrackPlus() {
		self.ordenarRegistro()
		if(self.estaVacioElRegistro()) self.error("No hay ningún registro de abatidos")
		if (registro.size()<2) return false
		else return (1..registro.size()-1).all({i => self.cant(registro.get(i)) > self.cant(registro.get(i-1))})
	}
}