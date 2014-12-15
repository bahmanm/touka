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

(module misc
  (nth-set nth zip-apply)

  (import scheme chicken)
  (use srfi-1)

  ;; Returns a new list which is a copy of the given list with its nth element
  ;; having the given value.
  (define (nth-set lis n val)
    (let-values (((hd tl) (split-at lis n)))
      (append hd (list val) (cdr tl))))

  ;; Returns the nth element of a given list.
  (define nth list-ref)

  ;; Applies a given procedure to the elements of the given lists grouped by
  ;; index (zipped). The given procedure should expect two arguments.
  (define (zip-apply f lis1 lis2)
    (assert (and (list? lis1) (list? lis2)))
    (map (lambda (l) (f (first l) (second l))) (zip lis1 lis2))))

