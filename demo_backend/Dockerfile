FROM node:latest
COPY . /srv
WORKDIR /srv
RUN npm install
EXPOSE 3000
CMD [ "node", "app.js" ]