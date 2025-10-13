find(List, Value, Index) :-
    length(List, Len),
    find(List, Value, 0, Len, Index).

find(List, Value, Left, Right, Index) :-
    Left < Right,
    Middle is (Left + Right) // 2,
    nth0(Middle, List, Curr),
    (Curr == Value ->
        Index = Middle;
    Curr > Value ->
        find(List, Value, Left, Middle, Index);
    find(List, Value, Middle + 1, Right, Index)).
