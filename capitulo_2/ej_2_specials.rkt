#lang racket
(define (TRUE x y) x)
(define (FALSE x y) y)

; NOT
; si b es TRUE, retorna FALSE
; si b es FALSE, retorna TRUE
(define (NOT b)
  (b FALSE TRUE))

; AND
; si x es TRUE, retorna y (depende de y porque x sabemos cierto)
; si x es FALSE, retorna FALSE
(define (AND x y)
  (x y FALSE))

; OR
; si x es TRUE, retorna TRUE
; si x es FALSE, retorna y (depende de y porque x sabemos falso)
(define (OR x y)
  (x TRUE y))

; Example
(NOT TRUE)         ;-> FALSE
(NOT FALSE)        ;-> TRUE
(AND TRUE TRUE)    ;-> TRUE
(AND TRUE FALSE)   ;-> FALSE
