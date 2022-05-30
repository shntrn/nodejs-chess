FROM node:11 as node
WORKDIR /usr/src/app

ARG API_URL
ENV API_URL=${API_URL}

COPY package*.json ./
RUN npm install phantomjs-prebuilt@2.1.16 --ignore-scripts
COPY . .
RUN npm install
RUN npm run build

FROM nginx
COPY --from=node /usr/src/app/lib/common /usr/share/nginx/common
COPY --from=node /usr/src/app/lib/client /usr/share/nginx/html
COPY --from=node /usr/src/app/node_modules /usr/share/nginx/node_modules

