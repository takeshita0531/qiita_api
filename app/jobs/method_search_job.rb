class MethodSearchJob < ApplicationJob
  queue_as :default

  def perform(method_code)
        if method_code.present?
            agent = Mechanize.new
                qiita_method = agent.get("https://qiita.com/search?page=1&q=ruby+#{method_code}")

                expected_qiita_description = qiita_method.search('.searchResult_snippet')
                qiita_method_title = qiita_method.search('.searchResult_itemTitle a')
                expected_qiita_name = qiita_method.search('.searchResult_itemTitle')
                expected_qiita_user_name = qiita_method.search('.searchResult_header a')
                expected_qiita_description.zip(qiita_method_title, expected_qiita_name, expected_qiita_user_name).each do |qiita_description, qiita_title, qiita_name, user_name|
                    method_memories = MethodMemory.new
                    method_memories.method = method_code
                    method_memories.expected_method_qiita = qiita_description.inner_text
                    method_memories.expected_url_qiita = qiita_title[:href]
                    method_memories.expected_title_qiita = qiita_name.inner_text
                    method_memories.expected_user_name = user_name.inner_text
                    method_memories.save
                    # method_memories.expected_method_qiita = @expected_method_qiita.push(qiita_description.inner_text)
                    # method_memories.expected_method_qiita = @expected_url_qiita.push(qiita_title[:href])
                    # method_memories.expected_method_qiita = @expected_title_qiita.push(qiita_name.inner_text)
                    # method_memories.expected_method_qiita = @expected_user_name.push(user_name.inner_text)
                end
                # binding.pry
                
            # end
            # @expected_method_qiita = Kaminari.paginate_array(@expected_method_qiita).page(paginate).per(10)
            # @expected_url_qiita = Kaminari.paginate_array(@expected_url_qiita).page(paginate).per(10)
            # @expected_title_qiita = Kaminari.paginate_array(@expected_title_qiita).page(paginate).per(10)
            # @expected_user_name = Kaminari.paginate_array(@expected_user_name).page(paginate).per(10)
            
            ruby_library = agent.get("https://docs.ruby-lang.org/ja/latest/library/_builtin.html")
            ruby_class = ruby_library.search('.signature a')
            
            ruby_class.each do |ruby| 
                ruby_class_url = ruby[:href].match(/class(.*)/) 
                ruby_method_url = agent.get("https://docs.ruby-lang.org/ja/latest/#{ruby_class_url}") 
                ruby_methods = ruby_method_url.search('dl a')
                # ruby_url1 = ruby_methods.to_s.slice(method_code)
                # result = ruby_methods.select { |x| x.children }
                # ruby_methods.select { |ruby_url|
                # result.each do |ruby_url|
                    ruby_methods.each do |ruby_url|
                        ruby_method_url_child = ruby_url[:href].match(/#(.*)/) 
                        ruby_method_inner_text = method_code.slice(ruby_url.inner_text)
                        if ruby_method_inner_text.present? && ruby_method_url_child.present?
                            ruby_method_child_commentary = "https://docs.ruby-lang.org/ja/latest/#{ruby_class_url}#{ruby_method_url_child}"
                            ruby_class_name = "https://docs.ruby-lang.org/ja/latest/#{ruby_class_url}"
                            ruby_method_description = agent.get("#{ruby_method_child_commentary.match(/.*#(.*)/)}")
                            ruby_class_description = agent.get("#{ruby_class_name.match(/.*#(.*)/)}")
                            all_method = ruby_method_description.search("#{ruby_method_url_child} code")
                            all_class = ruby_class_description.search("h1")
                            method_dt = ""
                            10.times do
                                method_heading = "#{ruby_method_url_child}#{method_dt}"
                                all_method_description = ruby_method_description.search("#{method_heading}"+ "+ .method-description")
                                method_dt += "+ .method-heading"
                                if all_method_description.present?
                            method_memories = MethodMemory.new
                                    # @extracted_method_description.push(all_method_description.inner_text)
                                    method_memories.extracted_method_description = all_method_description.inner_text
                                     method_memories.save
                                end
                            end 
                            method_memories = MethodMemory.new
                            method_memories.extracted_method_name = all_method.inner_text
                            method_memories.extracted_method_url = ruby_method_child_commentary
                            method_memories.extracted_method_class = all_class.inner_text
                            method_memories.save
                            # binding.pry
                        end 
                    end
            end 
        end
                            
  end
end
