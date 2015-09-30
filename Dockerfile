FROM nginx:latest

###
# Setup base dependencies
##
RUN apt-get update && apt-get install -y git php5-cli wget
WORKDIR /tmp
RUN wget https://getcomposer.org/composer.phar
RUN chmod +x composer.phar
RUN mv composer.phar /usr/bin/composer

###
# Add the code and auth for Composer
##
ADD ./code /opt/satis
#RUN mkdir /root/.composer
#ADD ./auth.json /root/.composer/auth.json

###
# Build the repo and get it ready to serve
##
WORKDIR /opt/satis
RUN composer install
RUN composer build
RUN cp -r ./packages/* /usr/share/nginx/html

###
# Expose it and we're good to go
##
WORKDIR /
EXPOSE 80
