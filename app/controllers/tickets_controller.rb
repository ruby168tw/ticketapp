class TicketsController < ApplicationController

    skip_before_action :verify_authenticity_token
    
    #post /ticket --新增票券
    def create
        @admin = Member.find_by(token: params[:token])

        if  @admin.blank?
            render :json => {"Q":"who are u?"}.to_json
        
        elsif
            @admin.admin != "yes"
            render :json => {"Q":"who comes?"}.to_json

        else    
            @admin.admin == "yes"

            @ticket = Ticket.new(ticket_params)
            @name = @ticket.name
            @member_id = @ticket.member_id
            @category_id = @ticket.category_id
            if @name.blank? or @member_id.blank? or @category_id.blank?
                render :json => {"warming":"u haven`t filled` ur shop`s name, memberID, or category_id yet."}.to_json
            elsif
                @ticket.save
                @code = Time.now.strftime("%Y%m%d%L") << (0..9).to_a.shuffle.join
                @ticket.code = @code
                @ticket.update(ticket_params)
                #@ticket.save
                respond_to do |format|
                    format.json { render :json => { ticket_ID: @code}.to_json }
                end
            else
                render :json => {"status":"fail."}.to_json
            end
        end
    end

    #get /ticket/:code--查詢票券資訊
    def check
        @admin = Member.find_by(token: params[:token])

        if  @admin.blank?
            render :json => {"Q":"who are u?"}.to_json
        
        elsif
            @admin.admin != "yes"
            render :json => {"Q":"who comes?"}.to_json

        else    
            @admin.admin == "yes"

            @ticketowner = Ticket.find_by(code: params[:code])
            if @ticketowner.blank?
                render :json => {"status":"no such ticket"}.to_json
            elsif
                @name = @ticketowner.name
                @member_id = @ticketowner.member_id
                @category = Category.find_by(:id => @ticketowner.category_id)
                @category_name =@category.name
                respond_to do |format|
                    format.json { render :json => { NAME: @name, MEMBER_ID: @member_id, CATEGORY: @category.name}.to_json }
                end
            end
        end
    end

    #put /ticket/:code--修改票券資訊
    def update
        @admin = Member.find_by(token: params[:token])

        if  @admin.blank?
            render :json => {"Q":"who are u?"}.to_json
        
        elsif
            @admin.admin != "yes"
            render :json => {"Q":"who comes?"}.to_json

        else    
            @admin.admin == "yes"
            @ticketowner = Ticket.find_by(code: params[:code])
            if @ticketowner.blank?
                render :json => {"status":"no such ticket"}.to_json
            elsif
                @ticketowner.update(ticket_params)
                render :json => {"status":"OK"}.to_json
            else
                render :json => {"status":"Fail"}.to_json
            end
        end
    end

    #delete /ticket/:code--刪除
    def delete
        @admin_token = Member.find_by(token: params[:token])

        if  @admin.blank?
            render :json => {"Q":"who are u?"}.to_json
        
        elsif
            @admin.admin != "yes"
            render :json => {"Q":"who comes?"}.to_json

        else    
            @admin.admin == "yes"
            @ticketowner = Ticket.find_by(code: params[:code])
            if @ticketowner.blank?
                render :json => {"status":"no such ticket"}.to_json
            elsif
                @ticketowner.destroy
                render :json => {"status":"OK"}.to_json
            else
                render :json => {"status":"Fail"}.to_json
            end
        end
    end

    #post /ticket/list--票券清單(供管理者查詢)
    def list
        @admin = Member.find_by(token: params[:token])

        if  @admin.blank?
            render :json => {"Q":"who are u?"}.to_json
        
        elsif
            @admin.admin != "yes"
            render :json => {"Q":"who comes?"}.to_json

        else    
            @admin.admin == "yes"
            respond_to do |format|
                @tickets = Ticket.all
                format.json { render :json => {name: @name, code: @code, category: @category_id.name, member_id: @member_id}.to_json}
            end
        end

    end


    private

    def ticket_params
        params.permit(:name, :code, :member_id, :category_id)
    end

end
