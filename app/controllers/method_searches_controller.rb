class MethodSearchesController < ApplicationController
    def index
        extracted_method_array = []
        ObjectSpace.each_object(Class) do |class_all|
            class_all.methods.each do |method|
                code_all = params[:code]
                if code_all.present?
                    method_result = code_all.slice(method.to_s)
                    if method_result != nil
                       extracted_method_array.push(method_result)
                       @extracted_methods = extracted_method_array.uniq
                    end
                end 
            end 
        end 
        
        @agent = Mechanize.new
        ruby_library = @agent.get("https://docs.ruby-lang.org/ja/latest/library/_builtin.html")
        @ruby_class = ruby_library.search('.signature a')
        
        # @ruby_class.each do |ruby|
        #     ruby_class_url = ruby[:href].match(/class(.*)/)
        #     ruby_method_url = @agent.get("https://docs.ruby-lang.org/ja/latest/#{ruby_class_url}")
        #     ruby_methods = ruby_method_url.search('.class-toc li')
        #     ruby_methods.each do |ruby_method|
        #             ruby_method_result= @agent.get("https://docs.ruby-lang.org/ja/latest/#{@ruby_class_url}#{ruby_method[:href]}")
        #             ruby_method_text = ruby_method_result.search('.method-heading')
        #             ruby_method_text.inner_text
        #         #ruby_method.[:href]
        #     end
        # end 
    end 
end
