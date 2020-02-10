
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
(deftemplate ambiente
	(slot tipo
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
	(slot fotoperiodo
		(type STRING)
		;(allowed-strings "diaLargo" "diaNeutro" "diaCorto")
	)
)
(deftemplate suelo
	(slot tipo
		(type STRING)
	)
	(slot profundidadDelSuelo
		(type INTEGER)
	)
	(slot texturaDelSuelo
		(type STRING)
		;(allowed-strings "pesada" "moderadamentePesada" "media" "moderadamenteLigera" "ligera")
	)
	(slot phDelSuelo
		(type FLOAT)
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
	(CafeCondiciones)
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
		(texturaDelSuelo "media" | "moderadamentePesada" | "pesada")
	)
	=>
	(assert (respuesta (print "La planta presenta, en estas condiciones, un estado optimo")))
)











