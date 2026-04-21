package com.postgres.android_proyect.models;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public class CreateAndroidVersionRequest {
    
    @NotBlank
    @Size(max = 100)
    private String nombre;

    @NotBlank
    private String fecha;

    @NotBlank
    @Size(max = 500)
    private String descripcion;

    @Size(max = 1000)
    private String caracteristicas;

    private String urlPhoto;

    public CreateAndroidVersionRequest() {}

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getFecha() { return fecha; }
    public void setFecha(String fecha) { this.fecha = fecha; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getCaracteristicas() { return caracteristicas; }
    public void setCaracteristicas(String caracteristicas) { this.caracteristicas = caracteristicas; }

    public String getUrlPhoto() { return urlPhoto; }
    public void setUrlPhoto(String urlPhoto) { this.urlPhoto = urlPhoto; }
}
