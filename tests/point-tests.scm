(use test)

(test-group
 "point"
 (test-group
  "point-create"
  (test #t (let ((point (point-create (list 10 20))))
             (and (not (null? point))
                  (point? point))))
  (test-error (point-create '()))
  (test-error (point-create 10)))
 (test-group
  "point-coords"
  (test #t (let ((point (point-create (list 10 20))))
             (and (not (null? (point-coords point)))
                  (equal? (point-coords point) (list 10 20))))))
 (test-group
  "point-coord"
  (test 10 (let ((point (point-create (list 10 20))))
             (point-coord point 0)))))
