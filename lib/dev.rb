require_relative 'wriki.rb'

def r
  Page.new(Wikipedia.random_url).doc
end

def t
  Page.new(Wikipedia.random_url).plaintext
end
