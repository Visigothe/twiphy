class TwilioController < ApplicationController
  def new
    @media_url = twilio_params[:media_url]
  end

  def create
    @phone_number = twilio_params[:phone_number]
    @body = twilio_params[:body].html_safe
    @media_url = twilio_params[:media_url]
    if @phone_number.scan(/\d{10}/).present?
      if @phone_number.length == 10
        if @body.present?
          @client = Twilio::REST::Client.new
          @message = @client.messages.create(
            to: "+1#{@phone_number}",
            from: ENV['TWILIO_FROM_NUMBER'],
            body: @body,
            media_url: @media_url
          )
          flash[:success] = 'Sending message!'
          redirect_to root_path
        else
          flash.now[:danger] = 'You need to enter a message to send.'
          render :new
        end
      else
        message = ['Phone number']
        message << (raw_phone_number.length < 10 ? 'is too short.' : 'is too long')
        flash.now[:danger] = message.join(' ')
        render :new
      end
    else
      flash.now[:danger] = 'Phone number must have 10 digits'
      render :new
    end
  end

  private

  def twilio_params
    params.require(:twilio).permit(:phone_number, :body, :media_url)
  end
end
