FROM node:alpine3.10

WORKDIR /app/

COPY . .

EXPOSE 3000

RUN npm install

CMD ["node", "app.js"]