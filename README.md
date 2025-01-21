# 2015 002 Addition of Either module

This is John Reppy's Either module added as an
[smlpkg](https://github.com/diku-dk/smlpkg) package. No original code has been
introduced, it's simply the implementation that was proposed in the [original
BasisLibrary 2015-002
submission](https://github.com/SMLFamily/BasisLibrary/wiki/2015-002-Addition-of-Either-module),
but packaged to be accessible to the wider smlpkg ecosystem.


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

