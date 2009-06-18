#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class PreCommit::Core < PreCommit
  def pre_commit
    rake_invoke :examples
    website
  end

  def website(run_webby=true)
    clobber
    rake_invoke :verify_rcov
    rake_invoke :spec_html
    webby
    rake_invoke :failing_examples_with_html
    rdoc
    rdoc_rails
  end

  def clobber
    rm_rf '../doc/output'
    rm_rf 'translated_specs'
  end

  def webby
    Dir.chdir '../doc' do
      output = silent_sh('rake rebuild 2>&1')
      if shell_error?(output)
        raise "ERROR while generating web site: #{output}"
      end

      spec_page = File.expand_path('output/documentation/tools/spec.html')
      spec_page_content = File.open(spec_page).read
      unless spec_page_content =~/\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\./m
        raise "#{'!'*400}\nIt seems like the output in the generated documentation is broken (no dots: ......)\n. Look in #{spec_page}"
      end
    end
  end

  def rdoc
    Dir.chdir '../rspec' do
      rake = (PLATFORM == "i386-mswin32") ? "rake.cmd" : "rake"
      `#{rake} rdoc`
    end
  end

  def rdoc_rails
    Dir.chdir '../rspec_on_rails' do
      rake = (PLATFORM == "i386-mswin32") ? "rake.cmd" : "rake"
      `#{rake} rdoc`
    end
  end
end
