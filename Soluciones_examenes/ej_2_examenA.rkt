#lang racket
(define (reduce f lista) ; Esta es una función de orden alto
                         ; donde f es una función
     (if (null? (cdr lista))
                (car lista)
                (f (car lista) (reduce f (cdr lista)))))


(define (reduce-iter f lista resultado)
  (if (null? lista)
      resultado
      (reduce f (cdr lista) (f (car lista) resultado))))