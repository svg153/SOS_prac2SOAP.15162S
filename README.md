# SOS_prac2SOAP.15162S
Cliente de la práctica 2 (Curso 2015-2016, 2º Semestre) de Sistemas Orientados a Servicios (SOS) de la Escuela Técnica Superior de Ingenieros Informáticos (ETISIINF, antigua Facultad de Informática, FI) de la Universidad Politécnica de Madrid (UPM).

## Info
| Infomacion: |  |   
| ----------- | --------
| Titulación  | Grado de Ingeniería Informática. Plan 09.
| Año         | 2015-2016
| Materia     | Sistemas Orientados a Servicios
| Semestre    | 2 Semestre. Mañana
| Proyecto    | Practica 2, SOAP

## Autores
* Roberto Fernández, [roberseik][2]
* Sergio Valverde, [@svg153][3]

## Descripción de la práctica
Implementar el servicio y el cliente partiendo del WSDL dado para la practica de la asignatura.

## Dependencias
Si no se tienen tiene que instalarlas por su cuenta:
* JDK1.7.0_75
* Ant 1.9.4
* Tomcat 7.0.59
* Axis2-1.6.2
* rar (se explica mas abajo como instalarla)

## TODOs
* Muchos...

## Archivos de la carpeta
* **UserManagement.wsdl**: Con la descripción del servicio.
* **UserManagementWSClient.java**: Código con el cliente que prueba el servicio.
* **generateStub.sh**: Script bash que genera el codigo del cliente, partiendo del *UserManagement.wsdl* que se tiene que encontrar en la misma carpeta y teniendo instalado Axis2.
* **run.sh**: Script bash que gestiona la practica, diseñado para los que no hacen la practica en la maquina virtual, si no en su propio equipo.
    * CUIDADO: por que hay que en el caso de que se use este script en vez del siguiente, hay que cambiar algunas cosas
* **runMV.sh**: Script igual que el anterior, pero diseñado para la gente que hace las practica en la maquina vritual.

> NOTA: Tanto para el 'run.sh' y para el 'runMV.sh', actualmente solo funciona correctamente:
* '-h': muestra el uso del script.
* '-v' o '--version': muestra la version del script
* '-u' o '--update': actualiza el script a la ultima version que esta en github.
* '-up' o '--desplegar': despliga el servicio en tomcat para directamente lanzar las pruebas.
* '-sd' o '--apagar': apaga el servicio de tomcat
* '-ent' o '--entrega': crea el fichero .rar acto para la entrega.


## run.sh y runMV.sh

> IMPORTANTE: si se hace la práctica en la máquina virtual, donde aparezca run.sh, hay poner runMV.sh.
> * CUDIADO: El código de ambos scripts no están depurados completamentes, tratarlos con cautela. Se adminten pulls ;).
> * CUIDADO: si se usa el script 'run.sh' hay que cambiar algunas cosas antes de ejecutar, principalmente variables con los dirrectorios que usted esté utilizando. Mirar todo el código.

### Inicio

* Dar permisos de ejecución al fichero 'run.sh', mediante el siguiente comando en una terminal de bash.

    ```bash
    chmod +x run.sh
    ```
* El script tiene que estar en la misma carpeta donde se encuentre las carpetas del 'Cliente' y 'Servicio'.

### Desplegar el servicio en tomcat
1. Ejecutar en una terminal el siguiente comando de Bash:

    ```bash
    ./run.sh -up
    ```
2. Esperar a que en la terminal, aparezca 'BUILD SUCCESSFUL'. En tal caso es que Axis2 ha podido generar el fichero 'UserManagementWS.aar' correctamente. En el caso de que no aparezca, es que hay un error de codigo en el servicio.

3. Sacar una terminar para ver el log de CATALINA, mediante el siguiente comando de Bash y esperar a que aparezca 'INFO: Server startup in XXXX ms'. En tal caso es qeu se ha podido desplegar el servicio correctamente.
    ```bash
    tail -f --lines=20 $CATALINA_HOME/logs/catalina.out
    ```

4. Ejecutar el fichero de pruebas del cliente 'UserManagementWSClient.java' como una aplicación de Java normal.

5. Observar tanto el log de la consola del cliente al ejecutar el codigo java, como la terminal del log de CATALINA, para ver los errores del sevidor.

### Crear el fichero de entrega

Para crear el fichero de entrega se necesita tener instalado la apliccacion 'rar' para poder crear ficheros comprimidos '.rar'. Para instalarla ejecuta el siguiente comando dando permisos de superusuario.
```bash
sudo apt-get install rar
```
Una vez instalado, se ejecuta el script de la siguiente manera:
```bash
./run.sh -ent
```
Se pedirá el primer apellido de cada autor del codigo, ya que asi es como lo quieren en la asignatura.
```bash
# Ejemplo
$ ./run.sh -ent
Introduccior el primer apellido de cada autor. Ejemplo: Pepe Garcia y Jose Perez --> garciaperez
pepe
```
Una vez puesto el nombre, se creará un fichero 'NOMBREDADO.rar', (en el ejemplo: 'pepe.rar') en la misma carpeta donde se encuentra el script.



[2]: https://github.com/roberseik
[3]: https://twitter.com/svg153
