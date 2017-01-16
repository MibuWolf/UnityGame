Shader "FixedFunctionShader/BlendColor" 
{
	// 固定管线Shader编写
	//-------------------------------【属性】-----------------------------------------
	Properties
	{
		_Color("混合颜色", Color) = (1,1,1,0)
		_MainTex("本身贴图", 2D) = "white" {}
	}

		//--------------------------------【子着色器】----------------------------------
		SubShader
	{
		//-----------子着色器标签----------
		Tags{ "Queue" = "Transparent" }

		//----------------通道1--------------
		Pass
		{
		Blend DstColor SrcColor
		// 主纹理
		SetTexture[_MainTex]
		{
		constantColor[_Color]
		// 纹理颜色*来自光照计算的颜色或是当它绑定时的顶点颜色
		combine constant lerp(texture) previous
		}
	}
	}

}