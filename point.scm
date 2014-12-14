(load "misc")

(module point
  (point-create point? point-coords point-coord)
  (import scheme chicken)
  (use srfi-1 misc)
  
  (define-record point coords)

  (define (point-create lis)
    (assert (and (list? lis) (not (null? lis))))
    (make-point lis))

  (define (point-coord point dim)
    (assert (and (point? point) (>= dim 1)))
    (nth (point-coords point) dim)))
