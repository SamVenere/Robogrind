:- module(model_robogrind, [
    is_instance_of_something/1,
    is_known_blade/1,
    cuttingSpeed/2,
    is_known_material/1,
    material_of/2,
    validSpeed/2,
    getMinSpeed/2,
    getMaxSpeed/2,
    betweeen/2,
    random_list/2,
    get_rotationalSpeed/2
]).

:- use_module(library(random)).

:- load_owl('package://robogrind/owl/grinding.owl',[ namespace(robogrind) ]).
%%% Benjamin Stuff

:- kb_project([
    is_individual('http://artimimds/RoboGrind/Grinding#blade2'),
    instance_of('http://artimimds/RoboGrind/Grinding#blade2', 'http://artimimds/RoboGrind/Grinding#Blade'),
    holds('http://artimimds/RoboGrind/Grinding#blade2','http://artimimds/RoboGrind/Grinding#hasMaterial', 'http://artimimds/RoboGrind/Grinding#glass')
]).

:- kb_project([
    is_individual('http://artimimds/RoboGrind/Grinding#blade3'),
    instance_of('http://artimimds/RoboGrind/Grinding#blade3', 'http://artimimds/RoboGrind/Grinding#Blade'),
    holds('http://artimimds/RoboGrind/Grinding#blade3','http://artimimds/RoboGrind/Grinding#hasMaterial', 'http://artimimds/RoboGrind/Grinding#wood')]).


is_instance_of_something(X) :-
    kb_call(instance_of(X, something)).



%%My stuff

betweeen(Speed,[Minspeed,Maxspeed]):-
    Speed>=Minspeed,
    Speed=<Maxspeed.

tab2Num([MinSpeed,MaxSpeed],Min,Max):-
    Min=MinSpeed,
    Max=MaxSpeed.

random_list([Min,Max],Var) :-
    random_between(Min, Max, Var).
    

%get the minimum speed for a given material
getMinSpeed(Material,Speed) ?+>
    subclass_of(Material,Superclass),
    is_restriction(Superclass, min(robogrind:hasCuttingSpeed,Speed)).

%get the maximum speed for a given material
getMaxSpeed(Material,Speed) ?+>
    subclass_of(Material,Superclass),
    is_restriction(Superclass, max(robogrind:hasCuttingSpeed,Speed)).


%has_properties(x, mat, shape) ?+>  
    %kb_projetc([is_individual(x),
    %instance_of(x, 'http://artimimds/RoboGrind/Grinding#Blade'),
    %holds(x, 'http://artimimds/RoboGrind/Grinding#hasMaterial', mat),
    %holds(x, 'http://www.ease-crc.org/ont/SOMA.owl#hasShape',shape)]).

%new(name) :- kb_project(is_individual(name)).

%List the known material
is_known_material(X):-
    subclass_of(X,'http://www.ease-crc.org/ont/SOMA.owl#Material').

%List the known blade (individual), true if it's a known blade (need to call it by 'http://artimimds/RoboGrind/Grinding#Name')
is_known_blade(Name):-
    instance_of(Name,'http://artimimds/RoboGrind/Grinding#Blade').


%find the Material of an indivual Blade
material_of(Name, Material) ?+>
    %instance_of(Name,Superclass),
    %is_restriction(Superclass, Material).
    holds(Name,robogrind:hasMaterial,Material).
    


%%%%%%%% CUTTING SPEED %%%%%%%%

%If Input is a Blade
cuttingSpeed1(Input, [MinSpeed,MaxSpeed]) ?+>
    instance_of(Input,'http://artimimds/RoboGrind/Grinding#Blade'),
    material_of(Input,BladeMaterial),
    instance_of(BladeMaterial,Material),
    getMinSpeed(Material,MinSpeed),
    getMaxSpeed(Material,MaxSpeed).

%If Input is a Instance Material
cuttingSpeed1(Input, [MinSpeed,MaxSpeed]) ?+>
    instance_of(Input,Material),
    subclass_of(Material,'http://www.ease-crc.org/ont/SOMA.owl#Material'),
    getMaxSpeed(Material,MaxSpeed),
    getMinSpeed(Material,MinSpeed).

%If Input is a Material
cuttingSpeed1(Input, [MinSpeed,MaxSpeed]) ?+>
    subclass_of(Input,'http://www.ease-crc.org/ont/SOMA.owl#Material'),
    getMaxSpeed(Input,MaxSpeed),
    getMinSpeed(Input,MinSpeed).

%Find the speed limit for a given materialInstance in m/s
cuttingSpeed(Input,Speed) ?+>
    cuttingSpeed1(Input,Speed).


%%%%%%%% VALID SPEED %%%%%%%%

validSpeed(Input,Speed):-
    cuttingSpeed(Input,Range),
    betweeen(Speed,Range).


%%%%%%% ROTATION SPEED %%%%%%%

%Give the rrotational speed in tr/min
get_rotationalSpeed(X,RS) :-
    cuttingSpeed(X,Range),
    random_list(Range,Vc),
    rotationSpeed(Vc, 5, RS).

get_rotationSpeedRange(X,V):-
    cuttingSpeed(X,Range),
    tab2Num(Range,Min,Max),
    rotationSpeed(Min,5,Rmin),
    rotationSpeed(Max,5,Rmax),
    V=[Rmin,Rmax].
