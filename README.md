# 2015 002 Addition of Either module

This is the Either module added as an [smlpkg](https://github.com/diku-dk/smlpkg) package.

https://github.com/SMLFamily/BasisLibrary/wiki/2015-002-Addition-of-Either-module


## How to include this in your sml project

1. Place the package in your `sml.pkg` file;

```
require {
  github.com/pzel/sml-either 0.0.1
}
```

2. Sync with upstream

```
smlpkg sync
```

3. If everything goes well, you'll have `either.mlb` in the `lib` hierarchy:

```
$ find lib/ | grep either.mlb
lib/github.com/pzel/sml-either/either.mlb
```


## TODO:

 - [ ] Run tests & build under mlton
 - [x] Run tests & build under poly(mlb)
 - [ ] Set up CI

