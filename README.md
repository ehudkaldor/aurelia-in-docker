# aurelia-in-docker

## This is a docker image running [Aurelia](http://aurelia.io) web framework, based on [NodeJS](http://nodejs.org), with [NGINX](http://nginx.com) ready to run the app.

confd is running when the container starts, and edits the site definitions (/etc/nginx/conf.d/default.conf).

* If you need NGINX to do any forwarding (proxy_pass), run the container with an env variable called PROXY. Forwarders should be separated by a space (' '), while each forwarder should have the filtered path and the redirection address separated by a comma (',').
for example: `docker run --env --env PROXY="/auth,http://127.0.0.1:9000 /api,http://127.0.0.1:9200" ...` will result in two forwarders added to the conf file, one for `/auth` and another for `/api`, as such:
```
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        # Everything is a 404
        location / {
                root html;
                index index.html;
        }




        location /auth  {
          proxy_pass http://127.0.0.1:9000;
        }


        location /api  {
          proxy_pass http://127.0.0.1:9000;
        }



        # You may need this to prevent return 404 recursion.
        location = /404.html {
                internal;
        }
}
```

not providing the PROXY env param will not add any forwarders, as such:
```
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        # Everything is a 404
        location / {
                root html;
                index index.html;
        }



        # You may need this to prevent return 404 recursion.
        location = /404.html {
                internal;
        }
}
```
