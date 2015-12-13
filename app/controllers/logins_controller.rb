class LoginsController < ApplicationController

  def new

  end

  def create
    chef = Chef.find_by(email: params[:email])
    # puts "id " << String(chef.id) <<" email " << String(chef.email) << " password " << String(params[:password])
    if chef && chef.authenticate(params[:password])
      session[:chef_id] = chef.id
      flash[:success] = "Login Successfull"
      redirect_to recipes_path
    else  
      flash.now[:danger] = "Your email or passowrd doesn,t match!!"
      render 'new' 
    end
  end


  def destroy
    session[:chef_id] = nil
    flash[:success] = "Successfully log out........"
    redirect_to root_path

  end

end