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
 "point"
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (test-group
  "point-create"
  (test #t (let ((point (point-create (list 10 20))))
             (and (not (null? point))
                  (point? point))))
  (test-error (point-create '()))
  (test-error (point-create 10)))
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (test-group
  "point-coords"
  (test #t (let ((point (point-create (list 10 20))))
             (and (not (null? (point-coords point)))
                  (equal? (point-coords point) (list 10 20))))))
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (test-group
  "point-coord"
  (test 10 (let ((point (point-create (list 10 20))))
             (point-coord point 0)))
  (test 20 (let ((point (point-create (list 10 20))))
             (point-coord point 1)))
  (test-error (let ((point (point-create (list 10 20))))
                (point-coord point 2))))
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (test-group
  "point-coord-set"
  (let ((p1 (point-create (list 10 20)))
        (p2 (point-create (list 10 25)))
        (p3 (point-create (list 1)))
        (p4 (point-create (list 2))))
    (test p2 (point-coord-set p1 1 25))
    (test p4 (point-coord-set p3 0 2))
    (test-error (point-coord-set 10 0 2))
    (test-error (point-coord-set p1 -1 0))
    (test-error (point-coord-set p1 0 (list 100 200))))))
