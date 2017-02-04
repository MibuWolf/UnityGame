using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Single<T> where T : class, new()
{
    private static T _instance;

    public static T Instance

    {

        get
        {
            if (Single<T>._instance == null)
            {
                _instance = new T();
            }
            return Single<T>._instance;
        }

    }
}

