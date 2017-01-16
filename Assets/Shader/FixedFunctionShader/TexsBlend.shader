Shader "FixedFunctionShader/TexsBlend" {
	Properties {
		_MainTex("主纹理", 2D) = "white" {}
		_SubTex("次纹理", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			SetTexture[_MainTex]
			{combine texture}
			SetTexture[_SubTex]
			{combine texture + previous}
		}
	}
	FallBack "Diffuse"
}
