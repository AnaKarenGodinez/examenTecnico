# examenTecnico
Este es un proyecto de prueba técnica que consiste en una aplicación web para gestionar usuarios y colaboradores. El backend está implementado con Node.js y MySQL, mientras que el frontend está desarrollado con Flutter.

# Aplicación Web
El sistema debe tener un modo de autentificación por el cual el usuario pueda registrarse
e iniciar sesión en caso de que cuente con un registro, además de poder actualizar su
contraseña.

## Registro
1. Nombre
2. Correo electrónico
3. RFC
4. Password
5. Confirmación del password

### Validaciones
1. Todos los campos son requeridos
2. En caso de que un campo esté vacío, se deberá indicar al usuario con un color rojo en los bordes
3. En caso de que el password y la confirmación no sean iguales, indicarlo de la misma manera que el punto anterios
4. Estas validaciones se deberán hacer en flutter
5. Valudar el RFC en cuanto a estructura y longitud
6. El registro no debe permitir 2 RFC duplicados ni correos electrónicos

## Inicio de Sesión
La forma de inicio de sesión deberá requerir el correo electrónico de la persona y el
password.

### Validaciones
1. Todos los campos son requeridos
2. En caso de que un campo esté vacío, se deberá indicar al usuario con un color rojo en los bordes
3. Si el correo electrónico de la persona y el password no coinciden, indicar mediante un mensaje que los valores introducidos no coinciden con los registrados en el sistema

## Menú de la apliación
Una vez iniciada la sesión, deberás mostrar una forma en donde se muestre la información de los usuarios registrados.
La aplicación deberá contar con un menú lateral (de lado izquierdo), el cual se podrá ocultar cuando se requiera.

### Menú
#### Carga de archivos 
Este menú tendrá la posibilidad de cargar un archivo de formato XLSX, PDF y se guardará en una tabla el nombre del archivo, extensión, fecha de creación.
#### Colaborador
En este menú, tendrá la posibilidad de escribir y resguardar en base de datos la siguiente información:
* Nombre
* Correo
* RFC
* Domicilio Fiscal
* CURP
* Número de Seguro Social
* Fecha Inicio Laboral
* Tipo de Contrato
* Departamento
* Puesto
* Salario Diario
* Salario
* Clave Entidad
* Estado (deberá de ser un despliegue de los estados de México)

#### Empleados
Esta vista deberán aparecer todos los colaboradores creados en la vista anterior con las siguientes funcionalidades:
  * Funcionalidad de hacer una búsqueda de la información mediante la fecha en que se creó el colaborador (Para hacer un ejemplo se recomienda contar más empleados generados de manera ficticia), por CURP, por RFC, Nombre
  * En el listado de colaboradores, deberá contar con la opción de editar o eliminar el empleado (de manera lógica)

#### Servicios
Esta vista deberá realizar el consumo de un servicio de jsonplaceholder donde se tendrá que visualizar el listado de Publicaciones

##### Aspectos Clave:
Asegurarse de que la lista se cargue correctamente al iniciar la pantalla
Diseñar una interfaz de usuario clara y funcional para mostrar las publicaciones

##### Funcionalidad para Crear Publicaciones
- Descripción
Implementar un botón para abrir un diálogo de creación de publicaciones
- Requisitos
  * Captura de Datos: El diálogo debe permitir ingresar el título y contenido de la publicación
  * Envío de Datos: Enviar los datos capturados a un método POST del servicio web
  * Actualización de la Lista: Una vez creada la publicación, la lista principal debe actualizarse, preferiblemente agregando la nueva publicación al inicio
  * Validación de Formulario: Asegurar que todos los campos del formulario sean requeridos y validarlos antes de enviar

##### Editar Publicaciones
- Descripción
Permitir la edición de publicaciones seleccionadas

- Requisitos
  * Envío de Datos Editados: Al seleccionar una publicación, mostrar un diálogo con los detalles que puedan editarse y enviar los cambios a un método PUT del servicio web
  * Actualización del Listado: Tras guardar los cambios, actualizar el listado principal para reflejar la publicación editada

##### Eliminar Publicaciones
- Descripción
Incluir una funcionalidad para eliminar publicaciones

- Requisitos
    * Consumo del Método DELETE: Utilizar un método DELETE del servicio web para eliminar una publicación
    * Actualización del Listado: Tras eliminar una publicación, actualizar el listado para reflejar este cambio
 
#### Actualización de contraseña
La aplicación deberá contar en la página de inicio de sesión con un apartado en donde se pueda cambiar la contraseña en caso de que se haya olvidado, tomando como parámetros el correo y el RFC
