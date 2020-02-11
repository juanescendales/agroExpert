
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
	(cafePrecipitacionN)
	(cacaoPrecipitacion)
	(cacaoPrecipitacionN)
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
	(zona
		(nombre 'cacao')
		(altitud 1200)
		(temperatura 25)
		(precipitacion 1600)
		(humedadRelativa 85)

	)
)

;---------------------------------------------------------------
;---------------------------REGLAS------------------------------
;---------------------------------------------------------------
;Reglas caf�
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
		(precipitacion ?precipitacion &:(> ?precipitacion 1499))
	)
	=>
	(assert (cafeTemperatura))
	(assert (cafeTemperaturaN))
)
(defrule cafePrecipitacionN
	?hecho <- (cafePrecipitacionN)
	(planta
		(nombre 'cafe')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(precipitacion ?precipitacion &:(< ?precipitacion 1500))
	)
	=>
	(assert (cafePrecipitacionN1))
	(assert (cafePrecipitacionN2))
)
(defrule cafePrecipitacionN1
	(cafePrecipitacionN1)
	(planta
		(nombre 'cafe')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(precipitacion ?precipitacion &:(> ?precipitacion 1000))
	)
	=>
	(assert (respuesta (print "Se encuentra en una precipitaci�n poco adecuada pero tolerable, lo ideal es tener una precipitaci�n por lo menos de 1500")))
)
(defrule cafePrecipitacionN2
	(cafePrecipitacionN2)
	(planta
		(nombre 'cafe')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(precipitacion ?precipitacion &:(< ?precipitacion 1000))
	)
	=>
	(assert (respuesta (print "No se encuentra en una precipitaci�n adecuada que puede resultar adversa para su producci�n y desarrollo")))
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
		(temperatura ?temperatura &:(> ?temperatura 15)&:(< ?temperatura 23))
	)
	=>
	(assert (cafeProfundidad))
	(assert (cafeProfundidadN))
)
(defrule cafeProfundidadN
	(cafeProfundidadN)
	(planta
		(nombre 'cafe')
		(profundidadDelSuelo ?pr &:(< ?pr 1))
	)
	=>
	(assert (respuesta (print "No se encuentra en la profundidad de suelo optima para el crecimiento de sus raices")))
)
(defrule cafeTemperaturaN
	(cafeTemperaturaN)
	(planta
		(nombre 'cafe')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(temperatura ?temperatura &:(< ?temperatura 16)|:(> ?temperatura 22))
	)
	=>
	(assert (cafeTemperaturaN1))
	(assert (cafeTemperaturaN2))
)
(defrule cafeTemperaturaN1
	(cafeTemperaturaN1)
	(planta
		(nombre 'cafe')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(temperatura ?temperatura &:(> ?temperatura 12)&:(< ?temperatura 28))
	)
	=>
	(assert (respuesta (print "La planta no tiene las condiciones optimas para su producci�n en cuanto temperatura, deber�a estar entre los 16 y 22 grados centigrados")))
)
(defrule cafeTemperaturaN2
	(cafeTemperaturaN2)
	(planta
		(nombre 'cafe')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(temperatura ?temperatura &:(< ?temperatura 13)|:(> ?temperatura 27))
	)
	=>
	(assert (respuesta (print "La planta esta en riesgo de sufrir da�os respecto a la temperatura")))
)
(defrule cafeProfundidad
	(cafeProfundidad)
	(planta
		(nombre 'cafe')
		(profundidadDelSuelo ?pr &:(> ?pr 1))
	)
	=>
	(assert (cafeAltitud))
	(assert (cafeAltitudN))
)
(defrule cafeAltitudN
	(cafeAltitudN)
	(planta
		(nombre 'cafe')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(altitud ?altitud &:(< ?altitud 1200)|:(> ?altitud 1700))
	)
	=>
	(assert (respuesta (print "La  altitud del terreno no es la optima para su producci�n, deber�a estar entre los 1200 y 1700 m")))
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
		(altitud ?altitud &:(> ?altitud 1199)&:(< ?altitud 1701))
	)
	=>
	(assert (cafeHumedad))
	(assert (cafeHumedadN))
)
(defrule cafeHumedadN
	(cafeHumedadN)
	(planta
		(nombre 'cafe')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(humedadRelativa ?humedadRelativa &:(< ?humedadRelativa 70)|:(> ?humedadRelativa 85))
	)
	=>
	(assert (respuesta (print "La humedad relativa no es la optima para la planta")))
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
		(humedadRelativa ?humedadRelativa &:(> ?humedadRelativa 69)&:(< ?humedadRelativa 86))
	)
	=>
	(assert (cafePh))
	(assert (cafePhN))
)
(defrule cafePhN
	(cafePhN)
	(planta
		(nombre 'cafe')
		(phDelSuelo ?phDelSuelo &:(< ?phDelSuelo 5)|:(> ?phDelSuelo 5.5))
	)
	=>
	(assert (respuesta (print "El PH del suelo no es optimo, se dificulta la nutrici�n del cultivo, debe estar entre 5 y 5.5")))
)
(defrule cafePh
	(cafePh)
	(planta
		(nombre 'cafe')
		(phDelSuelo ?phDelSuelo &:(> ?phDelSuelo 4.9)&:(< ?phDelSuelo 5.6))
	)
	=>
	(assert (cafeFotoperiodo))
	(assert (cafeFotoperiodoN1))
	(assert (cafeFotoperiodoN2))
)
(defrule cafeFotoperiodoN1
	(cafeFotoperiodoN1)
	(planta
		(nombre 'cafe')
		(fotoperiodo 'diaNeutro')
	)
	=>
	(assert (respuesta (print "EL proceso de floraci�n pordria verse afectado, hay que disminuir la cantidad de horas al sol")))
)
(defrule cafeFotoperiodoN2
	(cafeFotoperiodoN2)
	(planta
		(nombre 'cafe')
		(fotoperiodo 'diaLargo')
	)
	=>
	(assert (respuesta (print "EL proceso de floraci�n pordria verse afectado, hay que disminuir la cantidad de horas al sol")))
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
	(assert (cafeTextura1N))
	(assert (cafeTextura2N))
	(assert (cafeTextura3N))
)
(defrule cafeTextura1N
	(cafeTextura1N)
	(planta
		(nombre 'cafe')
		(texturaDelSuelo 'ligera')
	)
	=>
	(assert (respuesta (print "El caf� necesita de texturas mas pesadas para su producci�n optima")))
)
(defrule cafeTextura2N
	(cafeTextura2N)
	(planta
		(nombre 'cafe')
		(texturaDelSuelo 'moderadamenteLigera')
	)
	=>
	(assert (respuesta (print "El caf� necesita de texturas mas pesadas para su producci�n optima")))
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
	(cafeTextura2)
	(planta
		(nombre 'cafe')
		(texturaDelSuelo 'moderadamentePesada')
	)
	=>
	(assert (respuesta (print "La planta presenta, en estas condiciones, un estado optimo")))
)
(defrule cafeTextura3
	(cafeTextura3)
	(planta
		(nombre 'cafe')
		(texturaDelSuelo 'pesada')
	)
	=>
	(assert (respuesta (print "La planta presenta, en estas condiciones, un estado optimo")))
)















;Reglas cacao
(defrule cacaoPrecipitacion
	?hecho <- (cacaoPrecipitacion)
	(planta
		(nombre 'cacao')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(precipitacion ?precipitacion &:(> ?precipitacion 1499)&:(< ?precipitacion 2401))
	)
	=>
	(assert (cacaoTemperatura))
	(assert (cacaoTemperaturaN))
)
(defrule cacaoPrecipitacionN
	?hecho <- (cacaoPrecipitacionN)
	(planta
		(nombre 'cacao')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(precipitacion ?precipitacion &:(< ?precipitacion 1500)|:(> ?precipitacion 2400))
	)
	=>
	(assert (cacaoPrecipitacionN1))
	(assert (cacaoPrecipitacionN2))
)
(defrule cacaoPrecipitacionN1
	(cacaoPrecipitacionN1)
	(planta
		(nombre 'cacao')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(precipitacion ?precipitacion &:(> ?precipitacion 1500))
	)
	=>
	(assert (respuesta (print "La precipitaci�n es mayor a la optima, puede que haya riesgo a problemas de fungosis")))
)
(defrule cacaoPrecipitacionN2
	(cacaoPrecipitacionN2)
	(planta
		(nombre 'cacao')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(precipitacion ?precipitacion &:(< ?precipitacion 1500))
	)
	=>
	(assert (respuesta (print "La precipitaci�n es menor a la optima, se requiere riego.")))
)
(defrule cacaoTemperatura
	(cacaoTemperatura)
	(planta
		(nombre 'cacao')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(temperatura ?temperatura &:(> ?temperatura 22)&:(< ?temperatura 29))
	)
	=>
	(assert (cacaoProfundidad))
	(assert (cacaoProfundidadN))
)
(defrule cacaoProfundidadN
	(cacaoProfundidadN)
	(planta
		(nombre 'cacao')
		(profundidadDelSuelo ?pr &:(< ?pr 1))
	)
	=>
	(assert (respuesta (print "No se encuentra en la profundidad de suelo optima para el crecimiento de sus ra�ces, debe ser mayor a un metro")))
)
(defrule cacaoTemperaturaN
	(cacaoTemperaturaN)
	(planta
		(nombre 'cacao')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(temperatura ?temperatura &:(< ?temperatura 23)|:(> ?temperatura 28))
	)
	=>
	(assert (cacaoTemperaturaN1))
	(assert (cacaoTemperaturaN2))
)
(defrule cacaoTemperaturaN1
	(cacaoTemperaturaN1)
	(planta
		(nombre 'cacao')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(temperatura ?temperatura &:(> ?temperatura 14)&:(< ?temperatura 31))
	)
	=>
	(assert (respuesta (print "La planta esta en condiciones t�rmicas limitantes para su crecimiento")))
)
(defrule cacaoTemperaturaN2
	(cacaoTemperaturaN2)
	(planta
		(nombre 'cacao')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(temperatura ?temperatura &:(< ?temperatura 15)|:(> ?temperatura 30))
	)
	=>
	(assert (respuesta (print "La planta esta en condiciones de temperatura muy desfavorables")))
)
(defrule cacaoProfundidad
	(cacaoProfundidad)
	(planta
		(nombre 'cacao')
		(profundidadDelSuelo ?pr &:(> ?pr 1))
	)
	=>
	(assert (cacaoAltitud))
	(assert (cacaoAltitudN))
)
(defrule cacaoAltitudN
	(cacaoAltitudN)
	(planta
		(nombre 'cacao')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(altitud ?altitud &:(< ?altitud 1000)|:(> ?altitud 1400))
	)
	=>
	(assert (respuesta (print "La  altitud del terreno no es la optima para su produccion")))
)
(defrule cacaoAltitud
	(cacaoAltitud)
	(planta
		(nombre 'cacao')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(altitud ?altitud &:(> ?altitud 999)&:(< ?altitud 1401))
	)
	=>
	(assert (cacaoHumedad))
	(assert (cacaoHumedadN))
)
(defrule cacaoHumedadN
	(cacaoHumedadN)
	(planta
		(nombre 'cacao')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(humedadRelativa ?humedadRelativa &:(< ?humedadRelativa 80)|:(> ?humedadRelativa 90))
	)
	=>
	(assert (respuesta (print "La humedad relativa no es la optima")))
)
(defrule cacaoHumedad
	(cacaoHumedad)
	(planta
		(nombre 'cacao')
	)
	(zonaSeleccionada
		(nombre ?nombre)
	)
	(zona
		(nombre ?nombre)
		(humedadRelativa ?humedadRelativa &:(> ?humedadRelativa 79)&:(< ?humedadRelativa 91))
	)
	=>
	(assert (cacaoPh))
	(assert (cacaoPhN))
)
(defrule cacaoPhN
	(cacaoPhN)
	(planta
		(nombre 'cacao')
		(phDelSuelo ?phDelSuelo &:(< ?phDelSuelo 6.5)|:(> ?phDelSuelo 7.5))
	)
	=>
	(assert (respuesta (print "El PH del suelo no es el m�s optimo. Debe estar entre 6.5 y 7.5")))
)
(defrule cacaoPh
	(cacaoPh)
	(planta
		(nombre 'cacao')
		(phDelSuelo ?phDelSuelo &:(> ?phDelSuelo 6.4)&:(< ?phDelSuelo 7.6))
	)
	=>
	(assert (cacaoFotoperiodo))
	(assert (cacaoFotoperiodoN1))
	(assert (cacaoFotoperiodoN2))
)
(defrule cacaoFotoperiodoN1
	(cacaoFotoperiodoN1)
	(planta
		(nombre 'cacao')
		(fotoperiodo 'diaCorto')
	)
	=>
	(assert (respuesta (print "El foto periodo optimo esta entre las 12 y 14 horas de sol al dia")))
)
(defrule cacaoFotoperiodoN2
	(cacaoFotoperiodoN2)
	(planta
		(nombre 'cacao')
		(fotoperiodo 'diaLargo')
	)
	=>
	(assert (respuesta (print "El foto periodo optimo esta entre las 12 y 14 horas de sol al dia")))
)
(defrule cacaoFotoperiodo
	(cacaoFotoperiodo)
	(planta
		(nombre 'cacao')
		(fotoperiodo 'diaNeutro')
	)
	=>
	(assert (cacaoTextura1))
	(assert (cacaoTextura2))
	(assert (cacaoTextura3))
	(assert (cacaoTextura1N))
	(assert (cacaoTextura2N))
	(assert (cacaoTextura3N))
)
(defrule cacaoTextura1N
	(cacaoTextura1N)
	(planta
		(nombre 'cacao')
		(texturaDelSuelo 'ligera')
	)
	=>
	(assert (respuesta (print "El cacao necesita de texturas mas pesadas para su producci�n optima")))
)
(defrule cacaoTextura2N
	(cacaoTextura2N)
	(planta
		(nombre 'cacao')
		(texturaDelSuelo 'moderadamenteLigera')
	)
	=>
	(assert (respuesta (print "El cacao necesita de texturas mas pesadas para su producci�n optima")))
)
(defrule cacaoTextura1
	(cacaoTextura1)
	(planta
		(nombre 'cacao')
		(texturaDelSuelo 'media')
	)
	=>
	(assert (respuesta (print "La planta presenta, en estas condiciones, un estado optimo")))
)
(defrule cacaoTextura2
	(cacaoTextura2)
	(planta
		(nombre 'cacao')
		(texturaDelSuelo 'moderadamentePesada')
	)
	=>
	(assert (respuesta (print "La planta presenta, en estas condiciones, un estado optimo")))
)
(defrule cacaoTextura3
	(cacaoTextura3)
	(planta
		(nombre 'cacao')
		(texturaDelSuelo 'pesada')
	)
	=>
	(assert (respuesta (print "La planta presenta, en estas condiciones, un estado optimo")))
)






