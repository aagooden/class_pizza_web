require "sinatra"
require "erb"
require_relative "methods.rb"

enable :sessions


get "/" do
	session[:size] = []
	session[:crust] = []
	session[:sauce] = []
	session[:meats] = Array.new
	session[:toppings] = Array.new
	session[:address] = []
	session[:current_order] = Array.new
	session[:full_order] = []
	erb :welcome
end

post "/prebuilt" do
	redirect "/prebuilt"
end

get "/prebuilt" do
	erb :prebuilt
end

post "/premades" do
	redirect "/premades"
end

get "/premades" do
	erb :premades
end

post "/size" do
	redirect "/size"
end


get "/size" do
	erb :size
end


post "/crust" do
	session[:size].push(params[:size])
	if session[:size].length > 1
		for x in (0...session[:size].length)
			session[:size].delete(session[:size][x])
		end
	end
	redirect "/crust"
end


get "/crust" do
	erb :crust
end


post "/sauce" do
	session[:crust].push(params[:crust])

	if session[:crust].length > 1
		for x in (0...session[:crust].length)
			session[:crust].delete(session[:crust][x])
		end
	end

	redirect "/sauce"
end


get "/sauce" do
	erb :sauce
end


post "/meats" do
	session[:sauce].push(params[:sauce])

	if session[:sauce].length > 1
		for x in (0...session[:sauce].length)
			session[:sauce].delete(session[:sauce][x])
		end
	end

	redirect "/meats"
end


get "/meats" do
	erb :meats
end


post "/toppings" do
	session[:meats].push(params[:meats])
	p session[:meats]
	redirect "/toppings"
end


get "/toppings" do
	erb :toppings
end

post "/meats_conf" do
	@size = session[:size]
	@crust = session[:crust]
	@sauce = session[:sauce]
	@meats = session[:meats]
	@toppings = session[:toppings]
	p params[:Premade]
	if params[:Premade] == "pepperoni, sausage"
		premade_pizza(params[:Premade].split(", "))	
	elsif params[:Premade].class == String
		premade_pizza(params[:Premade].split("\n"))	
	else
		session[:toppings].push(params[:toppings])
	end
	p session[:meats]
	redirect "/meats_conf"
end


get "/meats_conf" do
	if session[:meats] == [nil]
		redirect "/toppings_conf"
	end


	erb :meats_conf
end


post "/toppings_conf" do
	params.each do |meat|
		if meat[1] == "none"
			session[:meats][0].delete(meat[0])
		end
	end
	redirect "/toppings_conf"
end


get "/toppings_conf" do
	if session[:toppings] == [nil]
		redirect "/index"
	end

	erb :toppings_conf
end


post "/index" do
	params.each do |topping|
		if topping[1] == "none"
			session[:toppings][0].delete(topping[0])
		end
	end
	redirect "/index"
end


get "/index" do
	session[:current_order].push(session[:size])
	session[:current_order].push(session[:crust])
	session[:current_order].push(session[:sauce])
	session[:current_order].push(session[:meats])
	session[:current_order].push(session[:toppings])

	session[:order_total] = current_order_total(session[:current_order])
	session[:current_order].push(session[:order_total])
	session[:full_order].push(session[:current_order])

	erb :index
end


get "/delivery" do
	erb :delivery
end


post "/delivery" do
	session[:address].push(params[:f_name])
	session[:address].push(params[:l_name])
	session[:address].push(params[:address])
	session[:address].push(params[:city])
	session[:address].push(params[:state])
	redirect "/final_totalling"

end


post "/another" do
		session[:size] = []
		session[:crust] = []
		session[:sauce] = []
		session[:meats] = Array.new
		session[:toppings] = Array.new
		session[:current_order] = Array.new
		redirect "/prebuilt"
end


get "/final_totalling" do
	session[:final_total] = overall_total(session[:full_order])
	puts "The session[final_total] is #{session[:final_total]}"
	redirect "/finalize"
end


get "/finalize" do
	puts "The address is #{session[:address]}"
	erb :final
end


get "/news" do
	erb :news
end


get "/contact" do
	erb :contact
end


get "/about" do
	erb :about
end
