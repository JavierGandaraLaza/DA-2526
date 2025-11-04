#lang racket

(define x 
  (list (list 1 2) (list 3 4)))

(define (reverse s)
  (if (null? s)
      null
      ; La funcion append junta dos o mas listas. En este caso pone el resultado de la recursion
      ; (la lista revertida sin el primer elemento) antes del elemento actual
      (append (reverse (cdr s)) (list (car s)))))

(define (deep-reverse s)
  (if (null? s)
      null
      (append (deep-reverse (cdr s))
              ; Antes de añadir el primer elemento (car s) al resultado, comprueba si ese elemento es en sí mismo una lista
              (list (if (list? (car s))
                  ; Si es una lista la sublista se invierte
                  (deep-reverse (car s))
                  ; Si no lo es devuelve el elemento sin modificar
                  (car s))))))

(reverse x)
(deep-reverse x)


