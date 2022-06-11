FROM node:gallium-alpine3.16 as build-step

RUN mkdir -p /app

WORKDIR /app

COPY package.json /app

RUN npm install

COPY . /app

RUN npm run build --prod

FROM nginx:stable

COPY --from=build-step /app/dist/crypto-exchange-fe /usr/share/nginx/html
