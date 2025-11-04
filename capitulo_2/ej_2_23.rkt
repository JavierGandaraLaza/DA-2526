#lang racket

(for-each 
 (lambda (x) (newline) (display x))
 (list 57 321 88))
(newline)

(define (for-each-2 proc items)
  ; Si la lista esta vacia la recursion se detiene
  (if (null? items)
      (void) ; Si no hay elementos o se han mostrado todos se termina la función
      (begin
        ; Proc realiza una accion como display o newline
        (proc (car items))
        ; Llamada recursiva con el resto de elementos
        (for-each-2 proc (cdr items)))))

(for-each-2
 (lambda (x) (newline) (display x))
 (list 57 321 88))
