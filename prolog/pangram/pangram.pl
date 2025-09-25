pangram(Sentence) :-
    string_lower(Sentence, Lower),
    string_codes(Lower, Codes),

    string_codes('az', [A, Z]),
    numlist(A, Z, Alphabet),

    subset(Alphabet, Codes).
