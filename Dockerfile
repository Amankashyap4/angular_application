FROM node:18.15.0-alpine AS build

WORKDIR /usr/src/app

#RUN npm cache clean --force

#COPY . .
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --prod

FROM nginx:latest
RUN rm /etc/nginx/conf.d/default.conf
#ADD /dist/angular_app /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/ 
#COPY --from=0 /dist/src/app /usr/share/nginx/html
#COPY /nginx.conf /etc/nginx/conf.d/default.conf 
COPY --from=0 /usr/src/app/dist/angular_app /usr/share/nginx/html
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]


