FROM debian:latest
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install -y git bc jq nginx-common nginx-extras
WORKDIR /app/
RUN git clone https://github.com/pribytkovskiy/MaYBE.git -b main
CP /app/bash /etc/nginx/sites-enabled/bash 
RUN chmod +x /app/app.sh
EXPOSE 1051
STOPSIGNAL SIGQUIT
CMD ["nginx", "-g", "daemon off;"]
