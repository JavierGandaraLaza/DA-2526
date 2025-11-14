#lang racket
;Para poder construir un programa que calcule derivadas de expresiones matemáticas representadas como listas (por ejemplo '(+ x 3) o '(* x y)), primero es necesario que el
;programa pueda reconocer qué tipo de expresión está viendo. Las listas no son matemáticas para el programa, por lo que debemos crear funciones que identifiquen si una expresión
;es una suma, un producto, una variable o un número. Estas funciones son predicados y permiten al derivador decidir qué regla matemática usar.

;También necesitamos funciones que puedan extraer las partes de una expresión (selectores). Por ejemplo, si una suma se representa como '(+ x 3), necesitamos poder obtener x y 3
;por separado. Además, necesitamos constructores que creen nuevas expresiones cuando el derivador aplica reglas. Estos constructores incluyen pequeñas reglas de simplificación, como
;eliminar sumas con 0 o productos con 1, para que las expresiones derivadas sean más limpias.

;Una vez que el sistema puede manejar sumas, productos y variables, podemos extenderlo para manejar potencias, que el ejercicio pide que se representen como '(** base exponente).
;Para ello seguimos el mismo patrón: creamos un predicado para reconocer potencias, selectores para acceder a la base y al exponente, y un constructor que fabrique potencias nuevas
;aplicando simplificaciones, como que cualquier cosa elevada a 0 es 1 y cualquier cosa elevada a 1 es ella misma.

;Finalmente, añadimos una nueva regla al procedimiento de derivación (deriv) aplicando la fórmula matemática d(u^n)/dx = n * u^(n-1) * du/dx. Gracias a las funciones anteriores, esta
;regla se integra sin modificar lo demás. Con esto el programa ya puede derivar expresiones que incluyan sumas, productos y potencias, generando nuevas expresiones simbólicas
;con las reglas correctas.

;Variables y números:
(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

;Sumas:
(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))
(define (augend s) (caddr s))

(define (make-sum a1 a2)
  (cond [(=number? a1 0) a2]
        [(=number? a2 0) a1]
        [(and (number? a1) (number? a2)) (+ a1 a2)]
        [else (list '+ a1 a2)]))

;Productos:
(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))
(define (multiplicand p) (caddr p))

(define (make-product m1 m2)
  (cond [(or (=number? m1 0) (=number? m2 0)) 0]
        [(=number? m1 1) m2]
        [(=number? m2 1) m1]
        [(and (number? m1) (number? m2)) (* m1 m2)]
        [else (list '* m1 m2)]))

;Potencias:
(define (exponentiation? exp)
  (and (pair? exp) (eq? (car exp) '**)))

(define (base exp) (cadr exp))
(define (exponent exp) (caddr exp))

(define (make-exponentiation b e)
  (cond [(=number? e 0) 1]
        [(=number? e 1) b]
        [(and (number? b) (number? e)) (expt b e)]
        [else (list '** b e)]))

;Derivación:
(define (deriv exp var)
  (cond
    [(number? exp) 0]

    [(variable? exp)
     (if (same-variable? exp var) 1 0)]

    [(sum? exp)
     (make-sum (deriv (addend exp) var)
               (deriv (augend exp) var))]

    [(product? exp)
     (make-sum
      (make-product (multiplier exp)
                    (deriv (multiplicand exp) var))
      (make-product (deriv (multiplier exp) var)
                    (multiplicand exp)))]

;Nuevo caso: potencias
    [(exponentiation? exp)
     (make-product
      (make-product (exponent exp)
                    (make-exponentiation (base exp)
                                         (- (exponent exp) 1)))
      (deriv (base exp) var))]

    [else (error "Tipo de expresión desconocida" exp)]))

;ejemplos de prueba:
(deriv '(** x 3) 'x)          ; -> 3*x^2
(deriv '(** (+ x 1) 4) 'x)    ; -> 4*(x+1)^3
(deriv '(* x (** x 2)) 'x)    ; -> x*(2x) + x^2
