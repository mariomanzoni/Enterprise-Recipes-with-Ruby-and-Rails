/***
 * Excerpted from "Enterprise Recipes for Ruby and Rails",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
***/
package com.example;

public class User implements java.io.Serializable {
    public User(String forename, String surname) {
        this.forename = forename;
        this.surname = surname;
    }
    
    public String getForename() {
        return this.forename;
    }
    
    public String getSurname() {
        return this.surname;
    }
    
    public String toString() {
        return this.forename + " " + this.surname;
    }
    
    private String forename;
    private String surname;
}
