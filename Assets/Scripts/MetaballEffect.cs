using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Sakkun.Metaball
{
    [ExecuteInEditMode]
    public class MetaballEffect : MonoBehaviour
    {
        [SerializeField] private float _cut;
        [SerializeField] private Shader _shader;
        private Material _material;
        private int _cutID;

        private void Awake()
        {
            _material = new Material(_shader);
            _cutID = Shader.PropertyToID("_Cut");
        }

        private void OnRenderImage(RenderTexture src, RenderTexture dest)
        {
            _material.SetFloat(_cutID, _cut);
            Graphics.Blit(src, dest, _material);
        }
    }
}