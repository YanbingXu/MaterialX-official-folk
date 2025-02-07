//Metal Shading Language version 2.3
#define __METAL__ 
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define vec2 float2
#define vec3 float3
#define vec4 float4
#define ivec2 int2
#define ivec3 int3
#define ivec4 int4
#define uvec2 uint2
#define uvec3 uint3
#define uvec4 uint4
#define bvec2 bool2
#define bvec3 bool3
#define bvec4 bool4
#define mat3 float3x3
#define mat4 float4x4


// Uniform block: PrivateUniforms
struct PrivateUniforms
{
    mat4 u_worldMatrix;
    mat4 u_viewProjectionMatrix;
    mat4 u_worldInverseTransposeMatrix;
};

// Inputs block: VertexInputs
struct VertexInputs
{
    vec3 i_position [[attribute(0)]];
    vec3 i_normal [[attribute(1)]];
    vec3 i_tangent [[attribute(2)]];
};
struct VertexData
{
    float4 pos [[position]];
    vec3 normalWorld;
    vec3 tangentWorld;
    vec3 positionWorld;
};

struct GlobalContext
{
    GlobalContext(
    vec3 i_position
,     vec3 i_normal
,     vec3 i_tangent
    ,     mat4 u_worldMatrix

    ,     mat4 u_viewProjectionMatrix

    ,     mat4 u_worldInverseTransposeMatrix

    ) : 
    i_position(i_position)
,     i_normal(i_normal)
,     i_tangent(i_tangent)
    ,     u_worldMatrix(u_worldMatrix)

    ,     u_viewProjectionMatrix(u_viewProjectionMatrix)

    ,     u_worldInverseTransposeMatrix(u_worldInverseTransposeMatrix)

    {}
    vec3 i_position;

    vec3 i_normal;

    vec3 i_tangent;
    
    mat4 u_worldMatrix;

    
    mat4 u_viewProjectionMatrix;

    
    mat4 u_worldInverseTransposeMatrix;

    VertexData VertexMain()
    {
        VertexData vd;
        float4 hPositionWorld = u_worldMatrix * float4(i_position, 1.0);
        vd.pos = u_viewProjectionMatrix * hPositionWorld;
        vd.normalWorld = normalize((u_worldInverseTransposeMatrix * vec4(i_normal, 0.0)).xyz);
        vd.tangentWorld = normalize((u_worldMatrix * vec4(i_tangent, 0.0)).xyz);
        vd.positionWorld = hPositionWorld.xyz;

        return vd;
        // Omitted node 'coat_roughness_vector'. Function already called in this scope.
        // Omitted node 'coat_tangent_rotate_degree'. Function already called in this scope.
        // Omitted node 'metal_reflectivity'. Function already called in this scope.
        // Omitted node 'metal_edgecolor'. Function already called in this scope.
        // Omitted node 'coat_affect_roughness_multiply1'. Function already called in this scope.
        // Omitted node 'tangent_rotate_degree'. Function already called in this scope.
        // Omitted node 'transmission_roughness_add'. Function already called in this scope.
        // Omitted node 'subsurface_color_nonnegative'. Function already called in this scope.
        // Omitted node 'coat_clamped'. Function already called in this scope.
        // Omitted node 'subsurface_radius_scaled'. Function already called in this scope.
        // Omitted node 'subsurface_selector'. Function already called in this scope.
        // Omitted node 'base_color_nonnegative'. Function already called in this scope.
        // Omitted node 'coat_attenuation'. Function already called in this scope.
        // Omitted node 'one_minus_coat_ior'. Function already called in this scope.
        // Omitted node 'one_plus_coat_ior'. Function already called in this scope.
        // Omitted node 'emission_weight'. Function already called in this scope.
        // Omitted node 'opacity_luminance'. Function already called in this scope.
        // Omitted node 'geomprop_Nworld'. Function already called in this scope.
        // Omitted node 'geomprop_Tworld'. Function already called in this scope.
        // Omitted node 'artistic_ior'. Function already called in this scope.
        // Omitted node 'coat_affect_roughness_multiply2'. Function already called in this scope.
        // Omitted node 'transmission_roughness_clamped'. Function already called in this scope.
        // Omitted node 'coat_gamma_multiply'. Function already called in this scope.
        // Omitted node 'coat_ior_to_F0_sqrt'. Function already called in this scope.
        // Omitted node 'emission_edf'. Function already called in this scope.
        // Omitted node 'opacity_luminance_float'. Function already called in this scope.
        // Omitted node 'sheen_bsdf'. Function already called in this scope.
        // Omitted node 'coat_tangent_rotate'. Function already called in this scope.
        // Omitted node 'tangent_rotate'. Function already called in this scope.
        // Omitted node 'coat_affected_roughness'. Function already called in this scope.
        // Omitted node 'coat_affected_transmission_roughness'. Function already called in this scope.
        // Omitted node 'coat_gamma'. Function already called in this scope.
        // Omitted node 'coat_ior_to_F0'. Function already called in this scope.
        // Omitted node 'coat_tinted_emission_edf'. Function already called in this scope.
        // Omitted node 'coat_tangent_rotate_normalize'. Function already called in this scope.
        // Omitted node 'tangent_rotate_normalize'. Function already called in this scope.
        // Omitted node 'main_roughness'. Function already called in this scope.
        // Omitted node 'transmission_roughness'. Function already called in this scope.
        // Omitted node 'coat_affected_subsurface_color'. Function already called in this scope.
        // Omitted node 'coat_affected_diffuse_color'. Function already called in this scope.
        // Omitted node 'one_minus_coat_ior_to_F0'. Function already called in this scope.
        // Omitted node 'coat_tangent'. Function already called in this scope.
        // Omitted node 'main_tangent'. Function already called in this scope.
        // Omitted node 'translucent_bsdf'. Function already called in this scope.
        // Omitted node 'subsurface_bsdf'. Function already called in this scope.
        // Omitted node 'diffuse_bsdf'. Function already called in this scope.
        // Omitted node 'emission_color0'. Function already called in this scope.
        // Omitted node 'coat_bsdf'. Function already called in this scope.
        // Omitted node 'metal_bsdf'. Function already called in this scope.
        // Omitted node 'specular_bsdf'. Function already called in this scope.
        // Omitted node 'transmission_bsdf'. Function already called in this scope.
        // Omitted node 'selected_subsurface_bsdf'. Function already called in this scope.
        // Omitted node 'coat_emission_edf'. Function already called in this scope.
        // Omitted node 'subsurface_mix'. Function already called in this scope.
        // Omitted node 'blended_coat_emission_edf'. Function already called in this scope.
        // Omitted node 'sheen_layer'. Function already called in this scope.
        // Omitted node 'transmission_mix'. Function already called in this scope.
        // Omitted node 'specular_layer'. Function already called in this scope.
        // Omitted node 'metalness_mix'. Function already called in this scope.
        // Omitted node 'thin_film_layer_attenuated'. Function already called in this scope.
        // Omitted node 'coat_layer'. Function already called in this scope.
        // Omitted node 'shader_constructor'. Function already called in this scope.
    }

};
vertex VertexData VertexMain(
VertexInputs i_vs [[ stage_in ]], constant PrivateUniforms& u_prv[[ buffer(3) ]])
{
	GlobalContext ctx {i_vs.i_position, i_vs.i_normal, i_vs.i_tangent    , u_prv.u_worldMatrix
    , u_prv.u_viewProjectionMatrix
    , u_prv.u_worldInverseTransposeMatrix
    };
    VertexData out = ctx.VertexMain();
    out.pos.y = -out.pos.y;
    return out;
}

