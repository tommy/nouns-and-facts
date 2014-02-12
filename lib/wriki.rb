require 'nokogiri'
require 'open-uri'

module Wikipedia
  def self.random_url(sub="en")
    "http://#{sub}.wikipedia.org/wiki/Special:Random"
  end

  def self.article_url(name, sub="en")
    "http://#{sub}.wikipedia.org/wiki/#{name}"
  end
end

class Page
  attr_accessor :doc
  attr_accessor :url

  def initialize(url)
    open(url, "User-Agent" => "Ruby/#{RUBY_VERSION}") do |resp|
      @doc = Nokogiri::HTML(resp)
      @url = resp.base_uri
    end
  end

  def plaintext
    @doc.search("//p").text
  end

  def title
    @doc.search("//title").text
  end
end

class String
  def remove_citations
    gsub(/\[[0-9]+\]/, '')
  end
end

module NLP
  ENDERS = ".!?"

  def self.split_sentences(text)
    text.scan(%r{[^#{ENDERS}]*[#{ENDERS}]+}).map(&:remove_citations).map(&:strip)
  end
end

module App
  def self.random_sentence_with_title_and_url
    page = Page.new(Wikipedia.random_url)
    return NLP.split_sentences(page.plaintext).sample, page.title, page.url
  end
end
