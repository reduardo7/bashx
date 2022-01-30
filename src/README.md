# BashX Sources

## [`/bootstrap.src`](bootstrap.src)

Uncompressed script to initialize the _main APP_.

It's present at the beginning of _BashX_ entry-point script.

## [`/config.init.src`](config.init.src)

Initial _BashX_ project configuration.
Should be override before load the _bootstrap_ script,
or before call the entrypoint script.

## [`/config.src`](config.src)

_BashX_ project configuration.
Can be override by custom project configuration.

## [`/constants.src`](constants.src)

Readonly _BashX_ internal constants.

## [`/init.sh`](init.sh)

Initial _BashX_ script.
In charge of loading everything before start.

## [`/setup.sh`](setup.sh)

First time install _BashX_ script.

## [`/actions`](actions)

Available _BashX_ **actions** script.

## [`/tests`](tests)

Available _BashX_ **tests** scripts.

## [`/utils`](utils)

Available _BashX_ **utils** scripts.
You can call each one using the prefix `@` and the filename.

_For example:_

```bash
# src/utils/myScript.xsh
@myScript

# src/utils/myScript/foo.xsh
@myScript.foo

# src/utils/helpers/bar.xsh
@helpers.bar
```
