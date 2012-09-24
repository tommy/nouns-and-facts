require 'rubygems'
require 'sinatra'
require 'haml'
require_relative 'lib/wriki'

get '/' do
  @sentence, @wiki_title = App.random_sentence_with_title
  haml :index
end

get '/*' do
  redirect to('/')
end

__END__

@@layout
%html
  %head
    %title
      nouns and facts
    <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
    %link{:href=>"style.css",:rel=>"stylesheet",:type=>"text/css"}
  %body
    = yield


@@index
%h1
  = @sentence
%h4
  = @wiki_title
