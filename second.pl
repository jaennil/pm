is_prime(N) :-
    N > 1,
    is_prime(N, 2).

is_prime(N, Divider) :-
    S is sqrt(N),
    F is floor(S),
    Divider =:= F + 1.

is_prime(N, Divider) :-
    N mod Divider =\= 0,
    Divider1 is Divider + 1,
    is_prime(N, Divider1).

% --------------------------------------------------

prime_factors(N, PrimeFactors) :-
    prime_factors(N, PrimeFactors, 2).

prime_factors(1, [], _).

prime_factors(N, [Divider | PrimeFactors], Divider) :-
    N mod Divider =:= 0,
    is_prime(Divider),
    N1 is N // Divider,
    prime_factors(N1, PrimeFactors, Divider).

prime_factors(N, PrimeFactors, Divider) :-
    N mod Divider =\= 0,
    Divider1 is Divider + 1,
    prime_factors(N, PrimeFactors, Divider1).

% --------------------------------------------------

prime_factors_mult(N, PrimeFactors) :-
    prime_factors_mult(N, 2, PrimeFactors).

prime_factors_mult(1, _, []).

prime_factors_mult(N, Divisor, [[Divisor,Count]|PrimeFactors]) :-
    count_factors(N, Divisor, Count, N1),   
    Count > 0,                        
    prime_factors_mult(N1, Divisor + 1, PrimeFactors). 

prime_factors_mult(N, Divisor, PrimeFactors) :-
    N > 1,
    N mod Divisor =\= 0,
    Divisor1 is Divisor + 1,
    prime_factors_mult(N, Divisor1, PrimeFactors).

count_factors(N, Divisor, 0, N) :-
    N mod Divisor =\= 0.  

count_factors(N, Divisor, Count, N1) :-
    N mod Divisor =:= 0,  
    N2 is N // Divisor,
    count_factors(N2, Divisor, Count1, N1),
    Count is Count1 + 1.

% prime_factors_mult(N, PrimeFactors) :-
%     prime_factors_mult(N, PrimeFactors, 2).
%
% prime_factors_mult(N, [[Divider, Amount]|PrimeFactors], Divider) :-
%     is_prime(Divider),
%     count_factors(N, Divider, Amount),
%     N1 is N // Divider * Amount,
%     Divider1 is Divider + 1,
%     prime_factors_mult(N1, PrimeFactors, Divider1);
%     Divider1 is Divider + 1,
%     prime_factors_mult(N, PrimeFactors, Divider1).
%
% count_factors(N, Divider, Amount) :-
%     N mod Divider =:= 0,
%     N1 is N // Divider,
%     Amount1 is Amount + 1,
%     count_factors(N1, Divider, Amount1).
    

% --------------------------------------------------

primes(From, To, Primes) :-
    findall(N, (between(From, To, N), is_prime(N), writeln(N)), Primes).

% --------------------------------------------------

goldbach(N, Pair) :-
    N > 3,
    even(N),
    Max is N - 2,
    goldbach(N, Pair, 2, Max).

goldbach(N, [Min, Max], Min, Max) :-
    is_prime(Min),
    is_prime(Max),
    Min + Max =:= N.

goldbach(N, Pair, Min, Max) :-
    Min < Max,
    Min1 is Min + 1,
    Max1 is Max - 1,
    goldbach(N, Pair, Min1, Max1).

% --------------------------------------------------

even(N) :- mod(N, 2) =:= 0.

goldbach_list(From, From) :-
    goldbach(From, [H|[T]]),
    format("~w = ~w + ~w", [From, H, T]), nl.

goldbach_list(From, To) :-
    goldbach(From, [H|[T]]),
    format("~w = ~w + ~w", [From, H, T]), nl,
    From1 is From + 1,
    goldbach_list(From1, To);
    From1 is From + 1,
    goldbach_list(From1, To).


goldbach_list(From, From, Limit) :-
    goldbach(From, [H|[T]]),
    H > Limit,
    T > Limit,
    format("~w = ~w + ~w", [From, H, T]), nl.

goldbach_list(From, To, Limit) :-
    goldbach(From, [H|[T]]),
    H > Limit,
    T > Limit,
    format("~w = ~w + ~w", [From, H, T]), nl,
    From1 is From + 1,
    goldbach_list(From1, To, Limit);
    From1 is From + 1,
    goldbach_list(From1, To, Limit).


% --------------------------------------------------

gcd(N1, N2, Divisor) :-
    Min is min(N1, N2),
    Max is max(N1, N2),
    Min =\= 0,
    R is Max mod Min,
    R =:= 0,
    Divisor is Min;
    Min is min(N1, N2),
    Max is max(N1, N2),
    Min =\= 0,
    R is Max mod Min,
    gcd(Min, R, Divisor).

% --------------------------------------------------

coprime(N1, N2) :-
    gcd(N1, N2, 1).
