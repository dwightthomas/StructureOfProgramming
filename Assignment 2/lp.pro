sum-up-numbers-simple([],0).
sum-up-numbers-simple(L, N) :-
   [X|Y] = L,
   sum-up-numbers-simple(Y, Sum),
   number(X),
   N is X + Sum.
sum-up-numbers-simple(L, N) :-
   [X|Y] = L,
   sum-up-numbers-simple(Y, Sum),
   is_list(X),
   N is 0 + Sum.
sum-up-numbers-simple(L, N) :-
   [X|Y] = L,
   sum-up-numbers-simple(Y, Sum),
   not(number(X)),
   N is 0 + Sum.




