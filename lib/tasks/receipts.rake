desc "update_receipts"
task :update_receipts => :environment do
  require 'Mechanize'
  agent = Mechanize.new
  
  agent.get("https://www.facebook.com/")
  form = agent.page.forms.first
  form.email = "cerebralstorm@gmail.com"
  form.pass = "aeiluj11"
  form.submit

  notification_count = agent.page.at("#notificationsCountValue")

  receipt = Receipt.find(1)
  content = notification_count.children.text
  receipt.update_attributes(:content => content)
end