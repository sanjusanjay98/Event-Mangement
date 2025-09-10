package com.example.event.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	@GetMapping("/ulogin")
	public String UserLogin() {
		System.out.println("Hiii...!!!!");
		return "userlogin";
	}
	
	@GetMapping("/alogin")
	public String AdminLogin() {
		return "adminlogin";
	}
	
	@GetMapping("/nuser")
	public String NewUser() {
		return "newuser";
	}
	
	@GetMapping("/nadmin")
	public String NewAdmin() {
		return "newadmin";
	}
	
	@GetMapping("/aevent")
	public String AdminEvent() {
		return "adminevent";
	}
	
	@GetMapping("/aeaccess")
	public String AdminEventAccess() {
		return "admineventaccess";
	}
	
	@GetMapping("/uevent")
	public String UserEvent() {
		return "userevent";
	}
}
