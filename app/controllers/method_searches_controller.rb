class MethodSearchesController < ApplicationController
    def index
        @text_value = "メソッドを入力してください。"
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
    end 
end
