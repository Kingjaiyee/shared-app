FROM node:11.13.0-alpine

RUN apk update && apk upgrade
# create destination directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app


# copy the app, note .dockerignore
COPY . /usr/src/app/
RUN npm install --silent
# expose 5000 on container
EXPOSE 3000

# set app serving to permissive / assigned
ENV NUXT_HOST=0.0.0.0
# set app port
ENV NUXT_PORT=3000
# start the app
CMD [ "node", "index.js" ]




