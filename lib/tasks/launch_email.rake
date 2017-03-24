namespace :launch_email do
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

  task :send_group1_discount_reminder_email  => :environment do
    testing_group = (1..10).to_a + [200]
    groups = testing_group.to_s.gsub("[", '(').gsub("]", ')')

    members = Member.find_by_sql("SELECT m.id
      from members m
      left join email_settings es on m.email = es.email
      left join suppression_lists sl on m.email = sl.email
      where sl.id is null
      and es.id is null
      and m.email is not null
      and m.email not like '%deloitte.com%'
      and m.email not like '%ey.com%'
      and m.email not like '%us.pwc.com%'
      and m.email not like '%kpmg.com%'
      and m.email not like '%.edu%'
      and m.testing_group in #{groups}"
    )

    promo = FixedPromotion.where(start_date: "2017-03-21", end_date: "2017-03-23").first
    raise "Promo code not found" unless promo.present?

    counter = 0
    members.each do |m|
      MemberMailer.delay.discount_reminder(m.id, promotion_id: promo.id, campaign_id: "launch-reminder-group1")
      counter += 1
    end

    p "Sent discount reminder email to #{counter} members"
  end

  task :send_group1_final_reminder => :environment do
    testing_group = (1..10).to_a + [200]
    groups = testing_group.to_s.gsub("[", '(').gsub("]", ')')

    members = Member.find_by_sql("SELECT m.id
      from members m
      left join email_settings es on m.email = es.email
      left join suppression_lists sl on m.email = sl.email
      where sl.id is null
      and es.id is null
      and m.email is not null
      and m.email not like '%deloitte.com%'
      and m.email not like '%ey.com%'
      and m.email not like '%us.pwc.com%'
      and m.email not like '%kpmg.com%'
      and m.email not like '%.edu%'
      and m.testing_group in #{groups}"
    )

    promo = FixedPromotion.where(start_date: "2017-03-21", end_date: "2017-03-23").first
    raise "Promo code not found" unless promo.present?

    counter = 0
    members.each do |m|
      MemberMailer.delay.final_reminder(m.id, promotion_id: promo.id, campaign_id: "launch-close-group1")
      counter += 1
    end

    p "Sent final reminder email to #{counter} members"
  end

  task :send_group2_launch_email  => :environment do
    testing_group = (11..21).to_a + [200]
    # make sure to exclude the big 4 and edu addresses
    members = Member.where(testing_group: testing_group).where('email is not null').where("email not like '%deloitte.com%'").where("email not like '%ey.com%'").where("email not like '%us.pwc.com%'").where("email not like '%ey.com%'").where("email not like '%kpmg.com%'").where("email not like '%.edu%'")
    promo = FixedPromotion.where(start_date: "2017-03-22", end_date: "2017-03-24").first
    raise "Promo code not found" unless promo.present?

    counter = 0
    members.each do |m|
      MemberMailer.delay.plain_launch(m.id, promotion_id: promo.id, campaign_id: "launch-start-group2")
      counter += 1
    end

    p "Sent first launch email to #{counter} members"
  end

  task :send_group2_discount_reminder_email  => :environment do
    testing_group = (11..21).to_a + [200]
    groups = testing_group.to_s.gsub("[", '(').gsub("]", ')')

    members = Member.find_by_sql("SELECT m.id
    from members m
    left join email_settings es on m.email = es.email
    left join suppression_lists sl on m.email = sl.email
    where sl.id is null
    and es.id is null
    and m.email is not null
    and m.email not like '%deloitte.com%'
    and m.email not like '%ey.com%'
    and m.email not like '%us.pwc.com%'
    and m.email not like '%kpmg.com%'
    and m.email not like '%.edu%'
    and m.testing_group in #{groups}"
    )

    promo = FixedPromotion.where(start_date: "2017-03-22", end_date: "2017-03-24").first
    raise "Promo code not found" unless promo.present?

    counter = 0
    members.each do |m|
      MemberMailer.delay.discount_reminder(m.id, promotion_id: promo.id, campaign_id: "launch-reminder-group2")
      counter += 1
    end

    p "Sent discount reminder email to #{counter} members"
  end

  task :send_group2_final_reminder => :environment do
    testing_group = (11..21).to_a + [200]
    groups = testing_group.to_s.gsub("[", '(').gsub("]", ')')

    members = Member.find_by_sql("SELECT m.id
      from members m
      left join email_settings es on m.email = es.email
      left join suppression_lists sl on m.email = sl.email
      where sl.id is null
      and es.id is null
      and m.email is not null
      and m.email not like '%deloitte.com%'
      and m.email not like '%ey.com%'
      and m.email not like '%us.pwc.com%'
      and m.email not like '%kpmg.com%'
      and m.email not like '%.edu%'
      and m.testing_group in #{groups}"
    )

    promo = FixedPromotion.where(start_date: "2017-03-22", end_date: "2017-03-24").first
    raise "Promo code not found" unless promo.present?

    counter = 0
    members.each do |m|
      MemberMailer.delay.final_reminder(m.id, promotion_id: promo.id, campaign_id: "launch-close-group2")
      counter += 1
    end

    p "Sent final reminder email to group 2 #{counter} members"
  end

  task :send_group3_launch_email  => :environment do
    testing_group = (22..32).to_a + [200]
    # make sure to exclude the big 4 and edu addresses
    members = Member.where(testing_group: testing_group).where('email is not null').where("email not like '%deloitte.com%'").where("email not like '%ey.com%'").where("email not like '%us.pwc.com%'").where("email not like '%ey.com%'").where("email not like '%kpmg.com%'").where("email not like '%.edu%'")

    promo = FixedPromotion.where(start_date: "2017-03-23", end_date: "2017-03-26").first
    raise "Promo code not found" unless promo.present?

    counter = 0
    members.each do |m|
      MemberMailer.delay.short_launch(m.id, promotion_id: promo.id, campaign_id: "launch-start-group3")
      counter += 1
    end

    p "Sent first launch email to #{counter} members"
  end

  task :send_group2_discount_reminder_email  => :environment do
    testing_group = (22..32).to_a + [200]
    groups = testing_group.to_s.gsub("[", '(').gsub("]", ')')

    members = Member.find_by_sql("SELECT m.id
    from members m
    left join email_settings es on m.email = es.email
    left join suppression_lists sl on m.email = sl.email
    where sl.id is null
    and es.id is null
    and m.email is not null
    and m.email not like '%deloitte.com%'
    and m.email not like '%ey.com%'
    and m.email not like '%us.pwc.com%'
    and m.email not like '%kpmg.com%'
    and m.email not like '%.edu%'
    and m.testing_group in #{groups}"
    )

    promo = FixedPromotion.where(start_date: "2017-03-23", end_date: "2017-03-26").first
    raise "Promo code not found" unless promo.present?

    counter = 0
    members.each do |m|
      MemberMailer.delay.discount_reminder(m.id, promotion_id: promo.id, campaign_id: "launch-reminder-group3")
      counter += 1
    end

    p "Sent discount reminder email to group 3 #{counter} members"
  end

  task :send_group3_final_reminder => :environment do
    testing_group = (22..32).to_a + [200]
    groups = testing_group.to_s.gsub("[", '(').gsub("]", ')')

    members = Member.find_by_sql("SELECT m.id
      from members m
      left join email_settings es on m.email = es.email
      left join suppression_lists sl on m.email = sl.email
      where sl.id is null
      and es.id is null
      and m.email is not null
      and m.email not like '%deloitte.com%'
      and m.email not like '%ey.com%'
      and m.email not like '%us.pwc.com%'
      and m.email not like '%kpmg.com%'
      and m.email not like '%.edu%'
      and m.testing_group in #{groups}"
    )

    promo = FixedPromotion.where(start_date: "2017-03-23", end_date: "2017-03-26").first
    raise "Promo code not found" unless promo.present?

    counter = 0
    members.each do |m|
      MemberMailer.delay.final_reminder(m.id, promotion_id: promo.id, campaign_id: "launch-close-group3")
      counter += 1
    end

    p "Sent final reminder email to group 3 #{counter} members"
  end
end
