using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OrthoSample.Models
{
    public class CreateOrderVM
    {
        public List<SelectListItem> CustomerList { get; set; }
        [Required(ErrorMessage = " Required!")]
        public string SelectedCustomer { get; set; }
        [Required(ErrorMessage = " Required!")]
        [Range(1, int.MaxValue, ErrorMessage = "Please enter valid integer Number")]
        public int Quantity { get; set; }
        [Required(ErrorMessage = " Required!")]
        [DataType(DataType.Date)]
        public DateTime? OrderDate { get; set; }
    }
}