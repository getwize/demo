class CreatePlanService
  def call
    p1 = Plan.where(name: 'Lite').first_or_initialize do |p|
      p.amount = 4000
      p.interval = 'month'
      p.stripe_id = 'lite'
    end
    p1.save!(:validate => false)
    p2 = Plan.where(name: 'Basic').first_or_initialize do |p|
      p.amount = 6000
      p.interval = 'month'
      p.stripe_id = 'basic'
    end
    p2.save!(:validate => false)
    p3 = Plan.where(name: 'Pro').first_or_initialize do |p|
      p.amount = 8000
      p.interval = 'month'
      p.stripe_id = 'pro'
    end
    p3.save!(:validate => false)
  end
end
