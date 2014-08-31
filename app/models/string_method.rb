require 'rdoc'

class StringMethod
  def self.get_methods(string)
    store = RDoc::Store.new("rdoc_db")
    store.load_cache
    strings = store.load_class(string)

    s = strings.each_method.map do |method|
      if method.singleton
        "::#{method.name}"
      else
        "##{method.name}"
      end
    end

    to_html = RDoc::Markup::ToHtml.new RDoc::Options.new
    s.each do |str_method|
      method = store.load_method(string, str_method)
      puts method.full_name
      puts to_html.convert method.comment
      puts "-------------------------------------"
    end
  end
end