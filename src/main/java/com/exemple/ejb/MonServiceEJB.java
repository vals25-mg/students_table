package com.exemple.ejb;

import jakarta.ejb.Stateless;
import jakarta.ejb.LocalBean;

@Stateless
@LocalBean
public class MonServiceEJB {
    
    public String direBonjour(String nom) {
        return "Bonjour " + nom + " depuis EJB ! 👋";
    }
    
    public int calculer(int a, int b) {
        return a + b;
    }
}