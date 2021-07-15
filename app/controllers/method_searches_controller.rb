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
        
        @method_code = params[:method_code]
        if @method_code.present?
            @agent = Mechanize.new
            ruby_library = @agent.get("https://docs.ruby-lang.org/ja/latest/library/_builtin.html")
            @ruby_class = ruby_library.search('.signature a')
            
            @extracted_method_name = []
            @extracted_method_url = []
            @extracted_method_class = []
            @extracted_method_description = []
            @expected_method_qiita = []
            @expected_url_qiita = []
            @expected_title_qiita = []
            
            @qiita_method_url = @agent.get("https://qiita.com/search?q=rails+#{@method_code}") 
            @qiita_method_url.each do |qiita_method|
                @expected_qiita_description = @qiita_method_url.search('.searchResult_snippet')
                @expected_qiita_description.each do |qiita_description|
                    @expected_method_qiita.push(qiita_description.inner_text)
                end

                @qiita_method_title = @qiita_method_url.search('.searchResult_itemTitle a')
                @qiita_method_title.each do |qiita_title|
                    @expected_url_qiita.push(qiita_title[:href])
                end
                
                @expected_qiita_name = @qiita_method_url.search('.searchResult_itemTitle')
                @expected_qiita_name.each do |qiita_name|
                    @expected_title_qiita.push(qiita_name.inner_text)
                end
            end
            
            @ruby_class.each do |ruby| 
                @ruby_class_url = ruby[:href].match(/class(.*)/) 
                @ruby_method_url = @agent.get("https://docs.ruby-lang.org/ja/latest/#{@ruby_class_url}") 
                @ruby_methods = @ruby_method_url.search('dl a')
                    @ruby_methods.each do |ruby_url|
                        @ruby_method_url_child = ruby_url[:href].match(/#(.*)/) 
                        # method_code = params[:method_code]
                        inner_text = ruby_url.inner_text
                        if @method_code.present?
                            # @ruby_method_inner_text = inner_text.match(/^#{code_all}$/) 
                            @ruby_method_inner_text = @method_code.slice(inner_text.to_s)
                        end 
                        if @ruby_method_inner_text.present? && @ruby_method_url_child.present?
                            @ruby_method_child_commentary = "https://docs.ruby-lang.org/ja/latest/#{@ruby_class_url}#{@ruby_method_url_child}"
                            @ruby_class_name = "https://docs.ruby-lang.org/ja/latest/#{@ruby_class_url}"
                            # @ruby_method_child_commentary.match(/.*#(.*)/)
                            @ruby_method_description = @agent.get("#{@ruby_method_child_commentary.match(/.*#(.*)/)}")
                            @ruby_class_description = @agent.get("#{@ruby_class_name.match(/.*#(.*)/)}")
                            @all_method = @ruby_method_description.search("#{@ruby_method_url_child} code")
                            @all_class = @ruby_class_description.search("h1")
                            # @method_heading = ""
                            @method_dt = ""
                            20.times do
                                @method_heading = "#{@ruby_method_url_child}#{@method_dt}"
                                @all_method_description = @ruby_method_description.search("#{@method_heading}"+ "+ .method-description")
                                @method_dt += "+ .method-heading"
                                if @all_method_description.present?
                                    @extracted_method_description.push(@all_method_description.inner_text)
                                end
                            end 
                            @extracted_method_name.push(@all_method.inner_text)
                            @extracted_method_url.push(@ruby_method_child_commentary)
                            @extracted_method_class.push(@all_class.inner_text)
                        end 
                    end  
            end 
        end
    end 
end
