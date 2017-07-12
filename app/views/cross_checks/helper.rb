module Views::CrossChecks::Helper
  def cross_check_form
    form_for :cross_check, url: next_step_cross_checks_path do |f|
      hidden_field_tag :current_step, action_name
      yield(f) if block_given?
      f.submit(class: :hide, id: :cross_check_submit)
    end
  end
end
