FROM node:11 as node
WORKDIR /usr/src/app

ARG API_URL
ENV API_URL=${API_URL}

COPY package*.json ./
COPY . .
RUN npm install
RUN npm run build

FROM nginx
COPY --from=node /usr/src/app/lib/client /usr/share/nginx/html
