package com.example.event.model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "events")
public class AdminEvent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)  // auto-increment primary key
    private Integer eventId;

    @ManyToOne
    @JoinColumn(name = "username", nullable = false)  // foreign key column
    private Admin admin;

    @Column(name = "event_name", nullable = false)
    private String eventName;

    @Column(name = "event_description", columnDefinition = "TEXT")
    private String eventDescription;

    @Column(name = "event_date_time", nullable = false)
    private LocalDateTime eventDateTime;
    
    @Column(name = "location", nullable = false)
    private String location;

    @Column(name = "available_tickets", nullable = false)
    private Integer availableTickets;

    @Column(name = "ticket_price", nullable = false, precision = 10, scale = 2)
    private BigDecimal ticketPrice;

    // Constructors
    public AdminEvent() {
    	
    }

    public AdminEvent(Admin admin, String eventName, String eventDescription, LocalDateTime eventDateTime,
                 String location, Integer availableTickets, BigDecimal ticketPrice) {
        this.admin = admin;
        this.eventName = eventName;
        this.eventDescription = eventDescription;
        this.eventDateTime = eventDateTime;
        this.location = location;
        this.availableTickets = availableTickets;
        this.ticketPrice = ticketPrice;
    }

    public Integer getEventId() { 
    	return eventId; 
    }
    
    public void setEventId(Integer eventId) { 
    	this.eventId = eventId; 
    }
    
    public Admin getUser() { 
    	return admin; 
    }
    
    public void setUser(Admin admin) { 
    	this.admin = admin; 
    }
    
    public String getEventName() { 
    	return eventName; 
    }
    
    public void setEventName(String eventName) { 
    	this.eventName = eventName; 
    }
    
    public String getEventDescription() { 
    	return eventDescription; 
    }
    
    public void setEventDescription(String eventDescription) { 
    	this.eventDescription = eventDescription; 
    }
    
    public LocalDateTime getEventDateTime() {
        return eventDateTime;
    }

    public void setEventDateTime(LocalDateTime eventDateTime) {
        this.eventDateTime = eventDateTime;
    }
    
    public String getLocation() { 
    	return location; 
    }
    
    public void setLocation(String location) { 
    	this.location = location; 
    }
    
    public Integer getAvailableTickets() { 
    	return availableTickets;
    }
    
    public void setAvailableTickets(Integer availableTickets) { 
    	this.availableTickets = availableTickets; 
    }
    
    public BigDecimal getTicketPrice() { 
    	return ticketPrice; 
    }
    
    public void setTicketPrice(BigDecimal ticketPrice) { 
    	this.ticketPrice = ticketPrice; 
    }
    
}
