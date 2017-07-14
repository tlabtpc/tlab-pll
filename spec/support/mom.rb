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

  def primary_referral(**args)
    PrimaryReferral.new(
      terminal_node: node(terminal: true),
      title: "PrimaryTitle",
      markdown_content: "#Header",
      **args
    )
  end

  def secondary_referral(**args)
    SecondaryReferral.new(
      terminal_node: node(terminal: true),
      title: "SecondaryTitle",
      link: "referrals.secondary.biz",
      **args
    )
  end

  def special_referral(title: "SpecialTitle", markdown_content: "SpecialDescription", link: "referrals.special.biz")
    SpecialReferral.new(
      title: title,
      markdown_content: markdown_content,
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
