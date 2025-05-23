class ReservationsController < ApplicationController
    before_action :set_room, except: [:index]

    def index
        @reservations = current_user.reservations
    end

    def new
        @reservation = Reservation.new(
            check_in: params[:check_in],
            check_out: params[:check_out],
            number_of_guests: params[:number_of_guests]
        )

        @stay_days = (@reservation.check_out - @reservation.check_in).to_i if @reservation.check_in && @reservation.check_out
        @total_price = @stay_days * @reservation.number_of_guests * @room.price if @stay_days && @reservation.number_of_guests
    end

    def create
        @reservation = @room.reservations.build(reservation_params)
        @reservation.user = current_user

        if @reservation.save
            redirect_to room_reservations_path(@room), notice: '予約が完了しました'
        else
            render :new
        end
    end

    def show
        @reservation = @room.reservations.find(params[:id])
        @stay_days = (@reservation.check_out - @reservation.check_in).to_i
        @total_price = @stay_days * @reservation.number_of_guests * @room.price
    end

    def destroy
        @reservation = @room.reservations.find(params[:id])

        if @reservation.user == current_user
            @reservation.destroy
            redirect_to room_reservations_path(@room), notice: '予約をキャンセルしました'
        else
            redirect_to room_reservations_path(@room), alert: '予約はキャンセルできませんでした'
        end
    end
    
    private
    def set_room
        @room = Room.find_by(id: params[:room_id])
        unless @room
            redirect_to rooms_path, alert: '部屋が見つかりません'
        end
    end

    def reservation_params
        params.require(:reservation).permit(:check_in, :check_out, :number_of_guests)
    end
end
