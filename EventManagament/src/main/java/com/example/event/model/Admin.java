package com.example.event.model;

import java.util.List;
import jakarta.persistence.*;

@Entity
@Table(name = "admin")
public class Admin {

    @Id
    @Column(nullable = false, unique = true)	
    private String username;

    @Column(nullable = false)
    private String password;

    @OneToMany(mappedBy = "admin", cascade = CascadeType.ALL)
    private List<AdminEvent> events;

    public Admin() {}

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<AdminEvent> getEvents() {
        return events;
    }

    public void setEvents(List<AdminEvent> events) {
        this.events = events;
    }
}
