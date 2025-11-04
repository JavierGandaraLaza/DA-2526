#lang racket

(define x 
  (list (list 1 2) (list 3 4)))

(define (fringe t)
  (cond
    ((null? t) null)
    ; Si el elemento actual no es una lista la función lo envuelve en una nueva lista de un solo elemento y lo devuelve
    ((not (list? t)) (list t))
    ; Si no hace que los elementos sean listas para que append pueda combinarlas
    (else (append (fringe (car t))
                  (fringe (cdr t))))))

(fringe x) ; (1 2 3 4)
(fringe (list x x)) ; (1 2 3 4 1 2 3 4)
