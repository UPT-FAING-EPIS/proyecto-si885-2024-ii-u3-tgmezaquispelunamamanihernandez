Logo de Mi Empresa		Logo de mi Cliente

![C:\Users\EPIS\Documents\upt.png](media/Aspose.Words.33fe436c-c1b3-4947-a292-794105a149f8.001.png)

<a name="_heading=h.gjdgxs"></a>**UNIVERSIDAD PRIVADA DE TACNA**

**FACULTAD DE INGENIERÍA**

**Escuela Profesional de Ingeniería de Sistemas**


**Proyecto Prevalencia de Enfermedades en el Campus**


Curso: *Inteligencia de Negocios*


Docente: *Patrick Cuadros Quiroga*


Integrantes:

***Luna Juárez Juan Brendon		(2020068762)***

***Elvis Mamani Valdivia		(2020068763)***

***Jean Marco Meza Noalcca		(2021071087)***

***Cristian Quispe Levano 		(2018000590)***

***Angel Hernandez Cruz		(2021070017)***





**Tacna – Perú**

***2024***



|CONTROL DE VERSIONES||||||
| :-: | :- | :- | :- | :- | :- |
|Versión|Hecha por|Revisada por|Aprobada por|Fecha|Motivo|
|1\.0|MPV|ELV|ARV|10/10/2020|Versión Original|









<a name="_heading=h.30j0zll"></a>Sistema *Prevalencia de enfermedades en el campus*

Documento de Arquitectura de Software

Versión *1.2*



|CONTROL DE VERSIONES||||||
| :-: | :- | :- | :- | :- | :- |
|Versión|Hecha por|Revisada por|Aprobada por|Fecha|Motivo|
|1\.0|MPV|ELV|ARV|10/10/2024|Versión Original|
|1\.1||||15/11/2024|Revisión del diseño|
|1\.2||||18/11/2024|Correlación final |

INDICE GENERAL


[***1.***](#_heading=h.1fob9te)[	](#_heading=h.1fob9te)***INTRODUCCIÓN	5******

[**1.1.**](#_heading=h.3znysh7)[	](#_heading=h.3znysh7)**Propósito (Diagrama 4+1)	5**

[**1.2.**](#_heading=h.2et92p0)[	](#_heading=h.2et92p0)**Alcance	5**

[**1.3.**](#_heading=h.tyjcwt)[	](#_heading=h.tyjcwt)**Definición, siglas y abreviaturas	5**

[**1.4.**](#_heading=h.3dy6vkm)[	](#_heading=h.3dy6vkm)**Organización del documento	5**

[***2.***](#_heading=h.1t3h5sf)[	](#_heading=h.1t3h5sf)***OBJETIVOS Y RESTRICCIONES ARQUITECTONICAS	5***

[2.1.1.](#_heading=h.4d34og8)[	](#_heading=h.4d34og8)Requerimientos Funcionales	5

[2.1.2.](#_heading=h.17dp8vu)[	](#_heading=h.17dp8vu)Requerimientos No Funcionales – Atributos de Calidad	5

[***3.***](#_heading=h.3rdcrjn)[	](#_heading=h.3rdcrjn)***REPRESENTACIÓN DE LA ARQUITECTURA DEL SISTEMA	6***

[**3.1.**](#_heading=h.lnxbz9)[	](#_heading=h.lnxbz9)**Vista de Caso de uso	6**

[3.1.1.](#_heading=h.35nkun2)[	](#_heading=h.35nkun2)Diagramas de Casos de uso	6

[**3.2.**](#_heading=h.1ksv4uv)[	](#_heading=h.1ksv4uv)**Vista Lógica	6**

[3.2.1.](#_heading=h.2jxsxqh)[	](#_heading=h.2jxsxqh)Diagrama de Subsistemas (paquetes)	7

[3.2.2.](#_heading=h.z337ya)[	](#_heading=h.z337ya)Diagrama de Secuencia (vista de diseño)	7

[3.2.3.](#_heading=h.3j2qqm3)[	](#_heading=h.3j2qqm3)Diagrama de Colaboración (vista de diseño)	7

[3.2.4.](#_heading=h.1y810tw)[	](#_heading=h.1y810tw)Diagrama de Objetos	7

[3.2.5.](#_heading=h.4i7ojhp)[	](#_heading=h.4i7ojhp)Diagrama de Clases	7

[3.2.6.](#_heading=h.2xcytpi)[	](#_heading=h.2xcytpi)Diagrama de Base de datos (relacional o no relacional)	7

[**3.3.**](#_heading=h.1ci93xb)[	](#_heading=h.1ci93xb)**Vista de Implementación (vista de desarrollo)	7**

[3.3.1.](#_heading=h.3whwml4)[	](#_heading=h.3whwml4)Diagrama de arquitectura software (paquetes)	7

[3.3.2.](#_heading=h.2bn6wsx)[	](#_heading=h.2bn6wsx)Diagrama de arquitectura del sistema (Diagrama de componentes)	7

[**3.4.**](#_heading=h.qsh70q)[	](#_heading=h.qsh70q)**Vista de procesos	7**

[3.4.1.](#_heading=h.3as4poj)[	](#_heading=h.3as4poj)Diagrama de Procesos del sistema (diagrama de actividad)	8

[**3.5.**](#_heading=h.1pxezwc)[	](#_heading=h.1pxezwc)**Vista de Despliegue (vista física)	8**

[3.5.1.](#_heading=h.49x2ik5)[	](#_heading=h.49x2ik5)Diagrama de despliegue	8

[***4.***](#_heading=h.2p2csry)[	](#_heading=h.2p2csry)***ATRIBUTOS DE CALIDAD DEL SOFTWARE	8***

[**Escenario de Funcionalidad	8**](#_heading=h.147n2zr)

[**Escenario de Usabilidad	8**](#_heading=h.3o7alnk)

[**Escenario de confiabilidad	9**](#_heading=h.23ckvvd)

[**Escenario de rendimiento	9**](#_heading=h.ihv636)

[**Escenario de mantenibilidad	9**](#_heading=h.32hioqz)

[**Otros Escenarios	9**](#_heading=h.1hmsyys)















































1. <a name="_heading=h.1fob9te"></a>INTRODUCCIÓN

1. <a name="_heading=h.3znysh7"></a>Propósito 

   <a name="_heading=h.edtte82cikd2"></a>El propósito de este documento es describir la arquitectura del sistema, proporcionando una visión integral que abarca los aspectos funcionales y no funcionales. Este enfoque asegura que se consideren las decisiones arquitectónicas clave para satisfacer las necesidades de los stakeholders. Además, se establece un equilibrio entre eficiencia, portabilidad y calidad del sistema, priorizando los atributos de rendimiento y mantenibilidad.

1. <a name="_heading=h.2et92p0"></a>Alcance

   <a name="_heading=h.vdznchty2vc6"></a>Este documento se centra en desarrollar la vista lógica del sistema, incluyendo componentes clave como casos de uso, estructura de subsistemas y diseño de la base de datos. 

   <a name="_heading=h.7ytgtvcjb70i"></a> El sistema está diseñado para gestionar datos de enfermedades, generar reportes interactivos y garantizar la seguridad de la información. Se aplica en entornos académicos y clínicos, priorizando la escalabilidad y la interoperabilidad.* 

1. <a name="_heading=h.tyjcwt"></a>Definición, siglas y abreviaturas

   **Caso de uso**: Representación de interacciones entre actores y el sistema para lograr un objetivo.

   **QAs**: Atributos de calidad, propiedades evaluables del sistema.

   **Diagrama de despliegue**: Representación física de la arquitectura del sistema, mostrando nodos y conexiones.

   <a name="_heading=h.buwqsi151fa1"></a>**Vista lógica**: Enfoque en la representación de requerimientos funcionales mediante subsistemas y clases.

1. <a name="_heading=h.3dy6vkm"></a>Organización del documento

   **Sección 1**: Introducción al propósito, alcance y términos clave.

   **Sección 2**: Identificación de objetivos y restricciones arquitectónicas.

   **Sección 3**: Representación detallada de las vistas arquitectónicas.

   <a name="_heading=h.u0ewxop3uijv"></a>**Sección 4**: Evaluación de atributos de calidad del sistema.

1. # <a name="_heading=h.1t3h5sf"></a>**OBJETIVOS Y RESTRICCIONES ARQUITECTONICAS**
   [Establezca las prioridades de los requerimientos y las restricciones del proyecto)

   1. Priorización de requerimientos

|ID|Descripción |Prioridad|
| - | - | - |
||<p>Análisis comparativo:</p><p></p><p></p>|Media|
||<p>Dashboard interactivo:</p><p></p><p></p><p></p>|Media|
||<p>Identificación de dolencias comunes:</p><p></p><p></p><p></p>|Alta|
||<p>Análisis comparativo de dolencias:</p><p></p><p></p><p></p>|Alta|
||<p>Control de Intervencion x ciclo:</p><p></p><p></p><p></p>|Media|

|ID|Descripcion |Prioridad|
| :- | :- | :- |
||<p>Seguridad y Privacidad:</p><p></p><p>Protección de datos personales conforme a las leyes locales de privacidad (por ejemplo, la Ley de Protección de Datos Personales en Perú).</p><p>Acceso limitado a usuarios autorizados para la consulta y análisis de datos.</p><p></p><p></p>|Alta|
||<p>Usabilidad:</p><p>Interfaz intuitiva y fácil de usar para el análisis y la generación de reportes.</p><p>Accesibilidad desde dispositivos móviles y de escritorio.</p><p></p><p></p><p></p>|Media|
||<p>Escalabilidad:</p><p>Capacidad de manejar un incremento en los datos a medida que se agregan nuevos años y semestres.</p><p>Adaptabilidad a nuevas fuentes de datos o indicadores de salud.</p><p></p><p></p><p></p>|Baja|
||<p>Rendimiento:</p><p>Generación de reportes en tiempo real o en tiempos aceptables (segundos o minutos).</p><p>Optimización del uso de hardware y software para asegurar tiempos de respuesta mínimos.</p><p></p>|Media|
###
1. ### <a name="_heading=h.sip97010oscv"></a><a name="_heading=h.4d34og8"></a>Requerimientos Funcionales


   |ID|Descripción |Prioridad|
   | - | - | - |
   ||<p>Análisis comparativo:</p><p></p><p></p>|Media|
   ||<p>Dashboard interactivo:</p><p></p><p></p><p></p>|Media|
   ||<p>Identificación de dolencias comunes:</p><p></p><p></p><p></p>|Alta|
   ||<p>Análisis comparativo de dolencias:</p><p></p><p></p><p></p>|Alta|
   ||<p>Control de Intervencion x ciclo:</p><p></p><p></p><p></p>|Media|
   ###
1. ### <a name="_heading=h.2s8eyo1"></a><a name="_heading=h.17dp8vu"></a>Requerimientos No Funcionales – Atributos de Calidad


   |ID|Descripcion |Prioridad|
   | :- | :- | :- |
   ||<p>Seguridad y Privacidad:</p><p></p><p>Protección de datos personales conforme a las leyes locales de privacidad (por ejemplo, la Ley de Protección de Datos Personales en Perú).</p><p>Acceso limitado a usuarios autorizados para la consulta y análisis de datos.</p><p></p><p></p>|Alta|
   ||<p>Usabilidad:</p><p>Interfaz intuitiva y fácil de usar para el análisis y la generación de reportes.</p><p>Accesibilidad desde dispositivos móviles y de escritorio.</p><p></p><p></p><p></p>|Media|
   ||<p>Escalabilidad:</p><p>Capacidad de manejar un incremento en los datos a medida que se agregan nuevos años y semestres.</p><p>Adaptabilidad a nuevas fuentes de datos o indicadores de salud.</p><p></p><p></p><p></p>|Baja|
   ||<p>Rendimiento:</p><p>Generación de reportes en tiempo real o en tiempos aceptables (segundos o minutos).</p><p>Optimización del uso de hardware y software para asegurar tiempos de respuesta mínimos.</p><p></p>|Media|
###


1. Restricciones

   **Presupuesto limitado**: Los recursos económicos disponibles restringen el alcance del desarrollo tecnológico y adquisición de infraestructura.

   **Cumplimiento legal**: Adherencia estricta a las normativas locales e internacionales relacionadas con privacidad y seguridad de datos.

   **Infraestructura existente**: Uso obligatorio de servidores y plataformas ya disponibles en la organización.

   **Tiempo de desarrollo**: Plazos ajustados para la implementación y despliegue del sistema.

   **Compatibilidad**: El sistema debe integrarse con herramientas existentes como sistemas ERP o CRM usados por la organización.



1. # <a name="_heading=h.3rdcrjn"></a>**REPRESENTACIÓN DE LA ARQUITECTURA DEL SISTEMA**

1. <a name="_heading=h.26in1rg"></a><a name="_heading=h.lnxbz9"></a>Vista de Caso de uso


1. ### <a name="_heading=h.35nkun2"></a>Diagramas de Casos de uso

Este diagrama ilustra los actores principales y sus interacciones con el sistema, reflejando las funcionalidades clave. Los casos de uso incluyen:

- Consultar datos históricos.
- Generar reportes gráficos interactivos.
- Gestión de accesos y permisos.

**Principales Casos de Uso**:

- **Consultar datos históricos de enfermedades**: Permite acceder a registros históricos segmentados por fecha, enfermedad, o facultad.
- **Generar reportes gráficos interactivos**: Presenta un análisis visual de los datos filtrados.

![](media/Aspose.Words.33fe436c-c1b3-4947-a292-794105a149f8.002.png)

Este diagrama representa las interacciones entre los actores (usuarios y sistemas externos) y las funcionalidades principales del sistema. Muestra los casos de uso, como consultas de datos históricos, generación de reportes y gestión de permisos.


1. <a name="_heading=h.1ksv4uv"></a>Vista Lógica
###
1. ### <a name="_heading=h.44sinio"></a><a name="_heading=h.2jxsxqh"></a>Diagrama de Subsistemas (paquetes)
![](media/Aspose.Words.33fe436c-c1b3-4947-a292-794105a149f8.003.png)

Define módulos para:

1. **Gestión de datos de enfermedades**: Incluye importación, validación y almacenamiento de datos.
1. **Generación de reportes**: Módulo para procesar consultas y producir dashboards.
1. **Autenticación y Seguridad**: Gestiona el acceso de usuarios.

1. ### <a name="_heading=h.z337ya"></a>Diagrama de Secuencia (vista de diseño)
![](media/Aspose.Words.33fe436c-c1b3-4947-a292-794105a149f8.004.png)

Este diagrama muestra el flujo temporal de mensajes entre los componentes del sistema para realizar una funcionalidad específica. Representa cómo un usuario interactúa con el sistema, el cual consulta la base de datos y retorna resultados.
1. ### <a name="_heading=h.3j2qqm3"></a>Diagrama de Colaboración (vista de diseño)

![](media/Aspose.Words.33fe436c-c1b3-4947-a292-794105a149f8.005.png)

Representa las interacciones entre objetos o componentes del sistema para lograr un objetivo. Enfatiza las relaciones estructurales entre los elementos participantes durante un proceso.

1. ### <a name="_heading=h.1y810tw"></a>Diagrama de Objetos
`		`![](media/Aspose.Words.33fe436c-c1b3-4947-a292-794105a149f8.006.png)

Es una instancia del diagrama de clases, que detalla los objetos específicos en un momento dado y cómo se relacionan entre ellos. Por ejemplo, muestra un usuario generando un reporte basado en datos históricos.
1. ### <a name="_heading=h.4i7ojhp"></a>Diagrama de Clases
`		`![](media/Aspose.Words.33fe436c-c1b3-4947-a292-794105a149f8.007.png)

Representa la estructura estática del sistema, mostrando las clases, sus atributos, métodos y relaciones. Define cómo se organiza la lógica del sistema a nivel de programación orientada a objetos.

1. ### <a name="_heading=h.2xcytpi"></a>Diagrama de Base de datos (relacional o no relacional)

![](media/Aspose.Words.33fe436c-c1b3-4947-a292-794105a149f8.008.png)

El diagrama de base de datos muestra la estructura lógica de las tablas del sistema y las relaciones entre ellas. En este caso, se trata de un modelo relacional con las siguientes entidades principales:

1. <a name="_heading=h.1ci93xb"></a>Vista de Implementación (vista de desarrollo)



1. ### <a name="_heading=h.3whwml4"></a>Diagrama de arquitectura software (paquetes)

![](media/Aspose.Words.33fe436c-c1b3-4947-a292-794105a149f8.009.png)

Representa la organización y la estructura del software en forma de paquetes. Los paquetes agrupan componentes relacionados, facilitando la gestión, mantenimiento y escalabilidad del sistema. En este diagrama, se visualiza cómo los diferentes módulos del sistema están organizados y cómo se interrelacionan para cumplir con los requisitos del sistema.

1. ### <a name="_heading=h.2bn6wsx"></a>Diagrama de arquitectura del sistema (Diagrama de componentes)

   ![](media/Aspose.Words.33fe436c-c1b3-4947-a292-794105a149f8.010.png)

   Este diagrama muestra los principales componentes del sistema y cómo interactúan entre sí. Cada componente representa un módulo o subsistema que realiza una función específica. Este diagrama es esencial para comprender la estructura interna del sistema y las dependencias entre sus partes, lo que facilita la implementación, las pruebas y el mantenimiento.

1. <a name="_heading=h.qsh70q"></a>Vista de procesos
   1. ### <a name="_heading=h.3as4poj"></a>Diagrama de Procesos del sistema (diagrama de actividad)

      ![](media/Aspose.Words.33fe436c-c1b3-4947-a292-794105a149f8.011.png)

      El diagrama de actividades describe el flujo de trabajo del sistema a través de una serie de pasos o actividades que se realizan en secuencia. En este caso, muestra el proceso de recopilación, validación y análisis de los datos de salud estudiantil, que luego se visualizan en dashboards interactivos. Este diagrama es crucial para entender cómo fluye la información y las decisiones dentro del sistema.



1. <a name="_heading=h.1pxezwc"></a>Vista de Despliegue (vista física)

   1. ### <a name="_heading=h.49x2ik5"></a>Diagrama de despliegue

      Este diagrama muestra cómo los diferentes componentes del sistema están distribuidos en la infraestructura física. Incluye detalles sobre la ubicación de los servidores, bases de datos, aplicaciones y usuarios, y cómo se comunican entre sí. El diagrama de despliegue es útil para entender cómo se implementará el sistema en el entorno real y cómo interactuarán los componentes físicos.



1. # <a name="_heading=h.2p2csry"></a>**ATRIBUTOS DE CALIDAD DEL SOFTWARE**

*[Los Atributos de Calidad (QAs) son propiedades medibles y evaluables de un sistema, estas propiedades son usadas para indicar el grado en que el sistema satisface las necesidades de los stakeholders   [Wojcik  2013].*

*Los QAs además son concebidos como aquellos requerimientos que no son funcionales. De hecho, la funcionalidad es mayormente ortogonal a los QAs; un diseño puede cumplir con la funcionalidad deseada y fallar a la hora de satisfacer sus requerimientos de calidad. De esta manera, se entiende a la funcionalidad como la capacidad del sistema para hacer el trabajo para el cual fue pensado, independientemente de la estructura. Existen QAs mayormente usados que se suelen identificar en numerosos sistemas y se tienen que describir, aunque la lista no es fina ya que muy a menudo hay situaciones en que podrían identificarse y proponerse nuevas propiedades para las diversas necesidades de stakeholders.]* 

*.*

<a name="_heading=h.147n2zr"></a>**Escenario de Funcionalidad**

<a name="_heading=h.ulpx5jl3r290"></a> **El sistema proporciona funcionalidades intuitivas para consultas de datos..**

*[se califica de acuerdo con el conjunto de características y capacidades del programa, la generalidad de las funciones que se entregan y la seguridad general del sistema.]*

<a name="_heading=h.3o7alnk"></a>**Escenario de Usabilidad**

<a name="_heading=h.kjuv4xmjwp0m"></a> **Interfaces diseñadas para minimizar el tiempo de aprendizaje**

*[Este atributo de calidad se refiere a la facilidad con la que un usuario puede aprender a utilizar e interpretar los resultados producidos por un sistema [Barbacci 1995]. Para este atributo de calidad, se suelen considerar diversos aspectos de la interacción humano computadora, tales como: aprendizaje del sistema, utilización eficiente del sistema, minimización del impacto de errores, adaptación del sistema a las necesidades del usuario, confianza y satisfacción, entre otros.]*

<a name="_heading=h.23ckvvd"></a>**Escenario de confiabilidad**

<a name="_heading=h.17q8f25qt683"></a>**Seguridad basada en roles y cumplimiento normativo.**

*[Es el equilibrio entre la confidencialidad, la integridad, la irrefutabilidad y la disponibilidad de la información y datos manipulados por el sistema. Se trata del estado de un sistema, el cual puede ser transitorio y volátil. La seguridad de un sistema se caracteriza por mecanismos y técnicas empleados para intentar reducir los más posible el impacto provocado por un ataque, y las amenazas (entendidas como los caminos mediante los cuales se pueden provocar un ataque).*

*Abarca los planos de observación físico, lógico y humanos. Posee tres tipos de enfoque: prevención, precaución y reacción.]*

<a name="_heading=h.ihv636"></a>**Escenario de rendimiento**

<a name="_heading=h.x6by1x35kotl"></a>**Respuestas rápidas en consultas complejas.**

*[Se mide con base en la velocidad de procesamiento, el tiempo de respuesta, el uso de recursos, el conjunto y la eficiencia.] (Pressman 2010, pág. 187)*


<a name="_heading=h.32hioqz"></a>**Escenario de mantenibilidad**

<a name="_heading=h.vb09l6prn63r"></a>**Documentación extensiva y arquitectura modular**

*[Combina la capacidad del programa para ser ampliable (extensibilidad), adaptable y servicial. (Pressman 2010, pág. 187)*

<a name="_heading=h.1hmsyys"></a>**Otros Escenarios**

*[“Otros escenarios como por ejemplo: Performance”*

***Performance**: El atributo de calidad Performance se refiere a la capacidad de responder, ya sea el tiempo requerido para responder a eventos determinados, o bien, la cantidad de eventos procesados en un intervalo de tiempo dado. La Performance caracteriza la proyección en el tiempo de los servicios entregados por el sistema.]*




