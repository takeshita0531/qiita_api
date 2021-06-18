class MethodSearche < ApplicationRecord
    def self.method_search
        @agent = Mechanize.new
        ruby_library = @agent.get("https://docs.ruby-lang.org/ja/latest/library/_builtin.html")
        @ruby_class = ruby_library.search('.signature a')
    end
end
