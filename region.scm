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

;; Represents a hyper region in an n-dimensional space.
(module region
  (region-create region? region-corner region-extent)
  (import scheme chicken)
  (use srfi-1 srfi-99 point)

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
    (region-make corner extent)))
