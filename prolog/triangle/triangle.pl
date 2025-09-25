triangle(A, A, A, "equilateral") :- is_triangle(A, A, A), !.
triangle(A, A, B, "isosceles") :- is_triangle(A, A, B), !.
triangle(A, B, A, "isosceles") :- is_triangle(A, B, A), !.
triangle(B, A, A, "isosceles") :- is_triangle(B, A, A), !.
triangle(A, B, C, "scalene") :- 
    is_triangle(A, B, C),
    A\==B,
    B\==C,
    C\==A.

is_triangle(A, B, C) :-
    A > 0,
    B > 0,
    C > 0,

    A + B >= C,
    B + C >= A,
    C + A >= B.
