%Number 1
sum-up-numbers-simple([],0).        %This is base case for empty list.
sum-up-numbers-simple(L, N) :-      %This takes in parameters.
   [X|Y] = L,                       %This breaks the list into first and tail.
   sum-up-numbers-simple(Y, Sum),   %This sum the tail of the list to sum.
   number(X),                       %This checks to ensure X is a number to.
   N is X + Sum.                    %If true it adds X to the rest of the sum for tail.
sum-up-numbers-simple(L, N) :-      %This block handles a nested list.
   [X|Y] = L,
   sum-up-numbers-simple(Y, Sum),
   is_list(X),                      %At this step is where it checks that it is a list.
   N is 0 + Sum.                    %And if true it adds zero to sum.
sum-up-numbers-simple(L, N) :-      %This block deals with a none number charater.
   [X|Y] = L,
   sum-up-numbers-simple(Y, Sum),
   not(number(X)),                  %At this point it is evaluted.
   N is 0 + Sum.                    %And if true zero is added.


%Number 2
sum-up-numbers-general([],0).        %This is base case for empty list.
sum-up-numbers-general(L, N) :-      %This takes in parameters.
   [X|Y] = L,                       %This breaks the list into first and tail.
   sum-up-numbers-general(Y, Sum),   %This sum the tail of the list to sum.
   number(X),                       %This checks to ensure X is a number to.
   N is X + Sum.                    %If true it adds X to the rest of the sum for tail.
sum-up-numbers-general(L, N) :-      %This block handles a nested list.
   [X|Y] = L,
   sum-up-numbers-general(Y, Sum),
   is_list(X),                      %At this step is where it checks that it is a list.
   sum-up-numbers-general(X, Sum2), %If true it calls the function recursively with X.
   N is Sum + Sum2.                 %And sums the the nested list sum with the tail.
sum-up-numbers-general(L, N) :-      %This block deals with a none number charater.
   [X|Y] = L,
   sum-up-numbers-general(Y, Sum),
   not(number(X)),                  %At this point it is evaluted.
   N is 0 + Sum.                    %And if true zero is added.



%Number 3
%Helper Function
min-of-list([], Min).
min-of-list(L1, Min) :-
   [X|Y] = L1,
   min-of-list(Y, Min),
   number(X),
   Min >= X,
   Min is X + 0.
min-of-list(L1, Min) :-
   [X|Y] = L1,
   min-of-list(Y, Min),
   number(X),
   Min < X,
   Min is Min.
min-of-list(L1, Min) :-
   [X|Y] = L1,
   min-of-list(Y, Min),
   Min is Min.

%Helper Function 2.
l1-min-greater-l2-min(L1, Min) :-
[X|Y] = L1,
number(X),
false.
test(L1, P)  :-
P is append(L1, P, P).

%Base Cases.
min-above-min([], [], N) :- false.
min-above-min([], L2, N) :- false.

%Empty List2.
min-above-min(L1, [], N) :-
   [X|Y] = L1,
   not(number(X)),
   min-above-min(Y, [], N).
min-above-min(L1, [], N) :-
   [X|Y] = L1,
   number(X),
   min-of-list(L1, X),
   N is X + 0.

%List 1 with no numbers.
min-above-min(L1, L2, N) :-
   [X|Y] = L1,
   not(number(X)),
   min-above-min(Y, L2, N).
min-above-min(L1, L2, N) :-
   [X|Y] = L1,
   number(X).

%Both list have elements.
min-above-min(L1, L2, N) :-
   [X|Y] = L2,
   not(number(X)),
    min-above-min(L1, Y, N).
min-above-min(L1, L2, N) :-
   [X|Y] = L2,
   number(X),
   min-of-list(L2, X),
   %pass x into other helper.
   false.
min-above-min(L1, L2, N) :-false.






