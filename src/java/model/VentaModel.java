package model;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author nayel
 */
public class VentaModel {
    private int idOrden;
    private String folio;
    private String usuarioNombre;
    private String fecha;
    private String clienteNombre;
    private double totalOrden;
private int clienteId;

    // Constructor vacío
    public VentaModel() {}

    // Constructor con parámetros
    public VentaModel(int idOrden, String folio, String usuarioNombre, String fecha, String clienteNombre, double totalOrden,int clienteId) {
        this.idOrden = idOrden;
        this.folio = folio;
        this.usuarioNombre = usuarioNombre;
        this.fecha = fecha;
        this.clienteNombre = clienteNombre;
        this.totalOrden = totalOrden;
        this.clienteId = clienteId;
    }

    // Getters y Setters
    public int getIdOrden() {
        return idOrden;
    }

    public void setIdOrden(int idOrden) {
        this.idOrden = idOrden;
    }

    public String getFolio() {
        return folio;
    }

    public void setFolio(String folio) {
        this.folio = folio;
    }

    public String getUsuarioNombre() {
        return usuarioNombre;
    }

    public void setUsuarioNombre(String usuarioNombre) {
        this.usuarioNombre = usuarioNombre;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getClienteNombre() {
        return clienteNombre;
    }

    public void setClienteNombre(String clienteNombre) {
        this.clienteNombre = clienteNombre;
    }

    public double getTotalOrden() {
        return totalOrden;
    }

    public void setTotalOrden(double totalOrden) {
        this.totalOrden = totalOrden;
    }
    
    public int getClienteId() {
    return clienteId;
}

public void setClienteId(int clienteId) {
    this.clienteId = clienteId;
}

    @Override
    public String toString() {
        return "VentaModel{" +
                "idOrden=" + idOrden +
                ", folio='" + folio + '\'' +
                ", usuarioNombre='" + usuarioNombre + '\'' +
                ", fecha='" + fecha + '\'' +
                ", clienteNombre='" + clienteNombre + '\'' +
                ", totalOrden=" + totalOrden +
                '}';
    }
}