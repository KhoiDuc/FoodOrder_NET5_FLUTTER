﻿using FoodOrder.Core.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FoodOrder.Data.Configurations
{
    public class CategoryConfig : IEntityTypeConfiguration<Category>
    {
        public void Configure(EntityTypeBuilder<Category> builder)
        {
            builder.ToTable("Category");
            builder.HasKey(x => x.ID);
            builder.Property(x => x.ID).UseIdentityColumn();
            builder.Property(x => x.Name).IsRequired().IsUnicode().HasMaxLength(100);
            builder.Property(x => x.Description).IsRequired().IsUnicode().HasMaxLength(300);

            builder.HasMany(x => x.FoodCategories).WithOne(x => x.Category);
        }
    }
}
