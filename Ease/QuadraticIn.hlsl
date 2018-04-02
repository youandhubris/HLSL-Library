#ifndef HUBRIS_EASE_QUADRATICIN
#define HUBRIS_EASE_QUADRATICIN

namespace Hubris
{
	inline float QuadraticIn(float t)
    {
	    return pow(t, 2.0);
    }
}

#endif // HUBRIS_EASE_QUADRATICIN