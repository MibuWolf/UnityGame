Shader "LightShader/CartoonShader" {
	Properties {
		_MainTex("基础纹理", 2D) = "white" {}
		_CartoonTex("动画色差纹理", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf MyCartoon

		sampler2D _MainTex;
		sampler2D _CartoonTex;

		half4 LightingMyCartoon(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
	{
		half nl = saturate(dot(s.Normal, lightDir));
		nl = nl *0.5 + 0.5;
		half3 cartoon = tex2D(_CartoonTex, float2(nl, nl)).rgb;

		half4 c;
		c.rgb = s.Albedo * cartoon * _LightColor0.rgb * (atten * 2);
		c.a = s.Alpha;

		return c;
	}


		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0



		struct Input {
			float2 uv_MainTex;
		};


		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
