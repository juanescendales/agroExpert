
;--------------------------------------------------------------
;-------------------Plantillas---------------------------------
;--------------------------------------------------------------
;La plantilla es la misma para todas las plantas
(deftemplate planta
	(slot altitud
		(type INTEGER)
	)
	(slot temperatura
		(type INTEGER)
	)
	(slot precipitacion
		(type INTEGER)	
	)
	(slot profundidadDelSuelo
		(type INTEGER)
	)
	(slot humedadRelativa
		(type INTEGER)
		(range 0 100)
	)
	(slot texturaDelSuelo
		(type STRING)
		(allowed-strings "pesada" "moderadamentePesada" "media" "moderadamenteLigera" "ligera")
	)
	(slot phDelSuelo
		(type INTEGER)
	)
	(slot fotoperiodo
		(type STRING)
		(allowed-strings "diaLargo" "diaNeutro" "diaCorto")
	)
)
(deftemplate ambiente
	(slot altitud
		(type INTEGER)
	)
	(slot temperatura
		(type INTEGER)
	)
	(slot precipitacion
		(type INTEGER)	
	)
	(slot humedadRelativa
		(type INTEGER)
		(range 0 100)
	)
	(slot fotoperiodo
		(type STRING)
		(allowed-strings "diaLargo" "diaNeutro" "diaCorto")
	)
)
(deftemplate suelo
	(slot profundidadDelSuelo
		(type INTEGER)
	)
	(slot texturaDelSuelo
		(type STRING)
		(allowed-strings "pesada" "moderadamentePesada" "media" "moderadamenteLigera" "ligera")
	)
	(slot phDelSuelo
		(type INTEGER)
	)
)

;---------------------------------------------------------------
;----------------------Hechos Iniciales-------------------------
;---------------------------------------------------------------
(deffacts hechos_iniciales
	
)

;---------------------------------------------------------------
;---------------------------REGLAS------------------------------
;---------------------------------------------------------------

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

