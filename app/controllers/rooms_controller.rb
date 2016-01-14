class RoomsController < ApplicationController
  def index
  end

  def rooms_index
    @rooms = Room.where(user_id: current_user)
  end

  def show
    @room = Room.find(params[:id])
  end

  def room_show
    @room = Room.find
  end

  def new
    @room = current_user.rooms.new
  end

  def create
    @room = current_user.rooms.create(room_params)
    if @room.save
      redirect_to '/rooms'
    else
      render 'new'
    end
  end

  def edit
  end

  private

  def room_params
    params.require(:room).permit(:name, :status)
  end
end
