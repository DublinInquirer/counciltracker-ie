class Admin::CouncillorsController < Admin::ApplicationController
  def index
    @councillors = Councillor.by_name.page(params[:p])
  end

  def show
    @councillor = Councillor.find_by(slug: params[:id])
  end

  def new
    @councillor = Councillor.new
  end

  def edit
    @councillor = Councillor.find_by(slug: params[:id])
  end

  def create
    @councillor = Councillor.new(councillor_params)
    ActiveRecord::Base.transaction do
      if @councillor.save
        create_membership_if_supplied!(@councillor)
        redirect_to [:admin, @councillor]
      else
        render :new
      end
    end
  end

  def update
    @councillor = Councillor.find_by(slug: params[:id])
    if @councillor.update(councillor_params)
      redirect_to [:admin, @councillor]
    else
      render :edit
    end
  end

  def destroy
    @councillor = Councillor.find_by(slug: params[:id])
    @councillor.destroy!
    redirect_to [:admin, :councillors]
  end

  private

  def councillor_params
    params.require(:councillor).permit(:given_name, :family_name, :full_name, :gender, :born_on, :portrait)
  end

  def membership_params
    params.fetch(:councillor, {}).permit(:local_electoral_area_id, :party_id, :seat_commenced_on)
  end

  def create_membership_if_supplied!(councillor)
    lea_id = membership_params[:local_electoral_area_id]
    party_id = membership_params[:party_id]
    commenced_on_param = membership_params[:seat_commenced_on]

    return unless lea_id.present?

    council_session = CouncilSession.current || CouncilSession.latest
    return unless council_session

    commenced_on = if commenced_on_param.present?
      Date.parse(commenced_on_param) rescue council_session.commenced_on
    else
      council_session.commenced_on
    end

    seat = Seat.create!(
      council_session: council_session,
      local_electoral_area_id: lea_id,
      councillor: councillor,
      commenced_on: commenced_on
    )

    if party_id.present?
      seat.party_affiliations.create!(party_id: party_id)
    end
  end
end
