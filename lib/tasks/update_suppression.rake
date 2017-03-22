require 'csv'

namespace :suppression_list do
  task :update_list => :environment do

    list_data = CSV.parse(File.read("lib/tasks/sparkpost_suppression.csv"))
    counter = 0
    list_data.each do |(email, type, source, subacct)|
      unless SuppressionList.where(email: email.downcase).exists?
        SuppressionList.create(email: email.downcase, source: source)
        counter += 1
      end
    end

    p "Added #{counter} emails to suppression table."
  end
end
