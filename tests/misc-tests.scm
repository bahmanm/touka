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
 (test-group
  "nth"
  (let ((l1 (list 10 20 30))
        (l2 (list 10)))
    (test 10 (nth l1 0))
    (test 20 (nth l1 1))
    (test-error (nth l2 1))
    (test-error (nth '() 0)))))
