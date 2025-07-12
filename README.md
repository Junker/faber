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
  ($ cc main.c foo.c bar.c -o main))
  
(define-task test ()
  (run-task build)
  ($ ./test))

(define-task sloc ()
  (let1 cnt (<$ "wc -l *.c") ;
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
```
- srfi-1
- srfi-13
- scheme.show
- scheme.show.color
- gauche.process
- file.util
```

You can import module in `faberfile` like this:
```scheme
(use rfc.http)
(define-task api-call ()
  (receive (code headers body)
      (http-get "example.org" "/api/test"
	            :secure #t)
	(display body)))
```

## Shorthand macros

- `$` - macro for `do-process!`
- `<$` - macro for `process-output->string`
- `task` - alias for `define-task`

## Requirements

- [Gauche Scheme](http://practical-scheme.net/gauche/) installed

## Documentation

- [Gauche Scheme Manual](https://practical-scheme.net/gauche/man/gauche-refe/index.html)

