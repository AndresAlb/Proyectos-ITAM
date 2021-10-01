directorio <- "C:/Users/Andres/OneDrive/Tenth Semester/Estadística Aplicada I/GitHub/EA1"
setwd(directorio)
knitr::opts_knit$set(root.dir = directorio)

sessionInfo()

library(ggplot2)
library(reshape2)
library(plyr)

###FUENTE
violencia.fuente <- NULL 
titulos.fuente <- NULL
for (i in 1:12){ 
violencia.fuente[[i]] <- read.csv(paste("./Datos/BrutosCSV_funcionan/Fuente/FueFem",i+2002,".csv", sep = "" ), sep = ",", stringsAsFactors = FALSE, encoding = "UTF-8")
titulos.fuente[i] <- paste("FueFem",i+2002,sep="")
}

for (i in 1:12){
violencia.fuente[[i+12]] <- read.csv(paste("./Datos/BrutosCSV_funcionan/Fuente/FueGen",i+2002,".csv",sep=""), sep = ",", stringsAsFactors=FALSE, encoding = "UTF-8")
titulos.fuente[i+12] <- paste("FueGen",i+2002,sep="")
}

for (i in 1:12){
violencia.fuente[[i+24]] <- read.csv(paste("./Datos/BrutosCSV_funcionan/Fuente/FueMas",i+2002,".csv",sep=""), sep = ",", stringsAsFactors=FALSE, encoding = "UTF-8")
titulos.fuente[i+24] <- paste("FueMas",i+2002,sep="")
}
names(violencia.fuente) <- titulos.fuente

###EDAD

violencia.edad <- NULL
titulos.edad <- NULL
for (i in 1:12){
violencia.edad[[i]] <- read.csv(paste("./Datos/BrutosCSV_funcionan/Grupo/GruFem",i+2002,".csv",sep=""),stringsAsFactors=FALSE)
titulos.edad[i] <- paste("GruFem",i+2002,sep="")
}

for (i in 1:12){
violencia.edad[[i+12]] <- read.csv(paste("./Datos/BrutosCSV_funcionan/Grupo/GruGen",i+2002,".csv",sep=""),stringsAsFactors=FALSE)
titulos.edad[i+12] <- paste("GruGen",i+2002,sep="")
}

for (i in 1:12){
violencia.edad[[i+24]] <- read.csv(paste("./Datos/BrutosCSV_funcionan/Grupo/GruMas",i+2002,".csv",sep=""),stringsAsFactors=FALSE)
titulos.edad[i+24] <- paste("GruMas",i+2002,sep="")
}
names(violencia.edad) <- titulos.edad

###MES

violencia.mes <- NULL 
titulos.mes <- NULL
for (i in 1:12){ 
violencia.mes[[i]] <- read.csv(paste("./Datos/BrutosCSV_funcionan/Mes/MesFem",i+2002,".csv", sep = "" ), stringsAsFactors = FALSE)
titulos.mes[i] <- paste("MesFem",i+2002,sep="")
 }

for (i in 1:12){
violencia.mes[[i+12]] <- read.csv(paste("./Datos/BrutosCSV_funcionan/Mes/MesGen",i+2002,".csv",sep=""),stringsAsFactors=FALSE)
titulos.mes[i+12] <- paste("MesGen",i+2002,sep="")
}

for (i in 1:12){
violencia.mes[[i+24]] <- read.csv(paste("./Datos/BrutosCSV_funcionan/Mes/MesMas",i+2002,".csv",sep=""),stringsAsFactors=FALSE)
titulos.mes[i+24] <- paste("MesMas",i+2002,sep="")
}
names(violencia.mes) <- titulos.mes

# Limpieza de datos

##FUENTE
for (i in 1:36){ 
names(violencia.fuente[[i]]) <-toupper(names(violencia.fuente[[i]]))
}

for (i in 1:36){ 
names(violencia.fuente[[i]]) <-gsub("SEDEMAR","SEMAR",names(violencia.fuente[[i]]))
}

for (i in 1:36){ 
names(violencia.fuente[[i]]) <-gsub("SALUD","SSA",names(violencia.fuente[[i]]))
}

##EDAD
for (i in 1:36){ 
names(violencia.edad[[i]]) <- c("Estado","Menor a 1","1 a 4","5 a 9", "10 a 14","15 a 19", "20 a 24","25 a 44", "45 a 49","50 a 59","60 a 64","65 o Mas","Desconocida")
}
for (i in 1:36){ 
names(violencia.edad[[i]]) <-toupper(names(violencia.edad[[i]]))
}

##MES
for (i in 1:36){ 
names(violencia.mes[[i]]) <-toupper(names(violencia.mes[[i]]))
}

# Guardamos la informacion en 3 data frames

##FUENTE
violencia.intrafamiliar.fuente <- ldply(violencia.fuente,data.frame)
violencia.intrafamiliar.fuente <- violencia.intrafamiliar.fuente[,1:12]
save(violencia.intrafamiliar.fuente, file="violencia_intrafamiliar_Fuente.RData")

##EDAD
violencia.intrafamiliar.edad <- ldply(violencia.edad,data.frame)
violencia.intrafamiliar.edad <- violencia.intrafamiliar.edad[,1:14]
save(violencia.intrafamiliar.edad, file="violencia_intrafamiliar_Edad.RData")

##MES
violencia.intrafamiliar.mes <- ldply(violencia.mes,data.frame)
violencia.intrafamiliar.mes <- violencia.intrafamiliar.mes[,1:15]
save(violencia.intrafamiliar.mes, file="violencia_intrafamiliar_Mes.RData")

# Se agregan las variables SEXO y PERIODO

##FUENTE
violencia.intrafamiliar.fuente$PERIODO <- factor(substr(violencia.intrafamiliar.fuente$.id,7,10), ordered=TRUE)
violencia.intrafamiliar.fuente$SEXO <- factor(substr(violencia.intrafamiliar.fuente$.id,4,4))
violencia.intrafamiliar.fuente$.id <- NULL
violencia.intrafamiliar.fuente <- within(violencia.intrafamiliar.fuente,{
 SEXO <- gsub("M","Masculino",SEXO,fixed=TRUE)
 SEXO <- gsub("F","Femenino",SEXO,fixed=TRUE)
 SEXO <- gsub("G","General",SEXO,fixed=TRUE)
 })

save(violencia.intrafamiliar.fuente, file="violencia_intrafamiliar_Fuente(Sexo-Periodo).RData")

##EDAD
violencia.intrafamiliar.edad$PERIODO <- factor(substr(violencia.intrafamiliar.edad$.id,7,10), ordered=TRUE)
violencia.intrafamiliar.edad$SEXO <- factor(substr(violencia.intrafamiliar.edad$.id,4,4))
violencia.intrafamiliar.edad$.id <- NULL
violencia.intrafamiliar.edad <- within(violencia.intrafamiliar.edad,{
 SEXO <- gsub("M","Masculino",SEXO,fixed=TRUE)
 SEXO <- gsub("F","Femenino",SEXO,fixed=TRUE)
 SEXO <- gsub("G","General",SEXO,fixed=TRUE)
 })

save(violencia.intrafamiliar.edad, file="violencia_intrafamiliar_Edad(Sexo-Periodo).RData")

##MES
violencia.intrafamiliar.mes$PERIODO <- factor(substr(violencia.intrafamiliar.mes$.id,7,10), ordered=TRUE)
violencia.intrafamiliar.mes$SEXO <- factor(substr(violencia.intrafamiliar.mes$.id,4,4))
violencia.intrafamiliar.mes$.id <- NULL
violencia.intrafamiliar.mes <- within(violencia.intrafamiliar.mes,{
 SEXO <- gsub("M","Masculino",SEXO,fixed=TRUE)
 SEXO <- gsub("F","Femenino",SEXO,fixed=TRUE)
 SEXO <- gsub("G","General",SEXO,fixed=TRUE)
 })

save(violencia.intrafamiliar.mes, file="violencia_intrafamiliar_Mes(Sexo-Periodo).RData")

# Convertimos los valores a tipo nominal

#FUENTE
violencia.intrafamiliar.fuente$ESTADO <- factor(violencia.intrafamiliar.fuente$ESTADO)
violencia.intrafamiliar.fuente$SEXO <- factor(violencia.intrafamiliar.fuente$SEXO)

save(violencia.intrafamiliar.fuente,file="violencia_Fuente_Limp.RData")

#EDAD
violencia.intrafamiliar.edad$ESTADO <- factor(violencia.intrafamiliar.edad$ESTADO)
violencia.intrafamiliar.edad$SEXO <- factor(violencia.intrafamiliar.edad$SEXO)

save(violencia.intrafamiliar.edad,file="violencia_Edad_Limp.RData")


#MES
violencia.intrafamiliar.mes$ESTADO <- factor(violencia.intrafamiliar.mes$ESTADO)
violencia.intrafamiliar.mes$SEXO <- factor(violencia.intrafamiliar.mes$SEXO)

save(violencia.intrafamiliar.mes,file="violencia_Mes_Limp.RData")

# Quitamos las comas y los espacios de los numeros

##FUENTE
violencia.intrafamiliar.fuente <- within(violencia.intrafamiliar.fuente, {
   SSA <- gsub("\\s+|,","",SSA)
   IMSS.ORD <- gsub("\\s+|,","",IMSS.ORD)
   ISSSTE <- gsub("\\s+|,","",ISSSTE)
   IMSS.OP <- gsub("\\s+|,","",IMSS.OP)
   DIF <- gsub("\\s+|,","",DIF)
   PEMEX <- gsub("\\s+|,","",PEMEX)
   SEDENA <- gsub("\\s+|,","",SEDENA)
   SEMAR <- gsub("\\s+|,","",SEMAR)
   OTRAS <- gsub("\\s+|,","",OTRAS)
 })

##EDAD
violencia.intrafamiliar.edad <- within(violencia.intrafamiliar.edad,{
 MENOR.A.1 <- gsub("\\s+|,","",MENOR.A.1)
 X1.A.4 <- gsub("\\s+|,|,","",X1.A.4)
 X5.A.9 <- gsub("\\s+|,","",X5.A.9)
 X10.A.14 <- gsub("\\s+|,","",X10.A.14)
 X15.A.19 <- gsub("\\s+|,","",X15.A.19)
 X20.A.24 <- gsub("\\s+|,","",X20.A.24)
 X25.A.44 <- gsub("\\s+|,","",X25.A.44)
 X45.A.49 <- gsub("\\s+|,","",X45.A.49)
 X50.A.59 <- gsub("\\s+|,","",X50.A.59)
 X60.A.64 <- gsub("\\s+|,","",X60.A.64)
 X65.O.MAS <- gsub("\\s+|,","",X65.O.MAS)
 DESCONOCIDA <- gsub("\\s+|,","",DESCONOCIDA) 
})

##MES

violencia.intrafamiliar.mes <- within(violencia.intrafamiliar.mes, {
   ENE <- gsub("\\s+|,","",ENE)
   FEB <- gsub("\\s+|,","",FEB)
   MAR <- gsub("\\s+|,","",MAR)
   ABR <- gsub("\\s+|,","",ABR)
   MAY <- gsub("\\s+|,","",MAY)
   JUN <- gsub("\\s+|,","",JUN)
   JUL <- gsub("\\s+|,","",JUL)
   AGO <- gsub("\\s+|,","",AGO)
   SEP <- gsub("\\s+|,","",SEP)
   OCT <- gsub("\\s+|,","",OCT)
   NOV <- gsub("\\s+|,","",NOV)
   DIC <- gsub("\\s+|,","",DIC)
 })

# Sustituimos los valores nulos por NA


# FUENTE
violencia.intrafamiliar.fuente <- within(violencia.intrafamiliar.fuente, {
     SSA <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",SSA)
     IMSS.ORD <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",IMSS.ORD)
     ISSSTE <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",ISSSTE)
     IMSS.OP <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",IMSS.OP)
     DIF <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",DIF)
     PEMEX <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",PEMEX)
     SEDENA <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",SEDENA)
     SEMAR <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",SEMAR)
     OTRAS <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",OTRAS)
     })

# MES
violencia.intrafamiliar.mes <- within(violencia.intrafamiliar.mes, {
     ENE <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",ENE)
     FEB <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",FEB)
     MAR <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",MAR)
     ABR <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",ABR)
     MAY <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",MAY)
     JUN <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",JUN)
     JUL <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",JUL)
     AGO <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",AGO)
     SEP <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",SEP)
     OCT <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",OCT)
     NOV <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",NOV)
     DIC <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",DIC)
     })

# EDAD
violencia.intrafamiliar.edad <- within(violencia.intrafamiliar.edad, {
     MENOR.A.1 <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",MENOR.A.1)
     X1.A.4 <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",X1.A.4)
     X5.A.9 <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",X5.A.9)
     X10.A.14 <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",X10.A.14)
     X15.A.19 <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",X15.A.19)
     X20.A.24 <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",X20.A.24)
     X25.A.44 <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",X25.A.44)
     X45.A.49 <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",X45.A.49)
     X50.A.59 <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",X50.A.59)
     X60.A.64 <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",X60.A.64)
     X65.O.MAS <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",X65.O.MAS)
     DESCONOCIDA <- gsub("[S.R.,S/R,N.A.,N/A]{1,}","NA",DESCONOCIDA)
     })

# Pasamos los valores a tipo numerico


##FUENTE
violencia.intrafamiliar.fuente <- within(violencia.intrafamiliar.fuente, {
 SSA <- as.numeric(SSA)
 IMSS.ORD <- as.numeric(IMSS.ORD)
 ISSSTE <- as.numeric(ISSSTE)
 IMSS.OP <- as.numeric(IMSS.OP)
 DIF <- as.numeric(DIF)
 PEMEX <- as.numeric(PEMEX)
 SEDENA <- as.numeric(SEDENA)
 SEMAR <- as.numeric(SEMAR)
 OTRAS <- as.numeric(OTRAS)
})

##MES
violencia.intrafamiliar.mes <- within(violencia.intrafamiliar.mes, {
  ENE <- as.numeric(ENE)
  FEB <- as.numeric(FEB)
  MAR <- as.numeric(MAR)
  ABR <- as.numeric(ABR)
  MAY <- as.numeric(MAY)
  JUN <- as.numeric(JUN)
  JUL <- as.numeric(JUL)
  AGO <- as.numeric(AGO)
  SEP <- as.numeric(SEP)
  OCT <- as.numeric(OCT)
  NOV <- as.numeric(NOV)
  DIC <- as.numeric(DIC)
})

##EDAD
violencia.intrafamiliar.edad <- within(violencia.intrafamiliar.edad,{  
 MENOR.A.1 <- as.numeric(MENOR.A.1)
 X1.A.4 <- as.numeric(X1.A.4)
 X5.A.9 <- as.numeric(X5.A.9)
 X10.A.14 <- as.numeric(X10.A.14)
 X15.A.19 <- as.numeric(X15.A.19)
 X20.A.24 <- as.numeric(X20.A.24)
 X25.A.44<- as.numeric(X25.A.44)
 X45.A.49 <- as.numeric(X45.A.49)
 X50.A.59 <- as.numeric(X50.A.59)
 X60.A.64 <- as.numeric(X60.A.64)
 X65.O.MAS<- as.numeric(X65.O.MAS)
 DESCONOCIDA <- as.numeric(DESCONOCIDA)
})

# Sumamos cada fila y agregamos el resultado a la nueva columna TOTAL

##FUENTE
FUENTE <- violencia.intrafamiliar.fuente[,c(-1,-11,-12,-13)]
violencia.intrafamiliar.fuente$TOTAL <- apply(FUENTE,1,function(x) sum(x, na.rm=TRUE))

##MES
MES <- violencia.intrafamiliar.mes[,c(-1,-2,-15,-16)]
violencia.intrafamiliar.mes$TOTAL <- apply(MES,1,function(x) sum(x,na.rm=TRUE))

##EDAD
EDAD<-violencia.intrafamiliar.edad[,c(-1,-14,-15)]
violencia.intrafamiliar.edad$TOTAL <- apply(EDAD,1,function(x) sum(x,na.rm=TRUE))

# Reporte de casos de violencia por fuente

mujeresf.periodo <-  aggregate(TOTAL~PERIODO,data=subset(violencia.intrafamiliar.fuente, SEXO=="Femenino"),sum) 
colnames(mujeresf.periodo) <- c("Periodo","Femenino")

hombresf.periodo <- aggregate(TOTAL~ PERIODO,data=subset(violencia.intrafamiliar.fuente, SEXO=="Masculino"),sum)
colnames(hombresf.periodo) <- c("Periodo","Masculino")

generalf.periodo <- aggregate(TOTAL~ PERIODO,data=subset(violencia.intrafamiliar.fuente, SEXO=="General"),sum)
colnames(generalf.periodo) <- c("Periodo","General")

#Se crearon 3 tablas con la suma de casos por periodo para los diferentes textos (femenino, masculino y general)
verificacion.fuente <- merge(merge(generalf.periodo,hombresf.periodo),mujeresf.periodo)

#Se juntan las 3 tablas en una sola
verificacion.fuente$Validacion <- as.list(rowSums(subset(verificacion.fuente,TRUE,c(Masculino,Femenino)),na.rm=FALSE))

#Se agrega una columna con la suma de la columna Femenino y Masculino
save(verificacion.fuente,file="Validacion_Fuente.RData")

# Reporte de casos de violencia por mes

mujeresm.periodo <-  aggregate(TOTAL~ PERIODO,data=subset(violencia.intrafamiliar.mes, SEXO=="Femenino"),sum)
colnames(mujeresm.periodo) <- c("Periodo","Femenino")

hombresm.periodo <- aggregate(TOTAL~ PERIODO,data=subset(violencia.intrafamiliar.mes, SEXO=="Masculino"),sum)
colnames(hombresm.periodo) <- c("Periodo","Masculino")

generalm.periodo <- aggregate(TOTAL~ PERIODO,data=subset(violencia.intrafamiliar.mes, SEXO=="General"),sum)
colnames(generalm.periodo) <- c("Periodo","General")

#Se crearon 3 tablas con la suma de casos por periodo para los diferentes textos (femenino, masculino y general)
verificacion.mes <- merge(merge(generalm.periodo,hombresm.periodo),mujeresm.periodo)

#Se juntan las 3 tablas en una sola
verificacion.mes$Validacion <- as.list(rowSums(subset(verificacion.mes,TRUE,c(Masculino,Femenino)),na.rm=FALSE))

#Se agrega una columna con la suma de la columna Femenino y Masculino
save(verificacion.mes,file="Validacion_Mes.RData")

# Reporte de casos de violencia por edad

mujerese.periodo <-  aggregate(TOTAL~ PERIODO,data=subset(violencia.intrafamiliar.edad, SEXO=="Femenino"),sum)
colnames(mujerese.periodo) <- c("Periodo","Femenino")

hombrese.periodo <- aggregate(TOTAL~ PERIODO,data=subset(violencia.intrafamiliar.edad, SEXO=="Masculino"),sum)
colnames(hombrese.periodo) <- c("Periodo","Masculino")

generale.periodo <- aggregate(TOTAL~ PERIODO,data=subset(violencia.intrafamiliar.edad, SEXO=="General"),sum)
colnames(generale.periodo) <- c("Periodo","General")

#Se crearon 3 tablas con la suma de casos por periodo para los diferentes textos (femenino, masculino y general)
verificacion.edad <- merge(merge(generale.periodo,hombrese.periodo),mujerese.periodo)

#Se juntan las 3 tablas en una sola
verificacion.edad$Validacion <- as.list(rowSums(subset(verificacion.edad,TRUE,c(Masculino,Femenino)),na.rm=FALSE))

#Se agrega una columna con la suma de la columna Femenino y Masculino
save(verificacion.edad,file="Validacion_Edad.RData")

library(reshape2)
violencia.intrafamiliar.estado <- NULL
violencia.intrafamiliar.fuente$TOTAL <- NULL
violencia.intrafamiliar.edad$TOTAL <- NULL
violencia.intrafamiliar.mes$TOTAL <- NULL

#Cambiamos el formato de la base violencia.intrafamiliar.fuente

violencia.intrafamiliar.FUENTE <- melt(data=violencia.intrafamiliar.fuente,id=c("ESTADO","PERIODO","SEXO"))
names(violencia.intrafamiliar.FUENTE) <- c("ESTADO","PERIODO","SEXO","INSTITUCION","CASOS")

save(violencia.intrafamiliar.FUENTE, file="violencia_FLargo_Fuente.RData")

#Cambiamos el formato a la base violencia.intrafamiliar.mes

violencia.intrafamiliar.MES <- melt(data=violencia.intrafamiliar.mes,id=c("ESTADO","PERIODO","SEXO"),na.rm=TRUE)
names(violencia.intrafamiliar.MES) <- c("ESTADO","PERIODO","SEXO","MES","CASOS")

save(violencia.intrafamiliar.MES, file="violencia_FLargo_Mes.RData")


#Cambiamos el formato de la base violencia.intrafamiliar.edad

violencia.intrafamiliar.EDAD <- melt(data=violencia.intrafamiliar.edad,id=c("ESTADO","PERIODO","SEXO"))
names(violencia.intrafamiliar.EDAD) <- c("ESTADO","PERIODO","SEXO","EDAD","CASOS")

save(violencia.intrafamiliar.EDAD,file="violencia_FLargo_Edad.RData")

periodo <- c(2003:2014)
for (i in 1:12){
  institucion.per[[i]] <- as.list(colSums(subset(violencia.intrafamiliar.fuente,PERIODO==periodo[i] & SEXO=="General")[,2:10]),na.rm=TRUE)
}

names(institucion.per) <- periodo

institucion.periodo <- ldply(institucion.per,data.frame)

names(institucion.periodo) <- c("PERIODO","SSA","IMSS.ORD","ISSSTE","IMSS.OP","DIF","PEMEX","SEDENA","SEMAR","OTRAS")

#La pasamos al formato largo

INSTITUCION.PERIODO <- melt(institucion.periodo,id=c("PERIODO"))

names(INSTITUCION.PERIODO) <- c("PERIODO","INSTITUCION","CASOS")

save(INSTITUCION.PERIODO, file="Total de Casos Por Institucion.RData")

# Graficamos

library(ggplot2)

ggplot(INSTITUCION.PERIODO,aes(PERIODO,CASOS,group=INSTITUCION))+geom_line(aes(colour=INSTITUCION)) +facet_wrap(~INSTITUCION,ncol=3)+ geom_point(aes(colour=INSTITUCION))+labs(title="Casos reportados por institucion (2003-2014)",x="Periodo",y="Numero de casos")+theme_bw()+theme(axis.text.x=element_text(angle=90))+theme(legend.position="none",strip.text = element_text(face = "bold"),axis.text.x = element_text(size=15), axis.text.y = element_text(size=15),strip.background = element_blank(),axis.text = element_text(colour=grey(.50)),axis.ticks=element_line(colour=grey(.80)),axis.title = element_text(colour=grey(.45), size=12), plot.title = element_text(size =20))

ggplot(INSTITUCION.PERIODO,aes(x=INSTITUCION,y=CASOS,group=PERIODO,fill=INSTITUCION)) +geom_bar(stat="identity",aes(colour=INSTITUCION))+facet_wrap(~PERIODO,ncol=3)+theme_bw()+theme(axis.text.x=element_text(angle=90,size=5),strip.text = element_text(face = "bold"),strip.background = element_blank(),axis.text = element_text(colour=grey(.50)),axis.ticks=element_line(colour=grey(.80)),axis.text.x = element_text(size=15), axis.text.y = element_text(size=15),axis.title = element_text(colour=grey(.45)))+labs(title="Casos por Institucion reportados cada periodo",x="Institucion",y="Numero de Casos", plot.title = element_text(size =20))

mes.per <- NULL
periodo <- c(2003:2014)

for (i in 1:12){
  mes.per[[i]] <- as.list(colSums(subset(violencia.intrafamiliar.mes,PERIODO==periodo[i] & SEXO=="General")[,2:13]),na.rm=TRUE)
}

names(mes.per) <- periodo

mes.periodo <- ldply(mes.per,data.frame)

names(mes.periodo) <- c("Periodo","ENE","FEB","MAR","ABR","MAY","JUN","JUL","AGO","SEP","OCT","NOV","DIC")

#Converitmos la tabla a formato largo
MES.PERIODO <- melt(mes.periodo,id=c("Periodo"),na.rm=TRUE)

#Renombramos variables
names(MES.PERIODO) <- c("Periodo","Mes","No.incidentes")

save(MES.PERIODO, file="Tendencia Interanual.RData")

ggplot(MES.PERIODO,aes(x=Mes,y=No.incidentes,group=Periodo))+geom_line(aes(colour=Periodo))+geom_point(aes(colour=Periodo),size=2.5)+facet_wrap(~Periodo,ncol=3)+theme_bw()+theme(strip.text = element_text(face = "bold"),strip.background = element_blank(),axis.text = element_text(colour=grey(.50)),axis.ticks=element_line(colour=grey(.80)),axis.title = element_text(colour=grey(.45)), axis.text.x = element_text(size=15, angle=45,vjust=.5), axis.text.y = element_text(size=15, angle=45),plot.title = element_text(size =20))+labs(title="Evolucion anual de los casos reportados de violencia intrafamiliar",x="Mes",y="Numero de incidentes")+theme(legend.position="none")+scale_x_discrete("Mes",labels=c("ENE"="Enero","FEB"="Febrero","MAR"="Marzo","ABR"="Abril","MAY"="Mayo","JUN"="Junio","JUL"="Julio","AGO"="Agosto","SEP"="Septiembre","OCT"="Octubre","NOV"="Noviembre","DIC"="Diciembre"))

media.mes.1 <- as.data.frame(sapply(mes.periodo[,2:13], function(x) mean(x, na.rm = TRUE)))
media.mes.1$Mes <- c("ENE","FEB","MAR","ABR","MAY","JUN","JUL","AGO","SEP","OCT","NOV","DIC")
names(media.mes.1) <- c("No.incidentes","Mes")

save(media.mes.1, file="Promedio incidentes Mensual.RData")

ggplot(MES.PERIODO,aes(x=Periodo,y=No.incidentes,group=Mes))+geom_line(aes(colour=Mes))+geom_point(aes(colour=Mes),size=2.5)+facet_wrap(~Mes,ncol=4)+theme_bw()+theme(strip.text = element_text(face = "bold"),strip.background = element_blank(),axis.text = element_text(colour=grey(.50)),axis.text.x = element_text(size=15, angle=45,vjust=.5),axis.text.y = element_text(size=15, angle=45),plot.title = element_text(size =20),axis.ticks=element_line(colour=grey(.80)),axis.title = element_text(colour=grey(.45)))+labs(title="Tendencia mensual por periodo de observacion comparada con la media del mes",x="Mes",y="Numero de incidentes")+theme(legend.position="none")+geom_hline(data=media.mes.1,aes(yintercept=No.incidentes,group=Mes),linetype=2)+ scale_colour_hue(h=c(180, 270))

color.prom <- c(NA,NA,NA,NA,NA,NA,NA,NA,NA,"withcolor",NA,NA)

ggplot(media.mes.1,aes(x=Mes,y=No.incidentes,fill=color.prom))+geom_bar(stat="identity")+theme_bw()+theme(strip.text = element_text(face = "bold"),strip.background = element_blank(),axis.text = element_text(colour=grey(.50)),axis.text.x = element_text(size=15, angle=45,vjust=.5),axis.text.y = element_text(size=15, angle=45),plot.title = element_text(size =20),axis.ticks=element_line(colour=grey(.80)),axis.title = element_text(colour=grey(.45)))+labs(title="Promedio Mensual de casos de violencia intrafamiliar",x="Mes",y="Numero de incidentes")+theme(legend.position="none")+xlim("ENE","FEB","MAR","ABR","MAY","JUN","JUL","AGO","SEP","OCT","NOV","DIC")

# Vemos los promedio en cada estado durante el mes de octubre

#Hacemos una tabla con el promedio de cada estado en el mes de octubre para el periodo de observacion (2003-2013)

ESTADO.OCTUBRE.PROM <- acast(subset(violencia.intrafamiliar.MES,MES=="OCT" & SEXO=="General"), MES~ESTADO, function (x) mean(x, na.rm = TRUE))

ESTADO.OCTUBRE.PROM <- melt(ESTADO.OCTUBRE.PROM,id=c("MES"),variable.name="ESTADO")

save(ESTADO.OCTUBRE.PROM, file="Promedios Entidad Para Octubre.RData")

ggplot(ESTADO.OCTUBRE.PROM,aes(x=reorder(ESTADO.OCTUBRE.PROM$Var2,value),y=value,fill=Var1))+geom_bar(stat="identity")+theme_bw()+theme(strip.background = element_blank(),axis.text = element_text(colour=grey(.50)),axis.ticks=element_line(colour=grey(.80)),axis.text.x = element_text(size=12),axis.text.y = element_text(size=15, angle=45),plot.title = element_text(size =20),axis.title = element_text(colour=grey(.45)))+labs(title="Promedio por estado en el mes de octubre de los casos de violencia intrafamiliar",x="Estado",y="Numero de casos")+theme(legend.position="none")+coord_flip()+scale_fill_manual(values = c("skyblue3"))


