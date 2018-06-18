require 'json'
require 'rqrcode_png'
class HomeController < ApplicationController
  before_action :authenticate_user, :except => [:currency_exchange,:index,:coming_soon]

  def index 
  	@currency = Currency.all
  	@top_10_ticker_price = {}
  	currency = HTTParty.get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,XRP,BTH,EOS,LTC,XMR,DASH,ETC,OMG&tsyms=USD')
  	currency["RAW"].map{|x| 
  		puts @top_10_ticker_price[x[0]] =
  		[x[1].first[1]["TOTALVOLUME24HTO"],
  		x[1].first[1]["CHANGEPCT24HOUR"]]
  	}
  end

  def coming_soon
  end

  def currency_exchange
    exchange_rate = HTTParty.get("https://shapeshift.io/rate/#{params["params"]["first"].downcase}_#{params["params"]["second"].downcase}")
    puts params["params"]["quantity"]
    data = params["params"]["quantity"].to_i * exchange_rate["rate"].to_f
    if exchange_rate["error"].present?
      flash[:alert] =  exchange_rate["error"]
    else
      flash[:alert] =   'You are not an authenticated user.Please login first.'
    end
    render :json => {:data => data}
  end

  def exchange
    @reusable_address = ReusableAddress.find_by(currency_name: params[:first].downcase, user_id: current_user.id) rescue ''
    exchange_rate = HTTParty.get("https://shapeshift.io/rate/#{params["first"].downcase}_#{params["second"].downcase}")
    @amount = exchange_rate["rate"].to_f
    @first_currency = params[:first].upcase()
    @second_currency = params[:second].upcase()
    session[:first_currency] = params[:first].upcase()
    session[:second_currency] = params[:second].upcase()
    @first_currency_icon = Currency.find_by(abbr: params[:first].downcase)
    @second_currency_icon = Currency.find_by(abbr: params[:second].downcase)
    session[:first_logo] = @first_currency_icon.logo.url
    session[:second_logo] = @second_currency_icon.logo.url
    @exchange_value = HTTParty.get("https://shapeshift.io/marketinfo/#{params["first"].downcase}_#{params["second"].downcase}")
  end

  def order_booking
    a = session[:transaction]["success"]["deposit"] rescue ''
    @qr = RQRCode::QRCode.new("#{a}").to_img.resize(200, 200).to_data_url 
    exchange_rate = HTTParty.get("https://shapeshift.io/rate/#{session[:first_currency].downcase}_#{session[:second_currency].downcase}")
    @amount = exchange_rate["rate"].to_f
  end

  def exchange_order
    reusable_address = ReusableAddress.find_by(currency_name: session[:first_currency].downcase, user_id: current_user.id) rescue ''
    if (reusable_address.present? and params[:currency][:resuable_address].present?)
      puts "Welcome"
    elsif( !reusable_address.present? and params[:currency][:resuable_address].present?) 
      ReusableAddress.create(currency_name: session[:first_currency].downcase, user_id: current_user.id, address: params[:currency][:refundalbe_address])
    elsif( reusable_address.present? and !params[:currency][:resuable_address].present?) 
      reusable_address.destroy
    else
      puts "else condtions"
    end
    @@params = params
    order = %x[curl -X POST -k -H 'Content-Type: application/json' -i 'https://shapeshift.io/sendamount' --data '{"amount" : #{session[:quantity].to_i}, "withdrawal":"#{params[:currency][:withdrawal_address]}", "pair":"#{session[:first_currency]}_#{session[:second_currency]}", "returnAddress":"#{params[:currency][:refundalbe_address]}"}']
    order = order.split("\r\n\r\n").last
    @data = JSON.parse(order)
    session[:transaction] = @data
    if  @data["error"].present? 
      redirect_to order_booking_home_index_url , alert: @data["error"]
    else
      redirect_to order_booking_home_index_url
    end
  end
  
end
