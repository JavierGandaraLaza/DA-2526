#lang racket
;Ejercicio 3.16:
;Ben propone una función count-pairs que intenta contar pares en cualquier estructura. El problema es que si existen referencias compartidas, ramas múltiples que vuelven a los mismos
;pares y ciclos, entonces se cuentan pares repetidos o se entra en recursión infinita.
(define (count-pairs x)
  (if (not (mpair? x))
      0
      (+ (count-pairs (mcar x))
         (count-pairs (mcdr x))
         1)))

;1.Estructura que devuelve 3:
(define three-correct
  (mcons 'a
         (mcons 'b
                (mcons 'c null))))

;Esta estructura es una lista completamente lineal, sin compartición ni ciclos. Contiene exactamente tres pares: p1 → (a . p2), p2 → (b . p3), p3 → (c . '()) count-pairs visita cada
;par exactamente una vez. El valor esperado es 3.

;2.Estructura que devuelve 4:
(define shared
  (let* ((p3 (mcons 'z null))
         (p2 (mcons 'y p3))
         (p1 (mcons 'x p2)))
    ;Añadimos compartición: p1.car apunta también al mismo p3
    (set-mcar! p1 p3)
    p1))

;Aunque hay sólo tres pares (p1, p2, p3), count-pairs re-traversa p3 dos veces: p1 = (p3 . p2), p2 = (y . p3), p3 = (z . '()). Los caminos explorados por count-pairs son
;desde p1.car → p3, desde p1.cdr → p2 → p3. p3 se cuenta dos veces, totalizando 4 pares. El valor esperado en este caso es 4

;3.Estructura que devuelve 7:
(define seven
  (let* ((p1 (mcons 'x 'dummy))
         (p2 (mcons 'y 'dummy))
         (p3 (mcons 'a 'dummy)))
    ;reconfiguración para provocar varias duplicaciones
    (set-mcar! p1 p2)
    (set-mcdr! p1 p3)
    (set-mcar! p2 p3)
    (set-mcdr! p2 null)
    (set-mcdr! p3 p2)
    p1))

;Solo hay tres pares, pero están conectados de forma que count-pairs los reexplora repetidamente: p1 = (p2 . p3), p2 = (p3 . '()), p3 = ('a . p2)
;count-pairs sigue muchos caminos redundantes: desde p1.car → p2 → p3 → p2 → ...; desde p1.cdr → p3 → p2 → ...; La estructura NO es cíclica en cuanto a mcdr (excepto p3 → p2 por car),
;pero count-pairs sigue ambos campos. Esto produce 7 visitas totales.

;4.Estructura que nunca termina: 
(define infinite-loop
  (let* ((p1 (mcons 'x 'dummy))
         (p2 (mcons 'y 'dummy)))
    (set-mcdr! p1 p2)
    (set-mcdr! p2 p1)  ;ciclo
    p1))

;Aquí sí hay un ciclo real en el cdr: p1 → p2 → p1 → p2 → ...; count-pairs sigue mcdr siempre, y al no haber corte, recorre un ciclo infinito. Resultado: NUNCA TERMINA.

;Pruebas:
;Debe devolver 3
(count-pairs three-correct)

;Debe devolver 4
(count-pairs shared)

;Debe devolver 7
(count-pairs seven) ; Esta estructura no devuelve 7 porque forma un ciclo entre p2 y p3 a través de car/cdr. count-pairs vuelve a esos mismos pares una y otra vez y entra en recursión
;infinita.

;NO ejecutar: bucle infinito
; (count-pairs infinite-loop)