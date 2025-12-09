#lang racket

;Ejercicio 3.22
;Se busca construir una cola (queue) como objeto con estado interno, usando un procedimiento que encierre en un entorno local dos punteros MUTABLES:
;front-ptr : apunta al primer par de la cola
;rear-ptr  : apunta al último par
;La cola se representa como una lista mutable ordinaria construida con mcons.

(define (make-queue)
  (let ((front-ptr null)
        (rear-ptr null))
;Cada llamada a (make-queue) crea una nueva cola independiente, con sus propias variables privadas front-ptr y rear-ptr.

    ;insert-queue!: Inserta un nuevo elemento x al final de la cola.
    ;Caso 1: la cola está vacía, ambos punteros deben apuntar al nuevo nodo.
    ;Caso 2: la cola tiene elementos enlazamos rear-ptr.cdr al nuevo nodo y actualizamos rear-ptr.
    (define (insert-queue! x)
      (let ((new (mcons x null)))
        (cond
          [(null? front-ptr)
           ;La cola estaba vacía:
           (set! front-ptr new)
           (set! rear-ptr new)]
          [else
           ;Cola no vacía:
           ;rear → new
           (set-mcdr! rear-ptr new)
           (set! rear-ptr new)])
        front-ptr)) ;devolvemos el inicio


    ;delete-queue!: Extrae el primer elemento de la cola.
    ;Si la cola está vacía: error.
    ;Si hay elementos: guardamos el nodo front actual, avanzamos front-ptr a su cdr, si la cola queda vacía, rear-ptr = null y devolvemos el valor almacenado en el nodo extraído
    (define (delete-queue!)
      (cond
        [(null? front-ptr)
         (error "Queue is empty")]
        [else
         (let ((old front-ptr))
           ;avanzar el puntero frontal
           (set! front-ptr (mcdr front-ptr))
           ;si quedó vacía, rear también debe ser null
           (when (null? front-ptr)
             (set! rear-ptr null))
           ;devolver el valor del nodo eliminado
           (mcar old))]))


    ;front-queue: Devuelve solo el valor de front-ptr sin alterar la cola.
    (define (front-queue)
      (if (null? front-ptr)
          (error "Queue empty")
          (mcar front-ptr)))


    ;print-queue: Devuelve directamente front-ptr, permitiendo inspeccionar la lista mutable completa.
    (define (print-queue)
      front-ptr)


    ;Este procedimiento decide qué operación devolver según el mensaje m recibido.
    (define (dispatch m)
      (cond
        [(eq? m 'insert!) insert-queue!]
        [(eq? m 'delete!) delete-queue!]
        [(eq? m 'front) front-queue]
        [(eq? m 'print) print-queue]
        [else (error "Unknown queue operation" m)]))

    ;devolvemos el objeto-cola
    dispatch))


;EJEMPLO DE USO:
(define q (make-queue))
((q 'insert!) 10) ;encola 10
((q 'insert!) 20) ;encola 20
((q 'insert!) 30) ;encola 30

((q 'front)) ; ->10
((q 'delete!)) ; ->10 (cola ahora: 20 → 30)

((q 'print)) ;->estructura mcons que comienza en 20
;Cada (make-queue) crea una cola completamente independiente, con su propio estado interno.

