#!/usr/bin/env gosh

(use gauche.test)
(use gauche.process)
(use file.util)

(define (run-faber . args)
  (process-output->string (cons "../faber" args)))

(define (run-faber-quiet . args)
  (do-process! (cons "../faber" args)
               :output :null
               :error :null))

(test* "--option-faberfile" #t
       (run-faber-quiet "--faberfile" "./faberfile"))

(test* "--option-faberfile2" #t
       (run-faber-quiet "--faberfile" (build-path (current-directory) "faberfile")))

(test* "--option-faberfile3" (test-error)
       (run-faber-quiet "--faberfile" "unexisted"))

(test* "--test1" "test1"
       (run-faber "test1"))

(test* "--test-with-arg" "myarg-result"
       (run-faber "test-with-arg" "myarg"))

(test* "--run-task" "test1"
       (run-faber "run-task"))

(test* "--run" (build-path (current-directory) "faberfile")
       (run-faber "run"))

(test* "--run-w-error" (test-error)
       (run-faber-quiet "run-w-error"))

(test* "run-w-error-noerr" ""
       (run-faber "run-w-error-noerr"))

(test* "--run-string" "result:."
       (run-faber "run-string"))

(test* "--run-lines" "3"
       (run-faber "run-lines"))

(test* "--run-pipe" "1"
       (run-faber "run-pipe"))

(test* "--run-file" "Hello"
       (run-faber "run-file"))

(test* "--sh" "Hello world"
       (run-faber "sh"))

(test* "--sh2" (home-directory)
       (run-faber "sh2"))
