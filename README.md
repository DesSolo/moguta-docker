# nginx emample
```nginx
server {
        listen       80;
        server_name  _;

        location / {
                proxy_set_header Host $host;
                proxy_pass http://127.0.0.1:8080;
        }

    }

```
