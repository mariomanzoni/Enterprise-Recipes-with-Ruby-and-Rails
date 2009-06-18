#!/bin/bash
#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

# Before running this script, download all necessary jar files to lib!

export CLASSPATH=bin:lib/spring.jar:lib/commons-logging-1.1.jar
export CLASSPATH=$CLASSPATH:lib/activemq-all-5.0.0.jar
javac -d bin src/com/example/messaging/MessageReceiver.java
java com.example.messaging.MessageReceiver etc/receiver.xml
