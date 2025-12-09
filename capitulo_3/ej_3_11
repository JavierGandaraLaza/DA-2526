#lang racket
(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance 
                     (- balance 
                        amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request: 
                        MAKE-ACCOUNT" 
                       m))))
  dispatch)

(define acc (make-account 50))

((acc 'deposit) 40)
;;90

((acc 'withdraw) 60)
;;30

(define acc2 (make-account 100))

((acc2 'deposit) 40)
;;140

((acc2 'withdraw) 60)
;;80

;;Where is the local state for acc kept?
;;El estado de acc se encuentra en el frame creado al llamar a make-account (acc)

;;How are the local states for the two accounts kept distinct? Which parts of the environment structure are shared between acc and acc2?
;;acc y acc2 tienen su propio entorno, por lo que los valores de las variables se guardan de forma separada.
;;Solo tienen en común el ambiente global donde está definido el código de make-account.
