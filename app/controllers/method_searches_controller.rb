class MethodSearchesController < ApplicationController
    def index
        code_all = params[:code]
        if code_all.present?
            extracted_method_array = []
            ObjectSpace.each_object(Class) do |class_all|
                class_all.methods.each do |method|
                    if code_all.present?
                        method_result = code_all.slice(method.to_s)
                        if method_result != nil
                           extracted_method_array.push(method_result)
                           @extracted_methods = extracted_method_array.uniq
                        end
                    end 
                end 
            end 
        end
        
        method_code = params[:method_code]
        if method_code.present?
            @agent = Mechanize.new
            ruby_library = @agent.get("https://docs.ruby-lang.org/ja/latest/library/_builtin.html")
            @ruby_class = ruby_library.search('.signature a')
            
            @extracted_method_name = []
            @extracted_method_url = []
             @ruby_class.each do |ruby| 
                @ruby_class_url = ruby[:href].match(/class(.*)/) 
                @ruby_method_url = @agent.get("https://docs.ruby-lang.org/ja/latest/#{@ruby_class_url}") 
                @ruby_methods = @ruby_method_url.search('dl a')
                    @ruby_methods.each do |ruby_url|
                        @ruby_method_url_child = ruby_url[:href].match(/#(.*)/) 
                        
                        # method_code = params[:method_code]
                        inner_text = ruby_url.inner_text
                        if method_code.present?
                            # @ruby_method_inner_text = inner_text.match(/^#{code_all}$/) 
                            @ruby_method_inner_text = method_code.slice(inner_text.to_s)
                        end 
                        if @ruby_method_inner_text.present? && @ruby_method_url_child.present?
                            @ruby_method_child_commentary = "https://docs.ruby-lang.org/ja/latest/#{@ruby_class_url}#{@ruby_method_url_child}"
                            # @ruby_method_child_commentary.match(/.*#(.*)/)
                            @ruby_method_description = @agent.get("#{@ruby_method_child_commentary.match(/.*#(.*)/)}")
                            @all_method = @ruby_method_description.search("#{@ruby_method_url_child} code")
                            @extracted_method_name.push(@all_method.inner_text)
                            @extracted_method_url.push(@ruby_method_child_commentary)
                        end 

                    end  
                end 
        end
    end 
end
