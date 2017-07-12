class Mom
  def user(name="user-#{sequence}", email: "#{name.to_s.underscore.dasherize.parameterize}@example.com", password: "password", admin: false)
    User.new(name: name, email: email, password: password, admin: admin)
  end

  def admin
    user "admin-#{sequence}", admin: true
  end

  def member
    user "member-#{sequence}"
  end

  def node(parent_node_id: nil, terminal: false, is_category: false, is_county: false, root: false, question: nil, title: "node-#{sequence}", tip: nil)
    Node.new(
      parent_node_id: parent_node_id,
      terminal: terminal,
      is_category: is_category,
      is_county: is_county,
      root: root,
      title: title,
      question: question,
      tip: tip
    )
  end

  def assessment(submitted_at: nil)
    Assessment.new(submitted_at: submitted_at)
  end

  def primary_referral(terminal_node_id:, title: "PrimaryTitle", description: "PrimaryDescription", introduction: "PrimaryIntroduction", link: "referrals.primary.biz")
    PrimaryReferral.new(
      terminal_node_id: terminal_node_id,
      title: title,
      description: description,
      introduction: introduction,
      link: link
    )
  end

  def special_referral(title: "SpecialTitle", description: "SpecialDescription", introduction: "SpecialIntroduction", link: "referrals.special.biz")
    SpecialReferral.new(
      title: title,
      description: description,
      introduction: introduction,
      link: link
    )
  end

  def cross_check(**args)
    CrossCheck.new(assessment: assessment, **args)
  end

  private

  def sequence
    @sequence ||= 0
    @sequence += 1
  end
end

def mom
  @mom ||= Mom.new
end

def build(thing, *args)
  mom.send(thing, *args)
end

def create(thing, *args)
  mom.send(thing, *args).tap(&:save!)
end
