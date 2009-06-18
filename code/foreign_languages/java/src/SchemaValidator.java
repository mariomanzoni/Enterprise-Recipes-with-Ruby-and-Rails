/***
 * Excerpted from "Enterprise Recipes for Ruby and Rails",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
***/

import java.io.StringReader;
import java.io.File;
import org.jdom.Document;
import org.jdom.input.SAXBuilder;

public class SchemaValidator {
  public static Document isValid(
    String xmlFileName,
    String xmlSchemaFileName)
  {
    try {
      final SAXBuilder builder = 
        new SAXBuilder("org.apache.xerces.parsers.SAXParser", true);
      builder.setFeature(
        "http://apache.org/xml/features/validation/schema",
        true
      );
      builder.setFeature(
        "http://apache.org/xml/features/validation/" +
          "schema-full-checking",
        true
      );
      builder.setFeature(
        "http://xml.org/sax/features/validation",
        true
      );
      builder.setFeature(
        "http://xml.org/sax/features/namespaces",
        false
      );
      builder.setProperty(
        "http://apache.org/xml/properties/schema/" +
          "external-noNamespaceSchemaLocation",
        new File(xmlSchemaFileName).toURL().toString()
      );
      return builder.build(xmlFileName); 
    }
    catch (Exception e) {
      System.err.println("Document is invalid: " + e.getMessage());
      return null; 
    }
  }


  public static void main(String[] args) {
    String xmlFile = args[0];
    String schemaFile = args[1];
    if (isValid(xmlFile, schemaFile) != null) {
      System.out.println(xmlFile + " is valid.");
    } else {
      System.out.println(xmlFile + " is invalid.");
    }
  }


}

