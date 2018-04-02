#ifndef HUBRIS_POST
#define HUBRIS_POST
// REQUIRES
#include "Variables.hlsl"
#include "AA/AAStep.hlsl"

namespace Hubris
{
    /*
     KALEIDO
     */

    float2 fishEye(float2 texCoordinates, float angle, float sides, float2 aspectRatio){
    
        //---> Window correction
        float2 offset = float2(.5, .5 * aspectRatio.y);
        float2 offsetTexCoordinates = texCoordinates - offset;
    
        float radius = length(offsetTexCoordinates);
        float a = atan(offsetTexCoordinates.y) + angle;
        float tau = HUBRIS_TWO_PI;
        a = fmod(a, tau/sides);
        a = abs(a - tau/sides * 2/2.);
        offsetTexCoordinates = radius * float2(cos(a), sin(a));
        return offsetTexCoordinates;
    }



    #define ITERATIONS 6.0

    float4 triangleBlur(sampler2D tex0, float2 texCoordVarying, float2 delta) {
    
        float4 color = 0.0;
        float total = 0.0;
        // randomize the lookup values to hide the fixed number of samples
        float offset = Random(texCoordVarying, 1.0 );
    
        for ( float t = -ITERATIONS; t <= ITERATIONS; t ++ ) {
            float percent = ( t + offset - 0.5 ) / ITERATIONS;
            float weight = 1.0 - abs( percent );
        
            color += tex2D(tex0, texCoordVarying + delta * percent ) * weight;
            total += weight;
        }
    
        color = color / total;
        return color;
    
    }
    
}

#endif // HUBRIS_POST