class Node < ApplicationRecord
  belongs_to :parent_node, class_name: "Node"
  has_many :children, -> { order(position: :asc) }, class_name: "Node", foreign_key: :parent_node_id
  has_many :node_referrals, -> { order(position: :asc) }
  has_many :referrals, through: :node_referrals

  scope :terminal, -> { where(terminal: true) }
  scope :counties, -> { where(is_county: true) }
  scope :categories, -> { where(is_category: true) }

  def primary_referrals=(referral_titles)
    set_referrals(referral_class: PrimaryReferral, titles: referral_titles)
  end

  def secondary_referrals=(referral_titles)
    set_referrals(referral_class: SecondaryReferral, titles: referral_titles)
  end

  def self.root
    find_by(root: true)
  end

  def to_param
    [id, title.parameterize].join("-")
  end

  private

  def set_referrals(referral_class:, titles:)
    titles.each_with_index do |title, position|
      if referral = referral_class.find_by(title: title)
        self.node_referrals
            .find_or_create_by(referral: referral)
            .update(position: position)
      else
        warn "Could not find #{referral_class} with title '#{title}'. Check the seeds file to ensure the referral exists."
      end
    end
  end
end
