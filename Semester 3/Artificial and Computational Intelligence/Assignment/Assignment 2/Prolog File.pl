% catchup.pl
% Simple Prolog model for the Catch-Up game rules.
% This code models generating minimal moves and checking terminal state.
% Usage (example, in SWI-Prolog):
% ?- numbers(5, Ns), minimal_moves(Ns, 3, Moves).
% ?- initial_first_moves(5, Moves).

% Create list of numbers 1..N
numbers(N, Ns) :-
    findall(X, between(1, N, X), Ns).

% Sum a list
sum_list([], 0).
sum_list([H|T], S) :- sum_list(T, S0), S is H + S0.

% Check if Sub is subset of Set
is_subset([], _).
is_subset([H|T], Set) :- member(H, Set), select(H, Set, NewSet), is_subset(T, NewSet).

% Generate all combinations (subsets) of a list
combinations([], []).
combinations([H|T], [H|C]) :- combinations(T, C).
combinations([_|T], C) :- combinations(T, C).

% minimal_move(Remaining, Threshold, Move) is true if Move is a minimal subset of Remaining whose sum >= Threshold
minimal_move(Remaining, Threshold, Move) :-
    combinations(Remaining, Move),
    Move \= [],
    sum_list(Move, S), S >= Threshold,
    \+ (combinations(Move, Sub), Sub \= [], Sub \= Move, sum_list(Sub, Ssub), Ssub >= Threshold).

% Collect all minimal moves
minimal_moves(Remaining, Threshold, Moves) :-
    findall(M, minimal_move(Remaining, Threshold, M), Moves).

% First move options for P1 (single numbers)
initial_first_moves(N, Moves) :-
    numbers(N, Ns),
    findall([X], member(X, Ns), Moves).

% Example: To check:
% ?- numbers(5, Ns), minimal_moves(Ns, 3, M).
% M = [[3], [4], [5], [1,2], [1,3], [1,4], [1,5], [2,3], [2,4], [2,5], [3,4], [3,5], [4,5], [1,2,3], ...].
% The minimal_moves predicate returns minimal subsets (by inclusion) that reach the threshold.

% NOTE: This Prolog file models the rule "turn-sum >= opponent_previous_turn_sum and minimal by inclusion".
% It is suitable for small N demonstration and can be extended to perform search or minimax, but that is beyond this simple file.


% Water_resource_prediction_decision_tree.pl

{\rtf1\ansi\ansicpg1252\cocoartf2867
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 % Assignment Part B: Logic - Water resource predict Decision Tree\
main :-\
    process,\
    halt.\
\
process :-\
    prompt('Enter rainfall intensity in mm (e.g. 120): ', Rainfall),\
    prompt('Is there a sandy aquifer (yes/no): ', SandyAquifer),\
    prompt('Distance from the perennial river in km: ', RiverDist),\
    prompt('Distance from the lake in km: ', LakeDist),\
    prompt('Distance from the beach in km: ', BeachDist),\
    decide_water_resource(Rainfall, SandyAquifer, RiverDist, LakeDist, BeachDist, Source),\
    format('Recommended water source: ~w~n', [Source]).\
\
prompt(Message, Value) :-\
    write(Message),\
    read(Value).\
\
decide_water_resource(_, _, _, LakeDist, _, lake) :-\
    LakeDist < 10, !.\
\
decide_water_resource(Rainfall, _, RiverDist, LakeDist, _, Source) :-\
    LakeDist >= 10,\
    RiverDist < 8,\
    (Rainfall >= 200 -> Source = rain ; Source = river), !.\
\
decide_water_resource(Rainfall, SandyAquifer, RiverDist, LakeDist, BeachDist, Source) :-\
    LakeDist >= 10,\
    RiverDist >= 8,\
    (Rainfall >= 150 -> Source = rain ;\
     Rainfall < 150, SandyAquifer == yes ->\
        (BeachDist < 5 -> (RiverDist < 20 -> Source = river ; Source = rain)\
        ; Source = groundwater)\
     ;\
     Rainfall < 150, SandyAquifer == no ->\
        (LakeDist < 14 -> Source = lake ; Source = rain)\
    ), !.\
\
:- main.}
