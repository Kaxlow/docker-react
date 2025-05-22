#build phase
FROM node:16-alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN npm install
#straight copy for Production, live change not needed
COPY . .
RUN npm run build

#run phase
FROM nginx
#tell AWS elastic beanstalk to map port 80 on container to incoming requests
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
#nginx container's default command is to start nginx