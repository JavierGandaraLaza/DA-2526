#lang racket
;Funciones generales para manejar tags:
(define (attach-tag tag contents)
  (cons tag contents))

(define (type-tag datum)
  (car datum))

(define (contents datum)
  (cdr datum))

;Bob's box con tag
(define (bob-make-box x y w h)
  (attach-tag 'bob-box
              (cons (cons x y) (cons w h))))

(define (bob-box? b)
  (eq? (type-tag b) 'bob-box))

(define (bob-width b)
  (car (cdr (contents b))))

(define (bob-height b)
  (cdr (cdr (contents b))))

(define (bob-area b)
  (* (bob-width b) (bob-height b)))

; Alice's box con tag
(define (alice-make-box x1 y1 x2 y2)
  (attach-tag 'alice-box
              (cons (cons x1 y1) (cons x2 y2))))

(define (alice-box? b)
  (eq? (type-tag b) 'alice-box))

(define (alice-width b)
  (abs (- (car (cdr (contents b)))
          (car (car (contents b))))))

(define (alice-height b)
  (abs (- (cdr (cdr (contents b)))
          (cdr (car (contents b))))))

(define (alice-area b)
  (* (alice-width b) (alice-height b)))

;Pruebas:
(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

(alice-area a) ; -> 4
(bob-area b)   ; -> 12

; Estructuras con tags
a   ; -> '(alice-box ((1 . 2) 3 . 4))
b   ; -> '(bob-box ((1 . 2) 3 . 4))

;Ahora tanto Bob como Alice producen estructuras que incluyen un "tag" que indica el tipo de caja. Esto nos permite distinguir fácilmente entre cajas de Bob y cajas de Alice, incluso
;si su estructura interna es idéntica: ((1 . 2) 3 . 4).   Antes, no podíamos escribir una función genérica (width box) que funcionara con ambas, porque no había manera de saber si la
;caja era de Bob o de Alice.  
;Con los type tags: attach-tag coloca el tag al frente de la estructura, type-tag devuelve ese tag, contents devuelve la estructura interna sin el tag. Así, la estructura final es:
; a -> '(alice-box ((1 . 2) 3 . 4))
; b -> '(bob-box ((1 . 2) 3 . 4))
; El cálculo del área sigue funcionando correctamente porque las funciones alice-area y bob-area extraen correctamente los valores usando contents y aplican las fórmulas
;correspondientes y ahora podemos definir funciones que verifiquen el tipo de caja antes de operar sobre ella.
