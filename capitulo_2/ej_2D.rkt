#lang racket
;Funciones generales para manejar "tags":
(define (attach-tag tag contents)
  (cons tag contents))

(define (type-tag datum)
  (car datum))

(define (contents datum)
  (cdr datum))

;Bob's box con tag:
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


; Registro de procedimientos:
(define registry (make-hash)) ; Creamos el hash para registrar funciones

(define (register name tag proc)
  (hash-set! registry (list name tag) proc)) ; Guardamos en el hash

(define (lookup name tag)
  (hash-ref registry (list name tag)))       ; Buscamos en el hash

; Registro de las funciones específicas:
(register 'width 'bob-box bob-width)
(register 'height 'bob-box bob-height)
(register 'area 'bob-box bob-area)

(register 'width 'alice-box alice-width)
(register 'height 'alice-box alice-height)
(register 'area 'alice-box alice-area)

;Funciones genéricas usando la tabla:
(define (width obj)
  ((lookup 'width (type-tag obj)) obj))

(define (height obj)
  ((lookup 'height (type-tag obj)) obj))

(define (area obj)
  ((lookup 'area (type-tag obj)) obj))

;Pruebas
(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

(width a)   ; -> 2
(width b)   ; -> 3
(height a)  ; -> 2
(height b)  ; -> 4
(area a)    ; -> 4
(area b)    ; -> 12

;Estructuras con tags
a ; -> '(alice-box ((1 . 2) 3 . 4))
b ; -> '(bob-box ((1 . 2) 3 . 4))

;Ahora tenemos un registro (registry) que asocia cada tipo de objeto con sus funciones específicas.
; 
; Ventajas:
; 1. Las funciones genéricas width, height y area no están fijo a tipos específicos.
; 2. Para agregar un nuevo tipo de caja, solo necesitamos: Crear el tipo y sus funciones específicas, registrar sus funciones en el hash con register y automáticamente las funciones
;genéricas funcionarán con el nuevo tipo. Esto hace que el código sea fácil de extender con nuevos tipos sin modificar las funciones genéricas existentes.
;La elección ahora se realiza **consultando la tabla (registry)**:
;width(a): busca en registry el par ('width 'alice-box) -> devuelve alice-width -> llama a alice-width(a)
;width(b): busca ('width 'bob-box) -> devuelve bob-width -> llama a bob-width(b)