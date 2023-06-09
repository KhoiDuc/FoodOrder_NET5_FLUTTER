﻿using AutoMapper;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels.Homes;
using FoodOrder.Data;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Services
{
    public class HomeServices
    {
        private readonly ApplicationDBContext _dbContext;
        private readonly IMapper _mapper;
        private readonly ILogger<HomeServices> _logger;
        public HomeServices(ApplicationDBContext applicationDBContext, IMapper mapper, ILogger<HomeServices> logger)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
            _logger = logger;
        }

        public ApiResult<HomeVM> Get()
        {
            HomeVM homeVM = new HomeVM();
            var salePerDay = getTotalSalePerDay(DateTime.Now.AddDays(-30), 30);
            var salePerMonth = getTotalSalePerMonth(DateTime.Now.AddMonths(-6), 6);

            homeVM.TotalSaleToday = (int)(from o in _dbContext.Orders
                                  where o.IsPaid && o.DatePaid.Value.Date == DateTime.Now.Date
                                  select o.FinalTotalPrice).Sum();
            homeVM.TotalOrderToday = (from o in _dbContext.Orders
                                       where o.CreatedDate.Date == DateTime.Now.Date
                                       select o).Count();
            homeVM.TotalDeliveredToday = (from o in _dbContext.Orders
                                          where o.OrderStatusID == OrderStatus.DaNhan && o.DatePaid.Value.Date == DateTime.Now.Date 
                                          select o).Count();
            homeVM.TotalCanceledToday = (from o in _dbContext.Orders
                                         where  o.OrderStatusID == OrderStatus.DaHuy && o.DatePaid.Value.Date == DateTime.Now.Date
                                         select o).Count();

            if (salePerDay.IsSuccessed == true && salePerMonth.IsSuccessed)
            {
                homeVM.TotalSaleLast30Days = salePerDay.PayLoad;
                homeVM.TotalSaleLast6Months = salePerMonth.PayLoad;
                return new SuccessedResult<HomeVM>(homeVM);
            }

            return new FailedResult<HomeVM>("Some thing went wrong!");
        }

        private ApiResult<List<int>> getTotalSalePerDay(DateTime start, int count)
        {
            List<int> values = new List<int>();
            DateTime date = start;
            for (int i = 0; i < count; i++)
            {
                date = date.AddDays(1);
                var query = from o in _dbContext.Orders
                where o.CreatedDate.Date == date.Date && o.IsPaid == true
                select o.FinalTotalPrice;
                if(query.Count() > 0)
                {
                    values.Add((int)query.Sum());
                }
                else
                {
                    values.Add(0);
                }
            }
            return new SuccessedResult<List<int>>(values);
        }
        private ApiResult<List<int>> getTotalSalePerMonth(DateTime start, int count)
        {
            List<int> values = new List<int>();
            DateTime date = start;
            for (int i = 0; i < count; i++)
            {
                date = date.AddMonths(1);
                var query = from o in _dbContext.Orders
                            where o.CreatedDate.Year == date.Year && o.CreatedDate.Month == date.Month && o.IsPaid == true
                            select o.FinalTotalPrice;
                if (query.Count() > 0)
                {
                    values.Add((int)query.Sum());
                }
                else
                {
                    values.Add(0);
                }
            }
            return new SuccessedResult<List<int>>(values);
        }
    }
}
