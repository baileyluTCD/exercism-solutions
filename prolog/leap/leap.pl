leap(X) :-
  X mod 400 =:= 0, !;
  X mod 4 =:= 0, X mod 100 =\= 0.
