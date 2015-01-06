; Copyright 2014, 2015 Bahman Movaqar
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

;; Represents a rectangular region in a metric space. A rectangular region is
;; marked by a "corner" and the "extent". The corner stands for the lowest
;; coordinates of the region while the extent denotes how far in each dimension
;; the region extends starting from the corner.
(module region
  (region-create region? region-corner region-extent region-corners
   region-overlaps? region-overlap region-move)
  (import scheme chicken)
  (use srfi-1 srfi-99 point misc lazy-seq)

  (define region-rtd (make-rtd #:region #(#:corner #:extent)))
  (define region-make (rtd-constructor region-rtd))
  (define region? (rtd-predicate region-rtd))
  (define region-corner (rtd-accessor region-rtd #:corner))
  (define region-extent (rtd-accessor region-rtd #:extent))

  ;; Creates a new region. It expects two points:
  ;;  1) a corner of the region with the smallest coordinates
  ;;  2) the extent of the region in all dimensions starting from the given
  ;;     corner.
  (define (region-create corner extent)
    (assert (and (point? corner) (point? extent)))
    (region-make corner extent))

  ;; Computes all corners of the region as a list of points.
  (define (region-corners region-rtd)
    (assert (region? region-rtd))
    (let* ((low-corner-point (region-corner region-rtd))
           (extent (region-extent region-rtd))
           (high-corner-point (point-move low-corner-point extent))
           (low-corner (point-coords low-corner-point))
           (high-corner (point-coords high-corner-point))
           (combinations (lazy-seq->list
                          (apply list-combinations
                                 (zip low-corner high-corner)))))
      (map point-create combinations)))

  ;; Checks if the two given regions overlap.
  (define (region-overlaps? region1 region2)
    (assert (and (region? region1) (region? region2)))
    (let* ((min1 (region-corner region1))
           (min2 (region-corner region2))
           (max1 (point-move min1 (region-extent region1)))
           (max2 (point-move min2 (region-extent region2))))
      (every (lambda (l)
               (let ((min1 (first l)) (min2 (second l))
                     (max1 (third l)) (max2 (fourth l)))
                 (or (and (> min1 min2) (> max2 min1))
                     (and (< min1 min2) (> max1 min2))
                     (equal? min1 min2))))
             (zip (point-coords min1) (point-coords min2)
                  (point-coords max1) (point-coords max2)))))

  ;; Computes the overlapping region of the two given regions.
  (define (region-overlap region1 region2)
    (assert (region-overlaps? region1 region2))
    (let* ((min1 (region-corner region1))
           (min2 (region-corner region2))
           (max1 (point-move min1 (region-extent region1)))
           (max2 (point-move min2 (region-extent region2)))
           (result-corner (point-create (map (lambda (x)
                                               (max (first x) (second x)))
                                             (zip (point-coords min1)
                                                  (point-coords min2)))))
           (result-high-corner (point-create (map (lambda (x)
                                                    (min (first x) (second x)))
                                                  (zip (point-coords max1)
                                                       (point-coords max2)))))
           (result-extent (point-distance result-high-corner result-corner)))
      (region-create result-corner result-extent)))

  ;; Moves the region by a given distance (as point), keeping the 'extent'
  ;; intact and only moving the corner. It does NOT mutate the given region
  ;; and instead returns a new one.
  (define (region-move region distance)
    (assert (and (region? region) (point? distance)))
    (region-create (point-move (region-corner region) distance)
                   (region-extent region))))
