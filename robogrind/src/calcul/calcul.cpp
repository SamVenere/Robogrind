#define _USE_MATH_DEFINES


#include </home/rems/catkin_ws/src/robogrind/src/calcul/calcul.h>
//#include <iostream>
//#include <boost/algorithm/string.hpp>
//#include <regex>
//#include <clocale>
#include <stdio.h> 
#include <string>
#include <math.h> 

const float pi = M_PI;

//R in-between (Radius if the grinder is horizontal in mm), Ap radial depth of pass in mm, Z material removal rate can determine the speed

// float RobotSpeed(float I, float Ap, float Z)
// {return (Z/(Ap*I));}

//Rotation Speed in tr/min
PREDICATE(rotationSpeed, 3){
    float Vc = (double)PL_A1;
    float R = (double)PL_A2;
    float rs = rotationSpeed(Vc,R);
    PL_A3 = rs;
    return true;
}

float rotationSpeed(float Vc, float R)
{return (Vc*1000)/(pi*R*2*60);}

// int add(int A){return (A+2);}

// float thetha(float R, float Ap){
//     float D = 2*R;
//     return acos(1-(2*Ap)/D);
// }

// //Workpiece and grinding wheel contact arc length Xr

// float Xr(float R, float Ap){
//     float theta = thetha(R,Ap);
//     float D = 2*R;
//     return pi*D*theta/360;
// }