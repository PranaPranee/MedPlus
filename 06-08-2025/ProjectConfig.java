package com.example1;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


@Configuration
public class ProjectConfig {
    
	@Bean
    Fruit fruit() {
        Fruit fruit = new Fruit();
        fruit.setName("Avacado");
        return fruit;
    }

}