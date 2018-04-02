#ifndef HUBRIS_EASE_QUINTICIN
#define HUBRIS_EASE_QUINTICIN

namespace Hubris
{
    inline float QuinticIn(float t)
    {
	    return pow(t, 5.0);
    }
}

#endif // HUBRIS_EASE_QUINTICIN