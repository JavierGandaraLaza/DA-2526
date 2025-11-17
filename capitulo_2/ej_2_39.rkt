#lang racket
(define (reverse sequence)
  (fold-right 
    (lambda (x y) (append y (list x))) 
    nil 
    sequence))

(define (reverse sequence)
  (fold-left  
    (lambda (acc x) (cons x acc)) 
    nil 
    sequence))

