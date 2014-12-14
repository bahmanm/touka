(use srfi-1)

(module misc
  (nth-set nth)

  (import scheme chicken)
  (use srfi-1)

  (define (nth-set lis n val)
    (let-values (((hd tl) (split-at lis n)))
      (append hd (list val) (cdr tl))))
  
  (define nth list-ref))

