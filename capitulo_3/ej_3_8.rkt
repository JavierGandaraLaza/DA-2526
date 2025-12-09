#lang racket

;; Ejercicio 3.8 — Comprobación de orden de evaluación

;; f: devuelve x la primera vez, 0 la segunda
(define called #f)

(define (f x)
  (display "llamando f con -> ")
  (display x)
  (newline)
  (if called
      0
      (begin
        (set! called #t)
        x)))


;; PRUEBAS

(displayln "   Prueba 1: evaluación izquierda → derecha")
(displayln "   (+ (f 0) (f 1))")

(set! called #f) 
(display "Resultado: ")
(displayln (+ (f 0) (f 1)))
(newline)

(displayln "   Prueba 2: evaluación derecha → izquierda")
(displayln "   (+ (f 1) (f 0))")

(set! called #f) 
(display "Resultado: ")
(displayln (+ (f 1) (f 0)))
(newline)