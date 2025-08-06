package com.example1;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class Main {

    public static void main(String[] args) {

        Fruit fruit = new Fruit();
        fruit.setName("Lemon");
        System.out.println("Fruit name from non-spring context is: " + fruit.getName());
        
        AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(ProjectConfig.class);

        Fruit f = context.getBean(Fruit.class);
        System.out.println("Vehicle name from Spring Context is: " + f.getName());
        context.close();
    }
}