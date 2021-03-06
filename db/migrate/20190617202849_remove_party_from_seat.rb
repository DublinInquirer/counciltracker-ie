class RemovePartyFromSeat < ActiveRecord::Migration[5.2]
  def change
    remove_column :seats, :party_id, :bigint

    Election.joins(:event).order("events.occurred_on asc").each do |election|
      election.parameters.each do |row|
        seat = Seat.find_by(id: row["seat_id"])
        party = if row["party_name"] == "Anti-Austerity Alliance"
          Party.find_by(name: "Solidarity")
        else
          Party.find_by(name: row["party_name"])
        end

        PartyAffiliation.create! seat: seat, party: party
      end
    end

    ChangeOfAffiliation.joins(:event).order("events.occurred_on asc").each do |change_of_affiliation|
      seat = change_of_affiliation.seat
      party = change_of_affiliation.incoming_party
      commenced_on = change_of_affiliation.occurred_on
      PartyAffiliation.create! seat: seat, party: party, commenced_on: commenced_on
    end

    CoOption.joins(:event).order("events.occurred_on asc").each do |co_option|
      seat = co_option.incoming_seat
      party = co_option.incoming_party
      PartyAffiliation.create! seat: seat, party: party, commenced_on: nil
    end

    Event.all.each(&:save)
  end
end
