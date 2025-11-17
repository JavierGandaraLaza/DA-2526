#lang racket
; Ejercicio 2.38

;(define (fold-left op initial sequence)
;  (define (iter result rest)
;    (if (null? rest)
;        result
;        (iter (op result (car rest))
;              (cdr rest))))
;  (iter initial sequence))


; a)
; (fold-right / 1 (list 1 2 3))
; (op 1(op 2(op 3 1)))
; (/1 (/2 (/31)))
; (/1(2/3))
; Resultado = 3/2

; b)
; (fold-left / 1 (list 1 2 3))
; (/(/(/11)2)3)
; (/1/23)
; Resultado = 1/6

; c)
; (fold-right list nil (list 1 2 3))
; (list1(list2(list3nil)))
; (3 nil), (2 (3 nil)), (1 (2 (3 nil)))
; Resultado = (1 (2 (3 ())))

; d)
; (fold-left  list nil (list 1 2 3))
; (list(list(listnil1)2)3)
; (() 1), ((() 1) 2), ((( () 1 ) 2) 3)
; Resultado = ((( () 1 ) 2) 3)
