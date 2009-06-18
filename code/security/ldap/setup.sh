#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
# Restarts slapd after deleting the repository.
kill -INT `ps -A | grep slapd | grep -v grep | cut -c 1-5`
rm -rf /opt/local/var/openldap-data/*
/opt/local/libexec/slapd -f slapd.conf -h 'ldap://localhost:389 ldaps://localhost:636'
ldapadd -c -x -D "cn=root,dc=enterpriserecipes,dc=com" -W -f init.ldif
