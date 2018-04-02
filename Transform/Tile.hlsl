#ifndef HUBRIS_TRANSFORM_TILE
#define HUBRIS_TRANSFORM_TILE

namespace Hubris
{
	inline float2 Tile(float2 varying, float zoom)
    {
		return frac(varying * zoom);
	}
}

#endif // HUBRIS_TRANSFORM_TILE