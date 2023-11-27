<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SliderUserControl1.ascx.cs" Inherits="CASEWEB.Usuario.SliderUserControl1" %>

 <style>
     /* Estilos para el cuadro */
     .cuadro1 {
         border: 2px;
         padding: 15px;
         margin: 20px;
         border-radius: 10px;
         background-color: rgba(0, 0, 0, 0.8); /* 0.8 representa la opacidad (de 0 a 1) */
     }

         /* Estilos para el contenido dentro del cuadro */
         .cuadro h1 {
             color: white;
         }

         .cuadro p {
             color: white;
         }
 </style>

<!-- slider section -->
<section class="slider_section ">
    <div id="customCarousel1" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <div class="container ">
                    <div class="row">
                        <div class="col-md-7 col-lg-6 ">
                            <div class="detail-box">
                                <%--<h1>Bienvenido a Caserita Web!
                                </h1>
                                <p>
                                    El mercado Lanza en La Paz, Bolivia, es uno de los mercados más emblemáticos de la ciudad, conocido por su bullicio y la diversidad de productos que ofrece. Este mercado tradicional es un importante centro de comercio donde se pueden encontrar alimentos frescos, artesanías, ropa y una gran variedad de productos locales y regionales. Los visitantes pueden sumergirse en la cultura boliviana mientras exploran sus pasillos llenos de colores y aromas.
                                </p>--%>
                               
                                <div class="cuadro1">
                                    <h1>Bienvenido a Caserita Web!</h1>
                                    <p>
                                        El mercado Lanza en La Paz, Bolivia, es uno de los mercados más emblemáticos de la ciudad, conocido por su bullicio y la diversidad de productos que ofrece. Este mercado tradicional es un importante centro de comercio donde se pueden encontrar alimentos frescos, artesanías, ropa y una gran variedad de productos locales y regionales. Los visitantes pueden sumergirse en la cultura boliviana mientras exploran sus pasillos llenos de colores y aromas.
     
                                    </p>
                                </div>
                                <%--  <div class="btn-box">
                      <a href="" class="btn1">
                        Ordena Ahora!
                      </a>
                    </div>--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--<div class="container">
          <ol class="carousel-indicators">
            <li data-target="#customCarousel1" data-slide-to="0" class="active"></li>
            <li data-target="#customCarousel1" data-slide-to="1"></li>
            <li data-target="#customCarousel1" data-slide-to="2"></li>
          </ol>
        </div>--%>
    </div>

</section>
<!-- end slider section -->
