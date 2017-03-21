namespace :launch_email do
  task :send_to_internal_testing, [:promo_id] => :environment do |t, args|
    internal_members = Member.where(testing_group: 200)
    promo = Promotion.find_by_id(args[:promo_id])
    raise "Promo code not found" unless promo.present?

    counter = 0
    internal_members.each do |m|
      MemberMailer.delay.plain_launch(m.id, promotion_id: promo.id, campaign_id: "launch-start-group1")
      counter += 1
    end

    p "Send proof launch email to #{counter} internal members"
  end

  task :send_testing_group0_launch_email  => :environment do
    members = Member.where(testing_group: [0, 200]).where('email is not null') #always send a copy to internal members
    promo = FixedPromotion.where(start_date: "2017-03-21", end_date: "2017-03-23").first
    raise "Promo code not found" unless promo.present?

    counter = 0
    members.each do |m|
      MemberMailer.delay.plain_launch(m.id, promotion_id: promo.id, campaign_id: "launch-start-group1")
      counter += 1
    end

    p "Sent first launch email to #{counter} members"
  end

  task :send_group1_launch_email  => :environment do
    testing_group = (1..10).to_a + [200]
    members = Member.where(testing_group: testing_group).where('email is not null') #always send a copy to internal members
    promo = FixedPromotion.where(start_date: "2017-03-21", end_date: "2017-03-23").first
    raise "Promo code not found" unless promo.present?

    counter = 0
    members.each do |m|
      MemberMailer.delay.plain_launch(m.id, promotion_id: promo.id, campaign_id: "launch-start-group1")
      counter += 1
    end

    p "Sent first launch email to #{counter} members"
  end
end
