using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace OrthoSample.Models
{
    public class EditOrderVM
    {
        public int OrderId { get; set; }
        public string CustomerEmail { get; set; }
        [Required(ErrorMessage = " Required!")]
        [Range(1, int.MaxValue, ErrorMessage = "Please enter valid integer Number")]
        public int Quantity { get;set;}
    }
}