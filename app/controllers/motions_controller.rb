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

  def council
    @council = params[:council].to_s.downcase
    unless %w[dcc fingal].include?(@council)
      render plain: 'Unknown council', status: :not_found and return
    end

    scope = Motion.published.joins(:meeting)
    if Meeting.column_names.include?("council")
      scope = scope.where(meetings: { council: @council })
    end
    @motions = scope.by_occurred_on.page(params[:p])

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @motions.limit(5) }
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
