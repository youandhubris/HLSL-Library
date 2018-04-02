#ifndef HUBRIS_EASE_QUINTICOUT
#define HUBRIS_EASE_QUINTICOUT

namespace Hubris
{
    inline float QuinticOut(float t)
    {
	    return 1.0 + (pow(t - 1.0, 5.0));
    }
}

#endif // HUBRIS_EASE_QUINTICOUT