# USAGE

This application allows you to setup your specific domain as TinyURL service. You can create short links, tracks the visits and count the stats.

No web interface included. Use `rails c` for the beginning. In real highload usage the web interface should be separate application on separate cluster of servers.

* Setup the application under any appropriate web server.
* Setup DNS to direct your domain (or subdomain) to the application. No additional routing needed.
* Link.create(slug: 'asdf', url: 'http://www.myhomepage.com/')
* Open in browser `yourdomain.com/asdf`. You should be redirected to `http://www.myhomepage.com/`.
* Check the `Click.all` and `Visitor.all` in the rails console to get the data.
