# 2015 002 Addition of Either module + explicit openable constrcutor module

This project started originally as John Reppy's Either module added as an
[smlpkg](https://github.com/diku-dk/smlpkg) package. Based on the [original
BasisLibrary 2015-002
submission](https://github.com/SMLFamily/BasisLibrary/wiki/2015-002-Addition-of-Either-module),
but packaged to be accessible to the wider smlpkg ecosystem. Subsequently, the
openable constructor addition was made for better ergonomics.

## Openable constructor

It's nice to be able to use Either's constructors (`INR` and `INL`) without
prefixing, just like one can use `SOME` and `NONE` in the Basis library.

The problem with `open`ining Either as-is is that there are several functions
in there that shadow standard Basis functions like `map` and `app`.

I wanted to be able to open the constructors only, while leaving the other functions
fully-prefixed. The solution I came up with is to define a separate signature
`EITHER_CONS`, which exposes only the constructors, and subsequently both open it in
the implementation *and* expose it as a member struct. So now you can:

```
> val prefixed_val = Either.INR 3;
val prefixed_val = INR 3: ('a, int) Either.either

> open Either.Cons;
datatype ('a, 'b) either = INL of 'a | INR of 'b

> val non_prefixed_val = INR 3;
val non_prefixed_val = INR 3: ('a, int) either

> prefixed_val = non_prefixed_val;
val it = true: bool

```

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

