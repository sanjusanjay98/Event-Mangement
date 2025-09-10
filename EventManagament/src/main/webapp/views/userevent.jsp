<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.example.event.model.AdminEvent, com.example.event.model.UserEvent" %>

<%
    // Available events for booking
    @SuppressWarnings("unchecked")
    List<AdminEvent> events = (List<AdminEvent>) request.getAttribute("events");

    // Already booked events for logged-in user
    @SuppressWarnings("unchecked")
    List<UserEvent> bookings = (List<UserEvent>) request.getAttribute("bookings");

    String view = request.getParameter("view"); // "book" or "mybookings"
    String message = (String) request.getAttribute("message");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Dashboard - EventManager</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            --info-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --warning-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            --dark-gradient: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-dark: rgba(0, 0, 0, 0.1);
            --glass-border: rgba(255, 255, 255, 0.2);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: white;
        }

        /* Header Styles */
        .header {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--glass-border);
            padding: 20px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .brand-header {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .brand-icon-header {
            width: 50px;
            height: 50px;
            background: var(--success-gradient);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: white;
            box-shadow: 0 8px 25px rgba(56, 239, 125, 0.3);
        }

        .brand-text h3 {
            font-weight: 700;
            font-size: 24px;
            margin: 0;
        }

        .brand-text p {
            font-size: 14px;
            opacity: 0.8;
            margin: 0;
        }

        /* Navigation Tabs */
        .nav-tabs-modern {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 8px;
            margin: 30px auto;
            max-width: 400px;
            border: 1px solid var(--glass-border);
        }

        .nav-tab-btn {
            background: transparent;
            border: none;
            color: rgba(255, 255, 255, 0.7);
            padding: 15px 30px;
            border-radius: 15px;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            flex: 1;
        }

        .nav-tab-btn.active {
            background: var(--success-gradient);
            color: white;
            box-shadow: 0 8px 25px rgba(56, 239, 125, 0.4);
            transform: translateY(-2px);
        }

        .nav-tab-btn:hover:not(.active) {
            background: rgba(255, 255, 255, 0.1);
            color: white;
        }

        /* Container Styles */
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px 40px;
        }

        /* Card Styles */
        .event-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 24px;
            padding: 30px;
            margin-bottom: 30px;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .event-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: var(--info-gradient);
        }

        .event-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.2);
        }

        /* Event Grid */
        .events-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }

        .event-item {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 25px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .event-item::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 2px;
            background: var(--secondary-gradient);
        }

        .event-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }

        .event-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .event-title {
            font-size: 20px;
            font-weight: 700;
            color: white;
            margin-bottom: 8px;
        }

        .event-description {
            color: rgba(255, 255, 255, 0.8);
            font-size: 14px;
            line-height: 1.5;
        }

        .event-meta {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin: 20px 0;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 14px;
            color: rgba(255, 255, 255, 0.9);
        }

        .meta-icon {
            width: 32px;
            height: 32px;
            background: var(--glass-bg);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
        }

        /* Price Badge */
        .price-badge {
            position: absolute;
            top: 20px;
            right: 20px;
            background: var(--success-gradient);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 14px;
            box-shadow: 0 4px 15px rgba(56, 239, 125, 0.4);
        }

        /* Booking Controls */
        .booking-controls {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-top: 20px;
            padding: 20px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .ticket-input {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            color: white;
            padding: 10px 15px;
            width: 80px;
            text-align: center;
            font-weight: 600;
        }

        .ticket-input:focus {
            outline: none;
            border-color: rgba(56, 239, 125, 0.6);
            background: rgba(255, 255, 255, 0.15);
        }

        /* Buttons */
        .btn-modern {
            background: var(--secondary-gradient);
            border: none;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            padding: 12px 24px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }

        .btn-modern:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(245, 87, 108, 0.4);
            color: white;
        }

        .btn-success {
            background: var(--success-gradient);
        }

        .btn-success:hover {
            box-shadow: 0 8px 25px rgba(56, 239, 125, 0.4);
        }

        .btn-warning {
            background: var(--warning-gradient);
        }

        .btn-warning:hover {
            box-shadow: 0 8px 25px rgba(250, 112, 154, 0.4);
        }

        /* Table Styles */
        .modern-table {
            width: 100%;
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            overflow: hidden;
            border: 1px solid var(--glass-border);
        }

        .modern-table thead {
            background: var(--glass-dark);
        }

        .modern-table th {
            padding: 20px 15px;
            font-weight: 600;
            color: white;
            border: none;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .modern-table td {
            padding: 20px 15px;
            border: none;
            color: rgba(255, 255, 255, 0.9);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .modern-table tbody tr:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        /* Status Badges */
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-available {
            background: rgba(56, 239, 125, 0.2);
            color: #38ef7d;
            border: 1px solid rgba(56, 239, 125, 0.3);
        }

        .status-sold-out {
            background: rgba(245, 87, 108, 0.2);
            color: #f5576c;
            border: 1px solid rgba(245, 87, 108, 0.3);
        }

        /* Empty States */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            border: 1px solid var(--glass-border);
        }

        .empty-icon {
            width: 80px;
            height: 80px;
            background: var(--glass-bg);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 36px;
            color: rgba(255, 255, 255, 0.6);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .events-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .event-meta {
                grid-template-columns: 1fr;
            }
            
            .booking-controls {
                flex-direction: column;
                align-items: stretch;
                gap: 10px;
            }
            
            .nav-tabs-modern {
                margin: 20px;
            }
            
            .nav-tab-btn {
                padding: 12px 20px;
                font-size: 14px;
            }
        }

        /* Animations */
        .fade-in {
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .ripple {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.3);
            transform: scale(0);
            animation: ripple 0.6s linear;
            pointer-events: none;
        }

        @keyframes ripple {
            to {
                transform: scale(4);
                opacity: 0;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-content">
            <div class="brand-header">
                <div class="brand-icon-header">
                    <i class="fas fa-calendar-star"></i>
                </div>
                <div class="brand-text">
                    <h3>Event Dashboard</h3>
                    <p>Discover & book amazing events</p>
                </div>
            </div>
            <div>
                <button class="btn-modern btn-warning">
                    <i class="fas fa-user"></i>
                    Profile
                </button>
            </div>
        </div>
    </header>

    <div class="main-container">
        <!-- Alert messages -->
        <% if (message != null) {
               String alertClass = "alert-success";
               String iconClass = "fas fa-check-circle";
               if (message.contains("❌")) {
                   alertClass = "alert-danger";
                   iconClass = "fas fa-times-circle";
               } else if (message.contains("⚠️")) {
                   alertClass = "alert-warning";
                   iconClass = "fas fa-exclamation-triangle";
               }
        %>
            <div class="alert <%= alertClass %> alert-dismissible fade show animate__animated animate__fadeInDown" role="alert" style="background: var(--glass-bg); backdrop-filter: blur(20px); border: 1px solid var(--glass-border); border-radius: 15px; color: white;">
                <i class="<%= iconClass %> me-2"></i>
                <%= message %>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert"></button>
            </div>
            <script>
                document.addEventListener('DOMContentLoaded', function() {
                    Swal.fire({
                        icon: '<%= message.contains("❌") ? "error" : message.contains("⚠️") ? "warning" : "success" %>',
                        title: 'Notification',
                        text: '<%= message.replaceAll("❌|⚠️|✅", "").trim() %>',
                        background: 'rgba(255,255,255,0.95)',
                        backdrop: 'rgba(0,0,0,0.8)',
                        confirmButtonColor: '#38ef7d'
                    });
                });
            </script>
        <% } %>

        <!-- Navigation Tabs -->
        <div class="nav-tabs-modern d-flex">
            <form method="get" action="userevents" style="flex: 1;">
                <input type="hidden" name="view" value="book">
                <button type="submit" class="nav-tab-btn w-100 <%= !"mybookings".equals(view) ? "active" : "" %>">
                    <i class="fas fa-ticket-alt me-2"></i>
                    Book Events
                </button>
            </form>
            <form method="get" action="userevents" style="flex: 1;">
                <input type="hidden" name="view" value="mybookings">
                <button type="submit" class="nav-tab-btn w-100 <%= "mybookings".equals(view) ? "active" : "" %>">
                    <i class="fas fa-calendar-check me-2"></i>
                    My Bookings
                </button>
            </form>
        </div>

        <% if ("mybookings".equals(view)) { %>
            <!-- My Bookings Section -->
            <div class="fade-in">
                <div class="event-card">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h3 class="mb-0">
                            <i class="fas fa-calendar-check me-3" style="color: #38ef7d;"></i>
                            My Event Bookings
                        </h3>
                        <span class="badge" style="background: var(--success-gradient); padding: 8px 15px; border-radius: 20px; font-size: 14px;">
                            <%= bookings != null ? bookings.size() : 0 %> Bookings
                        </span>
                    </div>

                    <% if (bookings != null && !bookings.isEmpty()) { %>
                        <div class="table-responsive">
                            <table class="modern-table">
                                <thead>
                                    <tr>
                                        <th><i class="fas fa-star me-2"></i>Event</th>
                                        <th><i class="fas fa-info-circle me-2"></i>Details</th>
                                        <th><i class="fas fa-calendar me-2"></i>Date & Time</th>
                                        <th><i class="fas fa-map-marker-alt me-2"></i>Location</th>
                                        <th><i class="fas fa-ticket-alt me-2"></i>Tickets</th>
                                        <th><i class="fas fa-dollar-sign me-2"></i>Total</th>
                                        <th><i class="fas fa-clock me-2"></i>Booked</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (UserEvent booking : bookings) { %>
                                        <tr>
                                            <td>
                                                <div class="fw-bold" style="color: white;">
                                                    <%= booking.getEvent().getEventName() %>
                                                </div>
                                            </td>
                                            <td>
                                                <div style="max-width: 200px; font-size: 13px; line-height: 1.4;">
                                                    <%= booking.getEvent().getEventDescription() %>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center gap-2">
                                                    <div class="meta-icon">
                                                        <i class="fas fa-calendar"></i>
                                                    </div>
                                                    <span style="font-size: 13px;"><%= booking.getEvent().getEventDateTime() %></span>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center gap-2">
                                                    <div class="meta-icon">
                                                        <i class="fas fa-map-marker-alt"></i>
                                                    </div>
                                                    <span style="font-size: 13px;"><%= booking.getEvent().getLocation() %></span>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="status-badge status-available">
                                                    <%= booking.getTicketsBooked() %> tickets
                                                </span>
                                            </td>
                                            <td>
                                                <div class="fw-bold" style="color: #38ef7d; font-size: 16px;">
                                                    $<%= booking.getTotalPrice() %>
                                                </div>
                                            </td>
                                            <td>
                                                <div style="font-size: 12px; opacity: 0.8;">
                                                    <%= booking.getBookingTime() %>
                                                </div>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    <% } else { %>
                        <div class="empty-state">
                            <div class="empty-icon">
                                <i class="fas fa-calendar-times"></i>
                            </div>
                            <h4 class="mb-3">No Bookings Yet</h4>
                            <p class="mb-4" style="color: rgba(255, 255, 255, 0.7);">
                                You haven't booked any events yet. Start exploring amazing events and book your tickets!
                            </p>
                            <form method="get" action="userevents" class="d-inline">
                                <input type="hidden" name="view" value="book">
                                <button type="submit" class="btn-modern btn-success">
                                    <i class="fas fa-search me-2"></i>
                                    Browse Events
                                </button>
                            </form>
                        </div>
                    <% } %>
                </div>
            </div>

        <% } else { %>
            <!-- Available Events Section -->
            <div class="fade-in">
                <div class="event-card">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h3 class="mb-0">
                            <i class="fas fa-star me-3" style="color: #f5576c;"></i>
                            Available Events
                        </h3>
                        <span class="badge" style="background: var(--secondary-gradient); padding: 8px 15px; border-radius: 20px; font-size: 14px;">
                            <%= events != null ? events.size() : 0 %> Events
                        </span>
                    </div>

                    <% if (events != null && !events.isEmpty()) { %>
                        <form action="bookEvent" method="post" id="bookingForm">
                            <div class="events-grid">
                                <% for (AdminEvent event : events) { %>
                                    <div class="event-item">
                                        <div class="price-badge">
                                            $<%= event.getTicketPrice() %>
                                        </div>

                                        <div class="event-header">
                                            <div>
                                                <h5 class="event-title"><%= event.getEventName() %></h5>
                                                <p class="event-description"><%= event.getEventDescription() %></p>
                                            </div>
                                        </div>

                                        <div class="event-meta">
                                            <div class="meta-item">
                                                <div class="meta-icon">
                                                    <i class="fas fa-calendar"></i>
                                                </div>
                                                <div>
                                                    <div style="font-size: 12px; opacity: 0.8;">Date & Time</div>
                                                    <div style="font-weight: 600;"><%= event.getEventDateTime() %></div>
                                                </div>
                                            </div>
                                            <div class="meta-item">
                                                <div class="meta-icon">
                                                    <i class="fas fa-map-marker-alt"></i>
                                                </div>
                                                <div>
                                                    <div style="font-size: 12px; opacity: 0.8;">Location</div>
                                                    <div style="font-weight: 600;"><%= event.getLocation() %></div>
                                                </div>
                                            </div>
                                            <div class="meta-item">
                                                <div class="meta-icon">
                                                    <i class="fas fa-ticket-alt"></i>
                                                </div>
                                                <div>
                                                    <div style="font-size: 12px; opacity: 0.8;">Available</div>
                                                    <div style="font-weight: 600; color: <%= event.getAvailableTickets() > 0 ? "#38ef7d" : "#f5576c" %>;">
                                                        <%= event.getAvailableTickets() %> tickets
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="meta-item">
                                                <div class="meta-icon">
                                                    <i class="fas fa-tag"></i>
                                                </div>
                                                <div>
                                                    <div style="font-size: 12px; opacity: 0.8;">Status</div>
                                                    <% if (event.getAvailableTickets() > 0) { %>
                                                        <span class="status-badge status-available">Available</span>
                                                    <% } else { %>
                                                        <span class="status-badge status-sold-out">Sold Out</span>
                                                    <% } %>
                                                </div>
                                            </div>
                                        </div>

                                        <% if (event.getAvailableTickets() > 0) { %>
                                            <div class="booking-controls">
                                                <div class="form-check" style="margin-right: auto;">
                                                    <input class="form-check-input" type="radio" name="eventId" 
                                                           value="<%= event.getEventId() %>" id="event_<%= event.getEventId() %>" 
                                                           required style="transform: scale(1.3);">
                                                    <label class="form-check-label fw-bold" for="event_<%= event.getEventId() %>">
                                                        Select Event
                                                    </label>
                                                </div>
                                                <div class="d-flex align-items-center gap-2">
                                                    <label style="font-size: 14px; font-weight: 600;">Tickets:</label>
                                                    <input type="number" class="ticket-input" 
                                                           name="tickets_<%= event.getEventId() %>" 
                                                           min="1" max="<%= event.getAvailableTickets() %>" 
                                                           value="1" required>
                                                </div>
                                            </div>
                                        <% } else { %>
                                            <div class="booking-controls" style="justify-content: center; opacity: 0.6;">
                                                <div class="text-center">
                                                    <i class="fas fa-times-circle me-2" style="color: #f5576c;"></i>
                                                    <span style="font-weight: 600;">Event Sold Out</span>
                                                </div>
                                            </div>
                                        <% } %>
                                    </div>
                                <% } %>
                            </div>

                            <div class="text-center mt-4">
                                <button type="submit" class="btn-modern btn-success" style="font-size: 18px; padding: 15px 40px;">
                                    <i class="fas fa-credit-card me-2"></i>
                                    Book Selected Event
                                </button>
                            </div>
                        </form>
                    <% } else { %>
                        <div class="empty-state">
                            <div class="empty-icon">
                                <i class="fas fa-calendar-times"></i>
                            </div>
                            <h4 class="mb-3">No Events Available</h4>
                            <p class="mb-4" style="color: rgba(255, 255, 255, 0.7);">
                                There are currently no events available for booking. Check back later for exciting events!
                            </p>
                            <button class="btn-modern btn-warning" onclick="window.location.reload()">
                                <i class="fas fa-refresh me-2"></i>
                                Refresh Page
                            </button>
                        </div>
                    <% } %>
                </div>
            </div>
        <% } %>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert2/11.7.12/sweetalert2.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Form validation for booking
            const bookingForm = document.getElementById('bookingForm');
            if (bookingForm) {
                bookingForm.addEventListener('submit', function(e) {
                    const selectedEvent = bookingForm.querySelector('input[name="eventId"]:checked');
                    if (!selectedEvent) {
                        e.preventDefault();
                        Swal.fire({
                            icon: 'warning',
                            title: 'Please Select an Event',
                            text: 'You must select an event before booking tickets.',
                            confirmButtonColor: '#38ef7d'
                        });
                        return;
                    }

                    // Show loading state
                    const submitBtn = this.querySelector('button[type="submit"]');
                    submitBtn.innerHTML = '<div class="spinner-border spinner-border-sm me-2" role="status"></div>Processing Booking...';
                    submitBtn.disabled = true;
                });
            }

            // Radio button change handler
            const radioButtons = document.querySelectorAll('input[name="eventId"]');
            radioButtons.forEach(radio => {
                radio.addEventListener('change', function() {
                    // Remove highlight from all event cards
                    document.querySelectorAll('.event-item').forEach(item => {
                        item.style.border = '1px solid rgba(255, 255, 255, 0.2)';
                        item.style.boxShadow = 'none';
                    });
                    
                    // Highlight selected event card
                    const selectedCard = this.closest('.event-item');
                    selectedCard.style.border = '2px solid #38ef7d';
                    selectedCard.style.boxShadow = '0 0 20px rgba(56, 239, 125, 0.3)';
                });
            });

            // Auto-hide alerts after 5 seconds
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                setTimeout(() => {
                    if (alert && alert.parentNode) {
                        alert.classList.remove('show');
                        setTimeout(() => {
                            if (alert && alert.parentNode) {
                                alert.remove();
                            }
                        }, 150);
                    }
                }, 5000);
            });

            // Add smooth transitions to nav tabs
            const navButtons = document.querySelectorAll('.nav-tab-btn');
            navButtons.forEach(button => {
                button.addEventListener('click', function() {
                    // Add loading state
                    this.innerHTML = '<div class="spinner-border spinner-border-sm me-2" role="status"></div>Loading...';
                });
            });

            // Add hover effects to event cards
            const eventItems = document.querySelectorAll('.event-item');
            eventItems.forEach(item => {
                item.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-8px) scale(1.02)';
                });
                
                item.addEventListener('mouseleave', function() {
                    if (!this.querySelector('input[name="eventId"]:checked')) {
                        this.style.transform = 'translateY(-5px) scale(1)';
                    }
                });
            });
        });

        // Add ripple effect to buttons
        document.querySelectorAll('.btn-modern, .nav-tab-btn').forEach(button => {
            button.addEventListener('click', function(e) {
                const ripple = document.createElement('span');
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;
                
                ripple.style.width = ripple.style.height = size + 'px';
                ripple.style.left = x + 'px';
                ripple.style.top = y + 'px';
                ripple.classList.add('ripple');
                
                this.appendChild(ripple);
                
                setTimeout(() => {
                    ripple.remove();
                }, 600);
            });
        });
    </script>
    
</body>
</html>