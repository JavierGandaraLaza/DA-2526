#lang racket
;; Ejercicio 3.9 — Análisis de entornos con factorial

;; Versión recursiva
(define (factorial-rec n)
  (displayln (string-append "factorial-rec llamado con n = "
                            (number->string n)))
  (if (= n 1)
      1
      (* n (factorial-rec (- n 1)))))

;; Versión iterativa
(define (fact-iter product counter max-count)
  (displayln (string-append "fact-iter: product = "
                            (number->string product)
                            ", counter = "
                            (number->string counter)
                            ", max = "
                            (number->string max-count)))
  (if (> counter max-count)
      product
      (fact-iter (* product counter)
                 (+ counter 1)
                 max-count)))

(define (factorial-iter n)
  (fact-iter 1 1 n))

;; PRUEBAS

(displayln "   Factorial recursivo de 6")
(factorial-rec 6)


(displayln "   Factorial iterativo de 6")
(factorial-iter 6)
