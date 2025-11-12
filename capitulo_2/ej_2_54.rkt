#lang racket

(define (equal? a b)
  (cond
    ;Caso 1: ambos son símbolos
    ;Se comparan con eq?
    ((and (symbol? a) (symbol? b))
     (eq? a b))
    ;Caso 2: ambos son números
    ;Se comparan con =
    ((and (number? a) (number? b))
     (= a b))
    ;Caso 3: ambos son listas (pares)
    ;Se comparan recursivamente: los primeros elementos (car) y el resto de la lista (cdr)
    ((and (pair? a) (pair? b))
     (and (equal? (car a) (car b))
          (equal? (cdr a) (cdr b))))
    ;Caso 4: ambos son vacíos (listas nulas)
    ((and (null? a) (null? b))
     #t)
    ;Caso 5: si nada de lo anterior aplica, son diferentes
    (else #f)))
