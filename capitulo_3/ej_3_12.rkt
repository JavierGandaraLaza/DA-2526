#lang racket

(define x (mcons 'a (mcons 'b null)))
(define y (mcons 'c (mcons 'd null)))
(define z (append x y))

z
(mcons 'a (mcons 'b (mcons 'c (mcons 'd '()))))

(cdr x)
(x)

(define w (append! x y))

w
(mcons 'a (mcons 'b (mcons 'c (mcons 'd '()))))

(cdr x)
(b c d)

;;What are the missing ⟨response⟩s? Draw box-and-pointer diagrams to explain your answer.
;;Primer <response> -> (x)

;;Segundo <response> -> (b c d)
