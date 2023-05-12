FROM node:18.15.0-alpine AS build
WORKDIR /usr/src/app

RUN npm cache clean --force

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --prod

FROM nginx:latest
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/  
COPY --from=build /usr/src/app/dist/angular_app /usr/share/nginx/html
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]


