#lang racket
; Bob's box
(define (bob-make-box x y w h)
  (cons (cons x y) (cons w h)))

(define (bob-width box)
   (car (cdr box)))

(define (bob-height box)
   (cdr (cdr box)))

(define (bob-area box)
    (* (bob-width box) (bob-height box)))

; Alice's box
(define (alice-make-box x1 y1 x2 y2)
 (cons (cons x1 y1) (cons x2 y2)))

(define (alice-width box)
   (abs (- (car (cdr box))
           (car (car box)))))

(define (alice-height box)
   (abs (- (cdr (cdr box))
           (cdr (car box)))))

(define (alice-area box)
    (* (alice-width box) (alice-height box)))


;Estructura a comprobar:
(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))
(alice-area a) ;4
(bob-area b) ;12
a        ;-> '((1 . 2) 3 . 4)
b        ;-> '((1 . 2) 3 . 4)

;Aunque Bob y Alice representan las cajas de manera diferente en concepto, ambos construyen exactamente la misma estructura interna de datos porque usan la misma expresión basada
;en cons: (cons (cons x y) (cons w h)) o (cons (cons x1 y1) (cons x2 y2)). Esto hace que tanto bob-make-box como alice-make-box produzcan la misma forma en memoria, es decir la
;estructura ((1 . 2) 3 . 4). En los dos casos el car del box contiene el par (1 . 2) y el cdr contiene el par (3 . 4). el área calculada es distinta porque Bob y Alice
;interpretan esos mismos números de forma diferente: para Bob, 3 es el ancho y 4 la altura, mientras que para Alice son las coordenadas opuestas x2 y y2, y su ancho y altura reales
;se calculan restando las coordenadas iniciales (|3−1| y |4−2|). Por eso alice-area produce 4 y bob-area produce 12 aunque la estructura impresa sea idéntica. 