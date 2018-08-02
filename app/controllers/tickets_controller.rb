class TicketsController < ApplicationController

    skip_before_action :verify_authenticity_token
    
    #post--新增ticket
    def create
        @ticket = Ticket.new(ticket_params)
        @name = @ticket.name
        if @name == "" or @name.nil?
            render :json => {"warming":"u forget filling ur name"}.to_json
            elsif
                
                @code = Time.now.strftime("%Y%m%d%L") << (0..9).to_a.shuffle.join
                @ticket.code = @code
                @ticket.save
                respond_to do |format|
                    format.json { render :json => { ticket_ID: @code}.to_json }
                end
        end
    end

    #get--查詢姓名
    def check
        @ticketowner = Ticket.find_by(code: params[:code])
        if @ticketowner.nil?
            render :json => {"status":"no such person"}.to_json
            elsif
                @name = @ticketowner.name
                respond_to do |format|
                    format.json { render :json => { NAME: @name}.to_json }
                end
        end
    end

    #put--修改姓名
    def update
        @ticketowner = Ticket.find_by(code: params[:code])
        if @ticketowner.update(name: params[:name])
            render :json => {"status":"OK"}.to_json
            #render JSON.parse('{"status":"OK"}')
            #render :json => {status: => "OK"}.to_json
            #respond_to do |format|
            #    format.json { render status: :OK }
            #end
            #    format.json { state :json => "OK" .to_json }
            #else
            
            #render json: "OK"
        else
            render :json => {"status":"Fail"}.to_json
            #render :json => {status: => "Fail"}.to_json
            #respond_to do |format|
            #    format.json { render status: :fail }
            #end
            #render json: "fail"
        end
    end

    #delete--刪除
    def delete
        @ticketowner = Ticket.find_by(code: params[:code])
        if @ticketowner.destroy
            render :json => {"status":"OK"}.to_json
            #render JSON.parse('{"status":"OK"}')
            #respond_to do |format|
            #    format.json { render status: :OK }
            #render json: "OK"
        else
            render :json => {"status":"Fail"}.to_json
            #render JSON.parse('{"status":"Fail"}')
            #format.json { render status: :fail }
            #render json: "fail"
        end
    end


    private

    def ticket_params
        params.permit(:name, :code)
    end

end
