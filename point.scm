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
  (point-create point? point-coords point-coord point-coord-set)
  (import scheme chicken)
  (use srfi-1 misc)
  
  (define-record point coords)

  ;; creates a new point using the given list as the coordinates
  (define (point-create lis)
    (assert (and (list? lis) (not (null? lis))))
    (make-point lis))

  ;; retrieves the value of a given dimension
  (define (point-coord point dim)
    (assert (and (point? point) (>= dim 0)))
    (nth (point-coords point) dim))

  ;; creates a new point with the new value for a given dimension
  (define (point-coord-set point dim val)
    (assert (and (point? point) (>= dim 0) (number? val)))
    (point-create (nth-set (point-coords point) dim val))))
