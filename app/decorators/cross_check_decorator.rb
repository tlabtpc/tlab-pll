class CrossCheckDecorator < Draper::Decorator
  delegate_all

  def client_has_consulted_attorney
    case object.client_has_consulted_attorney
    when "representation_yes"         then "Yes"
    when "representation_no"          then "No"
    when "representation_i_dont_know" then "I don't know"
    end
  end

  def client_is_long_term
    case object.client_has_consulted_attorney
    when "yes"         then "Yes"
    when "no"          then "No"
    when "i_dont_know" then "I don't know"
    end
  end

  def client_has_attorney_representation
    case object.client_has_consulted_attorney
    when "consulted_yes"         then "Yes"
    when "consulted_no"          then "No"
    when "consulted_i_dont_know" then "I don't know"
    end
  end

end
