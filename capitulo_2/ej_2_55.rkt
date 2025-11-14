#lang racket
;Cuando se evalúa la expresión (car ''abracadabra), lo que ocurre puede entenderse usando únicamente las reglas de citación que explican que el símbolo ' es un mecanismo de
;citación cuyo significado es “citar el siguiente objeto”, exactamente como si se hubiera escrito (quote objeto) 
;Por ejemplo, el archivo muestra que '(a b c) equivale a (quote (a b c)) y que (car '(a b c)) devuelve el primer elemento de la lista, el símbolo a, sin evaluarlo,
;precisamente porque la citación evita la evaluación del objeto 
;Aplicando esa misma regla, la expresión ''abracadabra implica dos operaciones de citación consecutivas. Según la definición del archivo, cada ' cita el objeto que le sigue;
;por lo tanto, la primera comilla cita el símbolo abracadabra y la segunda cita el objeto resultante de esa operación. Así, ''abracadabra se transforma en:(quote (quote abracadabra))
;Esto significa que el objeto pasado a car es la lista cuyo primer elemento es el símbolo quote y cuyo segundo elemento es el símbolo abracadabra. 
;Por tanto, al aplicar car a (quote (quote abracadabra)), el primer elemento de esa lista es el símbolo quote y ese es exactamente el valor que el intérprete devuelve.

(car ''abracadabra)