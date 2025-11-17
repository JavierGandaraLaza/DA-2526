#lang racket
;Bob's box usando message passing
(define (make-bob-box x y w h)
  (define (dispatch message)
    (cond ((eq? message 'width) w)
          ((eq? message 'height) h)
          ((eq? message 'area) (* w h))
          ((eq? message 'type) 'bob-box)
          (else (error "Unknown message" message))))
  dispatch)

;Alice's box usando message passing
(define (make-alice-box x1 y1 x2 y2)
  (define (dispatch message)
    (cond ((eq? message 'width) (abs (- x2 x1)))
          ((eq? message 'height) (abs (- y2 y1)))
          ((eq? message 'area) (* (abs (- x2 x1)) (abs (- y2 y1))))
          ((eq? message 'type) 'alice-box)
          (else (error "Unknown message" message))))
  dispatch)

;Funciones genéricas que envían mensajes
(define (width box)
  (box 'width))

(define (height box)
  (box 'height))

(define (area box)
  (box 'area))

(define (type-box box)
  (box 'type))

; Pruebas:
(define a (make-alice-box 1 2 3 4))
(define b (make-bob-box 1 2 3 4))

(width a)    ; -> 2  (ancho de Alice)
(height a)   ; -> 2  (altura de Alice)
(area a)     ; -> 4  (área de Alice)
(type-box a) ; -> 'alice-box

(width b)    ; -> 3  (ancho de Bob)
(height b)   ; -> 4  (altura de Bob)
(area b)     ; -> 12 (área de Bob)
(type-box b) ; -> 'bob-box

;En este enfoque:
;1.Cada caja es una función que recibe un "mensaje" como argumento.
;2.Dependiendo del mensaje, devuelve el valor correspondiente:
;'width -> ancho
;'height -> altura
;'area -> área
;'type -> tipo de caja
;3.Las funciones genéricas width, height y area simplemente envían el mensaje apropiado a la caja, sin necesidad de type-tags ni tablas de dispatch externas.
