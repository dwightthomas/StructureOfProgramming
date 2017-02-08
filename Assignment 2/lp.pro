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
min-of-list([], Min).         %This is the base case.
min-of-list(L1, Min) :-	      %This takes in the parameters
   [X|Y] = L1,		      %This gets the head and tail of the list.
   min-of-list(Y, Min),       %This calls function with tail of list and min.
   number(X),		      %This checks to make sure X is a number.
   Min >= X,                  %If true it checks to see if it is smaller than min.
   Min is X + 0.	      %Then makes it the new min.
min-of-list(L1, Min) :-	      %This block handles if X is greater than the min.
   [X|Y] = L1,
   min-of-list(Y, Min),
   number(X),
   Min < X,
   Min is Min.                %Then min remains the same.
min-of-list(L1, Min) :-       %This block handles if X is not a number.
   [X|Y] = L1,
   min-of-list(Y, Min),
   Min is Min.		      %Then min remains the same.

%Main Solution.
%Base Cases.
min-above-min([], [], N) :- false.     %This is the base cases.
min-above-min([], L2, N) :- false.

%Empty List2.
min-above-min(L1, [], N) :-	       %This handles if list 2 is empty.
   [X|Y] = L1,
   not(number(X)),		       %It checks that X is a not a number.
   min-above-min(Y, [], N).            %And steps over that as it can't be a min.
min-above-min(L1, [], N) :-            %This handles if X is a number.
   [X|Y] = L1,
   number(X),
   min-of-list(L1, X),		       %Then runs the helper function to find the min.
   N is X + 0.			       %Then it makes N that min.

%List 1 with no numbers.                %This block is if L1 has no numbers then it would return false.
min-above-min(L1, L2, N) :-
   [X|Y] = L1,
   not(number(X)),
   min-above-min(Y, L2, N).
min-above-min(L1, L2, N) :-
   [X|Y] = L1,
   number(X).                           %This is what makes it false.

%Both list have elements.                %This block handles if both L1 and L2 have elements.
min-above-min(L1, L2, N) :-
   [X|Y] = L2,
   not(number(X)),                       %This ensures that no none number element in list two would  be passed as the min for helper function min-of-list.
    min-above-min(L1, Y, N).             %So it would call the function again with the tail as X is not a number.
                                         %If List 2 has no number the function would be called like func(L1, [], N), which is the casue for block above which would then find the min of L1.

min-above-min(L1, L2, N) :-		 %This block deals with if X is a number then it can be pasted into the helper funtion to find the min of list 2.
   [X|Y] = L2,
   number(X),
   min-of-list(L2, X),                   %This calls the helper function and gets the min of list two.
   %pass x into other helper.            %Stuck here need to find a way to check the min of L2 to L1 but still find smallest number biger than it.
   %x<min of l1 den da min is rite else   %These are my thoughts so far.
   %x<min of tail
   false.
min-above-min(L1, L2, N) :-false.	  %And this would hold the last clause.



%Number 4
%Base cases.
%Assumption common elements in N must be in the same order as they appear in L1.
common-unique-elements([], [], []) :- true.  %These are the main base cases.
common-unique-elements([], L2, []) :- true.
common-unique-elements(L1, [], []) :- true.
common-unique-elements([], L2, N) :-true.    %This is used for stepping out of the nested list and based my assumption N has to follow the order of the elements in L1 so if L1 is empty from the jump then N should be as well.
common-unique-elements(L1,L2,N) :-           %This takes in the paremters
    [X|Y] = L1,				     %This gets the head and tail of L1.
    [A|B] = N,				     %This gets head and tail of N.
    is_list(X),				     %If head of L1, X is list.
    common-unique-elements(X,L2,N).	     %Then it calls the function with that neseted list.
common-unique-elements(L1,L2,N) :-	    %This is called if the head X is not a list.
    [X|Y] = L1,
    [A|B] = N,
    A = X,                                   %This checks to ensure head of both L1 and N are the same.
    member(X, L2),			     %This checks that this same element is in L2.
    !,
    common-unique-elements(Y,L2,B).	     %This handles the rest of the list.
common-unique-elements([_|Y],L2,N) :-	     %This handles continuation of the function.
    common-unique-elements(Y,L2,N).

























