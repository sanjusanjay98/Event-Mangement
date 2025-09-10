package com.example.event.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.event.model.User;

public interface UserRepo extends JpaRepository<User, String> {
	Optional<User> findByUsername(String username);
}
