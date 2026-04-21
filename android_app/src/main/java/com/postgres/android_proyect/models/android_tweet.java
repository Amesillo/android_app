package com.postgres.android_proyect.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@Entity
@Table( name = "android_versions")
public class android_tweet{

@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private Long id;

@NotBlank
@Size(max = 100)
private String nombre;

@NotBlank
private String fecha;

@NotBlank
@Size(max = 500)
private String descripcion;

@Column(length = 1000)
private String caracteristicas;

@Column(name = "url_photo")
private String urlPhoto;

public android_tweet(){ }

public android_tweet(String nombre, String fecha, String descripcion,
             String caracteristicas, String urlPhoto){
    this.nombre          = nombre;
    this.fecha           = fecha;
    this.descripcion     = descripcion;
    this.caracteristicas = caracteristicas;
    this.urlPhoto        = urlPhoto;
}

public Long getId(){ return id; }
public void setId(Long id){ this.id = id; }

public String getNombre(){ return nombre; }
public void setNombre(String nombre){ this.nombre = nombre; }

public String getFecha(){ return fecha; }
public void setFecha(String fecha){ this.fecha = fecha; }

public String getDescripcion(){ return descripcion; }
public void setDescripcion(String descripcion){ this.descripcion = descripcion; }

public String getCaracteristicas(){ return caracteristicas; }
public void setCaracteristicas(String caracteristicas){ this.caracteristicas = caracteristicas; }

public String getUrlPhoto(){ return urlPhoto; }
public void setUrlPhoto(String urlPhoto){ this.urlPhoto = urlPhoto; }

}
