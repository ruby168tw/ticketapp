class MembersController < ApplicationController

    skip_before_action :verify_authenticity_token
    
    #會員新增 POST /member 
    def create
        @member = Member.new(member_params)
        @name = @member.name
        @age = @member.age
        @account = @member.account
        @password = @member.password
        if @name.blank? or @age.blank? or @account.blank? or @password.blank?
            render :json => {"warming":"u haven`t filled` the information completely."}.to_json
    
        elsif
            @member.save
            @token = rand(999999)
            @member.token = @token
            @member.update(member_params)
            respond_to do |format|
                format.json { render :json => {Token: @token}.to_json }
            end

        elsif
            @account =Member.find_by(account: params[:account])
            render :json => {"status":"此帳號已註冊"}.to_json
            
        else
            render :json => {"status":"fail"}.to_json
        end
    end

    #會員修改 PUT /member/:token
    def update
        @member = Member.find_by(token: params[:token])
        if @member.blank?
            render :json => {"warming":"no such person."}.to_json
            elsif
                @member.update(member_params)
                render :json => {"status":"OK."}.to_json
            else
                render :json => {"status":"fail."}.to_json
        end
    end


    #會員查詢 GET /member/:token
    def show
        @member = Member.find_by(token: params[:token])
        if @member.blank?
            render :json => {"warming":"no such person."}.to_json
        else
            respond_to do |format|
                format.json { render :json => @member.to_json(:only => [:name, :age, :account, :password] )}
            end
        end
    end

    #會員刪除 DELETE /member/:token
    def destroy
        @member = Member.find_by(token: params[:token])
        if @member.blank?
            render :json => {"warming":"no such person."}.to_json
            elsif
                @member.destroy
                render :json => {"status":"OK."}.to_json
            else
                render :json => {"status":"fail."}.to_json
        end
    end

    #會員清單查詢 POST /member/list/
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
            @members = Member.all
            format.json { render :json => @members.to_json(:only => [:name, :age, :password, :account, :token] )}
            end
        end
    end
    

    #會員查詢個人所有全部票券 GET /member/checktickets/:token
    def c_tickets
        @member = Member.find_by(token: params[:token])
        @tickets = Ticket.where(:member_id => @member.id)
        if @tickets.blank?
            render :json => {"message":"There`s no ticket."}.to_json
            elsif
                respond_to do |format|
                    format.json { render :json => @tickets.to_json(:only => [:name, :code, :category_id, :member_id] )}
                end
        end

    end

    #會員查詢單一票券資料 POST /member/singleticket/
    #def s_ticket
    #    @member = Ticket.find_by(member_id: params[:member_id])
    #    @ticket = Ticket.find_by(code: params[:code])
    #    @category = Category.find_by(:id => @ticket.category_id)
    #    @category_name = @category.name
    #    if @member.blank?
    #        render :json => {"warning":"no such person."}.to_json
    #        elsif
    #            @ticket.blank?
    #            render :json => {"warning":"no such ticket."}.to_json
    #            elsif
    #                respond_to do |format|
    #                    format.json {render :json =>  {NAME: @ticket.name, CODE: @ticket.code, CATEGORY: @category_name}.to_json}
    #                end
    #    end
    #end
     
    #會員登入 POST /member/login
    def login
        @account = Member.find_by(account: params[:account])
        @password = Member.find_by(password: params[:password])
        if @account.blank? or @password.blank?
            render :json => {"status":"u haven`t filled the information correctly."}.to_json

        elsif 
            @account = Member.find_by(account: params[:account])
            @token = rand(999999)
            @account.token = @token
            @account.update(member_params)
            respond_to do |format|
                format.json { render :json => { Token: @token }.to_json }
            end

        else
            render :json => {"status":"fail."}.to_json
        end
    end

    #會員登出 POST /member/logout
    def logout
        @account = Member.find_by(account: params[:account])
        @token = Member.find_by(token: params[:token])
    
        if @account.blank? or @token.blank?
            render :json => {"status":"there`s something wrong."}.to_json

        elsif 
            @account.token == @token.token
            @token.token = nil
            p "*****"
            p @token.token
            p "*****"
            @token.save(member_params)
            render :json => {"status":"goodbye."}.to_json
         
        else
            render :json => {"status":"the account or the token is false."}.to_json
        end

    end
     


    private
    def member_params
        params.permit(:name, :age, :admin, :account, :password, :token)
    end

    


end
