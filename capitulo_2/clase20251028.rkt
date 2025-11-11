#lang racket

;(define (cons x y)
;  (lambda (f) (f x y))) ; esta funcion lo que devuelve es una función de alto orden que simplemente evalua en el punto x y

;(define (car par)
;  (par (lambda (x y) x))) ; evalua la función par en otra función que lo que hace es devolver el primer argumento que se le pasa.

;(define (cdr par)
;  (par (lambda (x y) y))) ; devuelve el segundo elemento del par.


; Vamos a definir la funcion map
(define (map f lista)
  (if (null? lista)
      null
      (cons (f (car lista)) (map f (cdr lista)))))

(map (lambda (x) (* x x)) (list 1 2 3 4))

(define (reduce f init lst)
  (if (null? lst)
      init
      (reduce f (f init (car lst)) (cdr lst))))


(reduce + 0 (list 1 2 3 4))

(define (filter f lista)
  (if (null? lista)
      null
      (if (f (car lista))
          (cons (car lista) (filter f (cdr lista)))
          (filter f (cdr lista)))))

(filter odd? (list 1 2 3 5 68 9))

