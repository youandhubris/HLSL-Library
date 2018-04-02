#ifndef HUBRIS_MATH_RANDOM
#define HUBRIS_MATH_RANDOM
// REQUIRES
#include "../Variables.hlsl"

namespace Hubris
{
	// ----------------------------------------------------------------------------------------------
	// http://byteblacksmith.com/improvements-to-the-canonical-one-liner-glsl-rand-for-opengl-es-2-0/
	// ----------------------------------------------------------------------------------------------
	float Random(float2 varying, float2 amount)
	{
		float2 a = float2(amount.x * 12.9898, amount.y * 78.233);
		float b = 43758.5453;
		float dotted = dot(varying, a);
		float sinned = dotted % HUBRIS_PI;
		float fracted = frac(sin(sinned) * b);
		return fracted;
	}
}

#endif // HUBRIS_MATH_RANDOM