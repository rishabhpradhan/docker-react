#Production docker file
#Build Phase
FROM node:alpine as builder
#all the below phase will be reference as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build


#Second Phase
FROM nginx
#For elastic bean stalk, will look and expost the port for incoming traffic
EXPOSE 80
#Want to copy something from some phase. i.e. builder phase
COPY --from=builder /app/build /usr/share/nginx/html
