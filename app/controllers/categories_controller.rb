class CategoriesController < ApplicationController
    
    skip_before_action :verify_authenticity_token

    #新增類別 POST /categories
    def create
        @admin = Member.find_by(token: params[:token])

        if  @admin.blank?
            render :json => {"Q":"who are u?"}.to_json
        
        elsif
            @admin.admin != "yes"
            render :json => {"Q":"who comes?"}.to_json

        else    
            @admin.admin == "yes"
            @category = Category.new(categories_params)
            @name = @category.name
            if @name.blank?
                render :json =>{"warning":"u forgot to give the name."}.to_json
            elsif
                @category.save
                render :json =>{"status":"OK."}.to_json
             else
                render :json =>{"status":"fail.".to_json}
            end
        end
    end

    #查詢類別 GET /categories/:id
    def show
        @admin = Member.find_by(token: params[:token])

        if  @admin.blank?
            render :json => {"Q":"who are u?"}.to_json
        
        elsif
            @admin.admin != "yes"
            render :json => {"Q":"who comes?"}.to_json

        else    
            @admin.admin == "yes"
            @category = Category.find_by(id: params[:id])
        
            if @category.blank?
                render :json => {"warning":"no such category."}.to_json
             else
                render :json =>{"NAME": @category.name}.to_json
            end
        end
    end

    #修改類別 PUT /categories/:id
    def update
        @admin = Member.find_by(token: params[:token])

        if  @admin.blank?
            render :json => {"Q":"who are u?"}.to_json
        
        elsif
            @admin.admin != "yes"
            render :json => {"Q":"who comes?"}.to_json

        else    
            @admin.admin == "yes"
            @category = Category.find_by(id: params[:id])
        
            if @category.blank?
                render :json => {"warning":"no such category."}.to_json
            elsif
                @category.update(name: params[:name])
                render :json =>{"status":"OK."}.to_json
            else
                render :json =>{"status":"fail. u may forgot to give the new name"}.to_json
            end
        end
    end

    #刪除類別 DELETE /categories/:id
    def destroy
        @admin_token = Member.find_by(token: params[:token])

        if  @admin.blank?
            render :json => {"Q":"who are u?"}.to_json
        
        elsif
            @admin.admin != "yes"
            render :json => {"Q":"who comes?"}.to_json

        else    
            @admin.admin == "yes"
            @category = Category.find_by(id: params[:id])
        
            if @category.blank?
                render :json => {"warning":"no such category."}.to_json
            elsif
                @category.destroy
                render :json =>{"status":"OK."}.to_json
            else
                render :json =>{"status":"fail."}.to_json
            end
        end

    end

    private
    
    def categories_params
        params.permit(:name)
    end
end
