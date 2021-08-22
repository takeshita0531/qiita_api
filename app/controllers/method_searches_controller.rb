class MethodSearchesController < ApplicationController

    def index
        code_all = params[:code]
        @method_code = params[:method_code]
        paginate = params[:page]
        
        @method_search = Api::SearchMethod.new
        @method_search.search_method(code_all, @method_code, paginate)
        
        folders =  current_user.folders
        @folder_user = folders.map do |folder|
            folder.url
        end
    end 
    
    def create
        folder = Folder.new
        folder.title = params[:title]
        folder.url = params[:url]
        folder.user_name = params[:user_name]
        folder.user_id = current_user.id
        respond_to do |format|
        if folder.save
            code_all = params[:code]
            method_code = params[:method_code]
            paginate = params[:page]
            
            @method_search = Api::SearchMethod.new
            @method_search.search_method(code_all, method_code, paginate)
            format.html
            format.js
        else
            format.html { render :index } 
            format.js { render :errors } 
        end
        end
    end
end
