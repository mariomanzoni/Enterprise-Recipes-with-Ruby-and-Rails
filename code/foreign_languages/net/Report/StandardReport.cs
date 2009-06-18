/***
 * Excerpted from "Enterprise Recipes for Ruby and Rails",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
***/
using System;
using System.Data.OracleClient;

namespace Report {
  public class ReportData {
    public int totalOrders;
    public int closedOrders;
  }

  public class StandardReport {
    public StandardReport(string user, string password) { 
      connection = new OracleConnection();
      connection.ConnectionString = GetConnectionString(user, password);
      connection.Open();
    }

    public ReportData Create() { 
      ReportData reportData = new ReportData();
      OracleCommand command = connection.CreateCommand();
      command.CommandText = "select count(*) from orders";
      OracleDataReader reader = command.ExecuteReader();
      reader.Read();
      reportData.totalOrders = reader.GetInt32(0);
      command.CommandText = 
        "select count(*) from orders where state='closed'";
      reader = command.ExecuteReader();
      reader.Read();
      reportData.closedOrders = reader.GetInt32(0);
      command.Dispose();
      return reportData;
    }

    private string GetConnectionString(string user, string password) {
      return "User ID=" + user + ";Password=" + password + 
        ";Unicode=True";
    }

    private OracleConnection connection;
  }
}
