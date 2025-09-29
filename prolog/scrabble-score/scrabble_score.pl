member_string(Letter, String) :-
    string_chars(String, Chars),
    member(Letter, Chars).

score_char(X, 1) :- member_string(X, "aeioulnrst"), !.
score_char(X, 2) :- member_string(X, "dg"), !.
score_char(X, 3) :- member_string(X, "bcmp"), !.
score_char(X, 4) :- member_string(X, "fhvwy"), !.
score_char(X, 5) :- member_string(X, "k"), !.
score_char(X, 8) :- member_string(X, "jx"), !.
score_char(X, 10) :- member_string(X, "qz"), !.
score_char(_, 0).

sum_char_score(Curr, Acc, Ret) :-
    score_char(Curr, CurrScore),
    Ret is Acc + CurrScore.

score(Word, Score) :-
    string_lower(Word, Lowercase),
    string_chars(Lowercase, List),
    foldl(sum_char_score, List, 0, Score).
