Faber is a task runner designed to leverage the power and flexibility of Gauche Scheme.
Unlike other build systems that rely on custom formats, Faber uses Gauche Scheme, allowing you to write build scripts using familiar Scheme syntax.

*“Homo **faber** suae quisque fortunae”* - Every man is the **maker** of his own fate.

## Warning
This software is still BETA quality. The APIs will be likely to change.

## Usage
Tasks are stored in a file called `faberfile`:
```scheme
(define-task task-name ()
  (display "This is a task!"))
;; OR
(deftask task-name ()
  (display "This is a task!"))
```

```scheme
(define-task build ()
  (run '(cc main.c foo.c bar.c -o main)))
;; or
(define-task build2 ()
  (sh "cc main.c foo.c bar.c -o main")) ; uses shell to execute command

(define-task test ()
  (run-task build) ; execute task "build"
  (run "/usr/bin/false" :noerr? #t) ; do not quit on error
  (run '(echo "Hello") :quiet? #t) ; do not print output
  (run "./test"))

(define-task test2 () 
  ;; runs shell equivalent: "ls -l | wc -l"
  (run-pipe '((ls -l)
              (wc -l))))

(define-task sloc ()
  (let1 cnt (run->string '(wc -l "*.c"))
    (show #t cnt " lines of code" nl)))
```

```shell
> faber build
> faber sloc
```

tasks with arguments:
```scheme
(define-task touch (path)
  (touch-file path))
```

```shell
> faber touch test.txt
```

default task:
```scheme
(define-task default ()
  (run-task build))
```

## Modules

This modules are imported already and can be used in `faberfile`:
- [scheme.list](https://practical-scheme.net/gauche/man/gauche-refe/R7RS-large.html#R7RS-lists)
- [srfi-13](https://practical-scheme.net/gauche/man/gauche-refe/String-library.html#String-library)
- [scheme.show](https://practical-scheme.net/gauche/man/gauche-refe/R7RS-large.html#R7RS-combinator-formatting)
- [scheme.show.color](https://practical-scheme.net/gauche/man/gauche-refe/R7RS-large.html#R7RS-combinator-formatting)
- [gauche.process](https://practical-scheme.net/gauche/man/gauche-refe/High_002dlevel-process-interface.html#High_002dlevel-process-interface)
- [file.util](https://practical-scheme.net/gauche/man/gauche-refe/Filesystem-utilities.html#Filesystem-utilities)

You can import module in `faberfile` like this:
```scheme
(use rfc.http)
(define-task api-call ()
  (receive (code headers body)
      (http-get "example.org" "/api/test"
	            :secure #t)
	(display body)))
```

## Shorthands

- `sh` - uses [`sys-system`](https://practical-scheme.net/gauche/man/gauche-refe/System-interface.html#index-sys_002dsystem)
- `run` - uses [`do-process`](https://practical-scheme.net/gauche/man/gauche-refe/High_002dlevel-process-interface.html#index-do_002dprocess)
- `run->string` - uses [`process-output->string`](https://practical-scheme.net/gauche/man/gauche-refe/High_002dlevel-process-interface.html#index-process_002doutput_002d_003estring)
- `run->lines` - uses [`process-output->string-list`](https://practical-scheme.net/gauche/man/gauche-refe/High_002dlevel-process-interface.html#index-process_002doutput_002d_003estring_002dlist)
- `run-pipe` - uses [`do-pipeline`](https://practical-scheme.net/gauche/man/gauche-refe/High_002dlevel-process-interface.html#index-do_002dpipeline)
- `run->file` - uses `process-output->file`
- `deftask` - alias for `define-task`

## Shell Integration

- [Zsh](misc/zsh/faber.plugin.zsh) - Task autocompletion

## Requirements

- [Gauche Scheme](http://practical-scheme.net/gauche/) installed

## Documentation

- [Gauche Scheme Manual](https://practical-scheme.net/gauche/man/gauche-refe/index.html)
