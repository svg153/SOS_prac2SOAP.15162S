#!/bin/bash
# -*- coding: utf-8 -*-

################################################
# >>>>>>> VAR SCRIPTS
################################################

VERSION=0.3
NAME=$(basename $0)
NM=$0
AUTHOR="@svg153 (based on garquiscript.sh by @mrgarri)"

CUR_DIR="$(pwd)"
bold=`tput bold`
normal=`tput sgr0`

UPDATE_source=https://raw.githubusercontent.com/svg153/SOS_prac2SOAP.15162S/master/runMV.sh


H="-h"
HELP="--help"
V="-v"
VER="--version"
U="-u"
UPD="--update"


function mostrar_descargando {
	echo -ne "Downloading files.  \r"
	sleep 0.5
	echo -ne "Downloading files.. \r"
	sleep 0.5
	echo -ne "Downloading files...\r"
	sleep 0.5
}

function download {
	wget --quiet --output-document=$1 $2 &
	while [[ $(ps | grep -c "wget") -gt 0 ]]
		do
			mostrar_descargando
	done
	printf "\rDone!\n"
}

function actualizar {
	# Download new version
	download $CUR_DIR/$NAME.tmp $UPDATE_source
	# Copy over modes from old version
	OCTAL_MODE=$(stat -c '%a' $0)
	chmod $OCTAL_MODE $CUR_DIR/$NAME.tmp
	# Overwrite old file with new
	mv -f $CUR_DIR/$NAME.tmp $NAME

	if [[ $? == 0 ]]
		then

			NEWVER=$(head ${NM} | grep "VERSION=" | sed 's/[^0-9.]//g')
			if [[ $NEWVER != $VERSION ]]
				then
					echo "Succesfully updated to version $NEWVER!"
				else
					echo "No updates found."
			fi
			exit 0
		else
			echo "There was an error performing the update, please try again later. Exit code: $?"
			exit 1
	fi
}

function print_version_corta {
	printf "\n$NAME ${bold}v$VERSION${normal}. LastUpdate:$(date -r $NAME). By $AUTHOR.\n\n"
}

function print_version {
	printf "\n${bold}$NAME version:${normal} $VERSION.\n\n"
	printf "${bold}Last updated:${normal} $(date -r $NAME).\n\n"
	printf "${bold}Author:${normal} $AUTHOR.\n\n"
}

function print_nombre {
	printf "${bold} $NAME ${normal} \n"
}

function mostrar_ayuda {
	print_acciones_script
	printf "\n"
	texto_uso
	printf "\n"

	printf "OPCIONES:\n"
		print_opciones
		printf "\n"

	printf "Otras opciones:\n"
		print_otras_opciones
		printf "\n"

	printf "You can ask my cat now how this script works and she'll just meaow you.\n"
	printf "\n"
}


function print_otras_opciones {
	printf "\t${bold}$H or $HELP:${normal} Shows help text.\n"
	printf "\t${bold}$V or $VER:${normal} Shows actual version of the script.\n"
	printf "\t${bold}$U or $UPD:${normal} Auto-updates the script to the latest version.\n"
}

################################################
# <<<<<<< VAR SCRIPTS
################################################

WJ="-wj"
WSDL2JAVA="--wsdl2java"
UP="-up"
DESPLEGAR="--desplegar"
SDW="-sd"
APAGAR="--apagar"
ENT="-ent"
ENTREGA="--entrega"

PATHBASE=/home/lsduser/software2015_linux

ANT_HOME=${PATHBASE}/apache-ant-1.9.7



CATALINA_HOME=${PATHBASE}/apache-tomcat-7.0.59
WEB_TOM=http://localhost:8080
TOM_UP=${CATALINA_HOME}/bin/startup.sh
TOM_DW=${CATALINA_HOME}/bin/shutdown.sh
# log de Tomcat
# $> $CATALINA_HOME /logs/catalina.out
WAR_TOM=${CATALINA_HOME}/webapps/axis2.war

AXIS2_HOME=${PATHBASE}/axis2-1.6.2
WAR_AXIS2=${AXIS2_HOME}/dist/axis2.war
# $AXIS2_HOME/webapp y construir la aplicación web utilizando ant
# $> $AXIS2_HOME/webapp ant


export TOM_UP=${TOM_UP}
export TOM_DW=${TOM_DW}

# Creamos las varibles aqui para que tengan ambito global
WSDL_PATH=""
JAVA_PROYECT_PATH=""
JAVA_NAME=""
ARR_PATH=""


CLIENTE_FOLDER="cliente"
SERVICIO_FOLDER="servicio"


function texto_uso {
	printf "Usage:  ${bold}$0 { $H | $HELP | $WJ | $WSDL2JAVA | $UP | $DESPLEGAR | $SDW | $APAGAR | $ENT | $ENTREGA }${normal}\n"
}

function mostrar_uso {
	texto_uso
}



function print_opciones {
	printf "\t${bold}$CO or $COMP:${normal} Compila: \"${FICH_BASE}\".\n"
	printf "\n"
}


function print_acciones_script {
	printf "ACCIONES:\n"
	printf ${bold}
	printf " * \n"
	printf ${normal}
}



function wsdl2java_func {
	printf "wsdl2java: Create a sketelon from WSDL file\n"
	printf "Write the complete path of WSDL file: \n"
	read $WSDL_PATH
    printf "Write the complete path of your java proyect: \n"
	read $JAVA_PROYECT_PATH
    printf "Write the java package name: \n"
	read $JAVA_NAME

	cd $JAVA_PROYECT_PATH
	$AXIS2_HOME/bin/wsdl2java.sh -s -ss -sd -wv 2.0 -p $JAVA_PROYECT_PATH/$JAVA_NAME -d adb -uri $WSDL_PATH
#	$AXIS2_HOME/bin/wsdl2java.sh -s -ss -sd -wv 2.0 -p userManagement -d adb -uri UserManagement.wsdl

    #TODO: control de errores de AXIS" wsdl2java.sh
#    printf "Make '${bold}$JAVA_NAME${normal}' in path '${bold}$JAVA_PROYECT_PATH${normal}'\n"
    cd $CUR_DIR
}



function crearPaqueteAAR {


	if [[ $JAVA_PROYECT_PATH == "" || $JAVA_NAME == "" ]] ; then
        crearPaqueteAAR_IMPUT
	else
        #crearPaqueteAAR_DEFECTO
        cd $JAVA_PROYECT_PATH
    	ant
    	ARR_PATH="$JAVA_PROYECT_PATH/build/lib/$JAVA_NAME.aar"
	fi

}


function desplegarAAR {
	if [[ $ARR_PATH == "" || $JAVA_NAME="" ]] ; then
        desplegarAAR_IMPUT
	else
        #desplegarAAR_DEFECTO
        ln -s $ARR_PATH $CATALINA_HOME/webapps/axis2/WEB-INF/services/$JAVA_NAME.aar
	fi
}


function montarAPP {
  	printf "wsdl2java: Create a sketelon from WSDL file\n"

  	# Crear el paquete para desplegar
  	crearPaqueteAAR

  	# Desplegar el servicio
  	desplegarAAR
}


function generarStub {
  	printf "generarStub: genera el stub para el cliente\n"


  	printf "wsdl2java: Create a sketelon from WSDL file\n"
	printf "Write the complete path of WSDL file: \n"
	read $WSDL_PATH
    printf "Write the complete path of your java proyect: \n"
	read $JAVA_PROYECT_PATH
    printf "Write the java package name: \n"
	read $JAVA_NAME


	cd $JAVA_PROYECT_PATH
	$AXIS2_HOME/bin/wsdl2java.sh -uri $WSDL_PATH -wv 2.0 -p $JAVA_NAME -d adb
    #TODO: control de errores de AXIS" wsdl2java.sh
#    printf "Make '${bold}$JAVA_NAME${normal}' in path '${bold}$JAVA_PROYECT_PATH${normal}'\n"
    cd $CUR_DIR
}







################################################
# ------ MAIN
################################################

case "$1" in
	"$H")
    	mostrar_uso
    	exit 0
        ;;
    "$HELP")
#@TODO: Hacer la funcion
    	mostrar_ayuda
    	exit 0
        ;;
    "$V")
    	print_version_corta
    	exit 0
        ;;
    "$VER")
    	print_version
    	exit 0
        ;;
    "$U")
    	actualizar
    	exit 0
        ;;
    "$UPD")
    	actualizar
    	exit 0
        ;;
    "$WJ" | "$WSDL2JAVA")
        wsdl2java_func
    	exit 0
        ;;
    "$UP" | "$DESPLEGAR")
        source ~/.bashrc
        echo "Paramos axis2..."
        $CATALINA_HOME/bin/shutdown.sh


#        activo=$(ps -aux | grep axis2 | wc -l)
#        echo $activo
#        if [ $activo > 0 ]; then
#            LOG=
#        else
#            LOG="TRUE"
#        fi

        JAVA_NAME="UserManagementWS"
        ARR_PATH="/home/lsduser/workspace/$SERVICIO_FOLDER/build/lib/$JAVA_NAME.aar"

        cd $SERVICIO_FOLDER
        rm ARR_PATH
        echo "Crearmos el fichero echo '$JAVA_NAME.aar'"
        ant
        # TODO mirar que se hizo bien en caso contrario no avanzar

        cd ..
        #desplegarAAR_DEFECTO

# No se puede hacer esto por que tomcat no reconoce que haya cambiado
# ln -s $ARR_PATH $CATALINA_HOME/webapps/axis2/WEB-INF/services/$JAVA_NAME.aar
        echo "Borramos el fichero antiguo '$JAVA_NAME.aar' de axis2"
        rm $CATALINA_HOME/webapps/axis2/WEB-INF/services/$JAVA_NAME.aar
        echo "Copiamos el nuevo '$JAVA_NAME.aar' en axis2"
        cp $ARR_PATH $CATALINA_HOME/webapps/axis2/WEB-INF/services/$JAVA_NAME.aar
        echo "Arrancamos axis2..."
        $CATALINA_HOME/bin/startup.sh

        # TODO solo cuando no este una ventana ya abierta
#        gnome-terminal --title="logTomcatTerminal" --command="tail -f --lines=20 $CATALINA_HOME/logs/catalina.out"
#        gnome-terminal --title="logTomcatDebbugTerminal" --command="tail -f --lines=20 $CATALINA_HOME/logs/catalina.out | grep --line-buffered 'DEBBUG'"

#        echo "$LOG" && echo "OK"
#        if [ -z "$LOG"]; then
#           LOG="TRUE"
#            export $LOG
#            source ~/.bashrc
#            echo $LOG
#        fi

#       
#       ping http://localhost:8080/axis2/services/listServices

        # Ejercutar el JAVA del cliente
        # cd $CLIENTE_FOLDER
        # javac


        # cd ..
        exit 0
        ;;
     "$SDW" | "$APAGAR")
        $CATALINA_HOME/bin/shutdown.sh

#        LOG=
#        export LOG
#        source ~/.bashrc
#        echo $LOG


        exit 0
        ;;

	"$ENT" | "$ENTREGA")

		# pedimos al user el nombre de la carpeta
		echo "Introduccior el primer apellido de cada autor. Ejemplo: Pepe Garcia y Jose Perez --> garciaperez"
		read NAMEENTREGA

        if [ -d "$NAMEENTREGA" ]; then
            rm -r $NAMEENTREGA
        fi

        mkdir $NAMEENTREGA

        JAVA_NAME="UserManagementWS"
        ARR_PATH="/home/lsduser/workspace/$SERVICIO_FOLDER/build/lib/$JAVA_NAME.aar"
        cp $ARR_PATH ./$NAMEENTREGA/$JAVA_NAME.aar

        # @CHANGE: por otro user
        cp -r ./$SERVICIO_FOLDER ./$NAMEENTREGA/servicio
        cp -r ./$CLIENTE_FOLDER ./$NAMEENTREGA/cliente

        cp /home/lsduser/workspace/$SERVICIO_FOLDER/src/UserManagement/UserManagementWSSkeleton.java ./$NAMEENTREGA/UserManagementWSSkeleton.java

        rm "$NAMEENTREGA.rar"

        rar a -r -c- $NAMEENTREGA.rar ./$NAMEENTREGA/

        rm -r $NAMEENTREGA


        exit 0
        ;;

     *)
        mostrar_ayuda
        exit 0

esac
