require 'dotenv'
Dotenv.load
require 'sinatra'
require 'Haml'
require 'pry'
require_relative 'models/ticket'

get '/' do
  haml :index, locals: {departments: %w(support general billing business subscription)}
end

post '/' do
  ticket = Ticket.new(params[:ticket])
  if ticket.submit
    haml :index, locals: {
      departments: %w(support general billing business subscription),
      success: "Ticket successfully submitted. You should receive an email about your ticket shortly"
    }
  else
    haml :index, locals: {
      departments: %w(support general billing business subscription),
      errors: "Sorry something went wrong"
    }
  end
end
