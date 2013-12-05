#README

* This application requires Ruby 2.0.0 or higher and Rails 4 or higher

* Your server should have the following things installed: MySQL, SQLite, v8. The production database will use MySQL, and the development/test databases will use SQLite (for convenience).

* Make sure you create a MySQL database named `production`, and a user named `cakesenders`. The `cakesenders` user should have full access rights to that database. The two SQLite databases (`development` and `test`) will take care of themselves, so don't worry about them.

* Make sure you have sendmail configured properly so that the website can send out emails. Basically, if you can send mail with `/usr/bin/sendmail` (or the equivalent on Windows), then it's configured properly'.

* To deploy this application, it is easiest to use passenger with nginx. First, you will want to create the database tables (run `rake db:create RAILS_ENV=production` on the command line), and set them up (run `rake db:migrate RAILS_ENV=production` on the command line). After that, you will want to compile the static assets (run `rake assets:precompile RAILS_ENV=production` on the command line). Once that is done, make sure you have set up nginx properly, and that passenger is enabled. Please view [this link](https://www.digitalocean.com/community/articles/how-to-install-rails-and-nginx-with-passenger-on-ubuntu) for more information.

* Once you have the application up and running, you will want to update a few things in the configuration. First, you want to change the default password for the MySQL user, so edit `config/database.yml`. Next, you want to change the hard-coded domain name; just open `config/environments/production.rb` and replace `cakesenders.epicdomain.name` with your own domain name. Lastly, you want to regenerate the application's secret token, so run `rake secret` on the command line, and then edit `config/initializers/secret_token.rb`.

* In order to make use of the website, you will need to create at least one administrator. To do that, just sign up for an account like you normally would (let's assume the username is `bob`). On the command line, run `rails console RAILS_ENV=production` and then `u=User.find_by_username('bob'); u.admin=true; u.save;`.

---

##Distinct functionalities:

* User accounts: anyone can create an account, anyone can view/edit/delete their own account, and admins can do whatever they want

* Log in/out: anyone can log into their own account, given that they know their username and password. Many sections of the site do not work if you are not logged in.

* Goodies: admins can create and modify the listing of baked goodies (what we are selling). Anyone can view a goodie, but only admins can modify or create one. Admins can do whatever they want.

* Orders: anyone who is logged in can order a goodie. However, once they have placed an order, they cannot edit it. Users can view only their own order history. Admins can do whatever they want.

* Comments on goodies: anyone who is logged in can leave a comment on a goodie. They can also modify their comment or delete it. Users cannot edit/delete comments they do not own. Anyone can view the comments that people have left on a goodie. Admins can do whatever they want.

* "Welcome Aboard" email: when a user account is created, an email is sent out to the associated email address. Note that this functionality **cannot** be tested on a noncommercial network because `sendmail` will be blocked by the firewall.

* Order confirmation email: when a user places an order, the website sends an email to the user. The email contains a few details about the order, just to make sure everyone is on the same page. Note that this functionality **cannot** be tested on a noncommercial network because `sendmail` will be blocked by the firewall.

* Markdown support: Markdown is the preferred markup language for online websites (such as reddit, HN, etc.), as opposed to things like BBCode. Pretty much every major text field on the site supports Markdown. You can format comments and goodie descriptions with Markdown and the website will render them properly!

* Mobile-friendly: the entire site works nicely on mobile devices as well. The site embraces responsive design, so the site's appearance is largely device-independent. The site uses Twitter Bootstrap 3 for all of the visual styles, so it should look nice on both desktop computers and mobile devices.

* Social network integration: users can place orders without even entering the website. All they need to do is send a tweet to our twitter bot. If the user has payment credentials on hand, an order will be placed automatically.

##Security:

* The entire web application is built with Ruby on Rails. Whenever Rails interacts with the database, it uses parameterized queries, so SQL injection is not possible.

* Passwords are salted with a randomly-generated salt and hashed with scrypt.

* Sessions are currently used to store the web application state. There are many benefits to using sessions. On an ecommerce website, you want to prompt your users to log in before doing anything important; because of the fact that sessions expire, users **must** sign in after a period of inactivity. Second, sessions offer more security because no sensitive data will ever be stored on the user's computer. Lastly, sessions are ridiculously easy to implement.

##Other notes:

* User roles: unregistered (anonymous) users, registered users, admins

* I tried to make the pages as pretty as possible, but polishing a web application takes a LOT of time, and there were over 20 different pages to polish. Please take that into consideration.

* Since this is just a class assignment, I did not take the time to set up Stripe (the payment processor) and integrate the Stripe payment API. As a result, the *New Order* page does not ask for credit card information. However, the page **does** ask for a *charge token*, which is something that the Stripe payment API would generate. *In other words, the payment system is not fully implemented, but I did implement a skeleton for it*.
