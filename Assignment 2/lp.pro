sum-up-numbers-simple(L, N).
sum-up-numbers-simple([X|Y], N) :-
    sum-up-numbers-simple(Y, Sum),
    N = X + sum.
