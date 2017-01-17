Shader "SurfaceShader/BumpRimColor" {
	Properties {
		_MainTex("主纹理", 2D) = "white" {}
		_Color ("主颜色", Color) = (0.6, 0.3, 0.6, 0.3)
		_BumpTex ("凹凸纹理", 2D) = "bump" {}
		_RimColor ("边缘颜色", Color) = (0.26,0.19,0.16,0.0)
		_RimPower("边缘颜色强度",Range(0.5,8.0)) = 3.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		fixed4 _Color;
		sampler2D _BumpTex;
		fixed4 _RimColor;
		half _RimPower;

		struct Input {
			float2 uv_MainTex;
			float2 uv__BumpTex;
			float3 viewDir;
		};


		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c;
			o.Normal = UnpackNormal( tex2D(_BumpTex, IN.uv__BumpTex) );
			half power = 1 - saturate(dot(IN.viewDir ,o.Normal));
			o.Emission = _RimColor * pow(power, _RimPower);
			o.Albedo = c.rgb;


		}
		ENDCG
	}
	FallBack "Diffuse"
}
