class ChefsController < ApplicationController
  before_action :set_chef, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]

  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 4)
  end


  def new
    @chef = Chef.new


  end

  def show
    #@chef = Chef.find(params[:id])
    @recipes = @chef.recipes.paginate(page: params[:page], per_page: 3)
  end


  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Your Account has been created successfully"
      session[:chef_id] = @chef.id #once user register it will automatically logged in
      redirect_to chef_path(@chef)#recipes_path
      #redirect_to chefs_path
    else
      render 'new'
    end
  end

  def edit
    #@chef = Chef.find(params[:id])
  end

  def update
    #@chef = Chef.find(params[:id])
    if @chef.update(chef_params)
      flash[:success] = "Your Profile Has benn updated successfully"
      redirect_to recipes_path #TODO show chef page
    else
      render 'edit'
    end
  end

  private
    def chef_params
      params.require(:chef).permit(:chefname, :email, :password)
    end

    def require_same_user
      if current_user != @chef
        flash[:danger] = "You can edit your own profile"
        redirect_to root_path
      end   
    end

    def set_chef
      @chef = Chef.find(params[:id])
    end
end