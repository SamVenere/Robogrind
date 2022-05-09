:- register_ros_package(knowrob).

:- use_module(library(random)).
:- load_owl('package://robogrind/owl/grinding.owl',[ namespace(robogrind, 'http://artimimds/RoboGrind/Grinding#') ]). 
:- use_module('robogrind').
:- use_directory('calcul').