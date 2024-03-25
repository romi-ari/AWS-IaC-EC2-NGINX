## How to Run

1. Create app or clone this repository:
    ```bash
    git clone https://github.com/romi-ari/todoapp
    ```

2. Clone this repository:
    ```bash
    git clone https://github.com/romi-ari/AWS-IaC-EC2-NGINX
    ```

3. Go to the todoapp directory, inside there is client and server directory and change the env value

4. Create docker image in both client and server directory

5. Go to the AWS-IaC-EC2-NGINX directory then make changes as desired and run this command:
    ```bash
    terraform init
    terraform plan
    terraform apply
    ```
6. Open AWS console and connect to EC2 instance (frontend and backend) with SSH then run this command:
    ```bash
    sudo vim /etc/nginx/sites-available/default
    ```
7. Update the configuration in SSL setting:
    * frontend
    ```bash
    location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                proxy_pass http://your_domain;
                root   /usr/share/nginx/html;
                index  index.html index.htm;
                try_files $uri $uri/ /index.html =404;
    }
    ```
    * backend
    ```bash
    location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                proxy_pass http://your_domain:
    }
    ```

8. Check NGINX configuration for syntax error:
    ```bash
    sudo nginx -t
    ```
    * if there are no error, restart NGINX
    ```bash
    sudo systemctl restart nginx
    ```
    
9. Test the app