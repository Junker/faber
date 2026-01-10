Faber is a CLI task runner designed to leverage the power and flexibility of Gauche Scheme.
Unlike other build systems that rely on custom formats, Faber uses Gauche Scheme, allowing you to write build scripts using familiar Scheme syntax.

> *“Homo **faber** suae quisque fortunae”* - Every man is the **maker** of his own fate.

## Getting Started
Tasks are stored in a file called `faberfile` in your project root. Here's a simple example:

```scheme
(define-task build ()
  (run '(cc main.c foo.c bar.c -o main)))

(define-task test ()
  (run-task build)  ; execute task "build" first
  (run "./test"))

(define-task default ()
  (run-task build))  ; default task when no task specified
```

### Running Tasks
```shell
> faber build     # Run the build task
> faber test      # Run the test task
> faber           # Run the default task
``` 

## Task Definition Syntax

### Basic tasks
There are two equivalent ways to define a task:
```scheme
(define-task task-name ()
  (display "This is a task!"))
;; OR
(deftask task-name ()
  (display "This is a task!"))
```

### Tasks with arguments
```scheme
(define-task touch (path)
  (touch-file path))

(define-task test-arg (arg)
  (format #t "Hello ~A" arg))

(define-task test-key-arg (:key arg1 arg2)
  (format #t "Hello ~A" arg1))
```

### Piped commands
```scheme
(define-task test-pipe ()
  ;; Equivalent to: ls -l | wc -l
  (run-pipe '((ls -l)
              (wc -l))))
```

### Parallel execution
```scheme
(define-task test-parallel ()
  ;; returns in ~5 seconds
  (run-parallel '((sleep 3) (sleep 5) (sleep 2)))

  ;; returns in ~10 seconds
  (run-parallel '((sleep 3) (sleep 5) (sleep 2))
                :num-threads 1))
```

### Capturing command output
```scheme
(define-task sloc ()
  (let1 cnt (run->string '(wc -l "*. c"))
    (show #t cnt " lines of code" nl)))
```

### More Examples
For additional examples, see the test [faberfile](test/faberfile) in the repository.

## Running Tasks
```shell
> faber build
> faber sloc
> faber test-arg world
> faber test-key-arg :arg1 world
> faber touch test.txt
```

## Modules

### Pre-imported Modules
This modules are imported already and can be used in `faberfile`:
- [scheme.list](https://practical-scheme.net/gauche/man/gauche-refe/R7RS-large.html#R7RS-lists)
- [srfi-13](https://practical-scheme.net/gauche/man/gauche-refe/String-library.html#String-library)
- [scheme.show](https://practical-scheme.net/gauche/man/gauche-refe/R7RS-large.html#R7RS-combinator-formatting)
- [scheme.show.color](https://practical-scheme.net/gauche/man/gauche-refe/R7RS-large.html#R7RS-combinator-formatting)
- [gauche.process](https://practical-scheme.net/gauche/man/gauche-refe/High_002dlevel-process-interface.html#High_002dlevel-process-interface)
- [file.util](https://practical-scheme.net/gauche/man/gauche-refe/Filesystem-utilities.html#Filesystem-utilities)
- [control.pmap](https://practical-scheme.net/gauche/man/gauche-refe/Parallel-map.html)

### Importing Additional Modules
You can import module in `faberfile` like this:
```scheme
(use rfc.http)

(define-task api-call ()
  (receive (code headers body)
      (http-get "example.org" "/api/test"
	            :secure #t)
	(display body)))
```

## Built-in Functions

- `sh` - Execute command via shell ([`sys-system`](https://practical-scheme.net/gauche/man/gauche-refe/System-interface.html#index-sys_002dsystem))
- `run` - Execute command directly ([`do-process`](https://practical-scheme.net/gauche/man/gauche-refe/High_002dlevel-process-interface.html#index-do_002dprocess))
- `run->string` - Capture command output as string ([`process-output->string`](https://practical-scheme.net/gauche/man/gauche-refe/High_002dlevel-process-interface.html#index-process_002doutput_002d_003estring))
- `run->lines` - Capture command output as list of strings ([`process-output->string-list`](https://practical-scheme.net/gauche/man/gauche-refe/High_002dlevel-process-interface.html#index-process_002doutput_002d_003estring_002dlist))
- `run-pipe` - Execute commands pipeline ([`do-pipeline`](https://practical-scheme.net/gauche/man/gauche-refe/High_002dlevel-process-interface.html#index-do_002dpipeline))
- `run-parallel` - Execute list of commands in parallel
- `run->file` - Capture command output to file 
- `deftask` - alias for `define-task`

## Shell Integration

- Zsh: [faber.plugin.zsh](misc/zsh/faber.plugin.zsh) - Task autocompletion

## Requirements

- [Gauche Scheme](http://practical-scheme.net/gauche/) installed

## Documentation

- [Gauche Scheme Manual](https://practical-scheme.net/gauche/man/gauche-refe/index.html)

## Alternatives

- [Maak](https://codeberg.org/jjba23/maak) - The infinitely extensible command runner, control plane and project automator à la Make (Guile Scheme - Lisp)
