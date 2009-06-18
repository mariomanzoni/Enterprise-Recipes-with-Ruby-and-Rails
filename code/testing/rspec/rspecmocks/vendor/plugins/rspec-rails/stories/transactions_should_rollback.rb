#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.join(File.dirname(__FILE__), *%w[helper])

Story "transactions should rollback", %{
  As an RSpec/Rails Story author
  I want transactions to roll back between scenarios
  So that I can have confidence in the state of the database
}, :type => RailsStory do
  Scenario "add one Person" do
    When "I add a Person" do
      Person.create!(:name => "Foo")
    end
  end
  
  Scenario "add another person" do
    GivenScenario "add one Person"
    Then "there should be one person" do
      Person.count.should == 1
    end
  end

  Scenario "add yet another person" do
    GivenScenario "add one Person"
    Then "there should be one person"
  end
end