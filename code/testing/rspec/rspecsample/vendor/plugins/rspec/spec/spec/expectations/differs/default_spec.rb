#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../../../spec_helper.rb'

module Spec
  module Fixtures
    class Animal
      def initialize(name,species)
        @name,@species = name,species
      end

      def inspect
        <<-EOA
<Animal
  name=#{@name},
  species=#{@species}
>
        EOA
      end
    end
  end
end

describe "Diff" do
  before(:each) do
    @options = ::Spec::Runner::Options.new(StringIO.new, StringIO.new)
    @differ = Spec::Expectations::Differs::Default.new(@options)
  end

  it "should output unified diff of two strings" do
    expected="foo\nbar\nzap\nthis\nis\nsoo\nvery\nvery\nequal\ninsert\na\nline\n"
    actual="foo\nzap\nbar\nthis\nis\nsoo\nvery\nvery\nequal\ninsert\na\nanother\nline\n"
    expected_diff="\n\n@@ -1,6 +1,6 @@\n foo\n-bar\n zap\n+bar\n this\n is\n soo\n@@ -9,5 +9,6 @@\n equal\n insert\n a\n+another\n line\n"
    diff = @differ.diff_as_string(expected, actual)
    diff.should eql(expected_diff)
  end

  it "should output unified diff message of two arrays" do
    expected = [ :foo, 'bar', :baz, 'quux', :metasyntactic, 'variable', :delta, 'charlie', :width, 'quite wide' ]
    actual   = [ :foo, 'bar', :baz, 'quux', :metasyntactic, 'variable', :delta, 'tango'  , :width, 'very wide'  ]

    expected_diff = <<'EOD'


@@ -5,7 +5,7 @@
  :metasyntactic,
  "variable",
  :delta,
- "charlie",
+ "tango",
  :width,
- "quite wide"]
+ "very wide"]
EOD


    diff = @differ.diff_as_object(expected,actual)
    diff.should == expected_diff
  end

  it "should output unified diff message of two objects" do
    expected = Spec::Fixtures::Animal.new "bob", "giraffe"
    actual   = Spec::Fixtures::Animal.new "bob", "tortoise"

    expected_diff = <<'EOD'

@@ -1,5 +1,5 @@
 <Animal
   name=bob,
-  species=giraffe
+  species=tortoise
 >
EOD

    diff = @differ.diff_as_object(expected,actual)
    diff.should == expected_diff
  end

end


describe "Diff in context format" do
  before(:each) do
    @options = Spec::Runner::Options.new(StringIO.new, StringIO.new)
    @options.diff_format = :context
    @differ = Spec::Expectations::Differs::Default.new(@options)
  end

  it "should output unified diff message of two objects" do
    expected = Spec::Fixtures::Animal.new "bob", "giraffe"
    actual   = Spec::Fixtures::Animal.new "bob", "tortoise"

    expected_diff = <<'EOD'

***************
*** 1,5 ****
  <Animal
    name=bob,
!   species=giraffe
  >
--- 1,5 ----
  <Animal
    name=bob,
!   species=tortoise
  >
EOD

    diff = @differ.diff_as_object(expected,actual)
    diff.should == expected_diff
  end
end
