#lang racket

(define s (stream-cons 1 (add-streams s s)))

; El primer elemento de s es 1.
; La cola del stream es (add-streams s s), es decir, la suma punto a punto del stream consigo mismo.
; Por lo tanto, si s = (s0, s1, s2, s3, ...), entonces la cola es:
; (s0 + s0, s1 + s1, s2 + s2, ...) = (2·s0, 2·s1, 2·s2, ...)

; Con lo explicado tenemos que:

; Se empieza en 1.

; La cola es la suma del stream consigo mismo -> duplica cada término.

; Por tanto, es la secuencia de potencias de dos:

; 1
; 1 + 1 = 2
; 2 + 2 = 4 = 2^2
; 4 + 4 = 8 = 2^3
; 8 + 8 = 16 = 2^4
; 16 + 16 = 32 = 2^5
; ...
