/*
--------------------------------
REFERENCE
Robert Penner's Easing Functions
http://robertpenner.com/easing/
--------------------------------

EASE FUNCTIONS
---------------------
Linear			    0

BackIn			    1
BackOut				2
BackInOut			3

BounceIn			4
BounceOut			5
BounceInOut			6

CircularIn		    7
CircularOut			8
CircularInOut		9

CubicIn		       10
CubicOut		   11
CubicInOut		   12

ElasticIn	       13
ElasticOut		   14
ElasticInOut	   15

ExponentialIn      16
ExponentialOut	   17
ExponentialInOut   18

QuadraticIn        19
QuadraticOut	   20
QuadraticInOut	   21

QuarticIn          22
QuarticOut		   23
QuarticInOut	   24

QuinticIn		   25
QuinticOut		   26
QuinticInOut	   27

SineIn		       28
SineOut			   29
SineInOut		   30
---------------------

*/

#ifndef HUBRIS_EASE
#define HUBRIS_EASE
// REQUIRES
#include "Ease/BackIn.hlsl"
#include "Ease/BackInOut.hlsl"
#include "Ease/BackOut.hlsl"
#include "Ease/BounceIn.hlsl"
#include "Ease/BounceInOut.hlsl"
#include "Ease/BounceOut.hlsl"
#include "Ease/CircularIn.hlsl"
#include "Ease/CircularInOut.hlsl"
#include "Ease/CircularOut.hlsl"
#include "Ease/CubicIn.hlsl"
#include "Ease/CubicInOut.hlsl"
#include "Ease/CubicOut.hlsl"
#include "Ease/ElasticIn.hlsl"
#include "Ease/ElasticInOut.hlsl"
#include "Ease/ElasticOut.hlsl"
#include "Ease/ExponentialIn.hlsl"
#include "Ease/ExponentialInOut.hlsl"
#include "Ease/ExponentialOut.hlsl"
#include "Ease/QuadraticIn.hlsl"
#include "Ease/QuadraticInOut.hlsl"
#include "Ease/QuadraticOut.hlsl"
#include "Ease/QuarticIn.hlsl"
#include "Ease/QuarticInOut.hlsl"
#include "Ease/QuarticOut.hlsl"
#include "Ease/QuinticIn.hlsl"
#include "Ease/QuinticInOut.hlsl"
#include "Ease/QuinticOut.hlsl"
#include "Ease/SineIn.hlsl"
#include "Ease/SineInOut.hlsl"
#include "Ease/SineOut.hlsl"

namespace Hubris
{
    inline float Ease(float t, int ease)
    {
        float easing = 0;

        if (ease == 0) easing = t;
        else if (ease == 1) easing = BackIn(t);
        else if (ease == 2) easing = BackOut(t);
        else if (ease == 3) easing = BackInOut(t);
        else if (ease == 4) easing = BounceIn(t);
        else if (ease == 5) easing = BounceOut(t);
        else if (ease == 6) easing = BounceInOut(t);
        else if (ease == 7) easing = CircularIn(t);
        else if (ease == 8) easing = CircularOut(t);
        else if (ease == 9) easing = CircularInOut(t);
        else if (ease == 10) easing = CubicIn(t);
        else if (ease == 11) easing = CubicOut(t);
        else if (ease == 12) easing = CubicInOut(t);
        else if (ease == 13) easing = ElasticIn(t);
        else if (ease == 14) easing = ElasticOut(t);
        else if (ease == 15) easing = ElasticInOut(t);
        else if (ease == 16) easing = ExponentialIn(t);
        else if (ease == 17) easing = ExponentialOut(t);
        else if (ease == 18) easing = ExponentialInOut(t);
        else if (ease == 19) easing = QuadraticIn(t);
        else if (ease == 20) easing = QuadraticOut(t);
        else if (ease == 21) easing = QuadraticInOut(t);
        else if (ease == 22) easing = QuarticIn(t);
        else if (ease == 23) easing = QuarticOut(t);
        else if (ease == 24) easing = QuarticInOut(t);
        else if (ease == 25) easing = QuinticIn(t);
        else if (ease == 26) easing = QuinticOut(t);
        else if (ease == 27) easing = QuinticInOut(t);
        else if (ease == 28) easing = SineIn(t);
        else if (ease == 29) easing = SineOut(t);
        else if (ease == 30) easing = SineInOut(t);

        return easing;
    }
}

#endif // HUBRIS_EASE
