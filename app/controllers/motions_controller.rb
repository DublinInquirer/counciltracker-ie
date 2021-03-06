class MotionsController < ApplicationController
  def index
    @motions = Motion.published.by_occurred_on.page(params[:p])

    respond_to do |format|
      format.html { render :index }
      format.json do
        render json: @motions.limit(5)
      end
    end
  end

  def show
    @motion = Motion.published.find_by(hashed_id: params[:id])
    @view = params[:view].try(:to_sym) || :votes
    @context = params[:context].try(:to_sym) || :full

    case @context
    when :full
      render action: :show
    when :partial
      render partial: "motions/#{@view}", locals: {motion: @motion}
    else
      raise "Unhandled render context"
    end
  end
end
