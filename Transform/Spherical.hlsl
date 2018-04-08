#ifndef HUBRIS_TRANSFORM_SPHERICAL
#define HUBRIS_TRANSFORM_SPHERICAL
// REFERENCE
// http://mathworld.wolfram.com/SphericalCoordinates.html


namespace Hubris
{
    struct Spherical { float radius, theta, phi; };

    inline Spherical ToSpherical(float3 cartesian)
    {
        Spherical spherical;
        spherical.radius = length(cartesian);
        spherical.theta = atan2(cartesian.y, cartesian.x);
        spherical.phi = acos(cartesian.z / spherical.radius);
        return spherical;
    }

    inline float3 PolarToCartesian(Spherical spherical)
    {
        float3 cartesian;
        cartesian.x = spherical.radius * cos(spherical.theta) * sin(spherical.phi);
        cartesian.y = spherical.radius * sin(spherical.theta) * sin(spherical.phi);
        cartesian.z = spherical.radius * cos(spherical.phi);
        return cartesian;
    }
}

#endif // HUBRIS_TRANSFORM_SPHERICAL