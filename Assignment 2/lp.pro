sum-up-numbers-simple(L, N).  %This deals with taking in the parameters.
sum-up-numbers-simple([X|Y], N) :-   %This splits the list into the the lead and the tail.
    sum-up-numbers-simple(Y, Sum),   %This calls the function recursively to get to the rest of the list.
    N is X + Sum.  %This sums the sum of the tail to the lead/head of the tail.
