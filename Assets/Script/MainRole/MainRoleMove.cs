using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using CrossPlatformInput; 

public class MainRoleMove : MonoBehaviour {

    // Use this for initialization
    private Transform mainRoleTransform;

    private Transform m_Cam;

    private Vector3 m_Move;

    void Start ()
    {
        mainRoleTransform = transform;

        if (Camera.main != null)
        {
            m_Cam = Camera.main.transform;
        }
    }

    // Update is called once per frame
    private void FixedUpdate()
    {
        float h = CrossPlatformInputManager.GetAxis("Horizontal");
        float v = CrossPlatformInputManager.GetAxis("Vertical");

        if (m_Cam != null)
        {
            // calculate camera relative direction to move:
            Vector3 camForward = Vector3.Scale(m_Cam.forward, new Vector3(1, 0, 1)).normalized;
            m_Move = v * camForward / 4.0f + h * m_Cam.right / 5.0f;
        }
        else
        {
            // we use world-relative directions in the case of no main camera
            m_Move = v * Vector3.forward  / 4.0f + h * Vector3.right / 5.0f;
        }

        mainRoleTransform.Translate(m_Move);
    }
}
