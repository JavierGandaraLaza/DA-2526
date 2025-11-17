#lang racket
;Funciones generales de type-tags
(define (attach-tag tag contents)
  (cons tag contents))

(define (type-tag datum)
  (car datum))

(define (contents datum)
  (cdr datum))

; Registry global 
(define registry (make-hash))

(define (register name tag proc)
  (hash-set! registry (list name tag) proc))

(define (lookup name tag)
  (hash-ref registry (list name tag)))

;Namespace para Bob
(define (import-bob-box)
  ;Funciones específicas de Bob dentro del namespace
  (define (width box)
    (car (cdr (contents box))))
  
  (define (height box)
    (cdr (cdr (contents box))))
  
  (define (area box)
    (* (width box) (height box)))
  
  ; Registrar funciones en el registry
  (register 'width 'bob-box width)
  (register 'height 'bob-box height)
  (register 'area 'bob-box area)
  
  ; Función para crear cajas de Bob (opcionalmente se puede incluir aquí)
  (define (make-box x y w h)
    (attach-tag 'bob-box (cons (cons x y) (cons w h))))
  
  ; Devolver el constructor para que pueda usarse fuera
  make-box)

;Namespace para Alice
(define (import-alice-box)
  ; Funciones específicas de Alice dentro del namespace
  (define (width box)
    (abs (- (car (cdr (contents box)))
            (car (car (contents box))))))
  
  (define (height box)
    (abs (- (cdr (cdr (contents box)))
            (cdr (car (contents box))))))
  
  (define (area box)
    (* (width box) (height box)))
  
  ; Registrar funciones en el registry
  (register 'width 'alice-box width)
  (register 'height 'alice-box height)
  (register 'area 'alice-box area)
  
  ; Función para crear cajas de Alice
  (define (make-box x1 y1 x2 y2)
    (attach-tag 'alice-box (cons (cons x1 y1) (cons x2 y2))))
  
  make-box)

; Import explícito de namespaces
(define bob-make-box (import-bob-box))
(define alice-make-box (import-alice-box))

;Funciones genéricas
(define (width box)
  ((lookup 'width (type-tag box)) box))

(define (height box)
  ((lookup 'height (type-tag box)) box))

(define (area box)
  ((lookup 'area (type-tag box)) box))

;Pruebas
(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

(width a)   ; -> 2
(width b)   ; -> 3
(height a)  ; -> 2
(height b)  ; -> 4
(area a)    ; -> 4
(area b)    ; -> 12

; Estructuras con tags
a ; -> '(alice-box ((1 . 2) 3 . 4))
b ; -> '(bob-box ((1 . 2) 3 . 4))

; Verificación de tipos
(type-tag a) ; -> 'alice-box
(type-tag b) ; -> 'bob-box


;En este ejercicio hemos mejorado la organización del código mediante “namespaces” simulados:
;1.Las funciones específicas de cada tipo de caja (width, height, area) se definen como procedimientos internos dentro de import-bob-box y import-alice-box.
;2.Estas funciones se registran en el registry global para que las funciones genéricas puedan hacer dispatch automáticamente según el type-tag del objeto.
;3.Los constructores bob-make-box y alice-make-box también se definen dentro de sus respectivos namespaces y se devuelven como resultado de la función import, evitando que los
;nombres internos se filtren al espacio global.
;4.Las funciones genéricas width, height y area ahora funcionan igual que antes, pero sin depender de nombres globales específicos de Bob o Alice.
;5.Se puede agregar un nuevo tipo de caja creando un namespace similar y registrando sus funciones, sin tocar las funciones genéricas ni ensuciar el espacio de nombres global.