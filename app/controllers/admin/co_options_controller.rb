class Admin::CoOptionsController < ApplicationController
    def show
      @co_option = CoOption.find(params[:id])
    end
  
    def new
      @co_option = CoOption.new(occurred_on: Date.current)
    end
  
    def create
    #   @co_option = CoOption.create_from_date_and_csv!(election_params[:occurred_on], File.read(election_params[:election_csv].path))
    #   if @election.save
    #     redirect_to [:admin, @election]
    #   else
    #     render :new
    #   end
    render :new
    end
  
    private
  
    def election_params
      params.require(:election).permit(:occurred_on, :election_csv)
    end
  end
  