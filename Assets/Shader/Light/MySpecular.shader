Shader "LightShader/MySpecular" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf MySpecular

		half4 LightingMySpecular(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
		{
			half diff = saturate(dot(s.Normal, lightDir));
			
			half nl = saturate( dot(s.Normal, lightDir) );
			half3 r = 2 * nl * s.Normal - lightDir;
			half spc = saturate(dot(r, viewDir));

			half4 c;

			c.rgb = s.Alpha * diff * _LightColor0.rgb + _LightColor0.rgb * spc;
			c.a = s.Alpha;

			return c;
		}

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input 
		{
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
