#lang racket

(define (reverse s)
  (if (null? s) ; Si la lista de entrada s es la lista vacía la función devuelve la lista vacía
      null
      ; 1. Construye la lista invertida de todos los elementos excepto el primero
      ; 2. Toma el primer elemento de la lista original y lo convierte en una lista de un solo elemento
      ; 3. Concatena la lista invertida  con la lista de un solo elemento
      (append (reverse (cdr s)) (list (car s)))))
      
(reverse (list 1 4 9 16 25))
