class MyMapsController < ApplicationController
  before_action :get_user
  before_action :authenticate_user!, :only => [:list, :show, :create, :destroy]

  def list
    @mymaps = @user.maps.order("updated_at DESC").page(params[:page] || 1).per(8)
    @mylayers = @user.layers
    @remove_from = true
    @html_title = "#{@user.login.capitalize}'s 'My Maps' on "
  end


  def create

    if @user == current_user
      @map = Map.find(params[:map_id])
      um = @user.my_maps.new(:map => @map)
      if um.save
        flash[:notice] = "Map saved to My Maps"
      else
        flash[:notice] = um.errors.on(:user_id)
      end

    else
      flash[:notice] = "You cannot add a map to another user!"
      #TODO redirect back with message
    end

    redirect_to my_maps_path
    #TODO catch when http referer is down

  end

  #we shouldnt be able to remove a map we uploaded
  def destroy
    if (@user == current_user and !current_user.own_this_map?(params[:map_id]))

      my_map = @user.my_maps.find_by_map_id(params[:map_id])

      if my_map.destroy
        flash[:notice] = "Map removed from list!"
      else
        flash[:notice] = "Map coudn't be removed from list"
      end
    else
      if current_user.own_this_map?(params[:map_id])
        flash[:notice]= "Sorry, you cannot remove maps you have uploaded, from the list"
      else
        flash[:notice]= "Map coudn't be removed from list"
      end



    end
    redirect_to my_maps_path
  end

  private
  def get_user
    @user = User.find(params[:user_id])

    if user_signed_in?
      if  @user == current_user or  current_user.has_role?("editor")
        @user
      else
        return redirect_to user_path(current_user)
      end
    else
      return redirect_to maps_path
    end

  end


end
