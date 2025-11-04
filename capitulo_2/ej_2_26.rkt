#lang racket

(define x (list 1 2 3))
(define y (list 4 5 6))

(append x y) ; '(1 2 3 4 5 6) Fusiona ambas listas 
(cons x y) ; '((1 2 3) 4 5 6) Añade a la segunda lista la primera lista como un elemento
(list x y) ; '((1 2 3) (4 5 6)) Crea una lista de listas
