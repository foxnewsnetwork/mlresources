Squash::Ruby.configure :api_host => 'https://lit-oasis-1400.herokuapp.com',
  :api_key => 'c6b743a2-9445-4fb7-be69-ebc4d1e83d6c',
  :disabled => (Rails.env.development? || Rails.env.test?)