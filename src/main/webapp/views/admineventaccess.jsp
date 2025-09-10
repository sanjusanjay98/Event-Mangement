<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.example.event.model.AdminEvent" %>

<%
    String operation = (String) request.getAttribute("operation");
    String message = (String) request.getAttribute("message");

    @SuppressWarnings("unchecked")
    List<AdminEvent> events = (List<AdminEvent>) request.getAttribute("events");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Management - Admin Panel</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            --warning-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            --danger-gradient: linear-gradient(135deg, #ff416c 0%, #ff4b2b 100%);
            --info-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
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
            background: var(--primary-gradient);
            min-height: 100vh;
            color: white;
        }

        /* Header */
        .admin-header {
            background: var(--glass-bg);
            backdrop-filter: blur(25px);
            border-bottom: 1px solid var(--glass-border);
            padding: 25px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .header-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .brand-section {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .admin-logo {
            width: 60px;
            height: 60px;
            background: var(--secondary-gradient);
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            color: white;
            box-shadow: 0 10px 30px rgba(245, 87, 108, 0.4);
        }

        .brand-info h2 {
            font-weight: 800;
            font-size: 28px;
            margin: 0;
            background: linear-gradient(135deg, #ffffff 0%, #f0f9ff 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .brand-info p {
            font-size: 14px;
            opacity: 0.8;
            margin: 0;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-avatar {
            width: 45px;
            height: 45px;
            background: var(--success-gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }

        /* Main Container */
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px 30px;
        }

        /* Message Styles */
        .alert-message {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: 15px;
            padding: 20px 25px;
            margin-bottom: 30px;
            border-left: 4px solid;
            display: flex;
            align-items: center;
            gap: 15px;
            animation: slideInDown 0.5s ease-out;
        }

        .alert-success {
            border-left-color: #38ef7d;
            background: linear-gradient(135deg, rgba(56, 239, 125, 0.1), rgba(17, 153, 142, 0.1));
        }

        .alert-error {
            border-left-color: #ff4b2b;
            background: linear-gradient(135deg, rgba(255, 65, 108, 0.1), rgba(255, 75, 43, 0.1));
        }

        .alert-warning {
            border-left-color: #fee140;
            background: linear-gradient(135deg, rgba(250, 112, 154, 0.1), rgba(254, 225, 64, 0.1));
        }

        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 20px;
            margin-bottom: 40px;
            flex-wrap: wrap;
        }

        .action-btn {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 2px solid var(--glass-border);
            color: white;
            padding: 18px 35px;
            border-radius: 18px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            position: relative;
            overflow: hidden;
        }

        .action-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .action-btn:hover {
            transform: translateY(-3px);
            color: white;
        }

        .action-btn:hover::before {
            left: 100%;
        }

        .btn-add {
            background: var(--success-gradient);
            border-color: rgba(56, 239, 125, 0.3);
        }

        .btn-add:hover {
            box-shadow: 0 15px 40px rgba(56, 239, 125, 0.4);
        }

        .btn-show {
            background: var(--info-gradient);
            border-color: rgba(79, 172, 254, 0.3);
        }

        .btn-show:hover {
            box-shadow: 0 15px 40px rgba(79, 172, 254, 0.4);
        }

        /* Content Cards */
        .content-card {
            background: var(--glass-bg);
            backdrop-filter: blur(25px);
            border: 1px solid var(--glass-border);
            border-radius: 28px;
            padding: 40px;
            margin-bottom: 30px;
            display: none;
            animation: slideInUp 0.6s ease-out;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.15);
        }

        .content-card.active {
            display: block;
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 35px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--glass-border);
        }

        .card-title {
            font-size: 24px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .card-icon {
            width: 50px;
            height: 50px;
            background: var(--secondary-gradient);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
        }

        /* Form Styles */
        .modern-form {
            display: grid;
            gap: 25px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-label {
            font-weight: 600;
            font-size: 16px;
            color: rgba(255, 255, 255, 0.9);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-control, .form-select {
            background: rgba(255, 255, 255, 0.1);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            color: white;
            font-size: 16px;
            padding: 18px 22px;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .form-control:focus, .form-select:focus {
            background: rgba(255, 255, 255, 0.15);
            border-color: rgba(245, 87, 108, 0.6);
            box-shadow: 0 0 0 4px rgba(245, 87, 108, 0.1);
            color: white;
            outline: none;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
        }

        /* Submit Button */
        .submit-btn {
            background: var(--secondary-gradient);
            border: none;
            border-radius: 15px;
            color: white;
            font-weight: 600;
            font-size: 18px;
            padding: 20px 40px;
            cursor: pointer;
            transition: all 0.4s ease;
            margin-top: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            box-shadow: 0 10px 30px rgba(245, 87, 108, 0.3);
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(245, 87, 108, 0.4);
        }

        /* Events Table */
        .events-table {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            overflow: hidden;
            border: 1px solid var(--glass-border);
            margin-top: 30px;
        }

        .events-table table {
            width: 100%;
            margin: 0;
            border-collapse: collapse;
        }

        .events-table thead {
            background: var(--glass-dark);
        }

        .events-table th {
            padding: 25px 20px;
            font-weight: 700;
            color: white;
            border: none;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
            text-align: left;
        }

        .events-table td {
            padding: 25px 20px;
            border: none;
            color: rgba(255, 255, 255, 0.9);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            vertical-align: middle;
        }

        .events-table tbody tr {
            transition: all 0.3s ease;
        }

        .events-table tbody tr:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        .event-name {
            font-weight: 600;
            font-size: 16px;
            color: white;
        }

        .event-description {
            max-width: 200px;
            font-size: 14px;
            line-height: 1.4;
            opacity: 0.8;
            word-wrap: break-word;
        }

        .ticket-info {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .ticket-count {
            font-weight: 600;
            color: #38ef7d;
        }

        .ticket-price {
            font-weight: 700;
            font-size: 18px;
            color: #fee140;
        }

        .event-datetime {
            font-size: 14px;
            color: rgba(255, 255, 255, 0.8);
        }

        .event-location {
            font-size: 14px;
            color: rgba(255, 255, 255, 0.8);
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* Delete Button */
        .delete-btn {
            background: var(--danger-gradient);
            border: none;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            padding: 15px 30px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .delete-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(255, 65, 108, 0.4);
        }

        /* Checkbox Styling */
        .custom-checkbox {
            width: 20px;
            height: 20px;
            accent-color: #f5576c;
            cursor: pointer;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-container {
                padding: 20px 15px;
            }

            .header-content {
                padding: 0 20px;
                flex-direction: column;
                gap: 20px;
            }

            .action-buttons {
                flex-direction: column;
                align-items: stretch;
            }

            .content-card {
                padding: 25px 20px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .events-table {
                overflow-x: auto;
            }

            .events-table table {
                min-width: 800px;
            }
        }

        /* Loading Animation */
        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,0.3);
            border-radius: 50%;
            border-top-color: #fff;
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* No Events Message */
        .no-events {
            text-align: center;
            padding: 60px 20px;
            color: rgba(255, 255, 255, 0.7);
        }

        .no-events i {
            font-size: 64px;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .no-events h4 {
            margin-bottom: 10px;
            color: rgba(255, 255, 255, 0.8);
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="admin-header">
        <div class="header-content">
            <div class="brand-section">
                <div class="admin-logo">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <div class="brand-info">
                    <h2>Event Manager</h2>
                    <p>Admin Dashboard</p>
                </div>
            </div>
            <div class="user-info">
                <div class="user-avatar">
                    <i class="fas fa-user-shield"></i>
                </div>
                <span>Admin Panel</span>
            </div>
        </div>
    </header>

    <!-- Main Container -->
    <div class="main-container">
        <!-- Success/Error Messages -->
        <% if (message != null) { 
            String alertClass = "alert-success";
            String iconClass = "fas fa-check-circle";
            if (message.contains("Error") || message.contains("Failed")) {
                alertClass = "alert-error";
                iconClass = "fas fa-exclamation-circle";
            } else if (message.contains("Warning")) {
                alertClass = "alert-warning";
                iconClass = "fas fa-exclamation-triangle";
            }
        %>
            <div class="alert-message <%= alertClass %>">
                <i class="<%= iconClass %>"></i>
                <span><%= message %></span>
            </div>
        <% } %>

        <!-- Action Buttons -->
        <div class="action-buttons">
            <button class="action-btn btn-add" onclick="showSection('addEventSection')">
                <i class="fas fa-plus-circle"></i>
                Add New Event
            </button>
            <button class="action-btn btn-show" onclick="showSection('showEventsSection')">
                <i class="fas fa-list"></i>
                View All Events
            </button>
        </div>

        <!-- Add Event Section -->
        <div id="addEventSection" class="content-card">
            <div class="card-header">
                <div class="card-title">
                    <div class="card-icon">
                        <i class="fas fa-calendar-plus"></i>
                    </div>
                    Create New Event
                </div>
            </div>

            <form action="addEvent" method="post" class="modern-form">
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-tag"></i>
                            Event Name
                        </label>
                        <input type="text" name="eventName" class="form-control" 
                               placeholder="Enter event name" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-clock"></i>
                            Date & Time
                        </label>
                        <input type="datetime-local" name="eventDateTime" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-map-marker-alt"></i>
                            Location
                        </label>
                        <input type="text" name="location" class="form-control" 
                               placeholder="Enter event location" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-tickets-alt"></i>
                            Available Tickets
                        </label>
                        <input type="number" name="availableTickets" class="form-control" 
                               placeholder="Number of tickets" min="1" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-dollar-sign"></i>
                            Ticket Price
                        </label>
                        <input type="number" name="ticketPrice" class="form-control" 
                               placeholder="Price per ticket" step="0.01" min="0" required>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-align-left"></i>
                        Event Description
                    </label>
                    <textarea name="eventDescription" class="form-control" 
                              placeholder="Describe your event..." rows="4"></textarea>
                </div>

                <button type="submit" class="submit-btn">
                    <i class="fas fa-save"></i>
                    Create Event
                </button>
            </form>
        </div>

        <!-- Show Events Section -->
        <div id="showEventsSection" class="content-card">
            <div class="card-header">
                <div class="card-title">
                    <div class="card-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    Event Management
                </div>
            </div>

            <% if (events != null && !events.isEmpty()) { %>
                <form action="deleteevents" method="post" onsubmit="return confirmDelete()">
                    <div class="events-table">
                        <table>
                            <thead>
                                <tr>
                                    <th>
                                        <input type="checkbox" class="custom-checkbox" 
                                               onclick="toggleAllCheckboxes(this)">
                                    </th>
                                    <th>ID</th>
                                    <th>Event Name</th>
                                    <th>Description</th>
                                    <th>Date & Time</th>
                                    <th>Location</th>
                                    <th>Tickets</th>
                                    <th>Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (AdminEvent e : events) { %>
                                    <tr>
                                        <td>
                                            <input type="checkbox" name="eventIds" 
                                                   value="<%= e.getEventId() %>" class="custom-checkbox">
                                        </td>
                                        <td><%= e.getEventId() %></td>
                                        <td class="event-name"><%= e.getEventName() %></td>
                                        <td class="event-description"><%= e.getEventDescription() %></td>
                                        <td class="event-datetime">
                                            <i class="fas fa-calendar"></i>
                                            <%= e.getEventDateTime() %>
                                        </td>
                                        <td class="event-location">
                                            <i class="fas fa-map-marker-alt"></i>
                                            <%= e.getLocation() %>
                                        </td>
                                        <td class="ticket-count"><%= e.getAvailableTickets() %></td>
                                        <td class="ticket-price">$<%= e.getTicketPrice() %></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    
                    <button type="submit" class="delete-btn">
                        <i class="fas fa-trash-alt"></i>
                        Delete Selected Events
                    </button>
                </form>
            <% } else { %>
                <div class="no-events">
                    <i class="fas fa-calendar-times"></i>
                    <h4>No Events Found</h4>
                    <p>You haven't created any events yet. Click "Add New Event" to get started!</p>
                </div>
            <% } %>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        function showSection(sectionId) {
            // Hide all sections
            const sections = document.querySelectorAll('.content-card');
            sections.forEach(section => {
                section.classList.remove('active');
            });

            // Show selected section
            const targetSection = document.getElementById(sectionId);
            if (targetSection) {
                targetSection.classList.add('active');
            }
        }

        function toggleAllCheckboxes(masterCheckbox) {
            const checkboxes = document.querySelectorAll('input[name="eventIds"]');
            checkboxes.forEach(checkbox => {
                checkbox.checked = masterCheckbox.checked;
            });
        }

        function confirmDelete() {
            const checkedBoxes = document.querySelectorAll('input[name="eventIds"]:checked');
            if (checkedBoxes.length === 0) {
                alert('Please select at least one event to delete.');
                return false;
            }

            const eventCount = checkedBoxes.length;
            const confirmMessage = `Are you sure you want to delete ${eventCount} event(s)? This action cannot be undone.`;
            return confirm(confirmMessage);
        }

        // Auto-hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert-message');
            alerts.forEach(alert => {
                setTimeout(() => {
                    alert.style.opacity = '0';
                    alert.style.transform = 'translateY(-20px)';
                    setTimeout(() => {
                        alert.remove();
                    }, 300);
                }, 5000);
            });
        });

        // Show add event section by default if no events
        <% if (events == null || events.isEmpty()) { %>
            document.addEventListener('DOMContentLoaded', function() {
                showSection('addEventSection');
            });
        <% } else { %>
            document.addEventListener('DOMContentLoaded', function() {
                showSection('showEventsSection');
            });
        <% } %>
    </script>
</body>
</html>