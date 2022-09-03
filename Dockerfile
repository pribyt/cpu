FROM debian:latest
RUN apt-get update
RUN apt-get install -y git bc jq nginx-common nginx-extras
WORKDIR /app/
RUN git clone https://github.com/pribyt/cpu.git -b main
COPY ./bash /etc/nginx/sites-enabled/bash 
COPY . /app/
RUN chmod +x /app/app.sh
EXPOSE 1501
STOPSIGNAL SIGQUIT
CMD ["nginx", "-g", "daemon off;"]
