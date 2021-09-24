class Api::SearchMethod
    attr_accessor :extracted_methods
    
    def search_method(code_all)
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
    end
end