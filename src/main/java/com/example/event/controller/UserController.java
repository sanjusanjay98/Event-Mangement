package com.example.event.controller;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.event.dao.AdminEventRepo;
import com.example.event.dao.UserEventRepo;
import com.example.event.dao.UserRepo;
import com.example.event.model.AdminEvent;
import com.example.event.model.User;
import com.example.event.model.UserEvent;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {
    
    @Autowired
    UserRepo userRepo;
    
    @Autowired
    AdminEventRepo adminEventRepo;
    
    @Autowired
    UserEventRepo userEventRepo;
    
	    
    // ✅ Register new user
    @PostMapping("/newuserdata")
    public String newUserAdd(
            @RequestParam("uname") String username,
            @RequestParam("pword") String pword,
            @RequestParam("rpword") String rpword,
            RedirectAttributes redirectAttributes) {
        
        if (!pword.equals(rpword)) {
            redirectAttributes.addFlashAttribute("message", "❌ Passwords do not match!");
            return "redirect:/nuser";   // correct redirect
        }
        
        if (userRepo.findByUsername(username).isPresent()) {
            redirectAttributes.addFlashAttribute("message", "❌ Username already exists!");
            return "redirect:/nuser";
        }
        
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(pword);
        userRepo.save(newUser);
        
        redirectAttributes.addFlashAttribute("message", "✅ New user registered successfully!");
        return "redirect:/ulogin";  // redirect to login page
    }

    // ✅ Login user
    @PostMapping("/userlogindata")
    public String userLogin(
            @RequestParam("uname") String username,
            @RequestParam("pword") String password,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Optional<User> optionalUser = userRepo.findByUsername(username);

        if (optionalUser.isPresent()) {
            User user = optionalUser.get();

            if (password.equals(user.getPassword())) {
                session.setAttribute("loggedInUser", user);
                return "redirect:/userevents"; // go to events page
            } else {
                redirectAttributes.addFlashAttribute("message", "❌ Invalid password!");
                return "redirect:/ulogin";
            }
        } else {
            redirectAttributes.addFlashAttribute("message", "❌ Username not found. Please register!");
            return "redirect:/ulogin";
        }
    }
    
    
    @PostMapping("/bookEvent")
    public String bookEvent(
            @RequestParam("eventId") Integer eventId,
            HttpServletRequest request,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        if (eventId == null) {
            redirectAttributes.addFlashAttribute("message", "⚠️ Please select an event to book!");
            return "redirect:/userevents?view=book";
        }

        // Parse number of tickets
        int tickets = 1;
        String ticketParam = request.getParameter("tickets_" + eventId);
        try {
            tickets = Integer.parseInt(ticketParam);
            if (tickets <= 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            redirectAttributes.addFlashAttribute("message", "❌ Please enter a valid number of tickets");
            return "redirect:/userevents?view=book";
        }

        // Get logged-in user
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            redirectAttributes.addFlashAttribute("message", "❌ You must log in first");
            return "redirect:/ulogin";
        }

        // Find event
        Optional<AdminEvent> optionalEvent = adminEventRepo.findById(eventId);
        if (!optionalEvent.isPresent()) {
            redirectAttributes.addFlashAttribute("message", "❌ Event not found");
            return "redirect:/userevents";
        }
        AdminEvent event = optionalEvent.get();

        // Check available tickets
        if (tickets > event.getAvailableTickets()) {
            redirectAttributes.addFlashAttribute("message", "❌ Not enough tickets available");
            return "redirect:/userevents";
        }

        // Calculate total price
        BigDecimal totalPrice = event.getTicketPrice().multiply(BigDecimal.valueOf(tickets));

        // Create booking
        UserEvent booking = new UserEvent();
        booking.setUser(loggedInUser);
        booking.setEvent(event);
        booking.setTicketsBooked(tickets);
        booking.setBookingTime(LocalDateTime.now());
        booking.setTotalPrice(totalPrice);
        userEventRepo.save(booking);

        // Update available tickets
        event.setAvailableTickets(event.getAvailableTickets() - tickets);
        adminEventRepo.save(event);

        redirectAttributes.addFlashAttribute("message", "✅ Successfully booked " + tickets + " tickets for " + event.getEventName());

        return "redirect:/userevents?view=mybookings";
    }


    
    @GetMapping("/userevents")
    public String showEvents(
            @RequestParam(value = "view", required = false, defaultValue = "book") String view,
            HttpSession session,
            Model model) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/ulogin";

        model.addAttribute("view", view);

        if ("mybookings".equals(view)) {
            // Fetch booked events for this user
            List<UserEvent> bookings = userEventRepo.findByUserUsername(loggedInUser.getUsername());
            model.addAttribute("bookings", bookings);
        } else {
            // Fetch available events
            List<AdminEvent> events = adminEventRepo.findAll();
            model.addAttribute("events", events);
        }

        return "userevent"; // JSP
    }



}
