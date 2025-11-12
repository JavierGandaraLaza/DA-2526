#lang racket
(define (maximo-repetido-aux lista ; la lista de números ordenada
                             mas-repetido ; el número que ha sido más veces repetido
                             mas-repeticiones ; el número de repeticiones del elemento mas-repetido
                             actual ; el elementos que vemos ahora
                             repeticiones ; el numero de repeticiones
                             )
  (if (null? lista) ; Si la lista esta vacia,
      (if (< mas-repeticiones repeticiones) actual mas-repetido)
      (if (= (car lista) actual) ; si el primero de la lista es igual al actual
          (maximo-repetido-aux (cdr lista) mas-repetido mas-repeticiones actual (+ repeticiones 1))
          (maximo-repetido-aux (cdr lista)
                               (if (< mas-repeticiones repeticiones) actual mas-repetido)
                               (if (< mas-repeticiones repeticiones) repeticiones mas-repeticiones)
                               (car lista) 1)
          )
      )
  )
  (maximo-repetido-aux (list 1 1 2 2 2 3 3 4 4 4 4) 0 0 0 0)

; Vamos a hacer un método de la substitución simplificado
; (maximo-repetido-aux (list 1 2 2 2 3 3 4 4 4 4) 1 1 1 1)
; (maximo-repetido-aux (list 2 2 2 3 3 4 4 4) 1 1 1 2)
; (maximo-repetido-aux (list 2 2 3 3 4 4 4) 1 2 2 1)
; (maximo-repetido-aux (list 2 3 3 4 4 4) 1 2 2 2) 
; (maximo-repetido-aux (list 3 3 4 4 4) 1 2 2 3)
; (maximo-repetido-aux (list 3 4 4 4) 2 3 3 1)

