class CoOptions202002 < ActiveRecord::Migration[6.0]
  def change
    date = Date.new(2020,7,1)
    session = CouncilSession.current_on(date).take

    CoOption.create(
      occurred_on: date,
      outgoing_seat: session.seats.find_by_councillor_name("Marie Sherlock"),
      incoming_councillor: Councillor.find_or_create_by(full_name: "Declan Meenagh"),
      incoming_party: Party.find_by(slug: "labour")
    )

    CoOption.create(
      occurred_on: date,
      outgoing_seat: session.seats.find_by_councillor_name("Lawrence Hemmings"),
      incoming_councillor: Councillor.find_or_create_by(full_name: "Dearbháil Butler"),
      incoming_party: Party.find_by(slug: "green")
    )

    CoOption.create(
      occurred_on: date,
      outgoing_seat: session.seats.find_by_councillor_name("Rebecca Moynihan"),
      incoming_councillor: Councillor.find_or_create_by(full_name: "Darragh Moriarty"),
      incoming_party: Party.find_by(slug: "labour")
    )
  end
end
