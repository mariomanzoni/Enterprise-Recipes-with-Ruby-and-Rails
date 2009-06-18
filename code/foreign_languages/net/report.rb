#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

require 'mscorlib'
require 'System, Version=2.0.0.0,
         Culture=neutral, PublicKeyToken=b77a5c561934e089'
require 'System.Xml, Version=2.0.0.0,
         Culture=neutral,PublicKeyToken=b77a5c561934e089'

Xml = System::Xml 
doc = Xml::XmlDocument.new
doc.load('config.xml')

def doc.get_first_element(name) 
  get_elements_by_tag_name(name).item(0).inner_text
end

user = doc.get_first_element('user')
password = doc.get_first_element('password')



require 'Report.dll'

StandardReport = Report::StandardReport
ReportData = Report::ReportData

class ReportData
  def to_s
    "total: #{totalOrders}/closed: #{closedOrders}"
  end
end

sr = StandardReport.new(user, password)
report_data = sr.create
puts report_data



require 'PresentationFramework, Version=3.0.0.0,
         Culture=neutral, PublicKeyToken=31bf3856ad364e35'
require 'PresentationCore, Version=3.0.0.0,
         Culture=neutral, PublicKeyToken=31bf3856ad364e35'

Window = System::Windows::Window
Application = System::Windows::Application
Button = System::Windows::Controls::Button
StackPanel = System::Windows::Controls::StackPanel
Label = System::Windows::Controls::Label
Thickness = System::Windows::Thickness

window = Window.new 
window.title = 'Fancy .NET Report'
stack = StackPanel.new
stack.margin = Thickness.new 15 
window.content = stack

[
  "Here's our Report:",
  "Total orders: #{report_data.totalOrders}",
  "Closed orders: #{report_data.closedOrders}"
].each do |message|
  label = Label.new
  label.font_size = 24
  label.content = message
  stack.children.add label 
end

button = Button.new 
button.content = 'Close'
button.font_size = 24
button.click { |sender, args| Application.exit } 
stack.children.add button
app = Application.new
app.run window

