/***
 * Excerpted from "Enterprise Recipes for Ruby and Rails",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
***/
package com.example.messaging;

import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage;
import javax.jms.BytesMessage;

import org.springframework.context.support.*;

public class MessageReceiver implements MessageListener {
    public void onMessage(final Message message) {
        try {
            String content = null;
            if (message instanceof BytesMessage) { 
                BytesMessage bytesMessage = (BytesMessage)message;
                long messageLength = bytesMessage.getBodyLength();
                byte[] buffer = new byte[(int)messageLength];
                bytesMessage.readBytes(buffer);
                content = new String(buffer);
            } else if (message instanceof TextMessage) {
                content = ((TextMessage)message).getText();
            }
            System.out.println("We've got a message: " + content);
        }
        catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }

    public static void main(final String[] args) {
        new FileSystemXmlApplicationContext(args);
    }
}
