package com.example.event.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.event.model.Admin;

public interface AdminRepo extends JpaRepository<Admin, String> {
	Optional<Admin> findByUsername(String username);
}
