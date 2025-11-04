#lang racket

(define (same-parity first . rest)
  ; Determina la paridad del primer elemento
  (let ((is-first-even (even? first)))
    (define (same-parity? n)
      ; Determina si la paridad del elemento actual es igual que la del primero
      (eqv? is-first-even (even? n)))
    (cons first
          ; Sigue con el resto de elementos
          (filter same-parity? rest)))) 

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)