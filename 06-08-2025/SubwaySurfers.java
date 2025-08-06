package com.example6;

import org.springframework.stereotype.Component;

import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;


@Component
public class SubwaySurfers {

    private String playername;

   
    public String getPlayername() {
		return playername;
	}

	public void setPlayername(String playername) {
		this.playername = playername;
	}

	@PostConstruct
    public void initialize() {
        this.playername = "Jake";
    }

    @PreDestroy
    public void destroy() {
        System.out.println(
                "Destroying Subway Surfers Bean");
    }

    public void printHello(){
        System.out.println(
            "Printing Hello from Component SubwaySurfers Bean");
    }
}