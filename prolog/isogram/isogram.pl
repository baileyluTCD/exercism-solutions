is_alpha(X) :- char_type(X, alpha).

isogram(Phrase) :-
    string_lower(Phrase, Lower),
    string_to_list(Lower, List),
    include(is_alpha, List, AlphaOnly),

    list_to_set(AlphaOnly, Set),

    length(Set, SetLength),
    length(AlphaOnly, AlphaLength),

    SetLength =:= AlphaLength.
