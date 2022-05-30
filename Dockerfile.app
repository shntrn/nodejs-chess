FROM node:10 as node
WORKDIR /usr/src/app

ENV API_URL=http://192.168.59.100:8081

COPY package*.json ./
RUN npm install phantomjs-prebuilt@2.1.16 --ignore-scripts
COPY . .
RUN npm install
RUN npm run build
CMD npm run client


FROM nginx
COPY --from=node /usr/src/app/lib/common /usr/share/nginx/common
COPY --from=node /usr/src/app/lib/client /usr/share/nginx/html
COPY --from=node /usr/src/app/node_modules /usr/share/nginx/node_modules

