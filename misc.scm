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
  (nth-set nth zip-map %advance-current list-combinations cars cdrs)

  (import scheme chicken)
  (use srfi-1 lazy-seq)

  ;; Returns a new list which is a copy of the given list with its nth element
  ;; having the given value.
  (define (nth-set lis n val)
    (let-values (((hd tl) (split-at lis n)))
      (append hd (list val) (cdr tl))))

  ;; Returns the nth element of a given list.
  (define nth list-ref)

  ;; Applies a given procedure to the elements of the given lists grouped by
  ;; index (zipped). The given procedure should expect two arguments.
  (define (zip-map f lis1 lis2)
    (assert (and (list? lis1) (list? lis2)))
    (map (lambda (l) (f (first l) (second l))) (zip lis1 lis2)))
  
  ;; Collects the CAR of each list in the given list of lists!
  (define (cars list-of-lists)
    (map car list-of-lists))

  ;; Collects the CDR of each list in the given list of lists!
  (define (cdrs list-of-lists)
    (map cdr list-of-lists))

  ;; Calculates the combinations of the given lists.
  ;; For example, calling (list-combinations '(a b) '(1) '(X Y Z)) produces 
  ;; (a 1 X), (a 1 Y), (a 1 Z), (b 1 X), (b 1 Y), (b 1 Z)
  (define (list-combinations . lists)
    (let lc ((current lists) (first-element? #t))
      (lazy-seq
       (if first-element? (cons (cars current) (lc current #f))
           (let ((advanced (%advance-current current lists #t)))
             (if (equal? advanced lists) '()
                 (cons (cars advanced)
                       (lc advanced #f))))))))

  ;; Advances the current list of lists one element ahead. As meaningless as
  ;; it sounds, it is at the heart of the list combinations.
  ;; A couple of examples:
  ;;   1) current-lists: ((a b c) (10 20) (w x y))
  ;;      original-lists: ((a b c) (10 20) (w x y))
  ;;      result: ((b c) (10 20) (w x y))
  ;;   2) current-lists: (() (20) (x y))
  ;;      original-lists: ((a b c) (10 20) (w x y))
  ;;      result: ((a b c) (10 20) (x y))
  (define (%advance-current current-lists original-lists advance?)
    (cond
     ((null? current-lists) '())
     ((not advance?) current-lists)
     (else
      (let ((new-current-list (cdr (car current-lists))))
        (if (null? new-current-list)
            (append (list (car original-lists))
                    (%advance-current (cdr current-lists)
                                      (cdr original-lists) #t))
            (append (list new-current-list)
                    (%advance-current (cdr current-lists)
                                      (cdr original-lists) #f))))))))
