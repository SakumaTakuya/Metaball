Shader "Custom/Metaball"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Strength ("Strength", float) = 1
	}
	SubShader
	{
		Tags 
		{ 
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
			"PreviewType" = "Plane"
			"CanUseSpriteAtlas" = "False"
		}

		LOD 100

		Pass
		{
			Blend One One
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR; //　頂点カラーで色を指定することで，バッチ数を減らすことが可能
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 color : COLOR;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float _Strength;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv; 
				o.color = v.color;
				return o;
			}
			
			float4 frag (v2f i) : SV_Target
			{
				float4 col = i.color;
				float2 diff = i.uv - 0.5;
				col.a = _Strength * pow(2, -20 * length(diff)); 
				col.rgb = col.rgb * col.a;
				return col;
			}
			ENDCG
		}
	}
}
