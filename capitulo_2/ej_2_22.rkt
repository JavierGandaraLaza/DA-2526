#lang racket

(define (square x)
  (* x x))

; El primer intento de Louis produce la lista de cuadrados en orden inverso porque utiliza cons para pre-cargar la lista
; answer en cada paso de la iteración. En cada paso, (square (car things)) se convierte en el primer elemento de la nueva
; lista answer, y la antigua lista answer se convierte en el resto de la nueva lista.
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items null))

(square-list (list 1 2 3 4))

; El segundo intento de Louis falla porque la función cons no puede usarse de esa manera para construir una lista, ya que
; viola la estructura fundamental de una lista en Lisp/Scheme. La funcion (cons A B) espera que B sea una lista y A debe
; ser un elemento que se convertira en el primer item de la nueva lista. 
; En esta definicion answer es la lista y (square (car things)) el elemento
(define (square-list-2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square 
                     (car things))))))
  (iter items null))

(square-list-2 (list 1 2 3 4))