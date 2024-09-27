female(maria).
female(tatiana).
female(elena).
male(evgeniyR).
male(evgeniy).
male(nikita).
male(matvey).
male(nikolay).

parent(evgeniy, nikita).
parent(maria, nikita).
parent(evgeniy, matvey).
parent(maria, matvey).
parent(nikolay, evgeniy).
parent(tatiana, evgeniy).
parent(elena, maria).
parent(evgeniyR, maria).

offspring(X, Y) :- parent(Y, X).
son(X, Y) :- male(X), parent(Y, X).
daughter(X, Y) :- female(X), parent(Y, X).
mother(X, Y) :- female(X), parent(X, Y).
father(X, Y) :- male(X), parent(X, Y).
husband(X, Y) :- father(X, Z), mother(Y, Z).
wife(X, Y) :- mother(X, Z), father(Y, Z).
brother(X, Y) :- male(X), parent(Z, X), parent(Z, Y).
sister(X, Y) :- female(X), parent(Z, X), parent(Z, Y).
sibling(X, Y) :- parent(Z, X), parent(Z, Y).

grandmother(X, Y) :- mother(X, Z), parent(Z, Y).
grandfather(X, Y) :- father(X, Z), parent(Z, Y).
% свекровь
mother_in_law(X, Y) :- mother(X, Z), husband(Z, Y).
% свёкр
father_in_law(X, Y) :- father(X, Z), husband(Z, Y).
% тёща
tesha(X, Y) :- mother(X, Z), wife(Z, Y).
% тесть
test(X, Y) :- father(X, Z), wife(Z, Y).
% зять
son_in_law(X, Y) :- daughter(Z, Y), husband(X, Z).
uncle(X, Y) :- parent(Z, Y), brother(X, Z).
aunt(X, Y) :- parent(Z, Y), sister(X, Z).
% племянник
nephew(X, Y) :- sibling(Y, Z), son(X, Z).
% племянница
niece(X, Y) :- sibling(Y, Z), daughter(X, Z).
grandson(X, Y) :- offspring(Z, Y), son(X, Z).
granddaughter(X, Y) :- offspring(Z, Y), daughter(X, Z).
