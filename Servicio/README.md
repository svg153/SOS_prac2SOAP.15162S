# SOS_prac2SOAP.15162S


## TIPS para servicio

### Estructura para el servicio
Lo mejor es hacer una estrucutura de tipo Map, que tenga los usuarios registrados teniendo por clave el String del username, y por valor la clase User. Como ejemplo hemos cogido un hashMap.

```java
// Estructura
HashMap<String User> usuariosRegistrados;
// El tipo String, se corresponderá con username del Username.getUsername()
```


En el caso de que se haga un hashMap con la clave, siendo Username, como clase, vamos a tener un problema a la hora de actualizar y borrar una entrada, ya que las clases User y Username no tienen implementados los metodos equals, por lo tanto la estructura al comparar las clases, buscara las funciones equals de la clase, pero al no encontrarlas usara la de Object y solo compara la refencia, por lo que no funcionará y habrá que crearse explícitamente las funciones para borrar y actualizar las estructuras o cambiar la clave a String como dijimos anteriormente.

```java
// Estructura
HashMap<Username, User> usuariosRegistrados;
// CUIDADO: La clase Username, no tiene el método equals creado en su clase
```

### Mantener la sesión

#### Servicio
Pasos a seguir para que el servicio mantenga las sesiones.

##### services.xml
Cambiar del fichero 'services.xml' las siguientes lineas:

 En la parte de la definición del servicio:

- Antigua:
```xml
<service name="UserManagementWS">
```
- Nueva:
```xml
<service name="UserManagementWS" scope="soapsession">
```

En la parte de la definición de los parámetros:

- Antigua:
```xml
<parameter name="useOriginalwsdl">true</parameter>
```
- Nueva:
```xml
<parameter name="useOriginalwsdl">false</parameter>
```

#### Cliente
Pasos a seguir para que el cliente mantenga la sesión:
1. Añadir el archivo 'addressing.mar' de Axis2 a la carpeta del cliente.
2. Renombrar el fichero 'addressing.mar', por 'addressing.jar'.
3. Añadir el fichero 'addressing.jar' al Build Path del cliente.
4. Escribir las siguientes lineas en la clase del cliente:

```java
// creamos el stub
UserManagementWSStub stub = new UserManagementWSStub();

// hacemos que el stub mantega la conexion        
stub._getServiceClient().engageModule("addressing");
stub._getServiceClient().getOptions().setManageSession(true);
```
