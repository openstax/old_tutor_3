
def email_deliveries
  ActionMailer::Base.deliveries
end

def email_deliveries_clear
  ActionMailer::Base.deliveries = []
end

def email_body(email)
  email.body.to_s
end
