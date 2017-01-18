Shader "LightShader/CartoonBumpRimColor" {
	Properties {
		_MainTex("主纹理", 2D) = "white" {}
		_Color("主颜色", Color) = (0.6, 0.3, 0.6, 0.3)
		_BumpTex("凹凸纹理", 2D) = "bump" {}
		_RimColor("边缘颜色", Color) = (0.26,0.19,0.16,0.0)
		_RimPower("边缘颜色强度",Range(0.5,8.0)) = 3.0
		_CartoonTex("动画纹理", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf CartoonBumpRimColor

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		fixed4 _Color;
		sampler2D _BumpTex;
		fixed4 _RimColor;
		half _RimPower;
		sampler2D _CartoonTex;

	struct Input {
		float2 uv_MainTex;
		float2 uv__BumpTex;
		float3 viewDir;
	};


	half4 LightingCartoonBumpRimColor(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
	{
		half nl = saturate(dot(s.Normal, lightDir));
		nl = nl *0.5 + 0.5;
		half3 cartoon = tex2D(_CartoonTex, float2(nl, nl)).rgb;

		half4 c;
		c.rgb = s.Albedo * cartoon * _LightColor0.rgb * (atten * 2);
		c.a = s.Alpha;

		return c;
	}

	void surf(Input IN, inout SurfaceOutput o) {
		// Albedo comes from a texture tinted by color
		fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
		o.Albedo = c;
		o.Normal = UnpackNormal(tex2D(_BumpTex, IN.uv__BumpTex)).rgb;
		half power = 1 - saturate(dot(IN.viewDir ,o.Normal));
		o.Emission = _RimColor * pow(power, _RimPower);
		o.Albedo = c.rgb;


	}
		ENDCG
	}
	FallBack "Diffuse"
}
