#lang racket

; Calcula el MCD de dos números usando el algoritmo de Euclides.
; Necesario para simplificar la fracción.
(define (greatest-common-divisor a b)
  (if (= b 0)
      (abs a) ; Usamos abs para manejar correctamente números negativos si es necesario
      (greatest-common-divisor b (remainder a b))))

; make-rat mejorada
; Crea un número racional normalizado, manejando los signos.
(define (make-rat n d)
  (let* (
         ; Calcula el MCD de los valores absolutos
         [g (greatest-common-divisor n d)]

         ; Simplifica la fracción
         [new-n (/ n g)]
         [new-d (/ d g)]

         ; XOR de los signos -> si los signos de n y d son distintos el resultado es negativo
         [is-negative (not (= (sgn n) (sgn d)))]
        )
    (if is-negative
        ; Si es negativa: el numerador es negativo y el denominador es positivo
        (cons (- (abs new-n)) (abs new-d))
        ; Si es positiva: ambos son positivos
        (cons (abs new-n) (abs new-d))))
)



(displayln (make-rat 5 10)) ; (1 . 2)

(displayln (make-rat -5 10)) ; (-1 . 2)

(displayln (make-rat 5 -10)) ; (-1 . 2)

(displayln (make-rat -5 -10)) ; (1 . 2)
