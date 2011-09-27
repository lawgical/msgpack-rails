# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dummy_2_3_14_session',
  :secret      => 'a040d27d025a4e0b612010d5b67d0aadd9f4bdeb2f935446560714566f0dd3459e4bb218a0cf2a846130525aebe0b8c999e63ad486a2c585eb8807c326b948a6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
