Shader "SurfaceShader/FlowingLightShader" {
	Properties {
		_MainTex ("基本纹理", 2D) = "white" {}
		_LightTex("流光纹理", 2D) = "white" {}
		_SpeedX("流光速度X",float) = 0.5
		_SpeedY("流光速度Y",float) = 2
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
		sampler2D _LightTex;
		float _SpeedX;
		float _SpeedY;

		struct Input {
			float2 uv_MainTex;
			float2 uv_LightTex;
		};


		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			IN.uv_LightTex.x = IN.uv_LightTex.x / 2 + _Time.x * _SpeedX;
			IN.uv_LightTex.y = IN.uv_LightTex.y / 2 + _Time.x * _SpeedY;
			fixed4 c1 = tex2D(_LightTex, IN.uv_LightTex);
			o.Albedo.r = o.Albedo.r + c1.r;
			o.Albedo.g = o.Albedo.g + c1.g;
			o.Albedo.b = o.Albedo.b + c1.b;

		}
		ENDCG
	}
	FallBack "Diffuse"
}
