# USAGE

This application allows you to setup your specific domain as TinyURL service. You can create short links, tracks the visits and count the stats.

No web interface included. Use `rails c` for the beginning. In real highload usage the web interface should be separate application on separate cluster of servers.

* Setup the application under any appropriate web server.
* Setup DNS to direct your domain (or subdomain) to the application. No additional routing needed.
* Link.create(slug: 'asdf', url: 'http://www.myhomepage.com/')
* Open in browser `yourdomain.com/asdf`. You should be redirected to `http://www.myhomepage.com/`.
* Check the `Click.all` and `Visitor.all` in the rails console to get the data.

# Examples

Check the `test\controllers\clicks_controller_test.rb` for the examples.

# Testing

Use `rake test` for testing.

# Basisc idea and data model

The basic entity is Link. It stores the each single link to translate from short url to long.

Each click to the short url is tracked as Click entity. It stores the click not the visitor (person).

The visitor (person, human or robot) is linked to the Click as Visitor entity. It is tracked by the hidden cookie in headers while redirect processing.

So if one person click two of your links, it will be tracked as TWO Clicks but ONE Visitor. This schema gives you a possibility to track the way of person through your resources. You can track the starting point, track all steps on your websites, track time periods between visits.

Also you can provide the personal recommendations to any visitor based on his/her history through your resources.

 
