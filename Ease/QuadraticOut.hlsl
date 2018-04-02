#ifndef HUBRIS_EASE_QUADRATICOUT
#define HUBRIS_EASE_QUADRATICOUT

namespace Hubris
{
	inline float QuadraticOut(float t)
    {
	    return -t * (t - 2.0);
    }
}

#endif // HUBRIS_EASE_QUADRATICOUT