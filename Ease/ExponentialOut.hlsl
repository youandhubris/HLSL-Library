#ifndef HUBRIS_EASE_EXPONENTIALOUT
#define HUBRIS_EASE_EXPONENTIALOUT

namespace Hubris
{
	inline float ExponentialOut(float t)
    {
	    return t == 1.0 ? t : 1.0 - pow(2.0, -10.0 * t);
    }
}

#endif // HUBRIS_EASE_EXPONENTIALOUT