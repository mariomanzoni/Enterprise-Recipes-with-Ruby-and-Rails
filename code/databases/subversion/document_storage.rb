#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

require 'svn_repos'

class Document
  attr_accessor :path, :content, :author, :revision
  
  def initialize(path, content, author, revision)
    @path, @content, @author = path, content, author
    @revision = revision
  end
  
  def to_s
    <<-"EOS".gsub(/^    /, '')
    path: #{@path}
    content: #{@content}
    author: #{@author}
    revision: #{@revision}
    EOS
  end  
end

class DocumentStorage
  attr_reader :repository
  
  DEFAULT_PATH = File.join('.', 'data', 'docstore')
  
  def initialize(path = DEFAULT_PATH)
    @repository = if SvnRepos.repository_exists?(path) 
      SvnRepos.open(path)
    else
      SvnRepos.create(path)
    end
  end
  
  def add_document(path, content, author)
    @repository.commit path => content, :author => author 
  end
end

  

class DocumentStorage
  def get_document(path, revision = nil)
    return nil unless @repository.path_exists?(path, revision) 
    content = @repository.file_contents(path, revision) 
    author = @repository.property(:author, revision) 
    Document.new(path, content, author, revision)
  end
  
  def get_revisions(path)
    @repository.history(path)
  end
  
  def get_history(path)
    get_revisions(path).inject([]) do |h, r|
      h << get_document(path, r)
    end
  end
end


if $0 == __FILE__
  
  ds = DocumentStorage.new
  
  puts ds.repository.repos_path
  
  ds.add_document('/first/document', "Hello, world!\n", 'maik')
  ds.add_document('/first/document', "Hello!\nHow are you?\n", 'jack')
  ds.add_document('/another/document', "Yet another document.\n", 'maik')
  
  
  puts '--- Check for existence'
  puts 'Does not exist.' if ds.get_document('/does/not/exist').nil?
  puts '--- Get revision IDs'
  puts "Revisions: #{ds.get_revisions('/first/document').join(',')}"
  puts '--- Get document revision #1'
  puts ds.get_document('/first/document', 1)
  puts '--- Get document revision #2'
  puts ds.get_document('/first/document', 2)
  puts '--- Get document history'
  puts ds.get_history('/another/document')
  
  puts ds.repository.property(:author, 1)
  puts ds.repository.property(:author, 2)
  
  puts ds.repository.diff('/first/document', 1, '/first/document', 2)
  
  #p ds.repository.dump
  p ds.repository.ls('/first')
end
