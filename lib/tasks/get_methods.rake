require 'rdoc/task'
require 'net/http'
require 'pp'

RDoc::Task.new('ruby_rdoc') do |rdoc|
  # rdoc.main = "README.rdoc"
  rdoc.rdoc_files.include("ruby-2.1.2")
  rdoc.options << "--ri"
  rdoc.rdoc_dir = "rdoc_db"
end

created_rid = file "rdoc_db/created.rid"
index_html = Rake::Task['rdoc_db/index.html']
created_rid.actions.replace(index_html.actions)
created_rid.prerequisites.replace(index_html.prerequisites)

Rake::Task['ruby_rdoc'].prerequisites.replace(["rdoc_db/created.rid"])
# Rake::Task['rdoc_db/index.html'].prerequisites.delete("rakefile")
# rake rerdoc

file "ruby-2.1.2.tar.gz" do 
  uri = URI("http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz")

  Net::HTTP.start(uri.host, uri.port) do |http|
    request = Net::HTTP::Get.new uri

    http.request(request) do |response|
      open 'ruby-2.1.2.tar.gz', 'wb' do |io|
        response.read_body do |chunk|
          io.write chunk
        end
      end
    end
  end
end


directory "ruby-2.1.2" => "ruby-2.1.2.tar.gz" do
  sh "tar -xzf ruby-2.1.2.tar.gz"
end

desc("count methods in database")
task "count_methods" => "ruby_rdoc" do 
  store = RDoc::Store.new("rdoc_db")
  store.load_cache
  # puts store.class_methods.values.flatten.length + store.instance_methods.values.flatten.length
  # pp store.class_methods
  pp store.class_path("String")
end


desc("count all array methods in database")
task "count_array_methods" => "ruby_rdoc" do
  store = RDoc::Store.new("rdoc_db")
  store.load_cache
  # pp store.load_class("Array").method_list.sample
  pp store.load_method("Array", "#delete")
end

desc("get array methods")
task "get_arr_methods" => %w[ruby_rdoc environment] do
  MethodName.get_methods("Array")
end

desc("get string methods")
task "get_str_methods" => %w[ruby_rdoc environment] do
  MethodName.get_methods("String")
end

desc("get integer methods")
task "get_int_methods" => %w[ruby_rdoc environment] do
  MethodName.get_methods("Integer")
end
