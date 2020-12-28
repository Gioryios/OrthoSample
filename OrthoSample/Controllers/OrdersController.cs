using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using OrthoSample.Models;

namespace OrthoSample.Controllers
{
    public class OrdersController : Controller
    {
        private OrthoSampleEntities dbcontext= new OrthoSampleEntities();

        public ActionResult Index()
        {
            var orders = dbcontext.Orders;
            return View(orders.ToList());
        }

        public ActionResult Create()
        {
            CreateOrderVM COVM = new CreateOrderVM();
            COVM.CustomerList = dbcontext.Customers.Select(x => new SelectListItem
            {
                Text = x.Email,
                Value = x.CustomerID.ToString()
            }).ToList();

            return View(COVM);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(CreateOrderVM COVM)
        {
            if (ModelState.IsValid)
            {
                Order order = new Order
                {
                    CustomerId = Convert.ToInt32(COVM.SelectedCustomer),
                    OrderStatus = "Active",
                    OrderDate = COVM.OrderDate.GetValueOrDefault(),
                    Quantity = COVM.Quantity,
                    Product = "Dietary Supplement 10oz",
                    ProductPrice = 20.00M,
                    DateCreated = DateTime.Now
                };
                order.OrderAmount = COVM.Quantity * order.ProductPrice;
                dbcontext.Orders.Add(order);
                dbcontext.SaveChanges();
                return RedirectToAction("Index");
            }

            COVM.CustomerList = dbcontext.Customers.Select(x => new SelectListItem
            {
                Text = x.Email,
                Value = x.CustomerID.ToString()
            }).ToList();
            return View(COVM);
        }

        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            
            Order order = dbcontext.Orders.Find(id);
            if (order == null || order.OrderStatus.ToLower() == "canceled")
            {
                return HttpNotFound();
            }

            EditOrderVM EOVM = new EditOrderVM();
            EOVM.CustomerEmail = order.Customer.Email;
            EOVM.OrderId = order.OrderId;
            EOVM.Quantity = order.Quantity;
            return View(EOVM);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(EditOrderVM EOVM)
        {
            if (ModelState.IsValid)
            {
                Order existingorder = dbcontext.Orders.Find(EOVM.OrderId);
                existingorder.Quantity = EOVM.Quantity;
                existingorder.OrderAmount = EOVM.Quantity * existingorder.ProductPrice;
                dbcontext.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(EOVM);
        }

        public ActionResult Cancel(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Order order = dbcontext.Orders.Find(id);
            if (order == null)
            {
                return HttpNotFound();
            }
            return View(order);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Cancel(int id)
        {
            Order order = dbcontext.Orders.Find(id);
            order.OrderStatus = "Canceled";
            dbcontext.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}
