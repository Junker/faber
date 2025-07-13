Faber is a task runner designed to leverage the power and flexibility of Gauche Scheme.
Unlike other build systems that rely on custom formats, Faber uses Gauche Scheme, allowing you to write build scripts using familiar Scheme syntax and semantics.
This approach not only reduces the learning curve but also offers the full expressive power of Scheme for complex build tasks.

*“Homo **faber** suae quisque fortunae”* - Every man is the **maker** of his own fate.

## Usage
Tasks are stored in a file called `faberfile`:
```scheme
(define-task task-name ()
  (display "This is a recipe!"))
;; OR
(task task-name ()
  (display "This is a recipe!"))
```

```scheme
(define-task build ()
  (run '(cc main.c foo.c bar.c -o main)))

(define-task test ()
  (run-task build)
  (run "./test"))

(define-task test2 ()
  (run/pipe '((ls -l)
              (wc -l))))

(define-task sloc ()
  (let1 cnt (run/string '(wc -l "*.c"))
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

This modules imported already and can be used in `faberfile`:
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

- `run` - alias for `do-process!`
- `run/string` - alias for `process-output->string`
- `run/strings` - alias for `process-output->strings`
- `run/pipe` - alias for `do-pipeline`
- `run/file` - alias for `process-output->file`
- `task` - alias for `define-task`

## Requirements

- [Gauche Scheme](http://practical-scheme.net/gauche/) installed

## Documentation

- [Gauche Scheme Manual](https://practical-scheme.net/gauche/man/gauche-refe/index.html)
