:- use_module(library('rostest')).
:- use_module(library('semweb/rdf_db')).
:- use_module('calcul').
:- use_module('/home/rems/catkin_ws/src/robogrind/src/robogrind.pl').


:- begin_rdf_tests(
    'calcul',
    'package://knowrob/owl/test/swrl.owl',
    [ namespace('http://knowrob.org/kb/swrl_test#')
    ]).

test_rotationSpeed(Vc,R, RS):-
    rotationSpeed(Vc,R, RS).

test_bladeSpeed(X,Radius,RS):-
    is_known_blade(X),
    cuttingSpeed(X,Range),
    random_list(Range,Vc),
    validSpeed(X,Vc),
    test_rotationSpeed(Vc, Radius, RS).

test('Rotation speed exists') :-
    test_rotationSpeed(1, 2, RS).

test('Rotation speed someting else') :-
    test_bladeSpeed('http://artimimds/RoboGrind/Grinding#blade2',23,Vc).