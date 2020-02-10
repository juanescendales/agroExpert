
;--------------------------------------------------------------
;-------------------Plantillas---------------------------------
;--------------------------------------------------------------
;La plantilla es la misma para todas las plantas
(deftemplate planta
	(slot nombre
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
(deftemplate zonaSeleccionada
	(slot nombre
		(type STRING)
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
	(cafePrecipitacion)
	(zona
		(nombre 'Palestina')
		(altitud 1603)
		(temperatura 26)
		(precipitacion 1202)
		(humedadRelativa 71)

	)
	(zona
		(nombre 'Armenia')
		(altitud 1480)
		(temperatura 22)
		(precipitacion 2275)
		(humedadRelativa 79)

	)
	(zona
		(nombre 'Yopal')
		(altitud 350)
		(temperatura 27)
		(precipitacion 2270)
		(humedadRelativa 72)

	)
	(zona
		(nombre 'Medellin')
		(altitud 1495)
		(temperatura 21)
		(precipitacion 1685)
		(humedadRelativa 68)

	)
	(zona
		(nombre 'Popayan')
		(altitud 1738)
		(temperatura 19)
		(precipitacion 2121)
		(humedadRelativa 77)

	)
	(zona
		(nombre 'Villavicencio')
		(altitud 476)
		(temperatura 26)
		(precipitacion 4383)
		(humedadRelativa 75)
	)
	(zona
		(nombre 'Palmira')
		(altitud 1001)
		(temperatura 24)
		(precipitacion 894)
		(humedadRelativa 73)

	)
	(zona
		(nombre 'Pasto')
		(altitud 2527)
		(temperatura 13)
		(precipitacion 796)
		(humedadRelativa 73)

	)
	(zona
		(nombre 'Florencia')
		(altitud 50)
		(temperatura 26)
		(precipitacion 3700)
		(humedadRelativa 78)

	)
	(zona
		(nombre 'Aguazul')
		(altitud 300)
		(temperatura 27)
		(precipitacion 2790)
		(humedadRelativa 77)

	)
	(zona
		(nombre 'cafe')
		(altitud 1500)
		(temperatura 20)
		(precipitacion 1600)
		(humedadRelativa 77)

	)

)

;---------------------------------------------------------------
;---------------------------REGLAS------------------------------
;---------------------------------------------------------------

(defrule cafePrecipitacion
	?hecho <- (cafePrecipitacion)
	(planta
		(nombre 'cafe')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(precipitacion ?precipitacion &:(> ?precipitacion 1500)&:(< ?precipitacion 2000))
	)
	=>
	(assert (cafeTemperatura))
)
(defrule cafeTemperatura
	(cafeTemperatura)
	(planta
		(nombre 'cafe')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(temperatura ?temperatura &:(> ?temperatura 16)&:(< ?temperatura 22))
	)
	=>
	(assert (cafeProfundidad))
)
(defrule cafeProfundidad
	(cafeProfundidad)
	(planta
		(nombre 'cafe')
		(profundidadDelSuelo ?pr &:(> ?pr 1))
	)
	=>
	(assert (cafeAltitud))
)
(defrule cafeAltitud
	(cafeAltitud)
	(planta
		(nombre 'cafe')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(altitud ?altitud &:(> ?altitud 1200)&:(< ?altitud 1700))
	)
	=>
	(assert (cafeHumedad))
)
(defrule cafeHumedad
	(cafeHumedad)
	(planta
		(nombre 'cafe')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(humedadRelativa ?humedadRelativa &:(> ?humedadRelativa 70)&:(< ?humedadRelativa 85))
	)
	=>
	(assert (cafePh))
)
(defrule cafePh
	(cafePh)
	(planta
		(nombre 'cafe')
		(phDelSuelo ?phDelSuelo &:(> ?phDelSuelo 5)&:(< ?phDelSuelo 5.5))
	)
	=>
	(assert (cafeFotoperiodo))
)
(defrule cafeFotoperiodo
	(cafeFotoperiodo)
	(planta
		(nombre 'cafe')
		(fotoperiodo 'diaCorto')
	)
	=>
	(assert (cafeTextura1))
	(assert (cafeTextura2))
	(assert (cafeTextura3))
)
(defrule cafeTextura1
	(cafeTextura1)
	(planta
		(nombre 'cafe')
		(texturaDelSuelo 'media')
	)
	=>
	(assert (respuesta (print "La planta presenta, en estas condiciones, un estado optimo")))
)
(defrule cafeTextura2
	(cafeTextura1)
	(planta
		(nombre 'cafe')
		(texturaDelSuelo 'moderadamentePesada')
	)
	=>
	(assert (respuesta (print "La planta presenta, en estas condiciones, un estado optimo")))
)
(defrule cafeTextura3
	(cafeTextura1)
	(planta
		(nombre 'cafe')
		(texturaDelSuelo 'pesada')
	)
	=>
	(assert (respuesta (print "La planta presenta, en estas condiciones, un estado optimo")))
)


;(defrule CafeCondiciones
;	?hecho <- (CafeCondiciones)
;	(planta
;		(nombre "cafe")
;		(precipitacion ?p &:(< ?p 2000))
;		(precipitacion ?p &:(> ?p 1500))
;		(temperatura ?t &:(< ?p 22))
;		(temperatura ?t &:(> ?p 16))
;		(profundidadDelSuelo ?pr &:(> ?pr 1))
;		(altitud ?a &:(> ?p 1200))
;		(altitud ?a &:(< ?p 1700))
;		(humedadRelativa ?hr &:(> ?hr 70))
;		(humedadRelativa ?hr &:(< ?hr 85))
;		(phDelSuelo ?ph &:(> ?ph 5))
;		(phDelSuelo ?ph &:(< ?ph 5.5))
;		(fotoperiodo "diaCorto")
;		(texturaDelSuelo ("media" | "moderadamentePesada" | "pesada"))
;	)
;	(zona
;		(nombre ?nombre)
;		(precipitacion ?p &:(< ?p 2000))
;		(precipitacion ?p &:(> ?p 1500))
;		(temperatura ?t &:(< ?p 22))
;		(temperatura ?t &:(> ?p 16))
;		(altitud ?a &:(> ?p 1200))
;		(altitud ?a &:(< ?p 1700))
;		(humedadRelativa ?hr &:(> ?hr 70))
;		(humedadRelativa ?hr &:(< ?hr 85))
;	)
;	=>
;	(assert (respuesta (print "La planta presenta, en " ?nombre ", un estado optimo")))
;	
;)
;(defrule cafePrecipitacion
;	?hecho <- (cafePrecipitacion)
;	(planta
;		(nombre "cafe")
;		(precipitacion ?p &:(< ?p 1500))
;		(precipitacion ?p &:(> ?p 1000))
;	)
;	(zona
;		(nombre ?nombre)
;		(precipitacion ?p &:(< ?p 1500))
;		(precipitacion ?p &:(> ?p 1000))
;	)
;	=>
;	(assert (respuesta (print "En " ?nombre " se encuentra en una precipitación poco adecuada pero tolerable, lo ideal es tener una precipitación por lo menos de 1500")))
;)










