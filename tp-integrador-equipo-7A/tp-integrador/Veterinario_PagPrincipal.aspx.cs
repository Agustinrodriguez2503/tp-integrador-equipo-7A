﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using helpers;

namespace tp_integrador
{
    public partial class Veterinario_PagPrincipal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!(Seguridad.sesionActiva(Session["usuario"])))
            //    Response.Redirect("IniciarSesion.aspx", false);
        }
    }
}