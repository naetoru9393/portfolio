class MonthsController < ApplicationController

    def new
        @months = Month.new
    end

    private

    def month_params
        praams.require(:month).permit(:month)
    end
end