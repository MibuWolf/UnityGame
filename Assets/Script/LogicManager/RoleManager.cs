using System.Collections.Generic;
using UnityEngine;

namespace Logic
{
    public class RoleManager : Single<RoleManager>
    {
        // 所有角色对象
        private Dictionary<int, Role> roles = new Dictionary<int, Role>();

        private static int index = 0;

        // 添加角色对象
        public int addRole(Role role, int id = -1 )
        {
            if (id == -1)
                id = index++;

            roles.Add(id, role);

            return id;
        }

        // 添加角色对象
        public int addRole(GameObject obj, int id = -1)
        {
            if (id == -1)
                id = index++;

            Role role = new Role();
            role.id = id;
            role.obj = obj;
            roles.Add(id, role);

            return id;
        }

        // 删除角色对象
        public void removeRole(Role role)
        {
            if (role == null)
                return;

            roles.Remove(role.id);
        }
    }
}

