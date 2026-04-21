package com.postgres.android_proyect.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.postgres.android_proyect.models.android_tweet;
import com.postgres.android_proyect.models.CreateAndroidVersionRequest;
import com.postgres.android_proyect.repository.AndroidRepository;

import jakarta.validation.Valid;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/android-versions")
public class Androidversioncontroller {

    @Autowired
    private AndroidRepository androidVersionRepository;

    @GetMapping
    public List<android_tweet> getAll() {
        return androidVersionRepository.findAll();
    }

    @PostMapping
    @Transactional
    public android_tweet create(@Valid @RequestBody CreateAndroidVersionRequest request) {
        // Crear nueva entidad sin ID (será generado por la BD)
        android_tweet version = new android_tweet(
            request.getNombre(),
            request.getFecha(),
            request.getDescripcion(),
            request.getCaracteristicas(),
            request.getUrlPhoto()
        );
        return androidVersionRepository.save(version);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        androidVersionRepository.deleteById(id);
    }
}
