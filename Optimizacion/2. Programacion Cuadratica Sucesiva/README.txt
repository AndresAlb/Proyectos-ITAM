Proyecto 2 de Optimizacion Numerica I (Semestre Otoño 2020)

Andres Angeles Albores
C.U. 131749

La carpeta contiene los siguientes archivos:
	
	1. fesfera.m: funcion objetivo del problema

	2. hesfera.m: funcion de restricciones del problema

	3. gradiente.m: funcion que calcula el vector gradiente de fesfera en un punto x

	4. jacobiana.m: funcion que calcula la matriz jacobiana de hesfera en un punto x

	5. meritoL1.m: funcion que calcula el valor de la funcion de merito L1 asociada a 
	fesfera y hesfera en un punto x

	6. meritoDDL1: funcion que calcula el valor de la derivada direccional de la 
	funcion de merito L1 asociada a fesfera y hesfera en un punto x con un paso p

	7. pcsglobal.m: metodo de programacion cuadratica sucesiva con actualizacion de
	BFGS-Powell

	8. Prueba_PCSGLOBAL.m: script que realiza las comparaciones de FMINCON con PCSGLOBAL

La carpeta contiene las siguientes subcarpetas:

	1. Graficas: carpeta donde se almacenan las graficas de las esferas con los puntos
	de la solución, las graficas de comparacion de iteraciones, tiempo de ejecucion y 
	de la distancia entre las soluciones de PCSGLOBAL y FMINCON