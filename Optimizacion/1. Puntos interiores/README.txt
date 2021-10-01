Proyecto 1 de Optimizacion Numerica I (Semestre Otoño 2020)

Andres Angeles Albores
C.U. 131749

La carpeta contiene los siguientes archivos:
	
	1. descenso2pasos.m: función de descenso por coordenadas para comprimir imágenes.

	2. punintpc.m: función del Método de puntos interiores.

	3. pintpredcorrpc.m: función del Método de puntos interiores con pasos predictor-corrector.

	4. recortarPaso.m: función que calcula el recorte del paso para las funciones PINTPREDCORRPC
	y PUNINTPC.

	5. Prueba_DESCENSO2PASOS: script de MATLAB que utiliza la función DESCENSO2PASOS para
	comprimir dos imágenes de prueba.

	6. Prueba_MPI: script de MATLAB que compara las funciones QUADPROG, PUNINTPC, PINTPREDCORRPC
	con 8 problemas de prueba de dimensión pequeña y con los problemas de prueba AFIRO, GROW7,
	SCTAP1, BOEING1

La carpeta contiene las siguientes subcarpetas:

	1. Imagenes: carpeta donde se almacenan las imágenes de prueba y las imágenes 
	comprimidas de la función DESCENSO2PASOS.

	2. Problemas de prueba: carpeta que contiene los problemas de prueba AFIRO, SCTAP1,
	GROW7 y BOEING1.

	3. Tablas de resultados: carpeta que contiene las tablas con los resultados de los 
	scripts Prueba_DESCENSO2PASOS.m y Prueba_MPI.m.
