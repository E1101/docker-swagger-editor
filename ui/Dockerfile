# --------------------------------------------------------------------
# | EXPOSE 80
# | SwaggerUI Source is under /swagger folder.
# |
# | ONBUILD:
# |    put swagger.json beside your Dockerfile, used this file as
# |    source to generate api documentation.
# | 
# | payam/swagger-ui
FROM ubuntu

MAINTAINER Payam Naderi <naderi.payam@gmail.com>

RUN apt-get update && apt-get install -y --force-yes \
      nginx \
      unzip \
      wget \
    ## https://github.com/e1101/swagger-ui can be used as alternate template
    && wget https://github.com/wordnik/swagger-ui/archive/master.zip \
       && unzip -o ./master.zip -d /swagger && rm -rf ./master.zip \
    && cd /swagger && mv ./swagger-ui-master/dist/* .

ADD swagger /etc/nginx/sites-enabled/
RUN rm -f /etc/nginx/sites-enabled/default \
    && echo 'daemon off;' >> /etc/nginx/nginx.conf

EXPOSE 80

ADD run.sh /run.sh
RUN chmod 755 /*.sh

WORKDIR /swagger

CMD ["/bin/sh", "-c", "/run.sh"]

# ........................................................................................................

ONBUILD ADD ["swagger.json", "/swagger/"]
## explore swagger.json as default generating ui insruction file
ONBUILD RUN sed -i '/location \/ {/a rewrite ^(.*)$ $1?url=swagger.json break;' \
            /etc/nginx/sites-enabled/swagger
ONBUILD RUN sed -i 's/http:\/\/petstore.swagger.io\/v2\/swagger.json/swagger.json/g' /swagger/index.html
## hide explore bar in ui
ONBUILD RUN sed -i 's@<div class='input'@& style="display:none" @g' /swagger/index.html
