#library
library(methods)

#Lecture des données
type = c(rep("character",4),"numeric","character","numeric",rep("character",9),
         rep("numeric",33),"character",rep("numeric",5),"character")

visprem0 = read.table("https://raw.githubusercontent.com/armelsoubeiga/Cours-2020-2021/master/Statistiques%20et%20Probabilit%C3%A9s/projet/data/visa_raw.dat",header=T,row.names=1,colClasses=type,
                      na.strings=c(".","","NA"))

#Codage des modalités
visprem1<-visprem0 
visprem1[,"SEXEQ"]<-factor(visprem0[,"SEXEQ"],
                           levels=c("1","2"),
                           labels=c("Shom","Sfem"))
visprem1[,"FAMIQ"]<-factor(visprem0[,"FAMIQ"],
                           levels=c("C","D","inc","M","S","U","V"),
                           labels=c("Fcel","Fdiv","Finc","Fmar","Fsep","Fuli","Fveu"))
visprem1[,"CARVP"]=factor(visprem0[,"CARVP"],
                          levels=c("oui","non"),
                          labels=c("Coui","Cnon"))
visprem0[,"PCSPQ"]=substr(as.character(visprem0[,"PCSPQ"]),1,1)
visprem0[,"PCSPQ"]=factor(visprem0[,"PCSPQ"])
levels(visprem0[,"PCSPQ"])=list(a="0",b="1",c="2",d="3",e="4",f="5",g="6",h="7",j="8",a="i")
visprem1[,"PCSPQ"]<-factor(visprem0[,"PCSPQ"],
                           levels=c("a","b","c","d","e","f","g","h","j"),
                           labels=c("Pinc","Pagr","Part","Pcad","Pint","Pemp","Pouv","Pret","Psan"))
summary(visprem1)


#Premiers nettoyages
visprem1=subset(visprem1,visprem1[,"G29G30S"]!="B") 
visprem1=subset(visprem1,visprem1[,"G29G30S"]!="X") 
visprem1=subset(visprem1,visprem1[,"G03G04S"]!="B") 
visprem1=subset(visprem1,visprem1[,"G03G04S"]!="X") 
visprem1=subset(visprem1,visprem1[,"G45G46S"]!="A") 
visprem1=subset(visprem1,visprem1[,"G45G46S"]!="B") 
visprem1=subset(visprem1,visprem1[,"G45G46S"]!="X") 
visprem1=subset(visprem1,visprem1[,"G37G38S"]!="A")
visprem1=subset(visprem1,visprem1[,"G25G26S"]!="A") 
visprem1=subset(visprem1,visprem1[,"G25G26S"]!="B") 
visprem1=subset(visprem1,visprem1[,"G25G26S"]!="X") 
visprem1=subset(visprem1,visprem1[,"G47G48S"]!="B")

visprem1=visprem1[(visprem1[,"NBCATS"]=="1")=="FALSE",]
visprem1=visprem1[(visprem1[,"NBBECS"]=="1")=="FALSE",]


visprem1<-subset(visprem1,visprem1[,"AGER"]>17)
visprem1<-subset(visprem1,visprem1[,"AGER"]<66)

JNBJD = visprem1[,"JNBJD1S"]+visprem1[,"JNBJD2S"]+visprem1[,"JNBJD3S"]
visprem1 = as.data.frame(cbind(visprem1,JNBJD))


var<-c("SEXEQ","AGER","FAMIQ",
       "RELAT","PCSPQ","IMPNBS","REJETS","OPGNB","MOYRV","TAVEP","ENDET","GAGET",
       "GAGEC","GAGEM","KVUNB","QSMOY","QCRED","DMVTP","BOPPN",
       "FACAN","LGAGT","VIENB","VIEMT","UEMNB","UEMMTS","XLGNB",
       "XLGMT","YLVNB","YLVMT","NBELTS","MTELTS","NBCATS","MTCATS",
       "NBBECS","MTBECS","ROCNB","NTCAS","NPTAG","ITAVC",
       "HAVEF","JNBJD","CARVP")
visprem = visprem1[,var]

#Save data cleaned
library(openxlsx)

write.xlsx(visprem, 'C:/Users/aso.RCTS/Downloads/Armel/UVB/cours/Projet/data/visa_raw_cleaning.xlsx')

