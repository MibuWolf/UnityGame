Shader "FixedFunctionShader/GlassShader"
{
	// 固定管线Shader编写
	//-------------------------------【属性】-----------------------------------------
	Properties
	{
		_Color("本身颜色", Color) = (1,1,1,1)
		_MainTex("本身贴图", 2D) = "white" {}
		_Reflections("周围环境贴图", Cube) = "skybox" { TexGen CubeReflect }
	}

		//--------------------------------【子着色器】----------------------------------
		SubShader
	{
		//-----------子着色器标签----------
		Tags{ "Queue" = "Transparent" }

		//----------------通道1--------------
		Pass
	{
		// 设置aplha混合模式 1- SrcAlpha
		Blend SrcAlpha OneMinusSrcAlpha

		Material
	{
		// 材质本身颜色
		Diffuse[_Color]
	}

		Lighting On
		// 主纹理
		SetTexture[_MainTex]{

		// 纹理颜色*来自光照计算的颜色或是当它绑定时的顶点颜色
		combine texture * primary double, texture * primary
	}
	}

		//----------------通道2--------------
		Pass
	{
		//进行纹理混合叠加模式
		Blend One One

		//设置材质
		Material
	{
		Diffuse[_Color]
	}

		//开光照
		Lighting On

		//和纹理相乘
		SetTexture[_Reflections]
	{
		combine texture
		//Matrix[_Reflection]
	}
	}
	}
}