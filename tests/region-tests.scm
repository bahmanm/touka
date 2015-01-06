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

(use test)

(test-group
 "region"
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (test-group
  "region-create"
  (test-error (region-create 10 20))
  (test #f (null? (region-create (point-create (list 1 1))
                                 (point-create (list 2 8))))))
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (test-group
  "region-corner"
  (test (point-create (list 10 20))
        (region-corner (region-create (point-create (list 10 20))
                                      (point-create (list 11 1)))))
  (test-error (region-corner 10)))
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (test-group
  "region-extent"
  (test (point-create (list 11 1))
        (region-extent (region-create (point-create (list 10 20))
                                      (point-create (list 11 1)))))
  (test-error (region-extent 10)))
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (test-group
  "region-corners"
  (let* ((p1 (point-create (list 1 2)))
         (p2 (point-create (list 10 20)))
         (p1-1 (point-create (list 1 2)))
         (p1-2 (point-create (list 1 22)))
         (p1-3 (point-create (list 11 2)))
         (p1-4 (point-create (list 11 22)))
         (r1 (region-create p1 p2)))
    (test-error (region-corners p1))
    (test #f (null? (region-corners r1)))
    (test 4 (length (region-corners r1)))
    (test-assert (member p1-1 (region-corners r1)))
    (test-assert (member p1-2 (region-corners r1)))
    (test-assert (member p1-3 (region-corners r1)))
    (test-assert (member p1-4 (region-corners r1)))
    (test #f (member p2 (region-corners r1)))))
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (test-group
  "region-overlaps?"
  (let* ((p1 (point-create (list 4 4)))
         (p2 (point-create (list 3 3)))
         (p3 (point-create (list 5 4)))
         (p4 (point-create (list 1 3)))
         (p5 (point-create (list 2 2)))
         (p6 (point-create (list 6 2)))
         (p7 (point-create (list 2 3)))
         (p8 (point-create (list 7 7)))
         (p9 (point-create (list 1 1)))
         (r (region-create p1 p2)))
    (test-assert (region-overlaps? r (region-create p1 p2)))
    (test-assert (region-overlaps? r (region-create p3 p4)))
    (test-assert (region-overlaps? r (region-create p2 p5)))
    (test #f (region-overlaps? r (region-create p5 p9)))
    (test-assert (region-overlaps? r (region-create p6 p7)))
    (test #f (region-overlaps? r (region-create p6 p5)))
    (test #f (region-overlaps? r (region-create p8 p5)))))
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (test-group
  "region-overlap"
  (let* ((p1 (point-create (list 4 4)))
         (p2 (point-create (list 3 3)))
         (p3 (point-create (list 5 4)))
         (p4 (point-create (list 1 3)))
         (p5 (point-create (list 2 2)))
         (p6 (point-create (list 6 2)))
         (p7 (point-create (list 2 3)))
         (p8 (point-create (list 7 7)))
         (p9 (point-create (list 1 1)))
         (p10 (point-create (list 6 4)))
         (r (region-create p1 p2)))
    (test r (region-overlap r r))
    (test (region-create p3 p4)
          (region-overlap r (region-create p3 p4)))
    (test (region-create p1 p9)
          (region-overlap r (region-create p2 p5)))
    (test (region-create p10 p9)
          (region-overlap r (region-create p6 p7)))
    (test-error (region-overlap r (region-create p9 p9)))))
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (test-group
  "region-move"
  (let* ((p1 (point-create (list 1 1)))
         (p2 (point-create (list 2 2)))
         (p3 (point-create (list -1 0)))
         (p4 (point-create (list 0 1)))
         (r (region-create p1 p2)))
    (test-error (region-move r r))
    (test-error (region-move p1 r))
    (test (region-extent r)
          (region-extent (region-move r p3)))
    (test p4
          (region-corner (region-move r p3))))))
