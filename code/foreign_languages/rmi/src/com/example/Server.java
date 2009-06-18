/***
 * Excerpted from "Enterprise Recipes for Ruby and Rails",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
***/
package com.example;
    
import java.rmi.registry.Registry;
import java.rmi.registry.LocateRegistry;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
    
public class Server implements AccountManager {
    public User authenticate(String username, String password) {
        User user = null;
        if (username != null && username.equals("maik"))
            if (password != null && password.equals("t0p$ecret"))
                user = new User("Maik", "Schmidt");
        return user;
    }
    
    public static void main(String args[]) throws Exception {
        AccountManager manager =
            (AccountManager)UnicastRemoteObject.exportObject(
                new Server(), 0
            );
        Registry registry = LocateRegistry.getRegistry();
        registry.bind("AccountManager", manager);
        System.out.println("Started Account Manager.");
    }
}
