#!/usr/bin/env gosh

(use gauche.test)
(use gauche.process)
(use file.util)

(define (run-faber . args)
  (process-output->string (cons "../faber" args)))

(test* "--test1" "test1"
       (run-faber "test1"))

(test* "--test-with-arg" "myarg-result"
       (run-faber "test-with-arg" "myarg"))

(test* "--run-task" "test1"
       (run-faber "run-task"))

(test* "--run" (build-path (current-directory) "faberfile")
       (run-faber "run"))

(test* "--run-string" "result:."
       (run-faber "run-string"))

(test* "--run-strings" "3"
       (run-faber "run-strings"))

(test* "--run-pipe" "1"
       (run-faber "run-pipe"))

(test* "--run-file" "Hello"
       (run-faber "run-file"))
