package org.apache.jsp.pages.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.ArrayList;
import model.CategoriaModel;

public final class createBeb_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(2);
    _jspx_dependants.add("/pages/admin/../../components/headerAdmin.jsp");
    _jspx_dependants.add("/pages/admin/../../components/sidebarAdmin.jsp");
  }

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Bebidas</title>\n");
      out.write("        <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("        <link href=\"https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css\" rel=\"stylesheet\">\n");
      out.write("        <style>\n");
      out.write("            .font {\n");
      out.write("                font-family: 'Barlow', sans-serif;\n");
      out.write("                font-weight: 600;\n");
      out.write("                font-size: 26px;\n");
      out.write("                padding-right: 30px;\n");
      out.write("                text-align: end;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            .form-control {\n");
      out.write("                border-color: #EC3718 !important;\n");
      out.write("                border-radius: 0% !important;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            .formImg {\n");
      out.write("                border-right: 0;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            .iconForm {\n");
      out.write("                background-color: #fff !important;\n");
      out.write("                border-left-color: #fff !important;\n");
      out.write("                border-left: 0;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            .form-select {\n");
      out.write("                border-color: #EC3718 !important;\n");
      out.write("                border-radius: 0% !important;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            .btnAdd {\n");
      out.write("                margin-top: 10vh;\n");
      out.write("                background-color: #EC3718 !important;\n");
      out.write("                color: #fff !important;\n");
      out.write("                padding-left: 20px !important;\n");
      out.write("                padding-right: 20px !important;\n");
      out.write("                box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.2);\n");
      out.write("            }\n");
      out.write("        </style>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        ");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>JSP Page</title>\n");
      out.write("        <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("        <style>\n");
      out.write("            \n");
      out.write("            .bgColor {\n");
      out.write("                background-color: #E58A56;\n");
      out.write("                color: white;\n");
      out.write("            }\n");
      out.write("            .logo {\n");
      out.write("                width: 100px;\n");
      out.write("                height: 60px;\n");
      out.write("            }\n");
      out.write("            .navbar {\n");
      out.write("                padding: 0.5rem 1rem;\n");
      out.write("            }\n");
      out.write("            .custom-hr {\n");
      out.write("                width: 95%; /* Ajusta el ancho para que no llegue a las orillas */\n");
      out.write("                \n");
      out.write("                margin: 0 auto; /* Centra el hr */\n");
      out.write("                border: 0;\n");
      out.write("                border-top: 2px solid black; /* Personaliza el color y estilo de la línea */\n");
      out.write("            }\n");
      out.write("            @media (max-width: 580px) {\n");
      out.write("                .logo {\n");
      out.write("                    width: 70px;\n");
      out.write("                    height: 50px;\n");
      out.write("                }\n");
      out.write("            }\n");
      out.write("        </style>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("            <nav class=\"navbar navbar-expand-sm navbar-white bg-white\">\n");
      out.write("                <div class=\"container d-flex justify-content-center\">\n");
      out.write("                    <a class=\"navbar-brand\" href=\"#\">\n");
      out.write("                        <img src=\"../../assets/FoodFlow Logo.png\" class=\"logo\" alt=\"LOGO\">\n");
      out.write("                    </a>\n");
      out.write("                </div>\n");
      out.write("            </nav>\n");
      out.write("            <hr class=\"custom-hr\">\n");
      out.write("    </body>\n");
      out.write("</html>\n");
      out.write("\n");
      out.write("        ");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Sidebar Component</title>\n");
      out.write("        <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("        <style>\n");
      out.write("            /* Estilo del contenedor del sidebar */\n");
      out.write("            .sidebar {\n");
      out.write("                position: fixed;\n");
      out.write("                top: 0;\n");
      out.write("                left: 0;\n");
      out.write("                height: 100%;\n");
      out.write("                width: 50px; /* Ajustar el ancho cerrado */\n");
      out.write("                background-color: white;\n");
      out.write("                overflow-x: hidden;\n");
      out.write("                transition: width 0.3s;\n");
      out.write("                color: black;\n");
      out.write("                display: flex;\n");
      out.write("                flex-direction: column;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            /* Estilo del sidebar cuando está abierto */\n");
      out.write("            .sidebar.open {\n");
      out.write("                width: 250px;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            /* Estilo del botón para abrir/cerrar */\n");
      out.write("            .sidebar-toggle {\n");
      out.write("                background-color: #fff;\n");
      out.write("                color: black;\n");
      out.write("                border: none;\n");
      out.write("                width: 100%;\n");
      out.write("                padding: 10px;\n");
      out.write("                cursor: pointer;\n");
      out.write("                text-align: center; /* Centrar el ícono ☰ */\n");
      out.write("                font-size: 18px;\n");
      out.write("                transition: background-color 0.3s;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            .sidebar-toggle:hover {\n");
      out.write("                background-color: #ffcccc;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            /* Estilo de las opciones */\n");
      out.write("            .sidebar-option {\n");
      out.write("                display: flex;\n");
      out.write("                align-items: center;\n");
      out.write("                padding: 15px;\n");
      out.write("                font-size: 16px;\n");
      out.write("                cursor: pointer;\n");
      out.write("                color: black;\n");
      out.write("                transition: background-color 0.3s;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            .sidebar-option:hover {\n");
      out.write("                background-color: #ffcccc;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            /* Imagen de las opciones */\n");
      out.write("            .sidebar-option img {\n");
      out.write("                width: 40px;\n");
      out.write("                height: 40px;\n");
      out.write("                margin-right: 15px;\n");
      out.write("                transition: margin 0.3s;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            /* Ocultar texto de la opción cuando el sidebar está cerrado */\n");
      out.write("            .sidebar:not(.open) .option-text,\n");
      out.write("            .sidebar:not(.open) .sidebar-option img {\n");
      out.write("                display: none;\n");
      out.write("            }\n");
      out.write("        </style>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <!-- Sidebar -->\n");
      out.write("        <div class=\"sidebar\" id=\"mySidebar\">\n");
      out.write("            <!-- Botón para abrir/cerrar el sidebar -->\n");
      out.write("            <button class=\"sidebar-toggle\" onclick=\"toggleSidebar()\">☰</button>\n");
      out.write("            \n");
      out.write("            <!-- Opciones del sidebar -->\n");
      out.write("            <div class=\"sidebar-option\">\n");
      out.write("                <img src=\"../../assets/icons/search.png\" class=\"logo\" alt=\"LOGO\">\n");
      out.write("                <span class=\"option-text\">Buscar</span>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"sidebar-option\">\n");
      out.write("                <img src=\"../../assets/icons/user.png\" alt=\"Opción 2\">\n");
      out.write("                <span class=\"option-text\">Usuarios</span>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"sidebar-option\">\n");
      out.write("                <img src=\"../../assets/icons/platillos.png\" alt=\"Opción 3\">\n");
      out.write("                <span class=\"option-text\">Platillos</span>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"sidebar-option\">\n");
      out.write("                <img src=\"../../assets/icons/ventas.png\" alt=\"Opción 4\">\n");
      out.write("                <span class=\"option-text\">Ventas</span>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"sidebar-option\">\n");
      out.write("                <img src=\"../../assets/icons/fidelidad.png\" alt=\"Opción 5\">\n");
      out.write("                <span class=\"option-text\">Fidelidad</span>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <script>\n");
      out.write("            // Función para abrir/cerrar el sidebar\n");
      out.write("            function toggleSidebar() {\n");
      out.write("                document.getElementById(\"mySidebar\").classList.toggle(\"open\");\n");
      out.write("            }\n");
      out.write("        </script>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
      out.write("\n");
      out.write("\n");
      out.write("        <div style=\"margin-left: 100px; padding: 20px; min-width: 100vh;  height: 100vh; align-content: center;\">\n");
      out.write("            <form action=\"/foodflow/pages/admin/createCat\" method=\"POST\" enctype=\"multipart/form-data\">\n");
      out.write("\n");
      out.write("                <div class=\"d-flex justify-content-start align-items-center\">\n");
      out.write("                    <div class=\"col-4 text-end mt-3\">\n");
      out.write("                        <p class=\"font\">Nombre(s):</p>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"col-4 ms-2\">\n");
      out.write("                        <input class=\"form-control\" type=\"text\" name=\"txt_nombre\" id=\"txt_nombre\" max=\"100\">\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                \n");
      out.write("                <div class=\"d-flex justify-content-start align-items-center\">\n");
      out.write("                    <div class=\"col-4 text-end mt-3\">\n");
      out.write("                        <p class=\"font\">Descripción:</p>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"col-4 ms-2\">\n");
      out.write("                        <input class=\"form-control\" type=\"text\" name=\"txt_descripcion\" id=\"txt_descripcion\">\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <div class=\"d-flex justify-content-start  \" style=\"padding-left: 3px;\">\n");
      out.write("                    <div class=\"col-4 text-end\">\n");
      out.write("                        <p class=\"font\">Imagen:</p>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"col-4 ms-2\">\n");
      out.write("    <div class=\"input-group mb-3\" style=\"position: relative;\">\n");
      out.write("        <!-- Input de archivo -->\n");
      out.write("        <input type=\"file\" class=\"form-control formImg\" name=\"image\" id=\"image\" style=\"opacity: 0; position: absolute; top: 0; left: 0; width: 100%; height: 100%; cursor: pointer; z-index: 2;\" onchange=\"updateFileName()\">\n");
      out.write("        <!-- Contenedor para el borde y el icono -->\n");
      out.write("        <div class=\"input-group-prepend\" style=\"border: 1px solid #EC3718; border-radius: 0px; height: 40px; width: 459px; display: flex; align-items: center;\">\n");
      out.write("            <span class=\"input-group-text\" style=\"background-color: transparent; border: none; margin-left: auto\">\n");
      out.write("                <img src=\"../../assets/icons/upload.png\" alt=\"Icono de subir\" style=\"width: 24px; height: 24px;\">\n");
      out.write("            </span>\n");
      out.write("            <span class=\"input-group-text\" style=\"background-color: transparent; border: none;\"></span>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write(" \n");
      out.write("</div>\n");
      out.write("\n");
      out.write("                </div>\n");
      out.write("                <div class=\"d-flex justify-content-start align-items-center\">\n");
      out.write("                    <div class=\"col-4 text-end mt-3\">\n");
      out.write("                        <p class=\"font\">Precio Unitario:</p>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"col-4 ms-2\">\n");
      out.write("                        <input class=\"form-control\" type=\"number\" name=\"txt_precio\" id=\"txt_precio\" min=\"0\">\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                \n");
      out.write("                <div class=\"d-flex justify-content-start align-items-center\">\n");
      out.write("                    <div class=\"col-4 text-end mt-3\">\n");
      out.write("                        <p class=\"font\">Categoria:</p>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"col-4 ms-2\">\n");
      out.write("                        <select class=\"form-control border-danger\" id=\"inputCategoria\" name=\"categoria\">\n");
      out.write("                          <option selected>Seleccione una categoría</option>\n");
      out.write("                            ");

                                ArrayList<CategoriaModel> listaCategorias = (ArrayList<CategoriaModel>) request.getAttribute("categorias");

                                if (listaCategorias != null && !listaCategorias.isEmpty()) {
                                    for (CategoriaModel categoria : listaCategorias) {
                            
      out.write("\n");
      out.write("                            <option value=\"");
      out.print( categoria.getId());
      out.write('"');
      out.write('>');
      out.print( categoria.getNombre());
      out.write("</option>\n");
      out.write("                            ");

                                }
                            } else {
                            
      out.write("\n");
      out.write("                            <tr>\n");
      out.write("                                <td colspan=\"7\">No hay categorias registrados.</td>\n");
      out.write("                            </tr>\n");
      out.write("                            ");

                                }
                            
      out.write("\n");
      out.write("                        </select>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                \n");
      out.write("                <div class=\"d-flex justify-content-start align-items-center\">\n");
      out.write("                    <div class=\"col-4 text-end mt-3\">\n");
      out.write("                        <p class=\"font\">Disponibilidad:</p>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"col-4 ms-2\">\n");
      out.write("                          <select class=\"form-control border-danger\" id=\"inputDisponibilidad\" name=\"disponibilidad\">\n");
      out.write("                            <option value=\"1\">Disponible</option>\n");
      out.write("                            <option value=\"2\">Agotado</option>\n");
      out.write("                        </select>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <div class=\"row\">\n");
      out.write("                    <div class=\"col-md-6 offset-md-5\">\n");
      out.write("                        <button type=\"submit\" class=\"btn btnAdd\">Agregar</button>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("            </form>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <script>\n");
      out.write("            // Función para actualizar el nombre del archivo en el input de imagen\n");
      out.write("            function updateFileName() {\n");
      out.write("    const fileInput = document.getElementById('image');\n");
      out.write("    const fileNameDisplay = document.getElementById('fileNameDisplay');\n");
      out.write("    const fileName = fileInput.files[0] ? fileInput.files[0].name : 'Ningún archivo seleccionado';\n");
      out.write("    fileNameDisplay.textContent = fileName; // Mostrar el nombre del archivo\n");
      out.write("}\n");
      out.write("\n");
      out.write("        </script>\n");
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
