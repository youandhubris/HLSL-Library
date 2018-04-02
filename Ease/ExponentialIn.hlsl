#ifndef HUBRIS_EASE_EXPONENTIALIN
#define HUBRIS_EASE_EXPONENTIALIN

namespace Hubris
{
    inline float ExponentialIn(float t)
    {
	    return t == 0.0 ? t : pow(2.0, 10.0 * (t - 1.0));
    }
}

#endif // HUBRIS_EASE_EXPONENTIALIN