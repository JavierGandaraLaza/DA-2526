#lang racket

(define (make-monitored f)
  (let ((count 0))
    (lambda (x)
      (cond ((eq? x 'how-many-calls?) count)       ;Para devolve el numero de operaciones que se llavan contadas
            ((eq? x 'reset-count) (set! count 0)) ;Reseteo del contador de operaciones
            (else (set! count (+ count 1))        ;Aumento el contador de operaciones y ejecuto la funcion con el parametro de entrada
                  (f x))))))

(define s (make-monitored sqrt))            ;Ejemplo con raiz cuadrada

(s 100)               ;10
(s 'how-many-calls?)   ;1
(s 25)                ;5
(s 'how-many-calls?)   ;2
(s 'reset-count)      ;Reseteo el contador   
(s 'how-many-calls?)   ;0
