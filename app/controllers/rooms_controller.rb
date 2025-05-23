class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :my_rooms]

  def index
    if params[:area].present? || params[:keyword].present?
      @rooms =Room.all
      @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%") if params[:area].present?
      @rooms = @rooms.where("name LIKE :keyword OR description LIKE :keyword", keyword: "%#{params[:keyword]}%") if params[:keyword].present?
    else
      @rooms = Room.all
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservations = @room.reservations.new
  end

  def search
    if params[:area].blank? && params[:keyword].blank?
      redirect_to rooms_path and return
    end

    @rooms = Room.all

    if params[:area].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
    end

    if params[:keyword].present?
      @rooms = @rooms.where("name LIKE :keyword OR description LIKE :keyword", keyword: "%#{params[:keyword]}%")
    end
  end

  def new
    @room = Room.new
    @reservation = @room.reservations.build
  end

  def create
    @room = current_user.rooms.build(room_params)
    Rails.logger.debug "New room user_id: #{current_user.id}"
    if @room.save
      redirect_to @room, notice: '施設を登録しました'
    else
      render :new
    end
  end

  def edit
    @room = Room.find(params[:id])
    Rails.logger.debug "Currrent Room: #{defined?(@room)}"
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to @room, notice: '施設情報を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @room = Room.find(params[:id])
    Rails.logger.debug "Reservations linked to this room: #{@room.reservations.inspect}"
    @room.destroy
    redirect_to my_rooms_user_path(current_user), notice: '施設情報を削除しました'
  end

  private

  def set_room
    Rails.logger.debug "Params: #{params.inspect}"
    @room = Room.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to rooms_path, alert: '予約した部屋はありません'
  end

  def room_params
    params.require(:room).permit(:name, :introduction, :price, :description, :address, :image)
  end

end

