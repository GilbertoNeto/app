class CepController < ApplicationController
	def index
		finder = Correios::CEP::AddressFinder.new

		Correios::CEP.configure do |config|
		  config.request_timeout = 10 # It configures timeout to 3 seconds
		end

		@address = []
		if (params[:cep] =~ /^[0-9]{5}-[0-9]{3}$/) != nil
			@address = finder.get(params[:cep])
  		end
    	respond_to do |format|
			format.json { render json: @address }
		end
	end
end
