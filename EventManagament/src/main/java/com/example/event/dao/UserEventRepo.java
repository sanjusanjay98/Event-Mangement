package com.example.event.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.event.model.UserEvent;

public interface UserEventRepo extends JpaRepository<UserEvent, Integer> {
    // Optional: find all bookings by a user
    List<UserEvent> findByUserUsername(String username);
}
