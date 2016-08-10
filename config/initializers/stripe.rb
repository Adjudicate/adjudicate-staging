Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_PUBLIC_KEY'],
  :secret_key      => ENV['SECRET_KEY']
}


Stripe.api_key = ENV['SECRET_KEY']
STRIPE_PUBLIC_KEY = ENV['STRIPE_PUBLIC_KEY']
