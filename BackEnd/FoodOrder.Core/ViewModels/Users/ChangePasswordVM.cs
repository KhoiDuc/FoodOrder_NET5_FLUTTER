﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Users
{
    public class ChangePasswordVM
    {
        public string Username { get; set; }
        public string NewPassword { get; set; }
        public string OldPassword { get; set; }
    }
}
