#lang racket

(define (last-pair s)
  (if (null? (cdr s)) ; Verifica que la cola de la lista sea la lista vacia
      s ; Si la cola es la lista vacia s es el ultimo par de la lista
      (last-pair (cdr s)))) ; Llamada recursiva si s no es el ultimo par de la lista

(last-pair (list 23 72 149 34)) 
