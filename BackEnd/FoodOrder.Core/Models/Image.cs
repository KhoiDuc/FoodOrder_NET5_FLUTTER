﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Core.Models
{
    public class Image
    {
        public int ID { get; set; }
        public int FoodID { get; set; }
        public string ImagePath { get; set; }
        public string Caption { get; set; }
        public int SortOrder { get; set; }
        public bool IsDefault { get; set; }

        public Food Food { get; set; }
    }
}
