#ifndef HUBRIS_AA_AASTEP
#define HUBRIS_AA_AASTEP
// REFERENCE
// https://github.com/glslify/glsl-aastep
// Performs a smoothstep using standard derivatives for anti-aliased edges at any level of magnification.

namespace Hubris
{
	
	inline float AAStep(float threshold, float value)
	{
		float afwidth = length(float2(ddx(value), ddy(value))) * 0.70710678118654757;
		return smoothstep(threshold - afwidth, threshold + afwidth, value);
	}
}

#endif // HUBRIS_AA_AASTEP