This is a ruby application for billing system

Assumptions:

1. Items are already in the cart example cart item hash used in this application is :

    {"groceries" => {"plates" => 100}, "cloths" => {"shirt" => 300, "pant" => 400}}

  You can change this billing items in the billing_item.rb file.
  You can add more Items in the groceries and cloths and also can add more categories, with different prices.


Here:
    - groceries and cloths are 2 categories
    - plates, shirt and pant are the items

2. User Types:
    - Customer : It represents 2 years old customer for the store and gets 5% discount
    - User: It represents the regular User for the store and gets 0% discount
    - Affiliate: It represents the affiliate user for the store and gets 10% discount
    - Employee: It represents the employee of the store and gets 30% discount

   All this Users will get the $5 for every hundred in the total bill (e.g. for $ 990, you get $ 45 as a discount).

   And all the percentage discount are not applied for the billing item category groceries.

PreRequisite:

    ruby 1.9.3

    run: gem install bundler

    go to application path and run: bundle install

Run the application in console:
    1. git clone git@github.com:mitijain123/BillingSystem.git
    2. go to application path and run: ruby billing.rb

Run tests:
    1. git clone git@github.com:mitijain123/BillingSystem.git
    2. go to application path and run:
        - bundle install
        - ruby test.rb

After running the test you can see the code coverage:
    open in browser: application_path/coverage/index.html


