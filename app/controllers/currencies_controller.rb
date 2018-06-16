require 'httparty'
class CurrenciesController < ApplicationController
	
	def new
	end

	def create
		Currency.create(name: params[:currency][:name],abbr: params[:currency][:abbr],logo: params[:currency][:logo],rate: params[:currency][:rate])
		redirect '#'
	end

	def top_currencies
		# binding.pry
		# list = currency_list["Data"]
		# render :json => {:responseCode => 200,:responseMessage => "Currency list fetched successfully.",currencies: top_10_ticker_price}
	end

end