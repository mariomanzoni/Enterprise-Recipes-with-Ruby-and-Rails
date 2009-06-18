/***
 * Excerpted from "Enterprise Recipes for Ruby and Rails",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
***/
package com.example.messaging;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.*;
import org.springframework.jms.core.JmsTemplate;

public class MessageSender {
	public void setDestination(JmsTemplate destination) {
		this.destination = destination;
	}

	public void sendMessage(String message) throws Exception {
		this.destination.convertAndSend(message);
	}

	public static void main(String[] args) throws Exception {
		final String configFile = args[0];
		final String message = args[1];
		final ApplicationContext factory =
			new FileSystemXmlApplicationContext(configFile);
		
		final MessageSender sender =
			(MessageSender)factory.getBean("messageSender");
		sender.sendMessage(message);
	}
	
	private JmsTemplate destination;
}
