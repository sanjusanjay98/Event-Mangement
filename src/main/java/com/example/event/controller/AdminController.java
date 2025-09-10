package com.example.event.controller;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.event.dao.AdminEventRepo;
import com.example.event.dao.AdminRepo;
import com.example.event.model.Admin;
import com.example.event.model.AdminEvent;

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

    @Autowired
    private AdminRepo adminRepo;

    @Autowired
    private AdminEventRepo adminEventRepo;

 // ✅ Admin Login
    @PostMapping("/adminlogindata")
    public String adminLogin(
            @RequestParam("uname") String username,
            @RequestParam("pword") String password,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Optional<Admin> optionalAdmin = adminRepo.findByUsername(username);

        if (optionalAdmin.isPresent()) {
            Admin admin = optionalAdmin.get();
            if (admin.getPassword().equals(password)) {
                session.setAttribute("loggedInAdmin", admin);
                return "redirect:/showevents"; // ✅ go to show events page
            } else {
                redirectAttributes.addFlashAttribute("message", "❌ Incorrect password!");
                return "redirect:/alogin";
            }
        } else {
            redirectAttributes.addFlashAttribute("message", "❌ Username not found!");
            return "redirect:/alogin";
        }
    }

    // ✅ Register new admin
    @PostMapping("/newadmindata")
    public String newAdminAdd(
            @RequestParam("uname") String username,
            @RequestParam("pword") String pwd,
            @RequestParam("rpword") String rpwd,
            RedirectAttributes redirectAttributes) {

        if (!pwd.equals(rpwd)) {
            redirectAttributes.addFlashAttribute("message", "❌ Passwords do not match!");
            return "redirect:/nadmin";
        }

        if (adminRepo.findByUsername(username).isPresent()) {
            redirectAttributes.addFlashAttribute("message", "❌ Username already exists!");
            return "redirect:/nadmin";
        }

        Admin newAdmin = new Admin();
        newAdmin.setUsername(username);
        newAdmin.setPassword(pwd);
        adminRepo.save(newAdmin);

        redirectAttributes.addFlashAttribute("message", "✅ New admin created successfully!");
        return "redirect:/alogin";
    }

    // ✅ Add new event
    @PostMapping("/addEvent")
    public String addEvent(
            String eventName,
            String eventDescription,
            String eventDateTime,
            String location,
            Integer availableTickets,
            BigDecimal ticketPrice,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Admin admin = (Admin) session.getAttribute("loggedInAdmin");
        if (admin == null) {
            redirectAttributes.addFlashAttribute("message", "❌ Please login first!");
            return "redirect:/alogin"; // back to login
        }

        LocalDateTime dateTime = LocalDateTime.parse(eventDateTime, DateTimeFormatter.ISO_LOCAL_DATE_TIME);

        AdminEvent event = new AdminEvent(admin, eventName, eventDescription, dateTime,
                location, availableTickets, ticketPrice);
        adminEventRepo.save(event);

        redirectAttributes.addFlashAttribute("message", "✅ Event added successfully!");
        return "redirect:/showevents"; // reload list
    }

    
    // ✅ Show events for logged-in admin
    @GetMapping("/showevents")
    public ModelAndView showEvents(HttpSession session) {
        Admin loggedInAdmin = (Admin) session.getAttribute("loggedInAdmin");

        ModelAndView mv = new ModelAndView("admineventaccess");

        if (loggedInAdmin != null) {
            List<AdminEvent> events = adminEventRepo.findByAdmin(loggedInAdmin);
            mv.addObject("events", events != null ? events : Collections.emptyList());
        } else {
            mv.addObject("events", Collections.emptyList());
            mv.addObject("message", "Please log in to see your events.");
        }

        mv.addObject("operation", "show");
        return mv;
    }

    // ✅ Delete events
    @PostMapping("/deleteevents")
    public String deleteEvents(
            @RequestParam(value = "eventIds", required = false) List<Integer> eventIds,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Admin loggedInAdmin = (Admin) session.getAttribute("loggedInAdmin");

        if (loggedInAdmin == null) {
            redirectAttributes.addFlashAttribute("message", "❌ Please login first!");
            return "redirect:/alogin"; // back to login
        }

        if (eventIds != null && !eventIds.isEmpty()) {
            adminEventRepo.deleteAllById(eventIds);
            redirectAttributes.addFlashAttribute("message", "✅ Selected events deleted successfully!");
        } else {
            redirectAttributes.addFlashAttribute("message", "⚠️ No events selected for deletion.");
        }

        return "redirect:/showevents"; // reload updated events
    }

    
    @GetMapping("/addEvent")
    public String showAddEventForm(HttpSession session) {
        Admin admin = (Admin) session.getAttribute("loggedInAdmin");
        if (admin == null) {
            return "redirect:/alogin"; // force login
        }
        return "adminevent"; // JSP page with the Add Event form
    }

}
