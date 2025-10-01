increment_if_different(A, B, Count, Return) :-
    (A =\= B ->
        Return is Count + 1;
        Return is Count).

hamming_distance(Str1, Str2, Dist) :-
    string_to_list(Str1, List1),
    string_to_list(Str2, List2),
    foldl(increment_if_different, List1, List2, 0, Dist).
