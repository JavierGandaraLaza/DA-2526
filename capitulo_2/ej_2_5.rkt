#lang racket

; Empaqueta a y b en un unico entero N = 2^a * 3^b
(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

; Extrae el primer elemento a del par codificado N. Lo hace contando cuantas veces se puede
; dividir N por 2 de forma exacta
(define (car n)
  (define (count-divisions-by-2 x)
    (if (zero? (remainder x 2))
        (+ 1 (count-divisions-by-2 (/ x 2)))
        0))
  (count-divisions-by-2 n))

; De la misma forma cuenta las veces que se puede dividir N por 3 de forma exacta
(define (cdr n)
  (define (count-divisions-by-3 x)
    (if (zero? (remainder x 3))
        (+ 1 (count-divisions-by-3 (/ x 3)))
        0))
  (count-divisions-by-3 n))

(define pair (cons 9 5))
(car pair)
(cdr pair)
