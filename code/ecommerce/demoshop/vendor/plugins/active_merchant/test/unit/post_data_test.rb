#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class MyPost < PostData
  self.required_fields = [ :ccnumber, :ccexp, :firstname, :lastname, :username, :password, :order_id, :key, :time ]
end

class PostDataTest < Test::Unit::TestCase
  
  def setup
    
  end
  
  def teardown
    PostData.required_fields = []
  end
  
  def test_element_assignment
    name = 'Cody Fauser'
    post = PostData.new
    
    post[:name] = name
    assert_equal name, post[:name]
  end
  
  def test_ignore_blank_fields
    post = PostData.new
    assert_equal 0, post.keys.size
    
    post[:name] = ''
    assert_equal 0, post.keys.size
    
    post[:name] = nil
    assert_equal 0, post.keys.size
  end
  
  def test_dont_ignore_required_blank_fields
    PostData.required_fields = [ :name ]
    post = PostData.new
    
    assert_equal 0, post.keys.size
    
    post[:name] = ''
    assert_equal 1, post.keys.size
    assert_equal '', post[:name]
    
    post[:name] = nil
    assert_equal 1, post.keys.size
    assert_nil post[:name]
  end
    
  def test_subclass
    post = MyPost.new
    assert_equal [ :ccnumber, :ccexp, :firstname, :lastname, :username, :password, :order_id, :key, :time ], post.required_fields
  end
end