#lang racket

(define (square x)
  (* x x))
  
(define (square-list items)
  (if (null? items)
      null
      ; 1. (square (car items)) -> el cuadrado del primer elemento
      ; 2. (square-list (cdr items)) -> el cuadrado del resto de elementos
      (cons (square (car items)) (square-list (cdr items)))))

(define (square-list-2 items)
  ; Procedimiento: square, List: items
  (map square items))

(square-list (list 1 2 3 4))
(square-list-2 (list 1 2 3 4))
