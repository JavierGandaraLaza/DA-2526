#lang racket

; Versión para streams de map. Lee el primer elemento de cada stream, aplica la función, construye un nuevo stream y continúa con los restos.
(define (stream-map proc . ss)
  (if (stream-empty? (car ss))
      empty-stream
      (stream-cons (apply proc (map stream-first ss))
                   (apply stream-map proc (map stream-rest ss)))))

; Stream infinito definido recursivamente: empieza en 1 y el resto es sumar 1 a cada número anterior.
(define integers
  (stream-cons 1
               (stream-map (lambda (x) (+ x 1))
                           integers)))

; Combina dos streams multiplicando sus elementos uno a uno.
(define (mul-streams s1 s2)
  (stream-cons
    (* (stream-first s1) (stream-first s2))
    (mul-streams (stream-rest s1) (stream-rest s2))))

; Usa la relación recursiva n! = n × (n-1)! y streams infinitos. El primer valor es 1, y el resto se
; obtiene multiplicando el stream de enteros por el propio stream de factoriales.
(define factorials
  (stream-cons
    1
    (mul-streams integers factorials)))

(stream-ref factorials 0) ; → 1   = 1!
(stream-ref factorials 1) ; → 1   = 1!
(stream-ref factorials 2) ; → 2   = 2!
(stream-ref factorials 3) ; → 6   = 3!
(stream-ref factorials 4) ; → 24  = 4!
(stream-ref factorials 5) ; → 120 = 5!

