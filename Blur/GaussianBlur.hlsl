#ifndef HUBRIS_BLUR_GAUSSIANBLUR
#define HUBRIS_BLUR_GAUSSIANBLUR
// REFERENCES
// http://callumhay.blogspot.com/2010/09/gaussian-blur-shader-glsl.html
// http://http.developer.nvidia.com/GPUGems3/gpugems3_ch40.html

// passingTurn: 0 or 1 to indicate vertical or horizontal pass

// The sigma value for the gaussian function: higher value means more blur
// A good value for 9x9 is around 3 to 5
// A good value for 7x7 is around 2.5 to 4
// A good value for 5x5 is around 2 to 3.5
// REQUIRES
#include "../Variables.hlsl"


namespace Hubris
{
	inline half4 GaussianBlur(sampler2D tex0, float2 texCoordinates, float blurAmnt, int passingTurn, float sigma, float numBlurPixelsPerSide)
    {
		half4 outputColor = 0;
		float2 blurMultiplyVec;
		if (passingTurn == 0) blurMultiplyVec = float2(1.0, 0.0);
		else blurMultiplyVec = float2(0.0, 1.0);

		// Incremental Gaussian Coefficent Calculation (See GPU Gems 3 pp. 877 - 889)
		float3 incrementalGaussian;
		incrementalGaussian.x = 1.0 / (sqrt(2.0 * HUBRIS_PI) * sigma);
		incrementalGaussian.y = exp(-0.5f / (sigma * sigma));
		incrementalGaussian.z = incrementalGaussian.y * incrementalGaussian.y;

		half4 avgValue = half4(0.0, 0.0, 0.0, 0.0);
		float coefficientSum = 0.0;

		// Take the central sample first...
		avgValue += tex2D(tex0, texCoordinates) * incrementalGaussian.x;
		coefficientSum += incrementalGaussian.x;
		incrementalGaussian.xy *= incrementalGaussian.yz;

		// Go through the remaining 8 vertical samples (4 on each side of the center)
		for (float i = 1.0; i <= numBlurPixelsPerSide; i++)
		{
			avgValue += tex2D(tex0, texCoordinates - i * blurAmnt * blurMultiplyVec) * incrementalGaussian.x;
			avgValue += tex2D(tex0, texCoordinates + i * blurAmnt * blurMultiplyVec) * incrementalGaussian.x;
			coefficientSum += 2.0 * incrementalGaussian.x;
			incrementalGaussian.xy *= incrementalGaussian.yz;
		}

		outputColor = avgValue / coefficientSum;

		return outputColor;
	}
}

#endif // HUBRIS_BLUR_GAUSSIANBLUR