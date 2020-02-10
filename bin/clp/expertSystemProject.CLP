
;--------------------------------------------------------------
;-------------------Plantillas---------------------------------
;--------------------------------------------------------------
;La plantilla es la misma para todas las plantas
(deftemplate planta
	(slot nombre
		(type STRING)
	)
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
		;(range 0 100)
	)
	(slot texturaDelSuelo
		(type STRING)
		;(allowed-strings "pesada" "moderadamentePesada" "media" "moderadamenteLigera" "ligera")
	)
	(slot phDelSuelo
		(type FLOAT)
	)
	(slot fotoperiodo
		(type STRING)
		;(allowed-strings "diaLargo" "diaNeutro" "diaCorto")
	)
)
;Plantilla zona
(deftemplate zona
	(slot nombre
		(type STRING)
	)
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
		;(range 0 100)
	)
)
(deftemplate respuesta
	(slot print
		(type STRING)
	)
)
;---------------------------------------------------------------
;----------------------Hechos Iniciales-------------------------
;---------------------------------------------------------------
(deffacts hechos_iniciales
	(menu)
	(zona
		(nombre "Palestina")
		(altitud 1603)
		(temperatura 26)
		(precipitacion 1202)
		(humedadRelativa 71)

	)
	(zona
		(nombre "Armenia")
		(altitud 1480)
		(temperatura 22)
		(precipitacion 2275)
		(humedadRelativa 79)

	)
	(zona
		(nombre "Yopal")
		(altitud 350)
		(temperatura 27)
		(precipitacion 2270)
		(humedadRelativa 72)

	)
	(zona
		(nombre "Medellin")
		(altitud 1495)
		(temperatura 21)
		(precipitacion 1685)
		(humedadRelativa 68)

	)
	(zona
		(nombre "Popayan")
		(altitud 1738)
		(temperatura 19)
		(precipitacion 2121)
		(humedadRelativa 77)

	)
	(zona
		(nombre "Villavicencio")
		(altitud 476)
		(temperatura 26)
		(precipitacion 4383)
		(humedadRelativa 75)

	(zona
		(nombre "Palmira")
		(altitud 1001)
		(temperatura 24)
		(precipitacion 894)
		(humedadRelativa 73)

	)
	(zona
		(nombre "Pasto")
		(altitud 2527)
		(temperatura 13)
		(precipitacion 796)
		(humedadRelativa 73)

	)
	(zona
		(nombre "Florencia")
		(altitud 50)
		(temperatura 26)
		(precipitacion 3700)
		(humedadRelativa 78)

	)
	(zona
		(nombre "Aguazul")
		(altitud 300)
		(temperatura 27)
		(precipitacion 2790)
		(humedadRelativa 77)

	)

)

;---------------------------------------------------------------
;---------------------------REGLAS------------------------------
;---------------------------------------------------------------
(defrule CafeCondiciones
	?hecho <- (CafeCondiciones)
	(planta
		(nombre "cafe")
		(precipitacion ?p &:(< ?p 2000))
		(precipitacion ?p &:(> ?p 1500))
		(temperatura ?t &:(< ?p 22))
		(temperatura ?t &:(> ?p 16))
		(profundidadDelSuelo ?pr &:(> ?pr 1))
		(altitud ?a &:(> ?p 1200))
		(altitud ?a &:(< ?p 1700))
		(humedadRelativa ?hr &:(> ?hr 70))
		(humedadRelativa ?hr &:(< ?hr 85))
		(phDelSuelo ?ph &:(> ?ph 5))
		(phDelSuelo ?ph &:(< ?ph 5.5))
		(fotoperiodo "diaCorto")
		(texturaDelSuelo ("media" | "moderadamentePesada" | "pesada"))
	)
	(zona
		(nombre ?nombre)
		(precipitacion ?p &:(< ?p 2000))
		(precipitacion ?p &:(> ?p 1500))
		(temperatura ?t &:(< ?p 22))
		(temperatura ?t &:(> ?p 16))
		(altitud ?a &:(> ?p 1200))
		(altitud ?a &:(< ?p 1700))
		(humedadRelativa ?hr &:(> ?hr 70))
		(humedadRelativa ?hr &:(< ?hr 85))
	)
	=>
	(assert (respuesta (print "La planta presenta, en " ?nombre ", un estado optimo")))
	
)











