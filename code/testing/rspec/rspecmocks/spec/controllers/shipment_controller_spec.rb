#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe ShipmentController, 'track' do
  fixtures :orders

  it 'should track package correctly' do
    get :track, :id => orders(:beer)
    assigns[:state].should eql('delivered') 
  end
end



describe ShipmentController, 'track with mock service' do
  fixtures :orders
  
  before :each do
    tracking_service = mock('tracking service') 
    tracking_service.stub!(:track).and_return('delivered')
    TrackingService.stub!(:new).and_return(tracking_service)
  end

  it 'should track package correctly' do
    get :track, :id => orders(:beer)
    assigns[:state].should eql('delivered')
  end
end



describe ShipmentController, 'tracking service unavailable' do
  fixtures :orders

  before :each do
    tracking_service = mock('unavailable tracking service')
    tracking_service.stub!(:track).and_raise(IOError) 
    TrackingService.stub!(:new).and_return(tracking_service)
  end

  it 'should not be able to track package' do
    get :track, :id => orders(:beer)
    assigns[:state].should eql(:unavailable) 
  end
end



describe ShipmentController, 'track with mock model' do
  before :each do
    order = mock_model(Order, :tracking_number => '42') 
    Order.stub!(:find).and_return(order)
    tracking_service = mock('tracking service')
    tracking_service.stub!(:track).and_return('delivered')
    TrackingService.stub!(:new).and_return(tracking_service)
  end

  it 'should track package correctly without database access' do
    get :track, :id => 42
    assigns[:state].should eql('delivered')
  end
end



describe ShipmentController, 'track with expectation' do
  fixtures :orders
  
  before :each do
    @tracking_service = mock('tracking service')
    @tracking_service.stub!(:track).and_return('delivered')
    TrackingService.stub!(:new).and_return(@tracking_service)
  end

  it 'should track package correctly' do
    @tracking_service.should_receive(:track).with('42-xyz-4711'). 
      once.and_return('delivered')
    get :track, :id => orders(:beer)
    assigns[:state].should eql('delivered')
  end
end

