:- dynamic lst_hanoi/1.

main :-
    init,
    repeat,
    next,
    finish(Hanoi),
    reverse(Hanoi, Rev_Hanoi),
    maplist(writeln, Rev_Hanoi).

init :-
    retractall(lst_hanoi(_)),
    assert(lst_hanoi([[hanoi([1,2,3,4], [], [])]])).

finish([hanoi([], [], A) | B]) :-
    lst_hanoi(Lst),
    member([hanoi([], [], A) | B], Lst).

next :-
    retract(lst_hanoi(Hanoi)),
    maplist(move_next,Hanoi, Hanoi_Temp),
    append(Hanoi_Temp, Hanoi_1),
    exclude(=([]), Hanoi_1, Hanoi_2),
    assert(lst_hanoi(Hanoi_2)).

move_next([Hanoi | T1], R) :-
    writeln(Hanoi),
    writeln(T1),
    move(Hanoi, Next),
    maplist(new_hanoi([Hanoi| T1]), Next, R).

new_hanoi(T, H, [H | T]) :-
    \+member(H, T), !.
new_hanoi(_T, _H, []).

move(hanoi([H | T], [], []), [hanoi(T, [H], []), hanoi(T, [], [H])]).
move(hanoi([], [H | T], []), [hanoi([H], T, []), hanoi([], T, [H])]).
move(hanoi([], [], [H | T]), [hanoi([H], [], T), hanoi([], [H], T)]).
move(hanoi([H1 | T1], [H2 | T2], []),
     [hanoi(T1, [H2 | T2], [H1]),
      hanoi([H1 | T1], T2, [H2]),
      hanoi([H2, H1 | T1], T2, [])]) :-
    H1 > H2, !.
move(hanoi([H1 | T1], [H2 | T2], []),
     [hanoi(T1, [H2 | T2], [H1]),
      hanoi([H1 | T1], T2, [H2]),
      hanoi(T1, [H1, H2 | T2], [])]).
move(hanoi([H1 | T1], [], [H2 | T2]),
     [hanoi(T1, [H1], [H2 | T2]),
      hanoi([H1 | T1], [H2], T2),
      hanoi([H2, H1 | T1], [], T2)]) :-
    H1 > H2, !.
move(hanoi([H1 | T1], [], [H2 | T2]),
     [hanoi(T1, [H1], [H2 | T2]),
      hanoi([H1 | T1], [H2], T2),
      hanoi(T1, [], [H1, H2 | T2])]).
move(hanoi([], [H1 | T1], [H2 | T2]),
     [hanoi([H1], T1, [H2 | T2]),
      hanoi([H2], [H1 | T1], T2),
      hanoi([], [H2, H1 | T1], T2)]) :-
    H1 > H2, !.
move(hanoi([], [H1 | T1], [H2 | T2]),
     [hanoi([H1], T1, [H2 | T2]),
      hanoi([H2], [H1 | T1], T2),
      hanoi([], T1, [H1, H2 | T2])]).
move(hanoi([H1 | T1], [H2 | T2], [H3 | T3]),
     [hanoi(T1, [H1, H2 | T2], [H3 | T3]),
      hanoi(T1, [H2 | T2], [H1, H3 | T3]),
      hanoi([H1 | T1] , T2, [H2, H3 | T3])]) :-
     H1 < H2, H2 < H3, !.
move(hanoi([H1 | T1], [H2 | T2], [H3 | T3]),
     [hanoi(T1, [H1, H2 | T2], [H3 | T3]),
      hanoi(T1, [H2 | T2], [H1, H3 | T3]),
      hanoi([H1 | T1] , [H3, H2 | T2 ], T3)]) :-
     H1 < H3, H3 < H2, !.
move(hanoi([H1 | T1], [H2 | T2], [H3 | T3]),
     [hanoi([H2, H1 | T1], T2, [H3 | T3]),
      hanoi([H1 |T1], T2, [H2, H3 | T3]),
      hanoi(T1 , [H2 | T2 ], [H1 , H3 | T3])]) :-
     H2 < H1, H1 < H3, !.
move(hanoi([H1 | T1], [H2 | T2], [H3 | T3]),
     [hanoi([H2, H1 | T1], T2, [H3 | T3]),
      hanoi([H1 |T1], T2, [H2, H3 | T3]),
      hanoi([H3, H1 | T1] , [H2 | T2 ], T3)]) :-
     H2 < H3, H3 < H1, !.
move(hanoi([H1 | T1], [H2 | T2], [H3 | T3]),
     [hanoi([H3, H1 | T1], [H2 | T2], T3),
      hanoi([H1 |T1], [H3, H2 |T2], T3),
      hanoi(T1 , [H1, H2 | T2 ], [H3 | T3])]) :-
     H3 < H1, H1 < H2, !.
move(hanoi([H1 | T1], [H2 | T2], [H3 | T3]),
     [hanoi([H3, H1 | T1], [H2 | T2], T3),
      hanoi([H2, H1 |T1], T2, [H3 |T3]),
      hanoi([H1 | T1] , [H3, H2 | T2 ], T3)]) :-
     H3 < H2, H2 < H1, !.
