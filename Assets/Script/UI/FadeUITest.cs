using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class FadeUITest : MonoBehaviour {

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}

    public void onClick()
    {
        GameObject parent = gameObject.transform.parent.gameObject;

        int count = parent.transform.childCount;

        for (int i = 0; i < count; ++i)
        {
            Transform trf = parent.transform.GetChild(i);

            Component[] comps = trf.gameObject.GetComponents<Component>();

            foreach (Component c in comps)
            {
                if (c is Graphic)
                {
                    (c as Graphic).CrossFadeAlpha(0, 1, true);
                }

                if (c is Image)
                {
                    (c as Image).CrossFadeColor(new Color(0.1f, 0.9f, 0.6f), 1, true, true);
                }
            }
        }
    }
}
