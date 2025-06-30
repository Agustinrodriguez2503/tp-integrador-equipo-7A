<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaPrincipalMasterPage.Master" AutoEventWireup="true" CodeBehind="PaginaPrincipal.aspx.cs" Inherits="tp_integrador.PaginaPrincipal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Banner -->
    <section id="Inicio">
        <img src="/Images/banner.png" alt="Banner de la veterinaria" class="img-fluid w-100" style="max-height: 400px; object-fit: cover;">
    </section>

    <!-- Sobre Nosotros -->
    <section class="py-5" style="background: linear-gradient(to right, #e8f5e9, #ffffff);" id="Nosotros">
        <div class="container">
            <div class="row align-items-center justify-content-center g-3">

                <!-- Columna de texto más ancha -->
                <div class="col-lg-7">
                    <div class="bg-white rounded-4 shadow-lg p-5 h-100">
                        <h2 class="text-center mb-4 fw-bold text-success">
                            <i class="bi bi-heart-pulse-fill me-2"></i>Sobre Nosotros
                        </h2>

                        <p class="fs-5 text-center mb-4">
                            En <strong>nuestra veterinaria</strong>, nos mueve el amor por los animales y el compromiso con su bienestar.
                        Somos un equipo de profesionales apasionados por brindar atención médica de calidad, con sensibilidad y respeto hacia cada mascota y su familia.
                        </p>

                        <div class="row text-center mt-4">
                            <div class="col-md-4 mb-4">
                                <i class="bi bi-clipboard2-pulse fs-1 text-success"></i>
                                <h5 class="mt-2 fw-semibold">Atención Clínica</h5>
                                <p>Consultas, chequeos y diagnóstico personalizado.</p>
                            </div>
                            <div class="col-md-4 mb-4">
                                <i class="bi bi-shield-plus fs-1 text-success"></i>
                                <h5 class="mt-2 fw-semibold">Vacunas y Prevención</h5>
                                <p>Protegemos a tu mascota desde sus primeros días.</p>
                            </div>
                            <div class="col-md-4 mb-4">
                                <i class="bi bi-heart-fill fs-1 text-success"></i>
                                <h5 class="mt-2 fw-semibold">Cuidado con Amor</h5>
                                <p>Sabemos que no es solo una mascota, ¡es parte de tu familia!</p>
                            </div>
                        </div>

                        <p class="fs-5 text-center mt-4">
                            Nuestro objetivo es que cada visita sea una experiencia positiva, tanto para vos como para tu compañero peludo.
                        ¡Porque su salud y felicidad también son las nuestras! 🐶🐱
                        </p>
                    </div>
                </div>

                <!-- Imagen más angosta -->
                <div class="col-lg-4 text-center">
                    <img src="/Images/Donacion.png" alt="Donación Refugio"
                        class="img-fluid rounded-4 shadow" style="max-height: 520px; object-fit: contain;">
                </div>

            </div>
        </div>
    </section>

    <!-- Contacto -->
    <section class="py-5" style="background: linear-gradient(to right, #ffffff, #e0f2f1);" id="Contacto">
        <div class="container">
            <div class="row align-items-center justify-content-center g-3">

                <!-- Imagen más angosta -->
                <div class="col-lg-4 text-center mb-4 mb-lg-0">
                    <img src="/images/Horarios.png" alt="Horarios Veterinaria"
                        class="img-fluid rounded-4 shadow-lg" style="max-height: 480px; object-fit: contain;">
                </div>

                <!-- Info más ancha -->
                <div class="col-lg-7">
                    <h3 class="fw-bold text-success text-center mb-4">
                        <i class="bi bi-geo-alt-fill me-2"></i>Ubicación y Contacto
                    </h3>

                    <div class="bg-white rounded-4 shadow p-4 fs-5 text-center">
                        <p class="mb-3">
                            <i class="bi bi-geo-alt-fill text-success fs-4 me-2"></i>
                            <strong>Av. Huesitos 1234 PB, C.A.B.A.</strong>
                        </p>
                        <p class="mb-3">
                            <i class="bi bi-telephone-fill text-success fs-4 me-2"></i>
                            <strong>(011) 1234-5678</strong>
                        </p>
                        <p>
                            <i class="bi bi-envelope-at-fill text-success fs-4 me-2"></i>
                            <strong>contacto@veterinariaejemplo.com</strong>
                        </p>
                    </div>
                </div>

            </div>
        </div>
    </section>



</asp:Content>
