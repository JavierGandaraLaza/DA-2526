#lang racket
(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq 
  (stream-map 
   accum 
   (stream-enumerate-interval 1 20)))

(define y (stream-filter even? seq))

(define z 
  (stream-filter 
   (lambda (x) 
     (= (remainder x 5) 0)) seq))

(stream-ref y 7)
(display-stream z)

; Valor de sum despues de cada expresion               sum
; definicion inicial                                    0
; definicion de accum                                   0
; definicion de seq                                     0
; definicion de y                                       0
; definicion de z                                       0
; despues de (stream-ref y 7)                          136
; despues de (display-stream z)                        210

; Cambiaria dramaticamente si no usamos memoizacion.
; Si usamos (lambda () <exp>), sin memoizacion cada vez que un elemento stream
; es demandado, recomputa <exp>. Por lo tanto, cada vez que y o z sean parte de seq, todos
; los elementos previos de seq tienen que ser recalculados. Sum sería mucho mas grande.

; Con memoizacion cada elemento stream de seq es calculado una vez y cada valor actuaria como
; en una cache.
; Sin memoizacion los resultados son los mismos pero sum seria mucho mas grande.