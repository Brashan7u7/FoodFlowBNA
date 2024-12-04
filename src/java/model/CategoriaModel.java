/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author nayel
 */
public class CategoriaModel {
    private int id;
    private String nombre;
    private String imagen;
    private String estatus;
    
    public CategoriaModel() {
    }

    public CategoriaModel(int id, String nombre, String imagen, String estatus) {
        this.id = id;
        this.nombre = nombre;
        this.imagen = imagen;
        this.estatus = estatus;
    }

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

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getEstatus() {
        return estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }
    
    

    @Override
    public String toString() {
        return "CategoriaModel{" + "id=" + id + ", nombre=" + nombre + ", imagen=" + imagen + ", estatus=" + estatus + '}';
    }
    
}
