Shader "Custom/RimsColor" {
	Properties {
		_MainTex ("主贴图", 2D) = "white" {}
		_BumpTex("凹凸贴图", 2D) = "white" {}
		_RimsColor("边缘颜色", Color) = (0.17,0.36,0.81,0.0)
		_RimsPower("边缘颜色强度", Range(0.6,10)) = 1.0
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
		sampler2D _BumpTex;
		float4 _RimsColor;
		float _RimsPower;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpTex;
			float dir;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;

			o.Normal = UnpackNormal(tex2D(_BumpTex, IN.uv_BumpTex));
			float rim = 1.0 - saturate(dot(normalize(IN.dir), o.Normal));

			o.Emission = _RimsColor.rgb * pow( rim, _RimsPower);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
