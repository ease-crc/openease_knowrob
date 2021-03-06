% make sure library path is expanded
:- register_ros_package(knowrob_openease).
:- register_ros_package(knowrob).

% query answering
:- use_module('./query_handler.pl').
:- use_module('./query_history.pl').

% handling of NEEMs
:- use_module('./neems.pl').

% load marker visualization
:- use_directory('marker_vis').
% load IDE interface
:- use_directory('ide').

% load backends for query visualization
:- use_module('./backends/canvas.pl').
:- use_module('./backends/timeline.pl').
:- use_module('./backends/tree.pl').
:- use_module('./backends/graph.pl').
:- use_module('./backends/table.pl').
