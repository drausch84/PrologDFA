start(df1, q0).
final(df1, q3).

transition(df1, q0, '0', q1).
transition(df1, q0, '1', q1).
transition(df1, q0, '.', q2).

transition(df1, q1, '0', q1).
transition(df1, q1, '1', q1).
transition(df1, q1, '.', q3).

transition(df1, q2, '0', q3).
transition(df1, q2, '1', q3).
transition(df1, q2, '.', q4).

transition(df1, q3, '0', q3).
transition(df1, q3, '1', q3).
transition(df1, q3, '.', q4).

transition(df1, q4, '0', q4).
transition(df1, q4, '1', q4).
transition(df1, q4, '.', q4).

dfaAcceptR(DFA, [], CurrentState) :- final(DFA, CurrentState).

dfaAcceptR(DFA, [H|T], CurrentState) :-
	% figure out next state and head of list,
	char_code(C , H),
	transition(DFA, CurrentState, C, NextState),

	% check to see if next state can be accepted based on rest of input
	dfaAcceptR(DFA, T, NextState).

dfaAccept(DFA, InputStr) :-
	string_to_list(InputStr, L),
	start(DFA, S0),
	dfaAcceptR(DFA, L, S0).
	
allStates(DFA, States) :-
	% Use the built-in “findall(TemplateX, GoalPredicateContainingX, BagList)” and “list_to_set(List, Set)” predicates to implement a rule,
	start(DFA, S0),
	findall(X, transition(DFA, _, _, X), L),
	list_to_set([S0|L], States).
