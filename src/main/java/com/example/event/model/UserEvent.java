package com.example.event.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.math.BigDecimal;

@Entity
@Table(name = "uevents")
public class UserEvent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer bookingId;   // Primary Key for each booking

    @ManyToOne
    @JoinColumn(name = "event_id", nullable = false)   // FK to AdminEvent
    private AdminEvent event;

    @ManyToOne
    @JoinColumn(name = "username", nullable = false)   // FK to User (who booked)
    private User user;

    @Column(name = "tickets_booked", nullable = false)
    private Integer ticketsBooked;

    @Column(name = "booking_time", nullable = false)
    private LocalDateTime bookingTime;

    @Column(name = "total_price", nullable = false, precision = 15, scale = 2)
    private BigDecimal totalPrice;

    // Constructors
    public UserEvent() {}

    public UserEvent(AdminEvent event, User user, Integer ticketsBooked, LocalDateTime bookingTime, BigDecimal totalPrice) {
        this.event = event;
        this.user = user;
        this.ticketsBooked = ticketsBooked;
        this.bookingTime = bookingTime;
        this.totalPrice = totalPrice;
    }

    // Getters and Setters
    public Integer getBookingId() {
        return bookingId;
    }

    public void setBookingId(Integer bookingId) {
        this.bookingId = bookingId;
    }

    public AdminEvent getEvent() {
        return event;
    }

    public void setEvent(AdminEvent event) {
        this.event = event;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Integer getTicketsBooked() {
        return ticketsBooked;
    }

    public void setTicketsBooked(Integer ticketsBooked) {
        this.ticketsBooked = ticketsBooked;
    }

    public LocalDateTime getBookingTime() {
        return bookingTime;
    }

    public void setBookingTime(LocalDateTime bookingTime) {
        this.bookingTime = bookingTime;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }
}
