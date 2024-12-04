/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 * Modelo para representar clientes fidelizados.
 */
public class ClienteFModel {
    private int id;
    private String nombre;
    private String telefono;
    private int compras;

    // Constructor sin argumentos
    public ClienteFModel() {
    }

    // Constructor completo
    public ClienteFModel(int id, String nombre, String telefono, int compras) {
        this.id = id;
        this.nombre = nombre;
        this.telefono = telefono;
        this.compras = compras;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public int getCompras() {
        return compras;
    }

    public void setCompras(int compras) {
        this.compras = compras;
    }
    

    // Método toString
    @Override
    public String toString() {
        return "ClienteFModel{" +
                "id=" + id +
                ", nombre='" + nombre + '\'' +
                ", telefono='" + telefono + '\'' +
                ", compras=" + compras +
                '}';
    }
}
