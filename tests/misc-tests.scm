; Copyright 2014 Bahman Movaqar
; 
; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
; 
;     http://www.apache.org/licenses/LICENSE-2.0
; 
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS,
; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the License for the specific language governing permissions and
; limitations under the License.

(use test)

(test-group
 "misc"
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (test-group
  "nth-set"
  (let ((l1 (list 10 20 30))
        (l2 (list 10 200 30))
        (l3 (list 10))
        (l4 (list 100))
        (l5 (list 10 20))
        (l6 (list 10 200)))
    (test #t (equal? (nth-set l1 1 200) l2))
    (test #t (equal? (nth-set l3 0 100) l4))
    (test #t (equal? (nth-set l5 1 200) l6))
    (test #f (equal? (nth-set l1 1 200) l1))
    (test-error (nth-set '() 1 10))
    (test-error (nth-set l1 10 1000))))
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (test-group
  "nth"
  (let ((l1 (list 10 20 30))
        (l2 (list 10)))
    (test 10 (nth l1 0))
    (test 20 (nth l1 1))
    (test-error (nth l2 1))
    (test-error (nth '() 0))))
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (test-group
  "zip-map"
  (test (list 1 1)
        (zip-map -
                   (list 10 5) (list 9 4)))
  (test (list 8 15)
        (zip-map *
                   (list 4 3) (list 2 5)))
  (test-error (zip-map (lambda (x y) (* x y)) 10 20)))
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (test-group
  "%advance-current"
  (test '() (%advance-current '() (list 1 2 3) #t))
  (test '() (%advance-current '() (list 1 2 3) #f))
  (let* ((l1 (list 10 20 30 40))
         (l2 (list 'a 'b))
         (l3 (list 100 200 300))
         (l4 (list l1 l2 l3))
         (l4-1 (list (cdr l1) l2 l3))
         (l4-2 (list (list 40) (cdr l2) l3))
         (l4-3 (list l1 l2 (cdr l3)))
         (l5 (list 'a))
         (l6 (list 'A))
         (l7 (list l5 l6)))
    (test l4 (%advance-current l4 l4 #f))
    (test l4-1 (%advance-current l4 l4 #t))
    (test l4-3 (%advance-current l4-2 l4 #t))
    (test "return the original lists if current is fully exhausted"
          l7 (%advance-current l7 l7 #t))))
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (test-group
  "cars"
  (test '() (cars '()))
  (test '(1 a 100) (cars '((1) (a b c) (100 200))))
  (test '(1 100) (cars '((1) (100)))))
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (test-group
  "cdrs"
  (test '() (cdrs '())))
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (test-group
  "list-combinations"
  (let ((lc (list-combinations (list 1) (list 'a 'b))))
    (test #t (lazy-seq? lc))
    (test #f (lazy-null? lc))
    (test 2 (lazy-length lc))
    (test (list 1 'a) (lazy-head lc))
    (test (list 1 'b) (lazy-head (lazy-tail lc)))
    (test #t (lazy-null? (lazy-tail (lazy-tail lc))))
    (test (list '(1 a) '(1 b)) (lazy-seq->list lc)))
  (let ((lc (list-combinations (list 1 2 3)
                               (list 'a 'b 'c 'd)
                               (list 100 200 300))))
    (test #t (lazy-seq? lc))
    (test #f (lazy-null? lc))
    (test 36 (lazy-length lc)))))
