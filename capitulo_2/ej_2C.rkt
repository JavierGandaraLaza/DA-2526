#lang racket
;Funciones generales para manejar "tags"
(define (attach-tag tag contents)
  (cons tag contents))

(define (type-tag datum)
  (car datum))

(define (contents datum)
  (cdr datum))

;Bob's box con tag-
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

;Alice's box con tag
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

;Funciones genéricas usando dispatch basado en type-tags
(define (width b)
  (cond ((bob-box? b) (bob-width b))
        ((alice-box? b) (alice-width b))
        (else (error "Unknown box type"))))

(define (height b)
  (cond ((bob-box? b) (bob-height b))
        ((alice-box? b) (alice-height b))
        (else (error "Unknown box type"))))

(define (area b)
  (cond ((bob-box? b) (bob-area b))
        ((alice-box? b) (alice-area b))
        (else (error "Unknown box type"))))

;Pruebas:
(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

(width a)   ; -> 2  (ancho de Alice)
(width b)   ; -> 3  (ancho de Bob)
(height a)  ; -> 2  (altura de Alice)
(height b)  ; -> 4  (altura de Bob)
(area a)    ; -> 4  (área de Alice)
(area b)    ; -> 12 (área de Bob)

;Estructuras con tags
a   ; -> '(alice-box ((1 . 2) 3 . 4))
b   ; -> '(bob-box ((1 . 2) 3 . 4))


;Ahora tenemos funciones genéricas width, height y area que trabajan con cualquier tipo de caja. Se utiliza la estructura de "type tags" para determinar qué tipo de caja estamos
;recibiendo. Cada función genérica realiza una elección condicional:
;Si la caja es de Bob, llama a la función específica de Bob.
;Si la caja es de Alice, llama a la función específica de Alice.
;Si no reconoce el tipo, lanza un error.
; Esto permite trabajar con cajas de distinto tipo usando una única interfaz: (width b), (height b) y (area b) funcionan independientemente de si la caja es de Bob o Alice.
;
;Las estructuras internas siguen siendo idénticas:
;a -> '(alice-box ((1 . 2) 3 . 4))
;b -> '(bob-box ((1 . 2) 3 . 4))

