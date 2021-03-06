:- module(table_handler,
	[ data_vis_table/3,
	  data_vis_rdf_table(r,t)
	]).

:- use_module(library(query_handler)).

query_handler:openease_gen_answer(all,Values) :-
	writeln(Values),
	data_vis_rdf_table(Values, [title: 'Result Description']).
%%
data_vis_rdf_table(Values,Options) :-
	findall(
		[Type, Comment],
		(
			member(Val,Values),
			instance_of(Val, Type),
			has_comment(Type,Comment)
		),
		CommentData0),
	sort(CommentData0, CommentData),
	% generate ID for the chart
	CommentData = [[FirstType,_]|_],
	rdf_db:rdf_split_url(_,FirstTypeName,FirstType),
	atomic_list_concat(
		['table',FirstTypeName],'_',ID),
	% publish the message
	data_vis_table(ID, CommentData, Options).

%%
% Publishes a data vis message with tree data.
%
data_vis_table(ID, TableData, Options) :-
	% need to map to DataVis message format here
	table_data_(0,TableData,ArrayData),
    data_vis(table(ID),
    	[array_data: ArrayData | Options]
    ).

table_data_(Index,[],[[],[]]) :- !.
table_data_(Index,
		[[Type,Comment]|RestIn],
		[[IndexT,IndexC|RestIndices],[Type,Comment|RestContent]]
) :-
	atom_concat(Index,'T',IndexT),
	atom_concat(Index,'C',IndexC),
	NewIndex is Index + 1,
	table_data_(NewIndex,RestIn,[RestIndices,RestContent]).