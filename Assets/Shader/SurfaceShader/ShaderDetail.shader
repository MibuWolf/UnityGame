Shader "SurfaceShader/ShaderDetail" {
	Properties {
		_MainTex ("主纹理", 2D) = "white" {}
		_DetailTex("细节纹理", 2D) = "gray" {}
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
		sampler2D _DetailTex;

		struct Input {
			float2 uv_MainTex;
			float2 uv_DetailTex;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;

			o.Albedo += tex2D(_DetailTex, IN.uv_DetailTex).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
