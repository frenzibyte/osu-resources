layout(location = 0) in highp vec2 m_Position;
layout(location = 1) in lowp vec4 m_Colour;
layout(location = 2) in mediump vec2 m_TexCoord;
layout(location = 3) in mediump vec4 m_TexRect;
layout(location = 4) in mediump float m_Time;

layout(location = 0) out highp vec2 v_MaskingPosition;
layout(location = 1) out lowp vec4 v_Colour;
layout(location = 2) out mediump vec2 v_TexCoord;
layout(location = 3) out mediump vec4 v_TexRect;
layout(location = 4) out mediump vec2 v_BlendRange;

layout(std140, set = 2, binding = 0) uniform m_CursorTrailParameters
{
    float g_FadeClock;
    float g_FadeExponent;
};

void main(void)
{
	// Transform from screen space to masking space.
    vec3 maskingPos = g_ToMaskingSpace * vec3(m_Position, 1.0);
    v_MaskingPosition = maskingPos.xy / maskingPos.z;

    v_Colour = vec4(m_Colour.rgb, m_Colour.a * pow(clamp(m_Time - g_FadeClock, 0.0, 1.0), g_FadeExponent));

    v_TexCoord = m_TexCoord;
    v_TexRect = m_TexRect;
    v_BlendRange = vec2(0.0);
    
    gl_Position = g_ProjMatrix * vec4(m_Position, 1.0, 1.0);
}
