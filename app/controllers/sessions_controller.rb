class SessionsController < ApplicationController
  def new
    redirect_to "/auth/google_oauth2"
  end

  def create
    info = request.env['omniauth.auth']
    user = User.first
    if user.nil?
      user = User.new(uid: info['uid'])
      session[:user] = info['uid']
    elsif user.uid != info['uid']
      session[:user] = nil
      redirect_to rooms_path
    end

    credentials = info['credentials']
    user.update access_token: credentials['access_token'],
      refresh_token: credentials['refresh_token'],
      expires_at: credentials['expires_at']
    
    session[:user] = info['uid']
      p info
    ##user           = User.new
    #user.id        = user_info["uid"]
    #user.name      = user_info["info"]["name"]
    #user.image_url = user_info["info"]["image"]

    #session[:user] = Marshal.dump(user_info)

    redirect_to rooms_path
  end
end
