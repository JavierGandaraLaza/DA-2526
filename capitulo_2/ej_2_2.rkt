#lang racket

; Constructor para un punto
(define (make-point x y)
  (cons x y))

; Selectores para obtener las coordenadas x e y de un punto
(define (x-point p)
  (car p)) ; Primer elemento del par

(define (y-point p)
  (cdr p)) ; Segundo elemento del par

; Constructor para un segmento
(define (make-segment start end)
  (cons start end))

; Selectores para obtener el punto de inicio y el punto final de un segmento
(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

; Función para calcular el punto medio de un segmento
(define (midpoint-segment s)
  ; Obtener los puntos de inicio y fin
  (let ((start (start-segment s))
        (end (end-segment s)))
    ; Devolver el punto medio
    (make-point
     (/ (+ (x-point start) (x-point end)) 2)
     (/ (+ (y-point start) (y-point end)) 2))))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

; Ejemplo de uso
(define p1 (make-point 0 0))
(define p2 (make-point 4 5))
(define segment (make-segment p1 p2))

(print-point (midpoint-segment segment))

(define p3 (make-point -2 0))
(define p4 (make-point 10 -7))
(define segment1 (make-segment p3 p4))

(print-point (midpoint-segment segment1))


