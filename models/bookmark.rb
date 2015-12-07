require_relative 'dbbase'

class Bookmark < DBBase

  attributes({:url => :string, :name => :string, :genre => :string, :details => :string} )

end