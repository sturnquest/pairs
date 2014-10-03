# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Pairs::Application.config.secret_token = (0...50).map { ('a'..'z').to_a[rand(26)] }.join # meets minimum requirement of 30 chars long