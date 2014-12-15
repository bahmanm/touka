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
  (test-error (region-extent 10))))
