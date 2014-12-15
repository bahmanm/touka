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

(module point
  (point-create point? point-coords point-coord point-coord-set point-distance
   point-abs-distance)
  (import scheme chicken)
  (use srfi-1 srfi-99 misc)
  
  (define point (make-rtd #:point #(#:coords)))
  (define make-point (rtd-constructor point))
  (define point-coords (rtd-accessor point #:coords))
  (define point? (rtd-predicate point))

  ;; Creates a new point using the given list as the coordinates.
  (define (point-create lis)
    (assert (and (list? lis) (not (null? lis))))
    (make-point lis))

  ;; Retrieves the value of a given dimension.
  (define (point-coord point dim)
    (assert (and (point? point) (>= dim 0)))
    (nth (point-coords point) dim))

  ;; Creates a new point with the new value for a given dimension.
  (define (point-coord-set point dim val)
    (assert (and (point? point) (>= dim 0) (number? val)))
    (point-create (nth-set (point-coords point) dim val)))

  ;; Calculates the distance from point1 to point2; if the number of dimensions
  ;; of the given points is not equal, uses the smaller dimension.
  (define (point-distance point1 point2)
    (assert (and (point? point1) (point? point2)))
    (point-create (zip-apply -
                             (point-coords point1) (point-coords point2))))

  ;; Calculates the absolute distance between the given points.
  (define (point-abs-distance point1 point2)
    (assert (and (point? point1) (point? point2)))
    (point-create (zip-apply (lambda (x y) (abs (- x y)))
                             (point-coords point1) (point-coords point2)))))
