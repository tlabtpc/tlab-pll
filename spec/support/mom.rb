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

  def node(**args)
    Node.new(
      title: "node-#{sequence}",
      **args
    )
  end

  def assessment(submitted_at: nil)
    Assessment.new(submitted_at: submitted_at)
  end

  def assessment_node(**args)
    AssessmentNode.new(
      assessment: assessment,
      node: node,
      **args
    )
  end

  def assessment_referral(**args)
    AssessmentReferral.new(
      assessment: assessment,
      referral: primary_referral,
      **args
    )
  end

  def node_referral(**args)
    NodeReferral.new(
      node: node,
      referral: primary_referral,
      **args
    )
  end

  def primary_referral(**args)
    PrimaryReferral.new(
      code: "prim",
      title: "PrimaryTitle",
      description: "Description of primary referral",
      markdown_content: "#Header",
      **args
    )
  end

  def secondary_referral(**args)
    SecondaryReferral.new(
      title: "SecondaryTitle",
      link: "referrals.secondary.biz",
      **args
    )
  end

  def special_referral(**args)
    SpecialReferral.new(
      title: "SpecialTitle",
      code: "spec",
      description: "SpecialDescription",
      markdown_content: "SpecialContent",
      **args
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
