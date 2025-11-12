#lang racket

(define (suma-menores lista ultimo penultimo)
  (if (null? lista)
      (+ ultimo penultimo)
      (suma-menores (cdr lista)
                    (if (< (car lista) ultimo) (car lista) ultimo)
                    (if (and (< (car lista) penultimo) (< (car lista) ultimo))
                        ultimo
                        (if (< (car lista) penultimo)
                            (car lista)
                            penultimo
                            )))))

(suma-menores (list 1 2 5 4 2 3) 10 10)