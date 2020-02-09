
;--------------------------------------------------------------
;-------------------Plantillas---------------------------------
;--------------------------------------------------------------
;Cafe arábico
(deftemplate planta
	(slot 
		(type STRING)
	)
	(slot ciudad
		(type STRING)
	)
	(slot sector
		(type STRING)	
	)
	(slot edad
		(type INTEGER)
	)
)

;---------------------------------------------------------------
;----------------------Hechos Iniciales-------------------------
;---------------------------------------------------------------
(deffacts hechos_iniciales
	(menu)
	(gobierno
		(ciudad "Medellin")
	)
	(gobierno
		(ciudad "Barbosa")
	)
	(gobierno
		(ciudad "Envigado")
	)
	(gobierno
		(ciudad "Itagüí")
	)
	(gobierno
		(ciudad "Caldas")
	)
	(gobierno
		(ciudad "Sabaneta")
	)
	(gobierno
		(ciudad "Bello")
	)
	(gobierno
		(ciudad "Copacabana")
	)
	(gobierno
		(ciudad "Girardota")
	)
	(gobierno
		(ciudad "La Estrella")
	)
	(sector
		(nombre "Hatillo")
		(ciudad "Barbosa")
		(ica 59)
	)
	(sector
		(nombre "Frontera")
		(ciudad "Envigado")
		(ica 68)
	)
	(sector
		(nombre "Calasanz")
		(ciudad "Medellin")
		(ica 500)
	)
	(sector
		(nombre "Poblado")
		(ciudad "Medellin")
		(ica 500)
	)
	(sector
		(nombre "Centro")
		(ciudad "Medellin")
		(ica 500)
	)
	(sector
		(nombre "Platanito")
		(ciudad "Barbosa")
		(ica 40)
	)
	(sector
		(nombre "Tablaza")
		(ciudad "Caldas")
		(ica 180)
	)
	(sector
		(nombre "Rosalpi")
		(ciudad "Bello")
		(ica 155)
	)
)

;---------------------------------------------------------------
;---------------------------REGLAS------------------------------
;---------------------------------------------------------------

;Variables globales
(defglobal
	?*cont* = 0
	?*suma* = 0 
	?*prom* = 0
)
(deffunction promedio (?a) "funcion para sacar el promedio"
	(bind ?*cont* (+ ?*cont* 1))
	(bind ?*suma*(+ ?*suma* ?a))
	(bind ?*prom* (/ ?*suma* ?*cont*))
)
;Menu de consola
(defrule menu
	?hecho <- (menu)
	=>
	(printout t "----------Menu----------" crlf)
	(printout t "Elija el tipo de usuario:" crlf)
	(printout t "1. Persona Natural" crlf)
	(printout t "2. Alcaldía" crlf)
	(bind ?opcion (read))
	(if (eq ?opcion 1) then
		(assert (ingresar_usuario))
	else
		(assert (recomendar_gobierno))
	)
)

;Regla para ingresar usuario
(defrule ingresar_usuario
	?hecho <- (ingresar_usuario)
	=>
	(printout t "Ingrese el nombre:" crlf)
	(bind ?nombre (read))
	(printout t "Ingrese la ciudad donde reside:" crlf)
	(bind ?ciudad(read))
	(printout t "Ingrese el sector donde reside:" crlf)
	(bind ?sector(read))
	(printout t "Ingrese su edad:" crlf)
	(bind ?edad(read))
	(assert (persona_natural
			(nombre ?nombre)
			(ciudad ?ciudad)
			(sector ?sector)
			(edad ?edad)	
		)
	)
)

;Regla para recomendar a una Persona natural
(defrule ica200P
	(persona_natural 
		(ciudad ?ciudad)
		(sector ?sector)
	)
	(sector
		(nombre ?sector)
		(ciudad ?ciudad)
		(ica ?ica &:(> ?ica 200)) 
	)
	=>
	(printout t "-No salgas de tu casa a menos que sea ESTRICTAMENTE necesario" crlf)
	(reset)
	(run)
)
(defrule ica150P
	(persona_natural 
		(ciudad ?ciudad)
		(sector ?sector)
	)
	(sector
		(nombre ?sector)
		(ciudad ?ciudad)
		(ica ?ica &:(> ?ica 149)) 
	)
	=>
	(assert (ica_150PS))
	(assert (ica_150PN))
)
(defrule ica150PS
	(ica_150PS)
	(persona_natural
		(edad ?edad &:(< ?edad 13)|:(> ?edad 60))
	)
	=>
	(printout t "-No salgas de tu casa si no es necesario" crlf)
	(reset)
	(run)
)
(defrule ica150PN
	(ica_150PN)
	(persona_natural
			(edad ?edad &:(> ?edad 12)&:(< ?edad 61))	
	)
	=>
	(printout t "- No hagas ejercicio al aire libre en horas entre las 6am y las 10am" crlf)
	(printout t "- No uses tu bicicleta a menos que sea necesario, si la usas usa tapabocas" crlf)
	(reset)
	(run)
)
(defrule ica100P
	(persona_natural 
		(ciudad ?ciudad)
		(sector ?sector)
	)
	(sector
		(nombre ?sector)
		(ciudad ?ciudad)
		(ica ?ica &:(> ?ica 99)) 
	)
	=>
	(assert (ica_100PS))
	(assert (ica_100PN))
)
(defrule ica100PS
	(ica_100PS)
	(persona_natural
		(edad ?edad &:(> ?edad 60)|:(< ?edad 13))	
	)
	=>
	(printout t "- No salgas de tu casa si no es necesario" crlf)
	(printout t "- No hagas ejercicio al aire libre en horas entre las 6am y las 10am " crlf)
	(reset)
	(run)
)
(defrule ica100PN
	(ica_100PN)
	(persona_natural
		(edad ?edad &:(> ?edad 12)&:(< ?edad 61))	
	)
	=>
	(printout t "- Evita estar mas de 2 horas seguidas al aire libre" crlf)
	(reset)
	(run)
)
(defrule ica50
	(persona_natural 
		(ciudad ?ciudad)
		(sector ?sector)
	)
	(sector
		(nombre ?sector)
		(ciudad ?ciudad)
		(ica ?ica &:(> ?ica 50)) 
	)
	=>
	(printout t "- Lavate las manos y la cara con regularidad para quitar la contaminacion" crlf)
	(reset)
	(run)	
)
(defrule ica49
	(persona_natural 
		(ciudad ?ciudad)
		(sector ?sector)
	)
	(sector
		(nombre ?sector)
		(ciudad ?ciudad)
		(ica ?ica &:(< ?ica 51)) 
	)
	=>
	(printout t "- Disfruta tu dia con tranquilidad" crlf)
	(reset)
	(run)
)

;Regla para recomendar a un Gobierno
(defrule recomendar_gobierno
	(recomendar_gobierno)
	=>
	(printout t "Ingrese la ciudad:" crlf)
	(bind ?ciudad (read))
	(assert (ciudad_user ?ciudad))
)
(defrule promedio
	(ciudad_user ?ciudad)
	(sector
		(ciudad ?ciudad)
		(ica ?ica) 
	)
	=> 
	(promedio ?ica)
)
(defrule assert_promedio
	(gobierno(ciudad ?ciudad))
	(ciudad_user ?ciudad)
	=>
	(assert (ica_prom ?*prom*))
)
(defrule 200G
	(gobierno(ciudad ?ciudad))
	(ciudad_user ?ciudad)
	(ica_prom ?prom &:(> ?prom 200))
	=>
	(printout t "- Parar la ciudad por completo, esto incluye prohibir la circulación de vehículos a menos que sea estrictamente necesario (ambulancias por ejemplo), ordenar a las fabricas parar su funcionamiento, ordenar a las personas que nos salgan a menos que sea estrictamente necesario" crlf)
	(reset)
	(run)
)
(defrule 150G
	(gobierno(ciudad ?ciudad))
	(ciudad_user ?ciudad)
	(ica_prom ?prom &:(> ?prom 150))
	=>
	(printout t "- Restringir el transporte particular a solo vehículos eléctricos y a gas, favorecer el uso del transporte publico, restringir las fabricas para que no funcionen durante las horas pico, recomendar a las personas salir con tapa bocas" crlf)
	(reset)
	(run)	
)
(defrule 100G
	(gobierno(ciudad ?ciudad))
	(ciudad_user ?ciudad)
	(ica_prom ?prom &:(> ?prom 100))
	=>
	(printout t "- Extender el pico y placa, restringir la circulación de camiones a solo la noche y la madrugada, favorecer el uso de transporte publico" crlf)
	(printout t "- Alertar a los grupos sensibles para que tengan mas cuidado y eviten estar tiempos prolongados al aire libre" crlf)
	(reset)
	(run)	
)
(defrule 99G
	(gobierno(ciudad ?ciudad))
	(ciudad_user ?ciudad)
	(ica_prom ?prom &:(< ?prom 101))
	=>
	(printout t "- Estar alerta a cualquier cambio" crlf)
	(reset)
	(run)	
)

