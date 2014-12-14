(use srfi-1)

(module misc
  (nth-value-set)

  (import scheme srfi-1 r4rs r5rs chicken)

  (define (nth-value-set lis n val)
    (let-values (((hd tl) (split-at lis n)))
      (append hd (list val) (cdr tl)))))
