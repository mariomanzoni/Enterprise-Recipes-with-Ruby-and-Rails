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


export CLASSPATH=lib/commons-logging-1.1.jar
export CLASSPATH=$CLASSPATH:lib/activemq-all-5.0.0.jar
export CLASSPATH=$CLASSPATH:lib/stompconnect-1.0.jar
export properties=-Djava.naming.factory.initial=\
org.apache.activemq.jndi.ActiveMQInitialContextFactory
export properties="$properties \
-Djava.naming.provider.url=tcp://localhost:61616"
java $properties org.codehaus.stomp.jms.Main \
tcp://localhost:62222 ConnectionFactory

