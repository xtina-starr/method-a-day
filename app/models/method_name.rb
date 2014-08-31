require 'rdoc'
class MethodName < ActiveRecord::Base

  def self.get_methods(method_class)
    store = RDoc::Store.new("rdoc_db")
    store.load_cache
    methods = store.load_class(method_class)

    array_of_methods = methods.each_method.map do |method|
      if method.singleton
        "::#{method.name}"
      else
        "##{method.name}"
      end
    end

    to_html = RDoc::Markup::ToHtml.new RDoc::Options.new
    array_of_methods.each do |m|
      method = store.load_method(method_class, m)

      MethodName.create(name: method.name, fullname: method.full_name, comment: to_html.convert(method.comment), link: "#{method_class}.html" + method.aref, kind: method_class.downcase)
      # puts method.full_name
      # puts to_html.convert method.comment
      # puts "-------------------------------------"
    end
  end

  def url
    "http://ruby-doc.org/core-2.1.0/#{self.link}"
  end

end
