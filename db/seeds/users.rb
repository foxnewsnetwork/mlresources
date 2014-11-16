users = [
  { email: "apple@t.co", password: "asdf123", company_name: "Apple Test Co." },
  { email: "orange@t.co", password: "asdf123", company_name: "Orange Test Co." },
  { email: "pear@t.co", password: "asdf123", company_name: "Pear Test Co." }
]
Admin::User.create! users
