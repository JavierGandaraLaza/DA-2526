#lang racket
;Definicion de accumulate:
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

;Rellenamos los huecos del map: Queremos que cada elemento x se transforme en (p x) y que se añada delante de la lista ya acumulada y. Por eso usamos: (cons (p x) y)
;cons: mete un elemento delante de una lista
(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y))
              '()
              sequence))

; Ejemplo:
(display (map (lambda (x) (* x x)) '(1 2 3 4))) (newline) ; => (1 4 9 16)

;Rellenamos los huecos de append: Queremos añadir todos los elementos de seq1 antes de seq2. accumulate recorre seq1, así que el valor inicial es seq2.
;Y la secuencia a recorrer es seq1. 
(define (append seq1 seq2)
  (accumulate cons
              seq2   
              seq1)) 

; Ejemplo:
(display (append '(1 2) '(3 4))) (newline) ; => (1 2 3 4)


; Rellenamos los huecos de length: Solo necesitamos sumar 1 por cada elemento. La función combinadora ignora x y devuelve (+ 1 y).
(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y))
              0
              sequence))

; Ejemplo:
(display (length '(5 6 7 8 9))) (newline) ; => 5