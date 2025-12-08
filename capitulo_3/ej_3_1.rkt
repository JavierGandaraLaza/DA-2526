#lang racket
(define (make-accumulator initial)
  (let ((sum initial))
    (lambda (x)
      (set! sum (+ sum x))
      sum)))

;Ejemplo
(define A (make-accumulator 5)) ;Acumulador que empieza con el valor 5

(A 10)   ; 5 + 10 = 15
(A 10)   ; 15 + 10 = 25
