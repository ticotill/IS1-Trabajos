# Ejercicio: Números de Peano

Analizar la definición axiomática de Peano de los números naturales (https://es.wikipedia.org/wiki/Axiomas_de_Peano)


Habiendo leído los axiomas intente representar los números de Peano con objetos y mensajes.


Llame al primer número I, al segundo número II, al tercero III y así

sucesivamente.



El protocolo a implementar es el siguiente:

previous

 next

+ unNumeroDePeano 

- unNumeroDePeano

* unNumeroDePeano

/ unNumeroDePeano


Aclaraciones:


Cuando al II se le envíe el mensaje next, automáticamente se debe crear el III si aún no existe y así sucesivamente. Lo mismo con las demás operaciones.

(por ejemplo II * II generará el III y el IIII si aún no están representados y retornará el IIII).


Para la división, puede definirla de modo que retorne la parte natural (IIII/III retorna I) o bien que solo funcione para divisiones de resultado natural y cuando se pretende dividir números que no se dividen haya un error (ej IIII/III genera un error).




