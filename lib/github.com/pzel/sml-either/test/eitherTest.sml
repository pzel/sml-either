structure Tests =
  struct

    local
      open Check
      open Either.Cons
      structure E = Either
      fun ident x = x
      val itos = Int.toString
    in
    val opensuite = (fn test => (
	(* test isLeft *)
	  test "isLeft-1" (expectTrue (fn () => E.isLeft (INL 1)));
	  test "isLeft-2" (expectFalse (fn () => E.isLeft (INR 1)));
	(* test isRight *)
	  test "isRight-1" (expectTrue (fn () => E.isRight (INR 1)));
	  test "isRight-2" (expectFalse (fn () => E.isRight (INL 1)));
	(* test asLeft *)
	  test "asLeft-1" (expectSome' 1 (fn () => E.asLeft (INL 1)));
	  test "asLeft-2" (expectNone (fn () => E.asLeft (INR 1)));
	(* test asRight *)
	  test "asRight-1" (expectSome' 1 (fn () => E.asRight (INR 1)));
	  test "asRight-2" (expectNone (fn () => E.asRight (INL 1)));
	(* test map *)
	  test "map-1" (expectVal' (INL "17") (fn () => E.map (itos, itos) (INL 17)));
	  test "map-2" (expectVal' (INR "17") (fn () => E.map (itos, itos) (INR 17)));
	  test "map-3" (expectVal' (INL 17) (fn () => E.map (ident, itos) (INL 17)));
	  test "map-4" (expectVal' (INR "17") (fn () => E.map (ident, itos) (INR 17)));
	(* test mapLeft *)
	  test "mapLeft-1" (expectVal' (INL "17") (fn () => E.mapLeft itos (INL 17)));
	  test "mapLeft-2" (expectVal' (INR 17) (fn () => E.mapLeft itos (INR 17)));
	(* test mapRight *)
	  test "mapRight-1" (expectVal' (INL 17) (fn () => E.mapRight itos (INL 17)));
	  test "mapRight-2" (expectVal' (INR "17") (fn () => E.mapRight itos (INR 17)));
	(* test app *)
	  test "app-1" (expectVal' "17"
		(withRef "" (fn r => E.app (fn x => r := itos x, fn x => r := itos x) (INL 17))));
	  test "app-2" (expectVal' "17"
	    (withRef "" (fn r => E.app (fn x => r := itos x, fn x => r := itos x) (INR 17))));
	  test "app-3" (expectVal' "16"
	    (withRef "" (fn r => E.app (fn x => r := itos(x-1), fn x => r := itos(x+1)) (INL 17))));
	  test "app-4" (expectVal' "18"
	    (withRef "" (fn r => E.app (fn x => r := itos(x-1), fn x => r := itos(x+1)) (INR 17))));
	(* test appLeft *)
	  test "appLeft-1" (expectVal' "17"
		(withRef "%%" (fn r => E.appLeft (fn x => r := itos x) (INL 17))));
	  test "appLeft-2" (expectVal' "%%"
	    (withRef "%%" (fn r => E.appLeft (fn x => r := itos x) (INR 17))));
	(* test appRight *)
	  test "appRight-1" (expectVal' "%%"
	    (withRef "%%" (fn r => E.appRight (fn x => r := itos(x+1)) (INL 17))));
	  test "appRight-2" (expectVal' "18"
	    (withRef "%%" (fn r => E.appRight (fn x => r := itos(x+1)) (INR 17))));
	(* test fold *)
	  test "fold-1" (expectInt 16 (fn () => E.fold (Int.-, Int.+) 1 (INL 17)));
	  test "fold-2" (expectInt 18 (fn () => E.fold (Int.-, Int.+) 1 (INR 17)));
	  test "fold-3" (expectInt 18 (fn () => E.fold (Int.+, Int.-) 1 (INL 17)));
	  test "fold-4" (expectInt 16 (fn () => E.fold (Int.+, Int.-) 1 (INR 17)));
	(* test proj *)
	  test "proj-1" (expectInt 17 (fn () => E.proj (INL 17)));
	  test "proj-2" (expectInt 42 (fn () => E.proj (INR 42)));
	(* test partition *)
	  test "partition-1" (expect (fn ([], []) => true | _ => false) (fn () => E.partition []));
	  test "partition-2" (expect (fn ([17], []) => true | _ => false) (fn () => E.partition [INL 17]));
	  test "partition-3" (expect (fn ([], [42]) => true | _ => false) (fn () => E.partition [INR 42]));
	  test "partition-4" (expect (fn ([17], [42]) => true | _ => false) (fn () => E.partition [INL 17, INR 42]));
	  test "partition-5" (expect (fn ([42], [17]) => true | _ => false) (fn () => E.partition [INR 17, INL 42]));
	  test "partition-6" (expect
		(fn ([13, 42], [17, 99]) => true | _ => false)
		(fn () => E.partition [INL 13, INR 17, INR 99, INL 42]));

    test "bindRight-1" (expect (fn (INR 1) => true | _ => false)
                               (fn () => E.bindRight (fn x => INR (x + 1)) (INR 0)));

    test "bindRight-2" (expect (fn (INL "leftval") => true | _ => false)
                               (fn () => E.bindRight (fn x => INL "leftval") (INR 0)));

    test "bindRight-2" (expect (fn (INL "original-leftval") => true | _ => false)
                               (fn () => E.bindRight (fn x => INL "unused") (INL "original-leftval")));


    test "bindLeft-1" (expect (fn (INL 1) => true | _ => false)
                               (fn () => E.bindLeft (fn x => INL (x + 1)) (INL 0)));

    test "bindLeft-2" (expect (fn (INR "rightval") => true | _ => false)
                               (fn () => E.bindLeft (fn x => INR "rightval") (INL 0)));

    test "bindLeft-2" (expect (fn (INR "original-rightval") => true | _ => false)
                               (fn () => E.bindLeft (fn x => INR "unused") (INR "original-rightval")));


    ()))


    fun run () = runSuite "Either" opensuite
    end (* local *)

  end

fun main () = Tests.run();
