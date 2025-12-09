#lang racket
(define (deriv exp var) ; La definición de deriva es una expresión con una variable
  (cond ((number? exp) 0) ; la derivada de un número es siempre cero
        ((variable? exp) ; Si es una variable
         (if (same-variable? exp var) 1 0)) ; La derivada es 1 si es la variable por la que derivadas y cero en otro caso
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var))) ; Si es una suma, la derivada es la suma de las derivadas
        ((product? exp)
         (make-sum
          (make-product 
           (multiplier exp)
           (deriv (multiplicand exp) var)); Si es un producto es la derivada del primero por el segundo sin derivar mas la derivada del segundo por el primero.
          (make-product 
           (deriv (multiplier exp) var)
           (multiplicand exp))))
        ((potencia? exp)
         (make-product (exponente exp)
                       (make-product
                        (make-potencia (funcion exp) (- (exponente exp) 1))
                        (deriv (funcion exp) var))))
        (else (error "unknown expression 
                      type: DERIV" exp))))




(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(define (potencia? exp) ; Las potencias exp= (** f n)
  (and (pair? exp) (eq? (car exp) '**) (number? (car (cdr (cdr exp))))))

(define (make-potencia exp n)
  (list '(** exp n)))

(define (exponente exp)
  (car (cdr (cdr exp))))
(define (funcion exp)
  (car (cdr exp)))
  
(define (make-sum a1 a2) (list '+ a1 a2))
(define (make-product m1 m2) (list '* m1 m2))
(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))

(define (augend s) (caddr s))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p) (caddr p))