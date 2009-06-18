/***
 * Excerpted from "Enterprise Recipes for Ruby and Rails",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
***/

package com.example;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class Client {
    public Client() throws Exception {
        Registry registry = LocateRegistry.getRegistry();
        this.accountManager =
            (AccountManager)registry.lookup("AccountManager");
    }
    
    public User authenticate(
        String username,
        String password) throws Exception
    {
        return this.accountManager.authenticate(username, password);
    }

    public static void main(String[] args) throws Exception {
        String username = args[0];
        String password = args[1];
        Client client = new Client();
        User   user = client.authenticate(username, password);
        if (user != null)
            System.out.println("Authenticated " + user + ".");
        else
            System.out.println("Could not authenticate user.");
    }


    private AccountManager accountManager;
}

