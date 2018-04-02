/*
-----------------------------------------------------------------------------------------------
Noise functions by Ashima Arts
https://github.com/ashima/webgl-noise
-----------------------------------------------------------------------------------------------

2D / 3D / 4D
-----------------------------------------------------------------------------------------------
Classic Perlin noise                       noiseClassic(float2 / float3 / float4 P)
Classic Perlin noise, periodic version     noisePeriodic(float2 / float3 / float4 P, float2 / float3 / float4 rep)
Noise                                      noiseSimplex(float2 / float3 / float4 v)
-----------------------------------------------------------------------------------------------

Notes & License:
GLSL textureless classic 2D / 3D / 4D noise "cnoise", with an RSL-style periodic variant "pnoise".
Author Stefan Gustavson (stefan.gustavson@liu.se), version: 2011-08-22

Many thanks to Ian McEwan of Ashima Arts for the ideas for permutation and gradient selection.

Copyright (c) 2011 Stefan Gustavson. All rights reserved.
Distributed under the MIT license. See LICENSE file.
https://github.com/ashima/webgl-noise


Array and textureless GLSL 2D simplex noise function.
Author Ian McEwan, Ashima Arts, maintainer ijm, lastmod 20110822 (ijm).

Copyright (C) 2011 Ashima Arts. All rights reserved.
Distributed under the MIT License. See LICENSE file.
https://github.com/ashima/webgl-noise

-----------------------------------------------------------------------------------------------
*/
namespace Hubris
{
	/*
	-------------------------------------------------------
	MOD / PERMUTE
	-------------------------------------------------------
	-------------------------------------------------------
	*/

	float mod289(float x) {
		return x - floor(x * (1.0 / 289.0)) * 289.0;
	}

	float2 mod289(float2 x) {
		return x - floor(x * (1.0 / 289.0)) * 289.0;
	}

	float3 mod289(float3 x) {
		return x - floor(x * (1.0 / 289.0)) * 289.0;
	}

	float4 mod289(float4 x)
	{
		return x - floor(x * (1.0 / 289.0)) * 289.0;
	}

	float3 permute(float3 x) {
		return mod289(((x*34.0) + 1.0)*x);
	}

	float4 permute(float4 x) {
		return mod289(((x*34.0) + 1.0)*x);
	}

	/*
	-------------------------------------------------------
	CLASSIC 2D
	-------------------------------------------------------
	-------------------------------------------------------
	*/
	float4 taylorInvSqrt(float4 r)
	{
		return 1.79284291400159 - 0.85373472095314 * r;
	}

	float2 fade(float2 t) {
		return t * t*t*(t*(t*6.0 - 15.0) + 10.0);
	}

	float noiseClassic(float2 P)
	{
		float4 Pi = floor(P.xyxy) + float4(0.0, 0.0, 1.0, 1.0);
		float4 Pf = frac(P.xyxy) - float4(0.0, 0.0, 1.0, 1.0);
		Pi = mod289(Pi); // To avoid truncation effects in permutation
		float4 ix = Pi.xzxz;
		float4 iy = Pi.yyww;
		float4 fx = Pf.xzxz;
		float4 fy = Pf.yyww;

		float4 i = permute(permute(ix) + iy);

		float4 gx = frac(i * (1.0 / 41.0)) * 2.0 - 1.0;
		float4 gy = abs(gx) - 0.5;
		float4 tx = floor(gx + 0.5);
		gx = gx - tx;

		float2 g00 = float2(gx.x, gy.x);
		float2 g10 = float2(gx.y, gy.y);
		float2 g01 = float2(gx.z, gy.z);
		float2 g11 = float2(gx.w, gy.w);

		float4 norm = taylorInvSqrt(float4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11)));
		g00 *= norm.x;
		g01 *= norm.y;
		g10 *= norm.z;
		g11 *= norm.w;

		float n00 = dot(g00, float2(fx.x, fy.x));
		float n10 = dot(g10, float2(fx.y, fy.y));
		float n01 = dot(g01, float2(fx.z, fy.z));
		float n11 = dot(g11, float2(fx.w, fy.w));

		float2 fade_xy = fade(Pf.xy);
		float2 n_x = lerp(float2(n00, n01), float2(n10, n11), fade_xy.x);
		float n_xy = lerp(n_x.x, n_x.y, fade_xy.y);
		return 2.3 * n_xy;
	}

	/*
	-------------------------------------------------------
	CLASSIC 2D PERIODIC
	-------------------------------------------------------
	-------------------------------------------------------
	*/
	float noisePeriodic(float2 P, float2 rep)
	{
		float4 Pi = floor(P.xyxy) + float4(0.0, 0.0, 1.0, 1.0);
		float4 Pf = frac(P.xyxy) - float4(0.0, 0.0, 1.0, 1.0);
		Pi = fmod(Pi, rep.xyxy); // To create noise with explicit period
		Pi = mod289(Pi);        // To avoid truncation effects in permutation
		float4 ix = Pi.xzxz;
		float4 iy = Pi.yyww;
		float4 fx = Pf.xzxz;
		float4 fy = Pf.yyww;

		float4 i = permute(permute(ix) + iy);

		float4 gx = frac(i * (1.0 / 41.0)) * 2.0 - 1.0;
		float4 gy = abs(gx) - 0.5;
		float4 tx = floor(gx + 0.5);
		gx = gx - tx;

		float2 g00 = float2(gx.x, gy.x);
		float2 g10 = float2(gx.y, gy.y);
		float2 g01 = float2(gx.z, gy.z);
		float2 g11 = float2(gx.w, gy.w);

		float4 norm = taylorInvSqrt(float4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11)));
		g00 *= norm.x;
		g01 *= norm.y;
		g10 *= norm.z;
		g11 *= norm.w;

		float n00 = dot(g00, float2(fx.x, fy.x));
		float n10 = dot(g10, float2(fx.y, fy.y));
		float n01 = dot(g01, float2(fx.z, fy.z));
		float n11 = dot(g11, float2(fx.w, fy.w));

		float2 fade_xy = fade(Pf.xy);
		float2 n_x = lerp(float2(n00, n01), float2(n10, n11), fade_xy.x);
		float n_xy = lerp(n_x.x, n_x.y, fade_xy.y);
		return 2.3 * n_xy;
	}

	/*
	-------------------------------------------------------
	SIMPLEX 2D
	-------------------------------------------------------
	-------------------------------------------------------
	*/
	float noiseSimplex(float2 v)
	{
		const float4 C = float4(0.211324865405187,  // (3.0-sqrt(3.0))/6.0
			0.366025403784439,  // 0.5*(sqrt(3.0)-1.0)
			-0.577350269189626,  // -1.0 + 2.0 * C.x
			0.024390243902439); // 1.0 / 41.0
								// First corner
		float2 i = floor(v + dot(v, C.yy));
		float2 x0 = v - i + dot(i, C.xx);

		// Other corners
		float2 i1;
		//i1.x = step( x0.y, x0.x ); // x0.x > x0.y ? 1.0 : 0.0
		//i1.y = 1.0 - i1.x;
		i1 = (x0.x > x0.y) ? float2(1.0, 0.0) : float2(0.0, 1.0);
		// x0 = x0 - 0.0 + 0.0 * C.xx ;
		// x1 = x0 - i1 + 1.0 * C.xx ;
		// x2 = x0 - 1.0 + 2.0 * C.xx ;
		float4 x12 = x0.xyxy + C.xxzz;
		x12.xy -= i1;

		// Permutations
		i = mod289(i); // Avoid truncation effects in permutation
		float3 p = permute(permute(i.y + float3(0.0, i1.y, 1.0))
			+ i.x + float3(0.0, i1.x, 1.0));

		float3 m = max(0.5 - float3(dot(x0, x0), dot(x12.xy, x12.xy), dot(x12.zw, x12.zw)), 0.0);
		m = m * m;
		m = m * m;

		// Gradients: 41 points uniformly over a line, mapped onto a diamond.
		// The ring size 17*17 = 289 is close to a multiple of 41 (41*7 = 287)

		float3 x = 2.0 * frac(p * C.www) - 1.0;
		float3 h = abs(x) - 0.5;
		float3 ox = floor(x + 0.5);
		float3 a0 = x - ox;

		// Normalise gradients implicitly by scaling m
		// Approximation of: m *= inversesqrt( a0*a0 + h*h );
		m *= 1.79284291400159 - 0.85373472095314 * (a0*a0 + h * h);

		// Compute final noise value at P
		float3 g;
		g.x = a0.x  * x0.x + h.x  * x0.y;
		g.yz = a0.yz * x12.xz + h.yz * x12.yw;
		return 130.0 * dot(m, g);
	}

	/*
	-------------------------------------------------------
	CLASSIC 3D
	-------------------------------------------------------
	-------------------------------------------------------
	*/
	float3 fade(float3 t) {
		return t * t*t*(t*(t*6.0 - 15.0) + 10.0);
	}

	// Classic Perlin noise
	float noiseClassic(float3 P)
	{
		float3 Pi0 = floor(P); // Integer part for indexing
		float3 Pi1 = Pi0 + 1.0; // Integer part + 1
		Pi0 = mod289(Pi0);
		Pi1 = mod289(Pi1);
		float3 Pf0 = frac(P); // fracional part for interpolation
		float3 Pf1 = Pf0 - 1.0; // fracional part - 1.0
		float4 ix = float4(Pi0.x, Pi1.x, Pi0.x, Pi1.x);
		float4 iy = float4(Pi0.yy, Pi1.yy);
		float4 iz0 = Pi0.zzzz;
		float4 iz1 = Pi1.zzzz;

		float4 ixy = permute(permute(ix) + iy);
		float4 ixy0 = permute(ixy + iz0);
		float4 ixy1 = permute(ixy + iz1);

		float4 gx0 = ixy0 * (1.0 / 7.0);
		float4 gy0 = frac(floor(gx0) * (1.0 / 7.0)) - 0.5;
		gx0 = frac(gx0);
		float4 gz0 = 0.5 - abs(gx0) - abs(gy0);
		float4 sz0 = step(gz0, 0.0);
		gx0 -= sz0 * (step(0.0, gx0) - 0.5);
		gy0 -= sz0 * (step(0.0, gy0) - 0.5);

		float4 gx1 = ixy1 * (1.0 / 7.0);
		float4 gy1 = frac(floor(gx1) * (1.0 / 7.0)) - 0.5;
		gx1 = frac(gx1);
		float4 gz1 = 0.5 - abs(gx1) - abs(gy1);
		float4 sz1 = step(gz1, 0.0);
		gx1 -= sz1 * (step(0.0, gx1) - 0.5);
		gy1 -= sz1 * (step(0.0, gy1) - 0.5);

		float3 g000 = float3(gx0.x, gy0.x, gz0.x);
		float3 g100 = float3(gx0.y, gy0.y, gz0.y);
		float3 g010 = float3(gx0.z, gy0.z, gz0.z);
		float3 g110 = float3(gx0.w, gy0.w, gz0.w);
		float3 g001 = float3(gx1.x, gy1.x, gz1.x);
		float3 g101 = float3(gx1.y, gy1.y, gz1.y);
		float3 g011 = float3(gx1.z, gy1.z, gz1.z);
		float3 g111 = float3(gx1.w, gy1.w, gz1.w);

		float4 norm0 = taylorInvSqrt(float4(dot(g000, g000), dot(g010, g010), dot(g100, g100), dot(g110, g110)));
		g000 *= norm0.x;
		g010 *= norm0.y;
		g100 *= norm0.z;
		g110 *= norm0.w;
		float4 norm1 = taylorInvSqrt(float4(dot(g001, g001), dot(g011, g011), dot(g101, g101), dot(g111, g111)));
		g001 *= norm1.x;
		g011 *= norm1.y;
		g101 *= norm1.z;
		g111 *= norm1.w;

		float n000 = dot(g000, Pf0);
		float n100 = dot(g100, float3(Pf1.x, Pf0.yz));
		float n010 = dot(g010, float3(Pf0.x, Pf1.y, Pf0.z));
		float n110 = dot(g110, float3(Pf1.xy, Pf0.z));
		float n001 = dot(g001, float3(Pf0.xy, Pf1.z));
		float n101 = dot(g101, float3(Pf1.x, Pf0.y, Pf1.z));
		float n011 = dot(g011, float3(Pf0.x, Pf1.yz));
		float n111 = dot(g111, Pf1);

		float3 fade_xyz = fade(Pf0);
		float4 n_z = lerp(float4(n000, n100, n010, n110), float4(n001, n101, n011, n111), fade_xyz.z);
		float2 n_yz = lerp(n_z.xy, n_z.zw, fade_xyz.y);
		float n_xyz = lerp(n_yz.x, n_yz.y, fade_xyz.x);
		return 2.2 * n_xyz;
	}

	/*
	-------------------------------------------------------
	CLASSIC 3D PERIODIC
	-------------------------------------------------------
	-------------------------------------------------------
	*/
	float noisePeriodic(float3 P, float3 rep)
	{
		float3 Pi0 = fmod(floor(P), rep); // Integer part, modulo period
		float3 Pi1 = fmod(Pi0 + 1.0, rep); // Integer part + 1, mod period
		Pi0 = mod289(Pi0);
		Pi1 = mod289(Pi1);
		float3 Pf0 = frac(P); // fracional part for interpolation
		float3 Pf1 = Pf0 - 1.0; // fracional part - 1.0
		float4 ix = float4(Pi0.x, Pi1.x, Pi0.x, Pi1.x);
		float4 iy = float4(Pi0.yy, Pi1.yy);
		float4 iz0 = Pi0.zzzz;
		float4 iz1 = Pi1.zzzz;

		float4 ixy = permute(permute(ix) + iy);
		float4 ixy0 = permute(ixy + iz0);
		float4 ixy1 = permute(ixy + iz1);

		float4 gx0 = ixy0 * (1.0 / 7.0);
		float4 gy0 = frac(floor(gx0) * (1.0 / 7.0)) - 0.5;
		gx0 = frac(gx0);
		float4 gz0 = 0.5 - abs(gx0) - abs(gy0);
		float4 sz0 = step(gz0, 0.0);
		gx0 -= sz0 * (step(0.0, gx0) - 0.5);
		gy0 -= sz0 * (step(0.0, gy0) - 0.5);

		float4 gx1 = ixy1 * (1.0 / 7.0);
		float4 gy1 = frac(floor(gx1) * (1.0 / 7.0)) - 0.5;
		gx1 = frac(gx1);
		float4 gz1 = 0.5 - abs(gx1) - abs(gy1);
		float4 sz1 = step(gz1, 0.0);
		gx1 -= sz1 * (step(0.0, gx1) - 0.5);
		gy1 -= sz1 * (step(0.0, gy1) - 0.5);

		float3 g000 = float3(gx0.x, gy0.x, gz0.x);
		float3 g100 = float3(gx0.y, gy0.y, gz0.y);
		float3 g010 = float3(gx0.z, gy0.z, gz0.z);
		float3 g110 = float3(gx0.w, gy0.w, gz0.w);
		float3 g001 = float3(gx1.x, gy1.x, gz1.x);
		float3 g101 = float3(gx1.y, gy1.y, gz1.y);
		float3 g011 = float3(gx1.z, gy1.z, gz1.z);
		float3 g111 = float3(gx1.w, gy1.w, gz1.w);

		float4 norm0 = taylorInvSqrt(float4(dot(g000, g000), dot(g010, g010), dot(g100, g100), dot(g110, g110)));
		g000 *= norm0.x;
		g010 *= norm0.y;
		g100 *= norm0.z;
		g110 *= norm0.w;
		float4 norm1 = taylorInvSqrt(float4(dot(g001, g001), dot(g011, g011), dot(g101, g101), dot(g111, g111)));
		g001 *= norm1.x;
		g011 *= norm1.y;
		g101 *= norm1.z;
		g111 *= norm1.w;

		float n000 = dot(g000, Pf0);
		float n100 = dot(g100, float3(Pf1.x, Pf0.yz));
		float n010 = dot(g010, float3(Pf0.x, Pf1.y, Pf0.z));
		float n110 = dot(g110, float3(Pf1.xy, Pf0.z));
		float n001 = dot(g001, float3(Pf0.xy, Pf1.z));
		float n101 = dot(g101, float3(Pf1.x, Pf0.y, Pf1.z));
		float n011 = dot(g011, float3(Pf0.x, Pf1.yz));
		float n111 = dot(g111, Pf1);

		float3 fade_xyz = fade(Pf0);
		float4 n_z = lerp(float4(n000, n100, n010, n110), float4(n001, n101, n011, n111), fade_xyz.z);
		float2 n_yz = lerp(n_z.xy, n_z.zw, fade_xyz.y);
		float n_xyz = lerp(n_yz.x, n_yz.y, fade_xyz.x);
		return 2.2 * n_xyz;
	}

	/*
	-------------------------------------------------------
	SIMPLEX 3D
	-------------------------------------------------------
	-------------------------------------------------------
	*/
	float noiseSimplex(float3 v)
	{
		const float2  C = float2(1.0 / 6.0, 1.0 / 3.0);
		const float4  D = float4(0.0, 0.5, 1.0, 2.0);

		// First corner
		float3 i = floor(v + dot(v, C.yyy));
		float3 x0 = v - i + dot(i, C.xxx);

		// Other corners
		float3 g = step(x0.yzx, x0.xyz);
		float3 l = 1.0 - g;
		float3 i1 = min(g.xyz, l.zxy);
		float3 i2 = max(g.xyz, l.zxy);

		//   x0 = x0 - 0.0 + 0.0 * C.xxx;
		//   x1 = x0 - i1  + 1.0 * C.xxx;
		//   x2 = x0 - i2  + 2.0 * C.xxx;
		//   x3 = x0 - 1.0 + 3.0 * C.xxx;
		float3 x1 = x0 - i1 + C.xxx;
		float3 x2 = x0 - i2 + C.yyy; // 2.0*C.x = 1/3 = C.y
		float3 x3 = x0 - D.yyy;      // -1.0+3.0*C.x = -0.5 = -D.y

								   // Permutations
		i = mod289(i);
		float4 p = permute(permute(permute(
			i.z + float4(0.0, i1.z, i2.z, 1.0))
			+ i.y + float4(0.0, i1.y, i2.y, 1.0))
			+ i.x + float4(0.0, i1.x, i2.x, 1.0));

		// Gradients: 7x7 points over a square, mapped onto an octahedron.
		// The ring size 17*17 = 289 is close to a multiple of 49 (49*6 = 294)
		float n_ = 0.142857142857; // 1.0/7.0
		float3  ns = n_ * D.wyz - D.xzx;

		float4 j = p - 49.0 * floor(p * ns.z * ns.z);  //  fmod(p,7*7)

		float4 x_ = floor(j * ns.z);
		float4 y_ = floor(j - 7.0 * x_);    // fmod(j,N)

		float4 x = x_ * ns.x + ns.yyyy;
		float4 y = y_ * ns.x + ns.yyyy;
		float4 h = 1.0 - abs(x) - abs(y);

		float4 b0 = float4(x.xy, y.xy);
		float4 b1 = float4(x.zw, y.zw);

		//float4 s0 = float4(lessThan(b0,0.0))*2.0 - 1.0;
		//float4 s1 = float4(lessThan(b1,0.0))*2.0 - 1.0;
		float4 s0 = floor(b0)*2.0 + 1.0;
		float4 s1 = floor(b1)*2.0 + 1.0;
		float4 sh = -step(h, 0.0);

		float4 a0 = b0.xzyw + s0.xzyw*sh.xxyy;
		float4 a1 = b1.xzyw + s1.xzyw*sh.zzww;

		float3 p0 = float3(a0.xy, h.x);
		float3 p1 = float3(a0.zw, h.y);
		float3 p2 = float3(a1.xy, h.z);
		float3 p3 = float3(a1.zw, h.w);

		//Normalise gradients
		float4 norm = taylorInvSqrt(float4(dot(p0, p0), dot(p1, p1), dot(p2, p2), dot(p3, p3)));
		p0 *= norm.x;
		p1 *= norm.y;
		p2 *= norm.z;
		p3 *= norm.w;

		// lerp final noise value
		float4 m = max(0.6 - float4(dot(x0, x0), dot(x1, x1), dot(x2, x2), dot(x3, x3)), 0.0);
		m = m * m;
		return 42.0 * dot(m*m, float4(dot(p0, x0), dot(p1, x1),
			dot(p2, x2), dot(p3, x3)));
	}

	/*
	-------------------------------------------------------
	CLASSIC 4D
	-------------------------------------------------------
	-------------------------------------------------------
	*/
	float4 fade(float4 t) {
		return t * t*t*(t*(t*6.0 - 15.0) + 10.0);
	}

	// Classic Perlin noise
	float noiseClassic(float4 P)
	{
		float4 Pi0 = floor(P); // Integer part for indexing
		float4 Pi1 = Pi0 + 1.0; // Integer part + 1
		Pi0 = mod289(Pi0);
		Pi1 = mod289(Pi1);
		float4 Pf0 = frac(P); // fracional part for interpolation
		float4 Pf1 = Pf0 - 1.0; // fracional part - 1.0
		float4 ix = float4(Pi0.x, Pi1.x, Pi0.x, Pi1.x);
		float4 iy = float4(Pi0.yy, Pi1.yy);
		float4 iz0 = float4(Pi0.zzzz);
		float4 iz1 = float4(Pi1.zzzz);
		float4 iw0 = float4(Pi0.wwww);
		float4 iw1 = float4(Pi1.wwww);

		float4 ixy = permute(permute(ix) + iy);
		float4 ixy0 = permute(ixy + iz0);
		float4 ixy1 = permute(ixy + iz1);
		float4 ixy00 = permute(ixy0 + iw0);
		float4 ixy01 = permute(ixy0 + iw1);
		float4 ixy10 = permute(ixy1 + iw0);
		float4 ixy11 = permute(ixy1 + iw1);

		float4 gx00 = ixy00 * (1.0 / 7.0);
		float4 gy00 = floor(gx00) * (1.0 / 7.0);
		float4 gz00 = floor(gy00) * (1.0 / 6.0);
		gx00 = frac(gx00) - 0.5;
		gy00 = frac(gy00) - 0.5;
		gz00 = frac(gz00) - 0.5;
		float4 gw00 = 0.75 - abs(gx00) - abs(gy00) - abs(gz00);
		float4 sw00 = step(gw00, 0.0);
		gx00 -= sw00 * (step(0.0, gx00) - 0.5);
		gy00 -= sw00 * (step(0.0, gy00) - 0.5);

		float4 gx01 = ixy01 * (1.0 / 7.0);
		float4 gy01 = floor(gx01) * (1.0 / 7.0);
		float4 gz01 = floor(gy01) * (1.0 / 6.0);
		gx01 = frac(gx01) - 0.5;
		gy01 = frac(gy01) - 0.5;
		gz01 = frac(gz01) - 0.5;
		float4 gw01 = 0.75 - abs(gx01) - abs(gy01) - abs(gz01);
		float4 sw01 = step(gw01, 0.0);
		gx01 -= sw01 * (step(0.0, gx01) - 0.5);
		gy01 -= sw01 * (step(0.0, gy01) - 0.5);

		float4 gx10 = ixy10 * (1.0 / 7.0);
		float4 gy10 = floor(gx10) * (1.0 / 7.0);
		float4 gz10 = floor(gy10) * (1.0 / 6.0);
		gx10 = frac(gx10) - 0.5;
		gy10 = frac(gy10) - 0.5;
		gz10 = frac(gz10) - 0.5;
		float4 gw10 = 0.75 - abs(gx10) - abs(gy10) - abs(gz10);
		float4 sw10 = step(gw10, 0.0);
		gx10 -= sw10 * (step(0.0, gx10) - 0.5);
		gy10 -= sw10 * (step(0.0, gy10) - 0.5);

		float4 gx11 = ixy11 * (1.0 / 7.0);
		float4 gy11 = floor(gx11) * (1.0 / 7.0);
		float4 gz11 = floor(gy11) * (1.0 / 6.0);
		gx11 = frac(gx11) - 0.5;
		gy11 = frac(gy11) - 0.5;
		gz11 = frac(gz11) - 0.5;
		float4 gw11 = 0.75 - abs(gx11) - abs(gy11) - abs(gz11);
		float4 sw11 = step(gw11, 0.0);
		gx11 -= sw11 * (step(0.0, gx11) - 0.5);
		gy11 -= sw11 * (step(0.0, gy11) - 0.5);

		float4 g0000 = float4(gx00.x, gy00.x, gz00.x, gw00.x);
		float4 g1000 = float4(gx00.y, gy00.y, gz00.y, gw00.y);
		float4 g0100 = float4(gx00.z, gy00.z, gz00.z, gw00.z);
		float4 g1100 = float4(gx00.w, gy00.w, gz00.w, gw00.w);
		float4 g0010 = float4(gx10.x, gy10.x, gz10.x, gw10.x);
		float4 g1010 = float4(gx10.y, gy10.y, gz10.y, gw10.y);
		float4 g0110 = float4(gx10.z, gy10.z, gz10.z, gw10.z);
		float4 g1110 = float4(gx10.w, gy10.w, gz10.w, gw10.w);
		float4 g0001 = float4(gx01.x, gy01.x, gz01.x, gw01.x);
		float4 g1001 = float4(gx01.y, gy01.y, gz01.y, gw01.y);
		float4 g0101 = float4(gx01.z, gy01.z, gz01.z, gw01.z);
		float4 g1101 = float4(gx01.w, gy01.w, gz01.w, gw01.w);
		float4 g0011 = float4(gx11.x, gy11.x, gz11.x, gw11.x);
		float4 g1011 = float4(gx11.y, gy11.y, gz11.y, gw11.y);
		float4 g0111 = float4(gx11.z, gy11.z, gz11.z, gw11.z);
		float4 g1111 = float4(gx11.w, gy11.w, gz11.w, gw11.w);

		float4 norm00 = taylorInvSqrt(float4(dot(g0000, g0000), dot(g0100, g0100), dot(g1000, g1000), dot(g1100, g1100)));
		g0000 *= norm00.x;
		g0100 *= norm00.y;
		g1000 *= norm00.z;
		g1100 *= norm00.w;

		float4 norm01 = taylorInvSqrt(float4(dot(g0001, g0001), dot(g0101, g0101), dot(g1001, g1001), dot(g1101, g1101)));
		g0001 *= norm01.x;
		g0101 *= norm01.y;
		g1001 *= norm01.z;
		g1101 *= norm01.w;

		float4 norm10 = taylorInvSqrt(float4(dot(g0010, g0010), dot(g0110, g0110), dot(g1010, g1010), dot(g1110, g1110)));
		g0010 *= norm10.x;
		g0110 *= norm10.y;
		g1010 *= norm10.z;
		g1110 *= norm10.w;

		float4 norm11 = taylorInvSqrt(float4(dot(g0011, g0011), dot(g0111, g0111), dot(g1011, g1011), dot(g1111, g1111)));
		g0011 *= norm11.x;
		g0111 *= norm11.y;
		g1011 *= norm11.z;
		g1111 *= norm11.w;

		float n0000 = dot(g0000, Pf0);
		float n1000 = dot(g1000, float4(Pf1.x, Pf0.yzw));
		float n0100 = dot(g0100, float4(Pf0.x, Pf1.y, Pf0.zw));
		float n1100 = dot(g1100, float4(Pf1.xy, Pf0.zw));
		float n0010 = dot(g0010, float4(Pf0.xy, Pf1.z, Pf0.w));
		float n1010 = dot(g1010, float4(Pf1.x, Pf0.y, Pf1.z, Pf0.w));
		float n0110 = dot(g0110, float4(Pf0.x, Pf1.yz, Pf0.w));
		float n1110 = dot(g1110, float4(Pf1.xyz, Pf0.w));
		float n0001 = dot(g0001, float4(Pf0.xyz, Pf1.w));
		float n1001 = dot(g1001, float4(Pf1.x, Pf0.yz, Pf1.w));
		float n0101 = dot(g0101, float4(Pf0.x, Pf1.y, Pf0.z, Pf1.w));
		float n1101 = dot(g1101, float4(Pf1.xy, Pf0.z, Pf1.w));
		float n0011 = dot(g0011, float4(Pf0.xy, Pf1.zw));
		float n1011 = dot(g1011, float4(Pf1.x, Pf0.y, Pf1.zw));
		float n0111 = dot(g0111, float4(Pf0.x, Pf1.yzw));
		float n1111 = dot(g1111, Pf1);

		float4 fade_xyzw = fade(Pf0);
		float4 n_0w = lerp(float4(n0000, n1000, n0100, n1100), float4(n0001, n1001, n0101, n1101), fade_xyzw.w);
		float4 n_1w = lerp(float4(n0010, n1010, n0110, n1110), float4(n0011, n1011, n0111, n1111), fade_xyzw.w);
		float4 n_zw = lerp(n_0w, n_1w, fade_xyzw.z);
		float2 n_yzw = lerp(n_zw.xy, n_zw.zw, fade_xyzw.y);
		float n_xyzw = lerp(n_yzw.x, n_yzw.y, fade_xyzw.x);
		return 2.2 * n_xyzw;
	}

	/*
	-------------------------------------------------------
	CLASSIC 4D PERIODIC
	-------------------------------------------------------
	-------------------------------------------------------
	*/
	float noisePeriodic(float4 P, float4 rep)
	{
		float4 Pi0 = fmod(floor(P), rep); // Integer part modulo rep
		float4 Pi1 = fmod(Pi0 + 1.0, rep); // Integer part + 1 mod rep
		Pi0 = mod289(Pi0);
		Pi1 = mod289(Pi1);
		float4 Pf0 = frac(P); // fracional part for interpolation
		float4 Pf1 = Pf0 - 1.0; // fracional part - 1.0
		float4 ix = float4(Pi0.x, Pi1.x, Pi0.x, Pi1.x);
		float4 iy = float4(Pi0.yy, Pi1.yy);
		float4 iz0 = float4(Pi0.zzzz);
		float4 iz1 = float4(Pi1.zzzz);
		float4 iw0 = float4(Pi0.wwww);
		float4 iw1 = float4(Pi1.wwww);

		float4 ixy = permute(permute(ix) + iy);
		float4 ixy0 = permute(ixy + iz0);
		float4 ixy1 = permute(ixy + iz1);
		float4 ixy00 = permute(ixy0 + iw0);
		float4 ixy01 = permute(ixy0 + iw1);
		float4 ixy10 = permute(ixy1 + iw0);
		float4 ixy11 = permute(ixy1 + iw1);

		float4 gx00 = ixy00 * (1.0 / 7.0);
		float4 gy00 = floor(gx00) * (1.0 / 7.0);
		float4 gz00 = floor(gy00) * (1.0 / 6.0);
		gx00 = frac(gx00) - 0.5;
		gy00 = frac(gy00) - 0.5;
		gz00 = frac(gz00) - 0.5;
		float4 gw00 = 0.75 - abs(gx00) - abs(gy00) - abs(gz00);
		float4 sw00 = step(gw00, 0.0);
		gx00 -= sw00 * (step(0.0, gx00) - 0.5);
		gy00 -= sw00 * (step(0.0, gy00) - 0.5);

		float4 gx01 = ixy01 * (1.0 / 7.0);
		float4 gy01 = floor(gx01) * (1.0 / 7.0);
		float4 gz01 = floor(gy01) * (1.0 / 6.0);
		gx01 = frac(gx01) - 0.5;
		gy01 = frac(gy01) - 0.5;
		gz01 = frac(gz01) - 0.5;
		float4 gw01 = 0.75 - abs(gx01) - abs(gy01) - abs(gz01);
		float4 sw01 = step(gw01, 0.0);
		gx01 -= sw01 * (step(0.0, gx01) - 0.5);
		gy01 -= sw01 * (step(0.0, gy01) - 0.5);

		float4 gx10 = ixy10 * (1.0 / 7.0);
		float4 gy10 = floor(gx10) * (1.0 / 7.0);
		float4 gz10 = floor(gy10) * (1.0 / 6.0);
		gx10 = frac(gx10) - 0.5;
		gy10 = frac(gy10) - 0.5;
		gz10 = frac(gz10) - 0.5;
		float4 gw10 = 0.75 - abs(gx10) - abs(gy10) - abs(gz10);
		float4 sw10 = step(gw10, 0.0);
		gx10 -= sw10 * (step(0.0, gx10) - 0.5);
		gy10 -= sw10 * (step(0.0, gy10) - 0.5);

		float4 gx11 = ixy11 * (1.0 / 7.0);
		float4 gy11 = floor(gx11) * (1.0 / 7.0);
		float4 gz11 = floor(gy11) * (1.0 / 6.0);
		gx11 = frac(gx11) - 0.5;
		gy11 = frac(gy11) - 0.5;
		gz11 = frac(gz11) - 0.5;
		float4 gw11 = 0.75 - abs(gx11) - abs(gy11) - abs(gz11);
		float4 sw11 = step(gw11, 0.0);
		gx11 -= sw11 * (step(0.0, gx11) - 0.5);
		gy11 -= sw11 * (step(0.0, gy11) - 0.5);

		float4 g0000 = float4(gx00.x, gy00.x, gz00.x, gw00.x);
		float4 g1000 = float4(gx00.y, gy00.y, gz00.y, gw00.y);
		float4 g0100 = float4(gx00.z, gy00.z, gz00.z, gw00.z);
		float4 g1100 = float4(gx00.w, gy00.w, gz00.w, gw00.w);
		float4 g0010 = float4(gx10.x, gy10.x, gz10.x, gw10.x);
		float4 g1010 = float4(gx10.y, gy10.y, gz10.y, gw10.y);
		float4 g0110 = float4(gx10.z, gy10.z, gz10.z, gw10.z);
		float4 g1110 = float4(gx10.w, gy10.w, gz10.w, gw10.w);
		float4 g0001 = float4(gx01.x, gy01.x, gz01.x, gw01.x);
		float4 g1001 = float4(gx01.y, gy01.y, gz01.y, gw01.y);
		float4 g0101 = float4(gx01.z, gy01.z, gz01.z, gw01.z);
		float4 g1101 = float4(gx01.w, gy01.w, gz01.w, gw01.w);
		float4 g0011 = float4(gx11.x, gy11.x, gz11.x, gw11.x);
		float4 g1011 = float4(gx11.y, gy11.y, gz11.y, gw11.y);
		float4 g0111 = float4(gx11.z, gy11.z, gz11.z, gw11.z);
		float4 g1111 = float4(gx11.w, gy11.w, gz11.w, gw11.w);

		float4 norm00 = taylorInvSqrt(float4(dot(g0000, g0000), dot(g0100, g0100), dot(g1000, g1000), dot(g1100, g1100)));
		g0000 *= norm00.x;
		g0100 *= norm00.y;
		g1000 *= norm00.z;
		g1100 *= norm00.w;

		float4 norm01 = taylorInvSqrt(float4(dot(g0001, g0001), dot(g0101, g0101), dot(g1001, g1001), dot(g1101, g1101)));
		g0001 *= norm01.x;
		g0101 *= norm01.y;
		g1001 *= norm01.z;
		g1101 *= norm01.w;

		float4 norm10 = taylorInvSqrt(float4(dot(g0010, g0010), dot(g0110, g0110), dot(g1010, g1010), dot(g1110, g1110)));
		g0010 *= norm10.x;
		g0110 *= norm10.y;
		g1010 *= norm10.z;
		g1110 *= norm10.w;

		float4 norm11 = taylorInvSqrt(float4(dot(g0011, g0011), dot(g0111, g0111), dot(g1011, g1011), dot(g1111, g1111)));
		g0011 *= norm11.x;
		g0111 *= norm11.y;
		g1011 *= norm11.z;
		g1111 *= norm11.w;

		float n0000 = dot(g0000, Pf0);
		float n1000 = dot(g1000, float4(Pf1.x, Pf0.yzw));
		float n0100 = dot(g0100, float4(Pf0.x, Pf1.y, Pf0.zw));
		float n1100 = dot(g1100, float4(Pf1.xy, Pf0.zw));
		float n0010 = dot(g0010, float4(Pf0.xy, Pf1.z, Pf0.w));
		float n1010 = dot(g1010, float4(Pf1.x, Pf0.y, Pf1.z, Pf0.w));
		float n0110 = dot(g0110, float4(Pf0.x, Pf1.yz, Pf0.w));
		float n1110 = dot(g1110, float4(Pf1.xyz, Pf0.w));
		float n0001 = dot(g0001, float4(Pf0.xyz, Pf1.w));
		float n1001 = dot(g1001, float4(Pf1.x, Pf0.yz, Pf1.w));
		float n0101 = dot(g0101, float4(Pf0.x, Pf1.y, Pf0.z, Pf1.w));
		float n1101 = dot(g1101, float4(Pf1.xy, Pf0.z, Pf1.w));
		float n0011 = dot(g0011, float4(Pf0.xy, Pf1.zw));
		float n1011 = dot(g1011, float4(Pf1.x, Pf0.y, Pf1.zw));
		float n0111 = dot(g0111, float4(Pf0.x, Pf1.yzw));
		float n1111 = dot(g1111, Pf1);

		float4 fade_xyzw = fade(Pf0);
		float4 n_0w = lerp(float4(n0000, n1000, n0100, n1100), float4(n0001, n1001, n0101, n1101), fade_xyzw.w);
		float4 n_1w = lerp(float4(n0010, n1010, n0110, n1110), float4(n0011, n1011, n0111, n1111), fade_xyzw.w);
		float4 n_zw = lerp(n_0w, n_1w, fade_xyzw.z);
		float2 n_yzw = lerp(n_zw.xy, n_zw.zw, fade_xyzw.y);
		float n_xyzw = lerp(n_yzw.x, n_yzw.y, fade_xyzw.x);
		return 2.2 * n_xyzw;
	}

	/*
	-------------------------------------------------------
	SIMPLEX 4D
	-------------------------------------------------------
	-------------------------------------------------------
	*/
	float permute(float x) {
		return mod289(((x*34.0) + 1.0)*x);
	}

	float taylorInvSqrt(float r)
	{
		return 1.79284291400159 - 0.85373472095314 * r;
	}

	float4 grad4(float j, float4 ip)
	{
		const float4 ones = float4(1.0, 1.0, 1.0, -1.0);
		float4 p, s;

		p.xyz = floor(frac(float3(j, j, j) * ip.xyz) * 7.0) * ip.z - 1.0;
		p.w = 1.5 - dot(abs(p.xyz), ones.xyz);
		// s = float4(lessThan(p, 0.0));
		p.xyz = p.xyz + (s.xyz*2.0 - 1.0) * s.www;

		return p;
	}

	// (sqrt(5) - 1)/4 = F4, used once below
#define F4 0.309016994374947451

	float noiseSimplex(float4 v)
	{
		const float4  C = float4(0.138196601125011,  // (5 - sqrt(5))/20  G4
			0.276393202250021,  // 2 * G4
			0.414589803375032,  // 3 * G4
			-0.447213595499958); // -1 + 4 * G4

								 // First corner
		float4 i = floor(v + dot(v, F4));
		float4 x0 = v - i + dot(i, C.xxxx);

		// Other corners

		// Rank sorting originally contributed by Bill Licea-Kane, AMD (formerly ATI)
		float4 i0;
		float3 isX = step(x0.yzw, x0.xxx);
		float3 isYZ = step(x0.zww, x0.yyz);
		//  i0.x = dot( isX, float3( 1.0 ) );
		i0.x = isX.x + isX.y + isX.z;
		i0.yzw = 1.0 - isX;
		//  i0.y += dot( isYZ.xy, float2( 1.0 ) );
		i0.y += isYZ.x + isYZ.y;
		i0.zw += 1.0 - isYZ.xy;
		i0.z += isYZ.z;
		i0.w += 1.0 - isYZ.z;

		// i0 now contains the unique values 0,1,2,3 in each channel
		float4 i3 = clamp(i0, 0.0, 1.0);
		float4 i2 = clamp(i0 - 1.0, 0.0, 1.0);
		float4 i1 = clamp(i0 - 2.0, 0.0, 1.0);

		//  x0 = x0 - 0.0 + 0.0 * C.xxxx
		//  x1 = x0 - i1  + 1.0 * C.xxxx
		//  x2 = x0 - i2  + 2.0 * C.xxxx
		//  x3 = x0 - i3  + 3.0 * C.xxxx
		//  x4 = x0 - 1.0 + 4.0 * C.xxxx
		float4 x1 = x0 - i1 + C.xxxx;
		float4 x2 = x0 - i2 + C.yyyy;
		float4 x3 = x0 - i3 + C.zzzz;
		float4 x4 = x0 + C.wwww;

		// Permutations
		i = mod289(i);
		float j0 = permute(permute(permute(permute(i.w) + i.z) + i.y) + i.x);
		float4 j1 = permute(permute(permute(permute(
			i.w + float4(i1.w, i2.w, i3.w, 1.0))
			+ i.z + float4(i1.z, i2.z, i3.z, 1.0))
			+ i.y + float4(i1.y, i2.y, i3.y, 1.0))
			+ i.x + float4(i1.x, i2.x, i3.x, 1.0));

		// Gradients: 7x7x6 points over a cube, mapped onto a 4-cross polytope
		// 7*7*6 = 294, which is close to the ring size 17*17 = 289.
		float4 ip = float4(1.0 / 294.0, 1.0 / 49.0, 1.0 / 7.0, 0.0);

		float4 p0 = grad4(j0, ip);
		float4 p1 = grad4(j1.x, ip);
		float4 p2 = grad4(j1.y, ip);
		float4 p3 = grad4(j1.z, ip);
		float4 p4 = grad4(j1.w, ip);

		// Normalise gradients
		float4 norm = taylorInvSqrt(float4(dot(p0, p0), dot(p1, p1), dot(p2, p2), dot(p3, p3)));
		p0 *= norm.x;
		p1 *= norm.y;
		p2 *= norm.z;
		p3 *= norm.w;
		p4 *= taylorInvSqrt(dot(p4, p4));

		// lerp contributions from the five corners
		float3 m0 = max(0.6 - float3(dot(x0, x0), dot(x1, x1), dot(x2, x2)), 0.0);
		float2 m1 = max(0.6 - float2(dot(x3, x3), dot(x4, x4)), 0.0);
		m0 = m0 * m0;
		m1 = m1 * m1;
		return 49.0 * (dot(m0*m0, float3(dot(p0, x0), dot(p1, x1), dot(p2, x2)))
			+ dot(m1*m1, float2(dot(p3, x3), dot(p4, x4))));

	}
}