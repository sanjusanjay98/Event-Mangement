package com.example.event.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.event.model.Admin;
import com.example.event.model.AdminEvent;

public interface AdminEventRepo extends JpaRepository<AdminEvent, Integer> {
	Optional<AdminEvent> findByEventName(String eventName);
	
	// Fetch events for the respective administrator
	List<AdminEvent> findByAdmin(Admin admin);
}
