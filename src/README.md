# BashX Sources

## [`init-app.sh`](init-app.sh)

Script to initialize the _main APP_.

## [`setup.sh`](setup.sh)

Script to install _BashX_.

## [`actions`](actions)

Available _BashX_ **actions**.

> **Notes**
>
> - All scripts starting with `_` character, will be hidden when
>   `help` action is called.

## [`tests`](tests)

Available _BashX_ **tests**.

You can run available **tests** with [`./bashx _run-tests`](../bashx)

## [`utils`](utils)

Available _BashX_ **utils**.

Each file with `xsh` extension at this path,
will be a _BashX_ function prefixed with an `@`.
You can navigate the tree with `.`.

> **Example**
>
> - if you have `utils/foo.xsh`, you can use
>   `@foo` in your scripts.
> - if you have `utils/foo/bar.xsh`, you can use
>   `@foo.bar` in your scripts.
